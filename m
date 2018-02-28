Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964873AbeB1XMW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 18:12:22 -0500
Received: from mail-wm0-f52.google.com ([74.125.82.52]:34822 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935599AbeB1XMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 18:12:20 -0500
X-Google-Smtp-Source: AG47ELspAnnmdRCbuViWdVFX+qaLS0fc5aI3lObnS2YCjLglRDm6IqjBn/xNlksD4OAUetquTsmggA==
Date: Thu, 1 Mar 2018 00:12:15 +0100
From: Rodrigo Rivas Costa <rodrigorivascosta@gmail.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        "Pierre-Loup A. Griffais" <pgriffais@valvesoftware.com>,
        Cameron Gutman <aicommander@gmail.com>,
        =?iso-8859-1?Q?Cl=E9ment?= VUCHENER <clement.vuchener@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-input <linux-input@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] HID: steam: add serial number information.
Message-ID: <20180228231215.GB7009@casa>
References: <20180228184322.29636-1-rodrigorivascosta@gmail.com>
 <20180228184322.29636-3-rodrigorivascosta@gmail.com>
 <CAHp75VfxaxLJWK1Hk9PRiU0L2MuLPX5VoPsn6RRmmXg-apXo6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VfxaxLJWK1Hk9PRiU0L2MuLPX5VoPsn6RRmmXg-apXo6Q@mail.gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28, 2018 at 10:17:50PM +0200, Andy Shevchenko wrote:
> On Wed, Feb 28, 2018 at 8:43 PM, Rodrigo Rivas Costa
> <rodrigorivascosta@gmail.com> wrote:
> > This device has a feature report to send and receive commands.
> > Use it to get the serial number and set the device's uniq value.
> 
> >  #include <linux/module.h>
> >  #include <linux/workqueue.h>
> >  #include <linux/rcupdate.h>
> 
> > +#include <linux/delay.h>
> 
> Better to keep it somehow sorted (yes, I see it's not originally, but
> better to squeeze new header to the most ordered part).

Do you mean alphabetically? Or by topic/submodule? I just added it to
the end of the include list.
> 
> 
> > @@ -41,8 +42,99 @@ struct steam_device {
> >         unsigned long quirks;
> >         struct work_struct work_connect;
> >         bool connected;
> 
> > +       char serial_no[11];
> 
> 11 is a magic.
Magic indeed, it is 10 because the Valve protocol says so, and +1 for
the NUL.  I'll add a #define for that 10.
> 
> >  };
> >
> > +static int steam_recv_report(struct steam_device *steam,
> > +               u8 *data, int size)
> > +{
> > +       struct hid_report *r;
> > +       u8 *buf;
> > +       int ret;
> > +
> > +       r = steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];
> > +       if (hid_report_len(r) < 64)
> > +               return -EINVAL;
> 
> + empty line.

Ok.

> 
> > +       buf = hid_alloc_report_buf(r, GFP_KERNEL);
> > +       if (!buf)
> > +               return -ENOMEM;
> > +
> > +       /*
> > +        * The report ID is always 0, so strip the first byte from the output.
> > +        * hid_report_len() is not counting the report ID, so +1 to the length
> > +        * or else we get a EOVERFLOW. We are safe from a buffer overflow
> > +        * because hid_alloc_report_buf() allocates +7 bytes.
> > +        */
> > +       ret = hid_hw_raw_request(steam->hdev, 0x00,
> > +                       buf, hid_report_len(r) + 1,
> > +                       HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
> > +       if (ret > 0)
> > +               memcpy(data, buf + 1, min(size, ret - 1));
> > +       kfree(buf);
> > +       return ret;
> > +}
> > +
> > +static int steam_send_report(struct steam_device *steam,
> > +               u8 *cmd, int size)
> > +{
> > +       struct hid_report *r;
> > +       u8 *buf;
> > +       int retry;
> > +       int ret;
> > +
> > +       r = steam->hdev->report_enum[HID_FEATURE_REPORT].report_id_hash[0];
> > +       if (hid_report_len(r) < 64)
> > +               return -EINVAL;
> 
> +empty line.

Ok.

> 
> > +       buf = hid_alloc_report_buf(r, GFP_KERNEL);
> > +       if (!buf)
> > +               return -ENOMEM;
> > +
> > +       /* The report ID is always 0 */
> > +       memcpy(buf + 1, cmd, size);
> > +
> > +       /*
> > +        * Sometimes the wireless controller fails with EPIPE
> > +        * when sending a feature report.
> > +        * Doing a HID_REQ_GET_REPORT and waiting for a while
> > +        * seems to fix that.
> > +        */
> 
> > +       for (retry = 0; retry < 10; ++retry) {
> > +               ret = hid_hw_raw_request(steam->hdev, 0,
> > +                               buf, size + 1,
> > +                               HID_FEATURE_REPORT, HID_REQ_SET_REPORT);
> > +               if (ret != -EPIPE)
> > +                       break;
> > +               steam_recv_report(steam, NULL, 0);
> > +               msleep(50);
> > +       }
> 
> Personally I consider do{}while in case of "timeout loops" much easier to parse.
> 
> unsigned int retry = 10;
> ...
> 
> do {
> ...
> } while (--retry);
> 

Ok, it looks like it is done this way in most places. Also renamed to 'retries'.

> > +       kfree(buf);
> > +       if (ret < 0)
> > +               hid_err(steam->hdev, "%s: error %d (%*ph)\n", __func__,
> > +                               ret, size, cmd);
> > +       return ret;
> > +}
> > +
> > +static int steam_get_serial(struct steam_device *steam)
> > +{
> > +       /*
> > +        * Send: 0xae 0x15 0x01
> > +        * Recv: 0xae 0x15 0x01 serialnumber (10 chars)
> > +        */
> > +       int ret;
> > +       u8 cmd[] = {0xae, 0x15, 0x01};
> 
> > +       u8 reply[14];
> > +
> > +       ret = steam_send_report(steam, cmd, sizeof(cmd));
> > +       if (ret < 0)
> > +               return ret;
> > +       ret = steam_recv_report(steam, reply, sizeof(reply));
> > +       if (ret < 0)
> > +               return ret;
> 
> 
> > +       reply[13] = 0;
> > +       strcpy(steam->serial_no, reply + 3);
> 
> strlcpy()

Well, I've set a NUL byte at the end so the overflow is impossible.
I'll change it anyway, for extra safety.

> 
> > +       return 0;
> > +}
> 
> 
> -- 
> With Best Regards,
> Andy Shevchenko

Regards.
Rodrigo
