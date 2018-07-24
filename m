Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B652FC6778A
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B0C020875
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 13:09:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Roy6cHAj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B0C020875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388396AbeGXOQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 10:16:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388299AbeGXOQS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 10:16:18 -0400
Received: from localhost (unknown [171.61.90.205])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3912820874;
        Tue, 24 Jul 2018 13:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532437792;
        bh=smruhvTynsLIpO/HqtFh1l2Z+jgrXXMobQ4m1PZ8964=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Roy6cHAj51vE9JNPDsaiI+HlW2sACjfsHj0S4k42fwlZ7nPWyG6SVRF71KINzXKKM
         ma2Ck0vIEfrvJKKgNgzeHDobMAOV7uW62zWfoyMxn1BeQY7h1hKS+iqawWuKzxh0Am
         bCZMjBkdPkHyjdIqo1d3MahDcQdZLeyGgiLxXPT8=
Date:   Tue, 24 Jul 2018 18:39:43 +0530
From:   Vinod <vkoul@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     dan.j.williams@intel.com, afaerber@suse.de, robh+dt@kernel.org,
        dmaengine@vger.kernel.org, liuwei@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        manivannanece23@gmail.com, thomas.liau@actions-semi.com,
        jeff.chen@actions-semi.com, pn@denx.de, edgar.righi@lsitec.org.br
Subject: Re: [PATCH v2 3/4] dma: Add Actions Semi Owl family S900 DMA driver
Message-ID: <20180724130943.GD3661@vkoul-mobl>
References: <20180723041743.32024-1-manivannan.sadhasivam@linaro.org>
 <20180723041743.32024-4-manivannan.sadhasivam@linaro.org>
 <20180724124614.GB2587@vkoul-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180724124614.GB2587@vkoul-mobl>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

somehow this got stuck so sending again...

