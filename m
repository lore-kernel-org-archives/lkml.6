Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751951AbeBVCU0 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 21:20:26 -0500
Received: from mail-yb0-f196.google.com ([209.85.213.196]:36068 "EHLO
        mail-yb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbeBVCUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 21:20:24 -0500
X-Google-Smtp-Source: AH8x225uCQrmVoT4CjN688qrjZ5/EbwXxoLrCdD8/rKdF+rLci7y8YKt8hkMxqtx19xc6YqoF9MfMR/d2q0mj8gt4l0=
MIME-Version: 1.0
In-Reply-To: <20180219224111.21601-1-enric.balletbo@collabora.com>
References: <20180219224111.21601-1-enric.balletbo@collabora.com>
From: Gwendal Grignou <gwendal@chromium.org>
Date: Wed, 21 Feb 2018 18:20:02 -0800
X-Google-Sender-Auth: IsLmzcHYWcIsqhDD7mPuxclefUM
Message-ID: <CAMHSBOVwqgTn5KAgq8Ueqh-QDMU+bfDAzQLSEk5-6pb58L8X9g@mail.gmail.com>
Subject: Re: [PATCH 5/6] mfd: cros_ec_dev: Check communication with ec at resume
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc: Lee Jones <lee.jones@linaro.org>, Guenter Roeck <groeck@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Linux Kernel <linux-kernel@vger.kernel.org>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 2:41 PM, Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
> From: Gwendal Grignou <gwendal@chromium.org>
This patch is not needed anymore. It was added to
>
> Send dummy command to EC at resume time, wait for status.
> If EC loses that command and return a status for the
> pre-suspend command, we will not interpret that status as an
> answer for an important command.
>
> Signed-off-by: Gwendal Grignou <gwendal@chromium.org>
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Hold on for this commit. We have only used it in 3.14 kernels. It
looks like the issue has been addressed by a more elegant solution at
https://chromium.googlesource.com/chromiumos/third_party/kernel/+/0225a9de5971b99770344c04e0eba5b35ca68f71
> ---
>  drivers/mfd/cros_ec_dev.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
> index fc98e0564061..c901839317ae 100644
> --- a/drivers/mfd/cros_ec_dev.c
> +++ b/drivers/mfd/cros_ec_dev.c
> @@ -553,6 +553,16 @@ static __maybe_unused int ec_device_suspend(struct device *dev)
>  static __maybe_unused int ec_device_resume(struct device *dev)
>  {
>         struct cros_ec_dev *ec = dev_get_drvdata(dev);
> +       char msg[sizeof(struct ec_response_get_version) +
> +                sizeof(CROS_EC_DEV_VERSION)];
> +       int ret;
> +
> +       /* Be sure the communication with the EC is reestablished */
> +       ret = ec_get_version(ec, msg, sizeof(msg));
> +       if (ret < 0) {
> +               dev_err(ec->ec_dev->dev, "No EC response at resume: %d\n", ret);
> +               return 0;
Besides, that looks wrong, we should try to resume the lightbar.
> +       }
>
>         lb_resume(ec);
>
> --
> 2.16.1
>
