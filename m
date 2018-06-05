Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeFENob (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:44:31 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43531 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751820AbeFENo3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:44:29 -0400
X-Google-Smtp-Source: ADUXVKIeCRAvDRaQxAOvHE0L/qC8Zc/0x38m7VIqyUaaZpQumk3+lM1ciaDbhwvi9u9Riml+rJjVvkVgCSUzz3ZZTkY=
MIME-Version: 1.0
In-Reply-To: <20180529131014.18641-20-ricardo.ribalda@gmail.com>
References: <20180529131014.18641-1-ricardo.ribalda@gmail.com> <20180529131014.18641-20-ricardo.ribalda@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 16:44:28 +0300
Message-ID: <CAHp75VeNhtJSa-2NJ5hCJP5yxtcaiNi-P8QA3BYCbGSNRfyvrg@mail.gmail.com>
Subject: Re: [PATCH 19/19] serdev: Instantiate a ttydev serdev if acpi and of fails
To: Ricardo Ribalda Delgado <ricardo.ribalda@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Rob Herring <robh@kernel.org>, Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 4:10 PM, Ricardo Ribalda Delgado
<ricardo.ribalda@gmail.com> wrote:
> If a serdev ttyport controller does not have an acpi nor an of child,
> create a ttydev as a child of that controller.
>
> Doing this allows the removal, addition and replacement of ttydev devices
> at runtime.

> @@ -619,6 +619,27 @@ static inline int acpi_serdev_register_devices(struct serdev_controller *ctrl)
>  }
>  #endif /* CONFIG_ACPI */
>
> +

Redundant blank line.

> +#if IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV)

> -       if (ret_of && ret_acpi) {
> -               dev_dbg(&ctrl->dev, "no devices registered: of:%d acpi:%d\n",
> -                       ret_of, ret_acpi);
> +
> +#if IS_ENABLED(CONFIG_SERIAL_DEV_CTRL_TTYDEV)
> +       if (ret_of && ret_acpi && ctrl->is_ttyport)
> +               ret_tty = serdev_controller_add_ttydev(ctrl);
> +#endif
> +
> +       if (ret_of && ret_acpi && ret_tty) {
> +               dev_dbg(&ctrl->dev,
> +                       "no devices registered: of:%d acpi:%d tty:%d\n",
> +                       ret_of, ret_acpi, ret_tty);
>                 ret = -ENODEV;
>                 goto out_dev_del;
>         }

Wouldn't be better to leave above if-condition and introduce your
stuff inside it?

-- 
With Best Regards,
Andy Shevchenko
