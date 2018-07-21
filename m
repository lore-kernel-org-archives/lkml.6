Return-Path: <SRS0=ZAeg=KF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91347ECDE5F
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:35:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F20E2064D
	for <linux-kernel@archiver.kernel.org>; Sat, 21 Jul 2018 15:35:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eiYq/2Cw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F20E2064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728314AbeGUQ2o (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 21 Jul 2018 12:28:44 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:46143 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727759AbeGUQ2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Jul 2018 12:28:44 -0400
Received: by mail-vk0-f65.google.com with SMTP id b14-v6so7408417vke.13;
        Sat, 21 Jul 2018 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=fW0vGocHL6pmND88KwtvakVtQDEo4Mc3nNZPxJd9sag=;
        b=eiYq/2CwMO/bZ0KAOCC7iNprL9QSNKqckl5Xhl5ZKyzAr2NwU8rcOeCab+VAIuibWd
         nQyZd/HTZ+fRx3YFRaVSGfAWbelTGXe3qW9y+IpjnrDxHllaCUwljgZhLNeEuLC7cayk
         FJqumWfeTiYyyzj+DS5LFStHZby3m5x649tIsBDn9LyeAZlVxGBzArTxykRTnlZU+ADY
         W/ChEHXG7QW0/BFWzCIeppz+hxcvmyTlounocEABjljacZAxXLQPxXr/FKMQzoA7n58t
         sgEHBukvU7mY2+oQFA9qn44h619WFpma3viTxgH6N/m82lub8DueTDWrszC/pescJJP/
         pT3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=fW0vGocHL6pmND88KwtvakVtQDEo4Mc3nNZPxJd9sag=;
        b=EZKzUL75mSIme2/jbpcQ2k3omIR+pkdvotCXRW2NC6rZelj9A/4xQHkI1kRUei51Rv
         boY1hL9RieM5LYvOA0eBpP/9pikWs5q49o1PxoH/00Y3MVPyNsehuUXjULTDigHq/ILx
         n4TKxZFiPTogdD8+0/8PfpnQhlFecenFOm1mhMzkaGKSr5teQgaPy51lqpj5s5SJly6j
         UyjlRMuHqQJPhPAiOAl3kcBkHS/4X09ZCgZEmwK0mRPkiuVzg6dFXdKZss2vChVANng7
         PRm1ybvjS+MYWQy2j2KIa+dsKF8vtNpBBx2CtAsjYnpSXj7uuHdfgFal6nIYfrvM8ZDJ
         L9sg==
X-Gm-Message-State: AOUpUlE6Fj2vy72Q1SO4vKGa1lMU9rTtDe/1P+KuHieLYdl0xVFz/LO3
        wGVaqFsr4rwDsegG0pBajRunkcgWTsh1LNbC+Rs=
X-Google-Smtp-Source: AAOMgpdHAQTNM6jUlrLaMs/0T05nfhCTyEfyGwjoQy2fQmcFWVAX3YWzm9Sg8RPCuE3c5a1Ask9kXBxeVudRWI4Tjow=
X-Received: by 2002:a1f:920b:: with SMTP id u11-v6mr3810219vkd.58.1532187334577;
 Sat, 21 Jul 2018 08:35:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a67:2149:0:0:0:0:0 with HTTP; Sat, 21 Jul 2018 08:35:33
 -0700 (PDT)
In-Reply-To: <1532120272-17157-2-git-send-email-soares@synopsys.com>
References: <1532120272-17157-1-git-send-email-soares@synopsys.com> <1532120272-17157-2-git-send-email-soares@synopsys.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 21 Jul 2018 18:35:33 +0300
Message-ID: <CAHp75VfYYmr7o6xkDbjaad3HxyzZgODzKfSNWdPXjM+YjTMANA@mail.gmail.com>
Subject: Re: [PATCH 1/3] i3c: master: Add driver for Synopsys DesignWare IP
To:     Vitor soares <Vitor.Soares@synopsys.com>
Cc:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Documentation List <linux-doc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Przemyslaw Sroka <psroka@cadence.com>,
        Arkadiusz Golec <agolec@cadence.com>,
        Alan Douglas <adouglas@cadence.com>,
        Bartosz Folta <bfolta@cadence.com>,
        Damian Kos <dkos@cadence.com>,
        Alicja Jurasik-Urbaniak <alicja@cadence.com>,
        Cyprian Wronka <cwronka@cadence.com>,
        Suresh Punnoose <sureshp@cadence.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "ijc+devicetree" <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Xiang Lin <Xiang.Lin@synaptics.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Sekhar Nori <nsekhar@ti.com>,
        Przemyslaw Gaj <pgaj@cadence.com>,
        Peter Rosin <peda@axentia.se>,
        Joao Pinto <Joao.Pinto@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 20, 2018 at 11:57 PM, Vitor soares
<Vitor.Soares@synopsys.com> wrote:
> This patch add driver for Synopsys DesignWare IP on top of
> I3C subsystem patchset proposal V6

Some of comments below related to style.
But unaligned helpers I think is good to use.

> +#include <linux/bitops.h>
> +#include <linux/clk.h>
> +#include <linux/completion.h>
> +#include <linux/err.h>
> +#include <linux/errno.h>
> +#include <linux/i3c/master.h>
> +#include <linux/init.h>
> +#include <linux/interrupt.h>
> +#include <linux/io.h>
> +#include <linux/ioport.h>
> +#include <linux/iopoll.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/reset.h>

All of them required? Why?

> +       default:

Just return false here?

> +               break;
> +       }
> +
> +       return false;

