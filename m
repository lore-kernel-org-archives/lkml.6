Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZhsoS3y"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D198F60767
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932328AbeFFH3D (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 03:29:03 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:35308 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932114AbeFFH3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 03:29:02 -0400
X-Google-Smtp-Source: ADUXVKKDgd6mEhtLTDSSBahhur4iVtU0RFOJD4K2nkb+hgXzZFK37iPQXKSd2AeW+78onm1zHmmJ2zTTLnfWI9j/isQ=
MIME-Version: 1.0
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com>
 <20180529131014.18641-20-ricardo.ribalda@gmail.com> <CAHp75VeNhtJSa-2NJ5hCJP5yxtcaiNi-P8QA3BYCbGSNRfyvrg@mail.gmail.com>
In-Reply-To: <CAHp75VeNhtJSa-2NJ5hCJP5yxtcaiNi-P8QA3BYCbGSNRfyvrg@mail.gmail.com>
From: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Date: Wed, 6 Jun 2018 09:28:43 +0200
Message-ID: <CAPybu_2rpXkJEDkJ+jBtja-U+KK2LfDubpXz22xL1UAtKNdACA@mail.gmail.com>
Subject: Re: [PATCH 19/19] serdev: Instantiate a ttydev serdev if acpi and of fails
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Jun 5, 2018 at 3:44 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Tue, May 29, 2018 at 4:10 PM, Ricardo Ribalda Delgado
> <ricardo.ribalda@gmail.com> wrote:
> > If a serdev ttyport controller does not have an acpi nor an of child,
> > create a ttydev as a child of that controller.
> >
> > Doing this allows the removal, addition and replacement of ttydev devices
> > at runtime.
>
> > @@ -619,6 +619,27 @@ static inline int acpi_serdev_register_devices(struct serdev_controller *ctrl)
> >  }
> >  #endif /* CONFIG_ACPI */
> >
> > +
>
> Redundant blank line.

ACK
>
> > +#if IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV)
>
> > -       if (ret_of && ret_acpi) {
> > -               dev_dbg(&ctrl->dev, "no devices registered: of:%d acpi:%d\n",
> > -                       ret_of, ret_acpi);
> > +
> > +#if IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV)
> > +       if (ret_of && ret_acpi && ctrl->is_ttyport)
> > +               ret_tty = serdev_controller_add_ttydev(ctrl);
> > +#endif
> > +
> > +       if (ret_of && ret_acpi && ret_tty) {
> > +               dev_dbg(&ctrl->dev,
> > +                       "no devices registered: of:%d acpi:%d tty:%d\n",
> > +                       ret_of, ret_acpi, ret_tty);
> >                 ret = -ENODEV;
> >                 goto out_dev_del;
> >         }
>
> Wouldn't be better to leave above if-condition and introduce your
> stuff inside it?

I have redesign the logic in the function on the next version

Thanks


-- 
Ricardo Ribalda
