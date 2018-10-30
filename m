Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6EE0C2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 777B020664
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 05:32:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gJb2T6Jf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 777B020664
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726199AbeJ3OYG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 10:24:06 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:35575 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbeJ3OYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 10:24:05 -0400
Received: by mail-vs1-f65.google.com with SMTP id d62so5151295vsd.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 22:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jJTXiR9slGPzXOLcMkp5ZjYPQmVFIe6uBUx08qNr4YM=;
        b=gJb2T6Jfvp9WAdyMOiF6xjVpeLMxb8TaPP2rYJdgDPrNI5MKP9yJlQ0cS0Tk6Hw8rq
         J8BIppZyBzU2J+Rh0gVXyocjn7IKucEZKh9jzNt50XYCnlIiKhhbCHMj4WfL7YQXJiCQ
         W3EGDBNlWCL/R0yuKYu7JcsMB1N2SRbYxTE0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jJTXiR9slGPzXOLcMkp5ZjYPQmVFIe6uBUx08qNr4YM=;
        b=KJ97aw/+72DwXDOAdw4sqbT9s3Y5WfqWYgtFJBg4C3xhJvKyeRNAmHKT29Su0henDv
         x+rGsmaiSqsjgU2mFSxsrNbIoTn2ZSDko/piD3hvQg5zfnKsqBOgYylLkjd1Bi3kdBp2
         6/X5RyAX+LHC7vcjls74lm9Z2TJTPvbhCqT6ZexOBJ+r63Crquxxe2vEWOhsS9jh3WsV
         UZbSvf87oLWhhuT1BsVpvAAT8xaOCqXqCqDDsSIlOXQMxWs7grQLdlMfY8vzgj/6TAC2
         jrAn3rvlixGvoq6Yp/WgYdQC83u4GvVqiub5ZTuFaz2TaKlRcdRmBk11lUDWsgtt2Wo3
         5tqg==
X-Gm-Message-State: AGRZ1gJnlhJkUkN5sDaCQDtIagsiaAHOlyDiXUzcdiWSyAJunr6RC+jw
        HvU+FseGuQPn2HzqQi4WHgHwvMTTPdc=
X-Google-Smtp-Source: AJdET5fVsodsMX5dgmy5pvPkaeglAzJBa/G7w0dmeU9aCyEWXkc3UyXB0DMubmh7hLpMi8HgEDwwog==
X-Received: by 2002:a67:a448:: with SMTP id p8mr7186691vsh.238.1540877524424;
        Mon, 29 Oct 2018 22:32:04 -0700 (PDT)
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com. [209.85.217.46])
        by smtp.gmail.com with ESMTPSA id z73sm6851489vsc.16.2018.10.29.22.32.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 22:32:03 -0700 (PDT)
Received: by mail-vs1-f46.google.com with SMTP id t17so3740846vsc.8
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 22:32:02 -0700 (PDT)
X-Received: by 2002:a67:8316:: with SMTP id f22mr7306261vsd.6.1540877522397;
 Mon, 29 Oct 2018 22:32:02 -0700 (PDT)
MIME-Version: 1.0
References: <20181029180707.207546-1-dianders@chromium.org> <20181029180707.207546-3-dianders@chromium.org>
In-Reply-To: <20181029180707.207546-3-dianders@chromium.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 29 Oct 2018 22:31:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=WCocrN0ft3-VCsxF2-ftNpKNwmU33taWPkMb=rQF_U=Q@mail.gmail.com>
Message-ID: <CAD=FV=WCocrN0ft3-VCsxF2-ftNpKNwmU33taWPkMb=rQF_U=Q@mail.gmail.com>
Subject: Re: [PATCH 2/7] serial: core: Allow processing sysrq at port unlock time
To:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        kgdb-bugreport@lists.sourceforge.net,
        LKML <linux-kernel@vger.kernel.org>,
        Jiri Slaby <jslaby@suse.com>, Jeremy Kerr <jk@ozlabs.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Oct 29, 2018 at 11:08 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> Right now serial drivers process sysrq keys deep in their character
