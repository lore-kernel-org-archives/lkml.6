Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518102968; cv=none;
        d=google.com; s=arc-20160816;
        b=KxBNTqVUTC8/wofWrplGZ3QdyEprF9lwIk/4UFlhCCc+VqwPWGs0VKvmP50Lgp4Q1l
         LlDtF1+mM0r1LpStvRnCQgUnW2uKyp6ovsMUIIuLCc+rVM0uUKKOTMXUE2poFSWjsfHv
         /2MtuIVjfxraegaesuoSn5I40pLOHBqh7ezaUO/Ti4nqm9B3sQ+NKhPejVmCPwOdSJPe
         stHjsrW1s//6V9DxlLQfaqrpoglV+YNQEIXaSeTbAEvDw11IzhTh19uOsd773Pnv5HzY
         98jseeS0uyZw114xHs7FaIjHhUC2HIBDqzbC4lv0vDDSRqK3s3JLc0FyEDzEKPZVdA7a
         IlQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=IOoWewXpxQBFexBdocWfsmbLR+CJev3P1zkvZTr7D0U=;
        b=ijTtwntjCLptk84w3znujHghUGIvcFxOPttPiCE3jht9rlKNZRuRk3AXgxvXOv22C5
         qnAp+X5pq8QPyBOwNPPc+pVpdUe6EjVUac5LFIEaWxAnekM2l2YJebF5y4WQdmcNC4Z2
         mFJjH3oOu7Nxy8yp2QXg/VSuwONpyTdjFmnH6uJA6hKsO8mUv1cucYzRdJPyj3cATsxI
         wYq0ajrZf4ohQEyKQ57lXAldubjo6idC4vdETmON/hsZfbt7DJdepLyouNre6wGsQOFB
         bsWauwZV5deerf+yEBNhDtJONOKBZHgQbOgl+Ye6smeeHuI7lQG73rAwFXOGebqunLAp
         4hBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=P3XY5BXu;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=P3XY5BXu;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x225tvP54D7HausB0oEm5mjVSvtuzylH5uDZTn6ODegqoWp7Ag7oKEKCgPiJ/6c243mGXA3Ek0EkuRmF7fpvPIrs=
MIME-Version: 1.0
In-Reply-To: <20180208125542.15649-2-vigneshr@ti.com>
References: <20180208125542.15649-1-vigneshr@ti.com> <20180208125542.15649-2-vigneshr@ti.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 8 Feb 2018 17:16:07 +0200
Message-ID: <CAHp75Vdo+B=Z+ScUgYvoWMSP7G6iC=LOiW57dViXCXm=g2gOLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] serial: 8250: Don't service RX FIFO if interrupts are disabled
To: Vignesh R <vigneshr@ti.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>,
	linux-serial@vger.kernel.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux OMAP Mailing List <linux-omap@vger.kernel.org>,
	linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591837469077469236?=
X-GMAIL-MSGID: =?utf-8?q?1591846338961832540?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Feb 8, 2018 at 2:55 PM, Vignesh R <vigneshr@ti.com> wrote:
> Currently, data in RX FIFO is read based on UART_LSR register state even
> if RDI and RLSI interrupts are disabled in UART_IER register.
> This is because when IRQ handler is called due to TX FIFO empty event,
> RX FIFO is serviced based on UART_LSR register status instead of
> UART_IIR status. This defeats the purpose of disabling UART RX
> FIFO interrupts during throttling(see, omap_8250_throttle()) as IRQ
> handler continues to drain UART RX FIFO resulting in overflow of buffer
> at tty layer.
> Fix this by making sure that driver drains UART RX FIFO only when
> UART_IIR_RDI is set along with UART_LSR_BI or UART_LSR_DR bits.
>
> Signed-off-by: Vignesh R <vigneshr@ti.com>

> -       if (status & (UART_LSR_DR | UART_LSR_BI)) {
> +       if (status & (UART_LSR_DR | UART_LSR_BI) &&
> +           iir & UART_IIR_RDI) {

>                 if (!up->dma || handle_rx_dma(up, iir))

handle_rx_dma() checks for IRQ status as well.

But for now it seems we are on safe side since checks are done versus
IRQ status with bit 2 set, meaning that iir & RDI will be true.

>                         status = serial8250_rx_chars(up, status);
>         }

Anyway, thanks for the patch, though I need some time to test it on
non-OMAP hardware with DMA enabled.

-- 
With Best Regards,
Andy Shevchenko
