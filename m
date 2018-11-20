Return-Path: <SRS0=i6x1=N7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E30ACC43610
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:11:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A446C214D9
	for <linux-kernel@archiver.kernel.org>; Tue, 20 Nov 2018 08:11:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A446C214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726499AbeKTSiy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 20 Nov 2018 13:38:54 -0500
Received: from mail.bootlin.com ([62.4.15.54]:49551 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726215AbeKTSiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Nov 2018 13:38:54 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 3C09A2074F; Tue, 20 Nov 2018 09:11:03 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-13-146.w90-88.abo.wanadoo.fr [90.88.134.146])
        by mail.bootlin.com (Postfix) with ESMTPSA id DDEA6206A1;
        Tue, 20 Nov 2018 09:10:52 +0100 (CET)
Date:   Tue, 20 Nov 2018 09:10:52 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     masonccyang@mxic.com.tw, Mark Brown <broonie@kernel.org>,
        Trent Piepho <tpiepho@impinj.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-spi <linux-spi@vger.kernel.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Simon Horman <horms@verge.net.au>, juliensu@mxic.com.tw,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        zhengxunli@mxic.com.tw
Subject: Re: [PATCH 1/2] spi: Add Renesas R-Car RPC SPI controller driver
Message-ID: <20181120091052.096ab7e3@bbrezillon>
In-Reply-To: <CAMuHMdVjqkHsqEjEgBWg0eGtE-9ND+a=OeHwu=r39LrfkQq=Yw@mail.gmail.com>
References: <1542621690-10229-1-git-send-email-masonccyang@mxic.com.tw>
        <1542621690-10229-2-git-send-email-masonccyang@mxic.com.tw>
        <CAMuHMdVjqkHsqEjEgBWg0eGtE-9ND+a=OeHwu=r39LrfkQq=Yw@mail.gmail.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Nov 2018 09:01:29 +0100
Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > --- /dev/null
> > +++ b/drivers/spi/spi-renesas-rpc.c
> > @@ -0,0 +1,750 @@  
> 
> > +static int rpc_spi_set_freq(struct rpc_spi *rpc, unsigned long freq)
> > +{
> > +       int ret;
> > +
> > +       if (rpc->cur_speed_hz == freq)
> > +               return 0;
> > +
> > +       clk_disable_unprepare(rpc->clk_rpc);
> > +       ret = clk_set_rate(rpc->clk_rpc, freq);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = clk_prepare_enable(rpc->clk_rpc);
> > +       if (ret)
> > +               return ret;  
> 
> The clk_{disable_unprepare,prepare_enable}() may be needed on the Macronix
> controller you based this driver on, but will be futile on Renesas SoCs.
> 
> As the RPC is part of the CPG/MSSR clock domain, its clock will be controlled
> by the Runtime PM.  As you've already called pm_runtime_get_sync() from your
> .probe() calback, Runtime PM will have enabled the clock.
> If you disable it manually, you create an imbalance between automatic and
> manual clock control.
> 
> So please don't control the clock explicitly, but always use
> pm_runtime_*() calls.

More about that. The reason we did that on MXIC is that the clk rate
can't be changed when the clk is enabled. So we have to

1/ explicitly disable the clk that has been enabled by runtime PM
2/ set the new rate
3/ re-enable the clk

So the clk enable/disable are not unbalanced, but it's also true that
this disable/set_rate/enable dance might be unneeded on your platform.