> receiving code.  This means that they've already grabbed their
> port->lock spinlock.  This can end up getting in the way if we've go
> to do serial stuff (especially kgdb) in response to the sysrq.
>
> Serial drivers have various hacks in them to handle this.  Looking at
> '8250_port.c' you can see that the console_write() skips locking if
> we're in the sysrq handler.  Looking at 'msm_serial.c' you can see
> that the port lock is dropped around uart_handle_sysrq_char().
>
> It turns out that these hacks aren't exactly perfect.  If you have
> lockdep turned on and use something like the 8250_port hack you'll get
> a splat that looks like:
>
>   WARNING: possible circular locking dependency detected
>   [...] is trying to acquire lock:
>   ... (console_owner){-.-.}, at: console_unlock+0x2e0/0x5e4
>
>   but task is already holding lock:
>   ... (&port_lock_key){-.-.}, at: serial8250_handle_irq+0x30/0xe4
>
>   which lock already depends on the new lock.
>
>   the existing dependency chain (in reverse order) is:
>
>   -> #1 (&port_lock_key){-.-.}:
>          _raw_spin_lock_irqsave+0x58/0x70
>          serial8250_console_write+0xa8/0x250
>          univ8250_console_write+0x40/0x4c
>          console_unlock+0x528/0x5e4
>          register_console+0x2c4/0x3b0
>          uart_add_one_port+0x350/0x478
>          serial8250_register_8250_port+0x350/0x3a8
>          dw8250_probe+0x67c/0x754
>          platform_drv_probe+0x58/0xa4
>          really_probe+0x150/0x294
>          driver_probe_device+0xac/0xe8
>          __driver_attach+0x98/0xd0
>          bus_for_each_dev+0x84/0xc8
>          driver_attach+0x2c/0x34
>          bus_add_driver+0xf0/0x1ec
>          driver_register+0xb4/0x100
>          __platform_driver_register+0x60/0x6c
>          dw8250_platform_driver_init+0x20/0x28
>          ...
>
>   -> #0 (console_owner){-.-.}:
>          lock_acquire+0x1e8/0x214
>          console_unlock+0x35c/0x5e4
>          vprintk_emit+0x230/0x274
>          vprintk_default+0x7c/0x84
>          vprintk_func+0x190/0x1bc
>          printk+0x80/0xa0
>          __handle_sysrq+0x104/0x21c
>          handle_sysrq+0x30/0x3c
>          serial8250_read_char+0x15c/0x18c
>          serial8250_rx_chars+0x34/0x74
>          serial8250_handle_irq+0x9c/0xe4
>          dw8250_handle_irq+0x98/0xcc
>          serial8250_interrupt+0x50/0xe8
>          ...
>
>   other info that might help us debug this:
>
>    Possible unsafe locking scenario:
>
>          CPU0                    CPU1
>          ----                    ----
>     lock(&port_lock_key);
>                                  lock(console_owner);
>                                  lock(&port_lock_key);
>     lock(console_owner);
>
>    *** DEADLOCK ***
>
> The hack used in 'msm_serial.c' doesn't cause the above splats but it
> seems a bit ugly to unlock / lock our spinlock deep in our irq
> handler.
>
> It seems like we could defer processing the sysrq until the end of the
> interrupt handler right after we've unlocked the port.  With this
> scheme if a whole batch of sysrq characters comes in one irq then we
> won't handle them all, but that seems like it should be a fine
> compromise.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  include/linux/serial_core.h | 37 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 36 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
> index 047fa67d039b..78de9d929762 100644
> --- a/include/linux/serial_core.h
> +++ b/include/linux/serial_core.h
> @@ -175,6 +175,7 @@ struct uart_port {
>         struct console          *cons;                  /* struct console, if any */
>  #if defined(CONFIG_SERIAL_CORE_CONSOLE) || defined(SUPPORT_SYSRQ)
>         unsigned long           sysrq;                  /* sysrq timeout */
> +       unsigned int            sysrq_ch;               /* char for sysrq */
>  #endif
>
>         /* flags must be updated while holding port mutex */
> @@ -485,8 +486,42 @@ uart_handle_sysrq_char(struct uart_port *port, unsigned int ch)
>         }
>         return 0;
>  }
> +static inline int
> +uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch)
> +{
> +       if (port->sysrq) {
> +               if (ch && time_before(jiffies, port->sysrq)) {
> +                       port->sysrq_ch = ch;
> +                       port->sysrq = 0;
> +                       return 1;
> +               }
> +               port->sysrq = 0;
> +       }
> +       return 0;
> +}
> +static inline void
> +uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
> +{
> +       int sysrq_ch;
> +
> +       sysrq_ch = port->sysrq_ch;
> +       port->sysrq_ch = 0;
> +
> +       spin_unlock_irqrestore(&port->lock, irqflags);
> +
> +       if (sysrq_ch)
> +               handle_sysrq(sysrq_ch);
> +}
>  #else
> -#define uart_handle_sysrq_char(port,ch) ({ (void)port; 0; })
> +static inline int
> +uart_handle_sysrq_char(struct uart_port *port, unsigned int ch) { return 0; }
> +static inline int
> +uart_prepare_sysrq_char(struct uart_port *port, unsigned int ch) { return 0; }
> +static inline void
> +uart_unlock_and_check_sysrq(struct uart_port *port, unsigned long irqflags)
> +{
> +       spin_unlock_irqrestore(&port->lock, irqflags);
> +}

Jeremy wrote me to point out that I messed up and didn't get this
patch posted to the linux-serial list.  Sorry about that.  :(  I guess
get_mainatiners doesn't notice that this include file is relevant to
serial and I didn't notice either since I was too focused on trying to
figure out if it was really the right call to Cc all the arch
maintainers on the cover letter and the last patch...  Sigh.

If/when I need to repost, I'll make sure to get linux-serial.  For now
at least they are on LKML so probably the easiest place to find all
the patches is:

https://lore.kernel.org/patchwork/cover/1004280/

...if you clock on the "show" next to "Related" you get the whole
series.  Using the message ID from there you can also find them at:

https://lkml.kernel.org/r/20181029180707.207546-1-dianders@chromium.org

Both places allow you to grab 'mbox' files which (which a bit of a
hassle--sorry) can allow you to reply /apply patches.

-Doug
