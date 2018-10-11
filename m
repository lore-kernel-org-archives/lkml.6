Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB3C3C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:58:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96DA921476
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 17:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DA921476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728370AbeJLB1A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 21:27:00 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:40313 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbeJLB07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 21:26:59 -0400
Received: by mail-vs1-f65.google.com with SMTP id z130-v6so9411920vsc.7
        for <linux-kernel@vger.kernel.org>; Thu, 11 Oct 2018 10:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vQweEY0U1X0FceJ5ZR8Io1mXg3welnhn59fT64Wtwqc=;
        b=U1GSZkbAWKIvjBzXnQPxkVmShlUCqoZ/+CSPzEPXXLlQqysIJSzoF1xD1zD8mS8JDp
         KvZAe6KJivp8l6EIIvupPwNHRfMwk4aYLuFJbUx1frcurCmkw5a+KAIB+9yQVIWp12zu
         h4nyJvUyjN3CZGoPHxdK5i02L9lYuNOrOQ4cABZdIh4o/xGmcpmKM6IC4sDQyOj2WEat
         2wKdIIJbSZ/YFaWI2P4TNepAdtVX+zCMMS3gZWOcfEQ+prfdMQM0DHGpaBVOoXGlKVuX
         Va81dKWjUQgxhr4axg5XvneMhqGacX6JqXyd+J/4R0GGdJPQLqh2Hi6JHW3qjUDFjv1w
         KXEA==
X-Gm-Message-State: ABuFfoh672201Xdw3dLYOCNiekkluPiknaybd6hA8OwsQ7KIggtwLC/C
        b6OcYE0iXQ1F1svCFAIkrSpFHaZBqGt75Ylp5Mk=
X-Google-Smtp-Source: ACcGV63T/EqRgrGp/WZgtyCQIIhuOgvCi0kYpytjJ2syy5idD/M7qWhZj382hMLVQJzlCvDBN3lWpSwTvBm9h+X+bDg=
X-Received: by 2002:a67:e015:: with SMTP id c21mr999195vsl.63.1539280720831;
 Thu, 11 Oct 2018 10:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <20180913023119.GQ19965@ZenIV.linux.org.uk> <20180913024049.24567-1-viro@ZenIV.linux.org.uk>
 <20180913024049.24567-9-viro@ZenIV.linux.org.uk>
In-Reply-To: <20180913024049.24567-9-viro@ZenIV.linux.org.uk>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 11 Oct 2018 19:58:28 +0200
Message-ID: <CAMuHMdXqfzz-eE+SDnun-SHm0ma69sYipgMjVhn1ipLrfXzD8w@mail.gmail.com>
Subject: Re: [PATCH 09/50] amiserial: switch to ->[sg]et_serial()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg KH <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Al,

On Thu, Sep 13, 2018 at 4:45 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
> From: Al Viro <viro@zeniv.linux.org.uk>
>
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>

> --- a/drivers/tty/amiserial.c
> +++ b/drivers/tty/amiserial.c

> -static int set_serial_info(struct tty_struct *tty, struct serial_state *state,
> -                          struct serial_struct __user * new_info)
> +static int set_serial_info(struct tty_struct *tty, struct serial_struct *ss)
>  {
> +       struct serial_state *state = tty->driver_data;
>         struct tty_port *port = &state->tport;
> -       struct serial_struct new_serial;
>         bool change_spd;
> -       int                     retval = 0;

"retval" is still used...

>
> -       if (copy_from_user(&new_serial,new_info,sizeof(new_serial)))
> -               return -EFAULT;
> +       if (serial_paranoia_check(state, tty->name, "rs_ioctl"))
> +               return -ENODEV;
>
>         tty_lock(tty);
> -       change_spd = ((new_serial.flags ^ port->flags) & ASYNC_SPD_MASK) ||
> -               new_serial.custom_divisor != state->custom_divisor;
> -       if (new_serial.irq || new_serial.port != state->port ||
> -                       new_serial.xmit_fifo_size != state->xmit_fifo_size) {
> +       change_spd = ((ss->flags ^ port->flags) & ASYNC_SPD_MASK) ||
> +               ss->custom_divisor != state->custom_divisor;
> +       if (ss->irq || ss->port != state->port ||
> +                       ss->xmit_fifo_size != state->xmit_fifo_size) {
>                 tty_unlock(tty);
>                 return -EINVAL;
>         }
>
>         if (!serial_isroot()) {
> -               if ((new_serial.baud_base != state->baud_base) ||
> -                   (new_serial.close_delay != port->close_delay) ||
> -                   (new_serial.xmit_fifo_size != state->xmit_fifo_size) ||
> -                   ((new_serial.flags & ~ASYNC_USR_MASK) !=
> +               if ((ss->baud_base != state->baud_base) ||
> +                   (ss->close_delay != port->close_delay) ||
> +                   (ss->xmit_fifo_size != state->xmit_fifo_size) ||
> +                   ((ss->flags & ~ASYNC_USR_MASK) !=
>                      (port->flags & ~ASYNC_USR_MASK))) {
>                         tty_unlock(tty);
>                         return -EPERM;
>                 }
>                 port->flags = ((port->flags & ~ASYNC_USR_MASK) |
> -                              (new_serial.flags & ASYNC_USR_MASK));
> -               state->custom_divisor = new_serial.custom_divisor;
> +                              (ss->flags & ASYNC_USR_MASK));
> +               state->custom_divisor = ss->custom_divisor;
>                 goto check_and_exit;
>         }
>
> -       if (new_serial.baud_base < 9600) {
> +       if (ss->baud_base < 9600) {
>                 tty_unlock(tty);
>                 return -EINVAL;
>         }
> @@ -1062,19 +1059,19 @@ static int set_serial_info(struct tty_struct *tty, struct serial_state *state,
>          * At this point, we start making changes.....
>          */
>
> -       state->baud_base = new_serial.baud_base;
> +       state->baud_base = ss->baud_base;
>         port->flags = ((port->flags & ~ASYNC_FLAGS) |
> -                       (new_serial.flags & ASYNC_FLAGS));
> -       state->custom_divisor = new_serial.custom_divisor;
> -       port->close_delay = new_serial.close_delay * HZ/100;
> -       port->closing_wait = new_serial.closing_wait * HZ/100;
> +                       (ss->flags & ASYNC_FLAGS));
> +       state->custom_divisor = ss->custom_divisor;
> +       port->close_delay = ss->close_delay * HZ/100;
> +       port->closing_wait = ss->closing_wait * HZ/100;
>         port->low_latency = (port->flags & ASYNC_LOW_LATENCY) ? 1 : 0;
>
>  check_and_exit:
>         if (tty_port_initialized(port)) {
>                 if (change_spd) {
>                         /* warn about deprecation unless clearing */
> -                       if (new_serial.flags & ASYNC_SPD_MASK)
> +                       if (ss->flags & ASYNC_SPD_MASK)
>                                 dev_warn_ratelimited(tty->dev, "use of SPD flags is deprecated\n");
>                         change_speed(tty, state, NULL);
>                 }
> @@ -1084,7 +1081,6 @@ static int set_serial_info(struct tty_struct *tty, struct serial_state *state,
>         return retval;

... here, and in the line above (out of context). leading to

drivers/tty/amiserial.c:1076:3: error: 'retval' undeclared (first use
in this function)

http://kisskb.ellerman.id.au/kisskb/buildresult/13544535/
http://kisskb.ellerman.id.au/kisskb/buildresult/13544413/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
