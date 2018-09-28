Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35999C43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:29:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17052172C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 08:29:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D17052172C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbeI1OwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 10:52:25 -0400
Received: from mail.bootlin.com ([62.4.15.54]:47137 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbeI1OwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 10:52:24 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 5A71620AA0; Fri, 28 Sep 2018 10:29:45 +0200 (CEST)
Received: from bbrezillon (guest-nat.fw1.untrust.par1.mozilla.net [185.155.181.200])
        by mail.bootlin.com (Postfix) with ESMTPSA id 2C7662074F;
        Fri, 28 Sep 2018 10:29:35 +0200 (CEST)
Date:   Fri, 28 Sep 2018 10:29:35 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     masonccyang@mxic.com.tw
Cc:     broonie@kernel.org, juliensu@mxic.com.tw,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
        tpiepho@impinj.com, zhengxunli@mxic.com.tw
Subject: Re: [PATCH 1/2] spi: Add MXIC controller driver
Message-ID: <20180928102935.4c3811b4@bbrezillon>
In-Reply-To: <OF74F67ECA.BEFB2D2A-ON48258316.002C2CD6-48258316.002DE896@mxic.com.tw>
References: <1537168579-31593-1-git-send-email-masonccyang@mxic.com.tw>
        <1537168579-31593-2-git-send-email-masonccyang@mxic.com.tw>
        <20180917140922.3132ab99@bbrezillon>
        <OF74F67ECA.BEFB2D2A-ON48258316.002C2CD6-48258316.002DE896@mxic.com.tw>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mason,

On Fri, 28 Sep 2018 16:21:27 +0800
masonccyang@mxic.com.tw wrote:

> > > +static int mxic_spi_mem_exec_op(struct spi_mem *mem,
> > > +            const struct spi_mem_op *op)
> > > +{
> > > +   struct mxic_spi *mxic = spi_master_get_devdata(mem->spi->master);
> > > +   int nio = 1, i, ret;
> > > +   u32 ss_ctrl;
> > > +   u8 addr[8];
> > > +
> > > +   ret = mxic_spi_clk_setup(mem->spi);
> > > +   if (ret)
> > > +      return ret;  
> > 
> > Hm, can we change the rate when the clk/PLL is enabled? If not then
> > you'll have to first call pm_runtime_get_sync() to start from a know
> > state, then inside mxic_spi_clk_setup(), call mxic_spi_clk_disable(),
> > change the rate and call mxic_spi_clk_enable().
> >   
> 
> I have removed this clk_setup() in patch v3, 
> I think spi clock frequence changed should be modified from User space
> by something like sys-fs, right ?

No, it shouldn't. It should be changed when the driver detects it needs
to be changed (access to a different spi device using a different freq).
My point was: make sure the clk is disable when you change the rate.


> 
> 
> > > +
> > > +static int mxic_spi_probe(struct platform_device *pdev)
> > > +{
> > > +   ret = clk_prepare_enable(mxic->ps_clk);
> > > +   if (ret)
> > > +      return ret;
> > > +
> > > +   pm_runtime_use_autosuspend(&pdev->dev);
> > > +   pm_runtime_set_autosuspend_delay(&pdev->dev,   
> SPI_AUTOSUSPEND_TIMEOUT);
> > > +   pm_runtime_set_active(&pdev->dev);
> > > +   pm_runtime_enable(&pdev->dev);
> > > +   master->auto_runtime_pm = true;
> > > +
> > > +   master->num_chipselect = 1;
> > > +   master->setup = mxic_spi_setup;
> > > +   master->mem_ops = &mxic_spi_mem_ops;
> > > +
> > > +   master->set_cs = mxic_spi_set_cs;
> > > +   master->transfer_one = mxic_spi_transfer_one;
> > > +   master->bits_per_word_mask = SPI_BPW_MASK(8);
> > > +   master->mode_bits = SPI_CPOL | SPI_CPHA |
> > > +         SPI_RX_DUAL | SPI_TX_DUAL |
> > > +         SPI_RX_QUAD | SPI_TX_QUAD;
> > > +
> > > +   mxic_spi_hw_init(mxic);
> > > +
> > > +   pm_runtime_mark_last_busy(&pdev->dev);
> > > +   pm_runtime_put_autosuspend(&pdev->dev);  
> > 
> > Okay, I'll let others review the runtime PM init/cleanup bits, because
> > I'm not an expert, but I don't remember seeing this
> > pm_runtime_set_active()+pm_runtime_mark_last_busy()
> > +pm_runtime_put_autosuspend()
> > dance in the drivers I worked on. Most probably because they were not
> > using autosuspend.
> > 
> > [1]https://elixir.bootlin.com/linux/v4.19-rc4/source/drivers/spi/
> > spi-mem.c#L210
> > [2]  
> https://elixir.bootlin.com/linux/v4.19-rc4/source/drivers/spi/spi.c#L1214
> 
> In patch v2, the spi-mxic controller will auto enter suspend mode after 2 
> sec,
> and resume again if spi device read/write is needed.
> 
> In patch v3, removed it due to run time PM functions are enabled by the 
> core [1][2].

Okay. It seems you didn't patch spi-mem.c to call
pm_runtime_put_autosuspend() instead of pm_runtime_put(). Do you plan
to send a patch for that?

Regards,

Boris
