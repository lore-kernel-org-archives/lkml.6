Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520263026; cv=none;
        d=google.com; s=arc-20160816;
        b=XzC4OIbXW58UvzT9lsll1QvFiypexKa6/6H6Js2dTf2M1aNmhR/NTkfDo9K8FLfz4m
         3aXW0zK2me/JZkseNw7i2vfWmngVUK9P7mR3JiHulkxipIi02DzPoO7CpEiqiPBakF6I
         9eGo82zAFr8adJgewfHN2OSTLn7l+ZhBGXqcZVvU3k/oeVb00r2jgwhyLfbxXb9Twywv
         cJY+Jh7iy5AKrWMExDQ8/YP9MoaxAVntCn5dmhaz822X4N4xiAjTM+vnxgzID2oLcqO3
         1F08hOcWGpd0lHkiyHJD5thimfEyoP4L6Yh0gZ3EuuMUq1qDG3ZBz/rheDOhWWjTpqKV
         rvog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=9aO9eb6np451QX1x1t4Zl13seLdcRWY1vDCqdAB/nMU=;
        b=NYDoDWeBETaLXRF8xJVv6Qby12e1d9OeHKJuGkF1Hjd3zdjTGhtBkhCrHEdi9XgdGH
         7hLbofh+hcY3cprkHiHJ1ifliLKgYxhU26fH1c0OweMRyXrcbIk7ElXiY2sstPqsj1de
         crXsIW+sUkJfXX/4uEUtbQh9gXFOaWLsRpIG4MXs8atde/RLnzrOgRnY3syhsmMid7gm
         GgRpuIquO2GtYho8DUs6mDn27wm7lNfvlsqURg8eTvqGDRr3XEsBGxZ9CMp0gk+pWRGr
         ONf8c7JnW7RhaFmUVNOYmL2FuvN51o3cpyrlfWzvDy4DGbV3cjWsqe0HDtcbohNip7vv
         Llhw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hutwhyRf;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=hutwhyRf;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELvQUm/buv0pR1jc6vHz3gaKLHelX+o9ndK5jRotRS5XX0VBtFbuRO6zALA2eSciDA4eKOBZk0SUIECkU/lZUu8=
MIME-Version: 1.0
In-Reply-To: <20180305082235.12777-1-mmoese@suse.de>
References: <20180305082235.12777-1-mmoese@suse.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 5 Mar 2018 17:17:04 +0200
Message-ID: <CAHp75VfVm5B7NawwYdzNFkCgJG+2Ht8pkAL0Drr08GJ+p2ZVow@mail.gmail.com>
Subject: Re: [PATCH v3] 8250-men-mcb: add support for 16z025 and 16z057
To: Michael Moese <mmoese@suse.de>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, Johannes Thumshirn <jthumshirn@suse.de>,
	Andreas Geissler <andreas.geissler@men.de>, Ben Turner <ben.turner@21net.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594085248786012954?=
X-GMAIL-MSGID: =?utf-8?q?1594111322725847501?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 5, 2018 at 10:22 AM, Michael Moese <mmoese@suse.de> wrote:
> Add support for two MEN UARTs (16z025 and 16z057) to the
> 8250_men_mcb driver.
> The 16z025 consists of up to four ports, the 16z057 has
> exactly four ports. Apart from that, all of them share the
> Port settings.

> Changes to v2:
> Added include of linux/io.h due to finding of kbuild robot.

Hmm... Is it there?

>  static int serial_8250_men_mcb_probe(struct mcb_device *mdev,
>                                      const struct mcb_device_id *id)
>  {

>         mem = mcb_get_resource(mdev, IORESOURCE_MEM);

>         if (mem == NULL)
>                 return -ENXIO;

Redundant.

> +       membase = devm_ioremap_resource(&mdev->dev, mem);
> +       if (IS_ERR(membase))
> +               return PTR_ERR_OR_ZERO(membase);

> +       for (i = 0; i < num_ports; i++) {

> +               /* ok, register the port */
> +               data[i].line = serial8250_register_8250_port(&data[i].uart);
> +               if (data[i].line < 0) {
> +                       dev_err(&mdev->dev, "unable to register UART port\n");
> +                       return data[i].line;
> +               }
> +               dev_info(&mdev->dev, "found MCB UART: ttyS%d\n", data[i].line);

Consider to use  struct uart_port::name instead.

> +       }
>
>         return 0;
>  }
>
>  static void serial_8250_men_mcb_remove(struct mcb_device *mdev)
>  {

> +       if (!data)
> +               return;

When it's possible?

>  }

-- 
With Best Regards,
Andy Shevchenko