> +       for (i = 0; i < nbytes; i += 4) {
> +               u32 data = 0;
> +

> +               for (j = 0; j < 4 && (i + j) < nbytes; j++)
> +                       data |= (u32)bytes[i + j] << (j * 8);

NIH of get_unaligned_le32()

> +
> +               writel(data, master->regs + RX_TX_DATA_PORT);
> +       }
> +}
> +
> +static void dw_i3c_master_read_rx_fifo(struct dw_i3c_master *master,
> +                                      u8 *bytes, int nbytes)
> +{
> +       int i, j;
> +
> +       for (i = 0; i < nbytes; i += 4) {
> +               u32 data;
> +
> +               data = readl(master->regs + RX_TX_DATA_PORT);
> +


> +               for (j = 0; j < 4 && (i + j) < nbytes; j++)
> +                       bytes[i + j] = data >> (j * 8);

Ditto put_unaligned_le32() ?

> +       }
> +}

I'm wondering what else you open coded instead of using helpers we already have.

> +               writel(cmd->cmd_hi, master->regs + COMMAND_QUEUE_PORT);
> +               writel(cmd->cmd_lo, master->regs + COMMAND_QUEUE_PORT);

hmm... writesl()?

> +       info->pid = (u64)readl(master->regs + SLV_PID_VALUE);

Why explicit casting?


> +       u32 r;
> +
> +
> +       core_rate = clk_get_rate(master->core_clk);

Too many blank lines in between.

> +
> +

Ditto.

> +       /* Prepare DAT before launching DAA. */
> +       for (pos = 0; pos < master->maxdevs; pos++) {
> +               if (olddevs & BIT(pos))
> +                       continue;
> +
> +               ret = i3c_master_get_free_addr(m, last_addr + 1);
> +               if (ret < 0)
> +                       return -ENOSPC;
> +               master->addrs[pos] = ret;

> +               p = (ret >> 6) ^ (ret >> 5) ^ (ret >> 4) ^ (ret >> 3) ^
> +                   (ret >> 2) ^ (ret >> 1) ^ ret ^ 1;
> +               p = p & 1;

Is it parity calculus? Do we have something implemented in kernel already?

Btw, https://graphics.stanford.edu/~seander/bithacks.html#ParityNaive
offered this

v ^= v >> 4;
v &= 0xf;
v = (0x6996 >> v) & 1;


-- 
With Best Regards,
Andy Shevchenko