On 24-07-18, 18:16, Vinod wrote:
> On 23-07-18, 09:47, Manivannan Sadhasivam wrote:
> 
> > +#include <linux/bitops.h>
> > +#include <linux/clk.h>
> > +#include <linux/delay.h>
> > +#include <linux/dmaengine.h>
> > +#include <linux/dma-mapping.h>
> > +#include <linux/dmapool.h>
> > +#include <linux/err.h>
> > +#include <linux/init.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/mm.h>
> > +#include <linux/module.h>
> > +#include <linux/of_device.h>
> > +#include <linux/of_dma.h>
> 
> do you need this?
> 
> > +/* OWL_DMAX_MODE Bits */
> > +#define OWL_DMA_MODE_TS(x)			(((x) & 0x3f) << 0)
> > +#define OWL_DMA_MODE_ST(x)			(((x) & 0x3) << 8)
> > +#define	OWL_DMA_MODE_ST_DEV			OWL_DMA_MODE_ST(0)
> > +#define	OWL_DMA_MODE_ST_DCU			OWL_DMA_MODE_ST(2)
> > +#define	OWL_DMA_MODE_ST_SRAM			OWL_DMA_MODE_ST(3)
> 
> what are you trying to do with this? Generally we would define register
> bits using BIT and GENMASK here..
> 
> > +/* Extract the bit field to new shift */
> > +#define BIT_FIELD(val, width, shift, newshift)	\
> > +		((((val) >> (shift)) & ((BIT(width)) - 1)) << (newshift))
> 
> why new shift? I guess you want to extract bits from a register here and
> use those, right?
> 
> > +struct owl_dma_lli_hw {
> > +	u32	next_lli;	/* physical address of the next link list */
> > +	u32	saddr;		/* source physical address */
> > +	u32	daddr;		/* destination physical address */
> > +	u32	flen:20;	/* frame length */
> > +	u32	fcnt:12;	/* frame count */
> > +	u32	src_stride;	/* source stride */
> > +	u32	dst_stride;	/* destination stride */
> > +	u32	ctrla;		/* dma_mode and linklist ctrl */
> > +	u32	ctrlb;		/* interrupt control */
> > +	u32	const_num;	/* data for constant fill */
> 
> i think you can skip comment here or kernel-doc style, please pick one
> and not both
> 
> > +struct owl_dma_txd {
> > +	struct virt_dma_desc	vd;
> > +	struct list_head	lli_list;
> 
> why do you need this list. vd has its own list as well!
> 
> > +static void pchan_update(void __iomem *reg, u32 val, bool state)
> 
> why does this not use pchan as arg as the name of API implies (you did
> that on the other two)
> 
> > +static inline int owl_dma_cfg_lli(struct owl_dma_vchan *vchan,
> > +				  struct owl_dma_lli *lli,
> > +				  dma_addr_t src, dma_addr_t dst,
> > +				  u32 len, enum dma_transfer_direction dir)
> > +{
> > +	struct owl_dma_lli_hw *hw = &lli->hw;
> > +	u32 mode;
> > +
> > +	mode = OWL_DMA_MODE_PW(0);
> > +
> > +	switch (dir) {
> > +	case DMA_MEM_TO_MEM:
> > +		mode |= OWL_DMA_MODE_TS(0) | OWL_DMA_MODE_ST_DCU |
> > +			OWL_DMA_MODE_DT_DCU | OWL_DMA_MODE_SAM_INC |
> > +			OWL_DMA_MODE_DAM_INC;
> > +
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	hw->next_lli = 0; /* One link list by default */
> > +	hw->saddr = src;
> > +	hw->daddr = dst;
> > +
> > +	hw->fcnt = 1; /* Frame count fixed as 1 */
> > +	hw->flen = len; /* Max frame length is 1MB */
> 
> are you checking that somewhere?
> 
> > +static struct owl_dma_pchan *owl_dma_get_pchan(struct owl_dma *od,
> > +					       struct owl_dma_vchan *vchan)
> > +{
> > +	struct owl_dma_pchan *pchan;
> > +	unsigned long flags;
> > +	int i;
> > +
> > +	for (i = 0; i < od->nr_pchans; i++) {
> > +		pchan = &od->pchans[i];
> > +
> > +		spin_lock_irqsave(&pchan->lock, flags);
> > +		if (!pchan->vchan) {
> > +			pchan->vchan = vchan;
> > +			spin_unlock_irqrestore(&pchan->lock, flags);
> > +			break;
> > +		}
> > +
> > +		spin_unlock_irqrestore(&pchan->lock, flags);
> > +	}
> > +
> > +	if (i == od->nr_pchans) {
> > +		/* No physical channel available, cope with it */
> > +		dev_dbg(od->dma.dev, "no physical channel available\n");
> 
> not sure about this. The concept of virt-chan is that you would submit a
> transaction to controller for different channels. If channel is busy the
> txn is simply queued up. You do not need a _free_ channel
> 
> > +static void owl_dma_pause_pchan(struct owl_dma_pchan *pchan)
> > +{
> > +	pchan_writel(pchan, 1, OWL_DMAX_PAUSE);
> > +}
> > +
> > +static void owl_dma_resume_pchan(struct owl_dma_pchan *pchan)
> > +{
> > +	pchan_writel(pchan, 0, OWL_DMAX_PAUSE);
> > +}
> 
> mempcy and pause/resume dont make much sense, are you sure you want that
> here and not later on slave copy
> 
> > +static void owl_dma_free_txd(struct owl_dma *od, struct owl_dma_txd *txd)
> > +{
> > +	struct owl_dma_lli *lli, *_lli;
> > +
> > +	if (unlikely(!txd))
> > +		return;
> > +
> > +	list_for_each_entry_safe(lli, _lli, &txd->lli_list, node) {
> > +		owl_dma_free_lli(od, lli);
> > +	}
> 
> braces not required here
> 
> > +static int owl_dma_remove(struct platform_device *pdev)
> > +{
> > +	struct owl_dma *od = platform_get_drvdata(pdev);
> > +
> > +	of_dma_controller_free(pdev->dev.of_node);
> > +	dma_async_device_unregister(&od->dma);
> > +
> > +	/* Mask all interrupts for this execution environment */
> > +	dma_writel(od, 0x0, OWL_DMA_IRQ_EN0);
> > +	owl_dma_free(od);
> 
> the tasklets are killed but irqs can still run and trigger the irqs :)
> -- 
> ~Vinod

-- 
~Vinod
