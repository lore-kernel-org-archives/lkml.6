Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519754255; cv=none;
        d=google.com; s=arc-20160816;
        b=rnq9NB85jMm2z56qw1/TNr0t/McXCDPGN6zffQNxeElirE3x0BqCRxpPjFVSScGmfl
         vkSVkNfflgcIUtclRQcJG3YvWwWyThTXG7x/khOgV2dEaSJChEk7T/0kqUyzj34QOAEy
         fFyYiSD/lH4/v0cFE2jqU5qNHDiq/Bs07A2KXKiQCZJfnzqZbP71aTGjOoWGgzmTgBhR
         Jdrkv/16fCE9mmnkneAWqGqTUUZUFodO/x1IbEn4gxD0ze8yn3gh94n95SxnkDkYfUoL
         2IVSMQBWAG54ntqeqpuUwrAyfcmQfqWnVX1L7iWIQmKMD+YCIFNgIj2swA9/CiwWBwJo
         yklQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=p6uvN++qZaFMB8BSBW9KhHrsq4D6eRKv7BjDC5K3pYU=;
        b=pgmPkhiY2gCrTafoYTDW0N1bCT3se23S/vLRqwIQCktUS6dunawAi6gBnV6RegvPOy
         thGIbxwt6ybShhj+i3n8yH9Tt/3KUoXMVrkxGYLnBrxrtp8FnvJdAlkhGmxc32CL6a8N
         COnkWPQtJZ5PmLu0BpxPPjfRLG5i+QJ2zMq2BugTJFbT0CoNBBNafH13uh13xDnFoTae
         cSaHYOvzT0otl1pe/L67DZDWpviEtyMQqplafSExbpiUxPt/2qnzNCRXkagtJaI/dzmP
         Zy75jaC9GiiG/009Yg2nz90u7LgaG8eB5YSs61OPaOz90a6vODdUZpiZqwenDi6Jxicd
         6vkQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Co+FURVX;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=Co+FURVX;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELsPemxPr2/jcz8hHGCvGA5zF6NndTpwUOXBEBibAsi2aHEbizBhuYCKKRzX5NzZmF2cmwrtma/vwNr2PIAouf0=
MIME-Version: 1.0
In-Reply-To: <20180227153106.3224-1-mmoese@suse.de>
References: <20180227153106.3224-1-mmoese@suse.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 Feb 2018 19:57:34 +0200
Message-ID: <CAHp75VddLV3Ke8J3hYw0wLO_77H8K20J_g=QeLG8B0XYt90ZRA@mail.gmail.com>
Subject: Re: [PATCH] 8250-men-mcb: add support for 16z025 and 16z057
To: Michael Moese <mmoese@suse.de>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, Johannes Thumshirn <jthumshirn@suse.de>,
	Andreas Geissler <andreas.geissler@men.de>, Ben Turner <ben.turner@21net.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593568644699224821?=
X-GMAIL-MSGID: =?utf-8?q?1593577838216528962?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 5:31 PM, Michael Moese <mmoese@suse.de> wrote:
> Add support for two MEN UARTs (16z025 and 16z057) to the
> 8250_men_mcb driver.
> The 16z025 consists of up to four ports, the 16z057 has
> exactly four ports. Apart from that, all of them share the
> Port settings.

> -       else if  (strncmp(mdev->bus->name, "F216", 4) == 0)
> +       else if (strncmp(mdev->bus->name, "F216", 4) == 0)

What's changed?

>                 clkval = 1843200;


> +       switch (mdev->id) {
> +       case MEN_UART_ID_Z125:
> +               num_ports = 1U;
> +               break;
> +       case MEN_UART_ID_Z025:
> +               num_ports = readb(membase) >> 4;
> +               break;
> +       case MEN_UART_ID_Z057:
> +               num_ports = 4U;
> +               break;
> +       default:
> +               dev_err(&mdev->dev, "no supported device!\n");
> +               return -ENODEV;
> +       }

(1)

> +               data[i].uart.port.mapbase = (unsigned long) mem->start
> +                                           + (i * MEN_UART_MEM_SIZE);

Redundant parens.


> +       switch (mdev->id) {
> +       case MEN_UART_ID_Z125:
> +               num_ports = 1U;
> +               break;
> +       case MEN_UART_ID_Z025:
> +               num_ports = readb(data[0].uart.port.membase) >> 4;
> +               break;
> +       case MEN_UART_ID_Z057:
> +               num_ports = 4U;
> +               break;
> +       default:
> +               dev_err(&mdev->dev, "no supported device!\n");
> +               return;
> +       }

Can you deduplicate this with (1)?


-- 
With Best Regards,
Andy Shevchenko
