Return-Path: <geert.uytterhoeven@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525677280; cv=none;
        d=google.com; s=arc-20160816;
        b=eBe6YSpZ83PBzbPaMM8Hhs6/m9dUxcmZod/XQma9BmzGEk6Nay/qjEUVRJUX+ELTkO
         W7it9aVOlJe7yQ9PNeVHFKvpLNc2+VcnCAQkKWpaBWsBhq7xDNx9BqRFVOjQ7b9dDSJf
         5a1TOI5Vq9JvBbGe/QhqVquJf6uP2vgQG4R9aQdO37eTwMtOD6PIlcrBtbi1rKMTkaOs
         25YTjD6Fcf5MbXlT2xN9w8sP9kWPJam8rubMAKSX565dMumn7x/lnZFaH7kwnVAhUB7b
         3mmRcMepxRJCijW6w+5l7brAs5AuctstWJWqSPBrhI9uctrCYJIIpDY4XbEwIl4UtNHU
         yhDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=fS9j+9cuqgrj+qcukKEJ1ZEq9N/9yMR+aiaQg5jL8R8=;
        b=PCzarwBL55JgoMEekYOKxlpDX7yBiAAgA4m3bvHwF173dz1hY57cMhk8u3aaoJUB56
         ZnjOA/5kQbA1ZkbDy45IT2rIBTI663yF+6ammebm9JJy4ubBGNV3oD5nsELiWVRNstSm
         MO9OJymc+lLldTvqXe17wLFwk1rHFh2RGXSalPwUE+ISU8b2pDdP7Icm5GwFEPR5iXUY
         t3I3aqjOsM0IEwjRpRI1XIToQB7B1YLMuYwNZjwKARcpsTVOxJ2A/Hpt9JZgictvjIyt
         5NmL4iwFaGOW7wp46hIeqKxVmNgLCKbWRyFL5KcJYVlgwR8HGaN+Rdhmt7Dp3+rOOvNb
         La5g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cjkBs5qE;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cjkBs5qE;
       spf=pass (google.com: domain of geert.uytterhoeven@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=geert.uytterhoeven@gmail.com
X-Google-Smtp-Source: AB8JxZoCl3SteWCCrU70SGP+3T9ZjXxK5HUEG5DmM8oJwG+KCyexOLn+KDgehsTp0xCES766/U6cKNPTut1A3OgUdKI=
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20180504163041.28726-1-wagi@monom.org>
References: <20180504163041.28726-1-wagi@monom.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 May 2018 09:14:38 +0200
X-Google-Sender-Auth: -gzNzFRi7SJT8eXOzXTasw5Ax6E
Message-ID: <CAMuHMdUsWRbYxoV_it-EWtLWcT04h0AsHpZJCgJ2hDm5z+KCOA@mail.gmail.com>
Subject: Re: [PATCH v2] serial: sh-sci: Use spin_{try}lock_irqsave instead of
 open coding version
To: Daniel Wagner <wagi@monom.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	"open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>,
	Greg KH <gregkh@linuxfoundation.org>, Daniel Wagner <daniel.wagner@siemens.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599551777582271050?=
X-GMAIL-MSGID: =?utf-8?q?1599788580031287968?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Daniel,

On Fri, May 4, 2018 at 6:30 PM, Daniel Wagner <wagi@monom.org> wrote:
> From: Daniel Wagner <daniel.wagner@siemens.com>
>
> Commit 40f70c03e33a ("serial: sh-sci: add locking to console write
> function to avoid SMP lockup") copied the strategy to avoid locking
> problems in conjuncture with the console from the UART8250
> driver. Instead using directly spin_{try}lock_irqsave(),
> local_irq_save() followed by spin_{try}lock() was used. While this is
> correct on mainline, for -rt it is a problem. spin_{try}lock() will
> check if it is running in a valid context. Since the local_irq_save()
> has already been executed, the context has changed and
> spin_{try}lock() will complain. The reason why spin_{try}lock()
> complains is that on -rt the spin locks are turned into mutexes and
> therefore can sleep. Sleeping with interrupts disabled is not valid.

[...]

> ---
>
> changes since v1:
>  - Ported to current mainline (initial version was against v4.4.y)
>  - Left local_irq_save() in place when spinlocks are not used as suggested
>    by Geert.

Thanks for the update!

> --- a/drivers/tty/serial/sh-sci.c
> +++ b/drivers/tty/serial/sh-sci.c
> @@ -2890,16 +2890,16 @@ static void serial_console_write(struct console *co, const char *s,
>         unsigned long flags;
>         int locked = 1;
>
> -       local_irq_save(flags);
>  #if defined(SUPPORT_SYSRQ)
> -       if (port->sysrq)
> +       if (port->sysrq) {
>                 locked = 0;
> -       else
> +               local_irq_save(flags);
> +       } else
>  #endif
>         if (oops_in_progress)
> -               locked = spin_trylock(&port->lock);
> +               locked = spin_trylock_irqsave(&port->lock, flags);

If the spinlock could not be taken, interrupts are re-enabled:

    include/linux/spinlock.h:
    #define raw_spin_trylock_irqsave(lock, flags) \
    ({ \
            local_irq_save(flags); \
            raw_spin_trylock(lock) ? \
            1 : ({ local_irq_restore(flags); 0; }); \
    })

hence I think you need to check for this and disable interrupts again:

    if (!locked)
            local_irq_save(flags);

>         else
> -               spin_lock(&port->lock);
> +               spin_lock_irqsave(&port->lock, flags);
>
>         /* first save SCSCR then disable interrupts, keep clock source */
>         ctrl = serial_port_in(port, SCSCR);
> @@ -2919,8 +2919,9 @@ static void serial_console_write(struct console *co, const char *s,
>         serial_port_out(port, SCSCR, ctrl);
>
>         if (locked)
> -               spin_unlock(&port->lock);
> -       local_irq_restore(flags);
> +               spin_unlock_irqrestore(&port->lock, flags);
> +       else
> +               local_irq_restore(flags);
>  }
>
>  static int serial_console_setup(struct console *co, char *options)

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
