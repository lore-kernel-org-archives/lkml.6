Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031071AbeBNOve (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 09:51:34 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:46269 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1030650AbeBNOvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 09:51:32 -0500
X-Google-Smtp-Source: AH8x2245dQYbktn736xEo6iD9wS2/q0/LSpB/Fq9DzG0jhekSQjPySL+nj7BG9Caf8O/E7BbP+qHOXrmclGbejcc890=
MIME-Version: 1.0
In-Reply-To: <20180213120308.23879-2-rodrigorivascosta@gmail.com>
References: <20180213120308.23879-1-rodrigorivascosta@gmail.com> <20180213120308.23879-2-rodrigorivascosta@gmail.com>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Wed, 14 Feb 2018 15:51:31 +0100
Message-ID: <CAO-hwJK5sos9=RDajS_cXBzfePqf6TJs3Z-jk568sumR-zjqdw@mail.gmail.com>
Subject: Re: [PATCH 2/3] HID: steam: add serial number information.
To: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 13, 2018 at 1:03 PM, Rodrigo Rivas Costa
<rodrigorivascosta@gmail.com> wrote:
> This device has a feature report to send and receive commands.
> Use it to get the serial number and set the device's uniq value.
>
> Signed-off-by: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
> ---
>  drivers/hid/hid-steam.c | 89 +++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 86 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/hid/hid-steam.c b/drivers/hid/hid-steam.c
> index 03f912ab5484..f269a986e2be 100644
> --- a/drivers/hid/hid-steam.c
> +++ b/drivers/hid/hid-steam.c
> @@ -34,12 +34,17 @@ struct steam_device {
>         unsigned long quirks;
>         struct work_struct work_connect;
>         bool connected;
> +       char serial_no[11];
>  };
>
>  static int steam_register(struct steam_device *steam);
>  static void steam_unregister(struct steam_device *steam);
>  static void steam_do_connect_event(struct steam_device *steam, bool connected);
>  static void steam_do_input_event(struct steam_device *steam, u8 *data);
> +static int steam_send_report(struct steam_device *steam,
> +               u8 *cmd, int size);
> +static int steam_recv_report(struct steam_device *steam,
> +               u8 *data, int size);
>
>  static int steam_input_open(struct input_dev *dev)
>  {
> @@ -55,6 +60,78 @@ static void steam_input_close(struct input_dev *dev)
>         hid_hw_close(steam->hid_dev);
>  }
>
> +#define STEAM_FEATURE_REPORT_SIZE 65
> +
> +static int steam_send_report(struct steam_device *steam,
> +               u8 *cmd, int size)
> +{
> +       int retry;
> +       int ret;
> +       u8 *buf = kzalloc(STEAM_FEATURE_REPORT_SIZE, GFP_KERNEL);

Please use hid_alloc_report_buf() as sometimes we need to allocate a
slightly bigger report.

> +
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       /* The report ID is always 0 */
> +       memcpy(buf + 1, cmd, size);
> +
> +       /* Sometimes the wireless controller fails with EPIPE
> +        * when sending a feature report.
> +        * Doing a HID_REQ_GET_REPORT and waiting for a while
> +        * seems to fix that.
> +        */
> +       for (retry = 0; retry < 10; ++retry) {
> +               ret = hid_hw_raw_request(steam->hid_dev, 0,
> +                               buf, size + 1,
> +                               HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> +               if (ret != -EPIPE)
> +                       break;
> +               dbg_hid("%s: failed, retrying (%d times)\n", __func__, retry+1);
> +               steam_recv_report(steam, NULL, 0);
> +               msleep(50);
> +       }
> +       kfree(buf);
> +       return ret;
> +}
> +
> +static int steam_recv_report(struct steam_device *steam,
> +               u8 *data, int size)
> +{
> +       int ret;
> +       u8 *buf = kzalloc(STEAM_FEATURE_REPORT_SIZE, GFP_KERNEL);

same her hid_alloc_report_buf should be used

> +
> +       if (!buf)
> +               return -ENOMEM;
> +
> +       /* The report ID is always 0 */
> +       ret = hid_hw_raw_request(steam->hid_dev, 0x00,
> +                       buf, STEAM_FEATURE_REPORT_SIZE,
> +                       HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> +       memcpy(data, buf + 1, size);
> +       kfree(buf);
> +       return ret;
> +}
> +
> +static int steam_get_serial(struct steam_device *steam)
> +{
> +       /* Send: 0xae 0x15 0x01
> +        * Recv: 0xae 0x15 0x01 serialnumber (10 chars)
> +        */
> +       int ret;
> +       u8 cmd[] = {0xae, 0x15, 0x01};
> +       u8 reply[14];
> +
> +       ret = steam_send_report(steam, cmd, sizeof(cmd));
> +       if (ret < 0)
> +               return ret;
> +       ret = steam_recv_report(steam, reply, sizeof(reply));
> +       if (ret < 0)
> +               return ret;
> +       reply[13] = 0;
> +       strcpy(steam->serial_no, reply + 3);
> +       return 0;
> +}
> +
>  static void steam_work_connect_cb(struct work_struct *work)
>  {
>         struct steam_device *steam = container_of(work, struct steam_device,
> @@ -385,7 +462,12 @@ static int steam_register(struct steam_device *steam)
>
>         dbg_hid("%s\n", __func__);
>
> -       hid_info(hdev, "Steam Controller connected");
> +       ret = steam_get_serial(steam);
> +       if (ret)
> +               return ret;
> +
> +       hid_info(hdev, "Steam Controller SN: '%s' connected",
> +                       steam->serial_no);
>
>         input = input_allocate_device();
>         if (!input)
> @@ -398,7 +480,7 @@ static int steam_register(struct steam_device *steam)
>
>         input->name = "Steam Controller";
>         input->phys = hdev->phys;
> -       input->uniq = hdev->uniq;
> +       input->uniq = steam->serial_no;
>         input->id.bustype = hdev->bus;
>         input->id.vendor  = hdev->vendor;
>         input->id.product = hdev->product;
> @@ -447,7 +529,8 @@ static void steam_unregister(struct steam_device *steam)
>         dbg_hid("%s\n", __func__);
>
>         if (steam->input_dev) {
> -               hid_info(steam->hid_dev, "Steam Controller disconnected");
> +               hid_info(steam->hid_dev, "Steam Controller SN: '%s' disconnected",
> +                       steam->serial_no);
>                 input_unregister_device(steam->input_dev);
>                 steam->input_dev = NULL;
>         }
> --
> 2.16.1
>

Rest is OK (minus the multi lines comments as pointed in 1/3)

Cheers,
Benjamin
