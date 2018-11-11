Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978C3C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 10:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DA7920866
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 10:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="by+3WWcA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA7920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbeKKUHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 15:07:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:48112 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbeKKUHb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 15:07:31 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6248B20854;
        Sun, 11 Nov 2018 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541931561;
        bh=xanH/3xb73yfGEAKKPh9m0yuJTyqDG0bHFkgUMG3QRI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=by+3WWcAYLfdFXPAF/nPWkFqEHX7UaAplmYx2oI2xiYYomzkP6dXad54BDIIWpmZo
         AwzXUofvgQQcH5jfQ/DX/O4Hp/db0es1WgzxaTpc6Bk6KkWDBMACA1E+WkqtH506WH
         Qp951w73BbiyNVD1RtPYV+mzuT6aJukHgBid9zUU=
Date:   Sun, 11 Nov 2018 15:49:11 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     shun-chih.yu@mediatek.com
Cc:     Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        dmaengine@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, srv_wsdupstream@mediatek.com
Subject: Re: [PATCH 2/2] dmaengine: mediatek: Add MediaTek Command-Queue DMA
 controller for MT6765 SoC
Message-ID: <20181111101911.GF12092@vkoul-mobl>
References: <1539848951-14798-1-git-send-email-shun-chih.yu@mediatek.com>
 <1539848951-14798-3-git-send-email-shun-chih.yu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1539848951-14798-3-git-send-email-shun-chih.yu@mediatek.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-18, 15:49, shun-chih.yu@mediatek.com wrote:
> From: Shun-Chih Yu <shun-chih.yu@mediatek.com>
> 
> MediaTek Command-Queue DMA controller (CQDMA) on MT6765 SoC is dedicated
> to memory-to-memory transfer through queue based descriptor management.
> 
> There are only 3 physical channels inside CQDMA, while the driver is
> extended to support 32 virtual channels for multiple dma users to issue
> dma requests onto the CQDMA simultaneously.

I see some warns in the driver when I compile with C=1 please do fix
those in next rev

> +struct mtk_cqdma_vdesc {
> +	struct virt_dma_desc vd;
> +	size_t len;
> +	size_t residue;

why should you store residue in descriptor, it will get stale very soon!

> +	dma_addr_t dest;
> +	dma_addr_t src;
> +	struct dma_chan *ch;
> +
> +	struct list_head node;

why do you need your own list, vd has a list for descriptors!

> +struct mtk_cqdma_pchan {
> +	struct list_head queue;
> +	void __iomem *base;
> +	u32 irq;
> +
> +	refcount_t refcnt;

Can you submit more than one descriptor at any point of time?

> +struct mtk_cqdma_vchan {
> +	struct virt_dma_chan vc;
> +	struct mtk_cqdma_pchan *pc;
> +	struct completion issue_completion;
> +	bool issue_synchronize;

what lock protects this?

> +static void mtk_cqdma_start(struct mtk_cqdma_pchan *pc,
> +			    struct mtk_cqdma_vdesc *cvd)
> +{
> +	/* wait for the previous transaction done */
> +	if (mtk_cqdma_poll_engine_done(pc, true) < 0)
> +		dev_err(cqdma2dev(to_cqdma_dev(cvd->ch)), "cqdma wait transaction timeout\n");

Please split this to 2 lines to adhere to 80 chars limit

Also no bailout of error?

> +static struct mtk_cqdma_vdesc
> +*mtk_cqdma_consume_work_queue(struct mtk_cqdma_pchan *pc)
> +{
> +	struct mtk_cqdma_vchan *cvc;
> +	struct mtk_cqdma_vdesc *cvd, *ret = NULL;

ret initialization seems superfluous

> +static void mtk_cqdma_tasklet_cb(unsigned long data)
> +{
> +	struct mtk_cqdma_pchan *pc = (struct mtk_cqdma_pchan *)data;
> +	struct mtk_cqdma_vdesc *cvd = NULL;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pc->lock, flags);
> +	/* consume the queue */
> +	cvd = mtk_cqdma_consume_work_queue(pc);

why not do this from ISR, DMA should be submitted as fast as possible!

> +static int mtk_cqdma_alloc_chan_resources(struct dma_chan *c)
> +{
> +	struct mtk_cqdma_device *cqdma = to_cqdma_dev(c);
> +	struct mtk_cqdma_vchan *vc = to_cqdma_vchan(c);
> +	struct mtk_cqdma_pchan *pc = NULL;
> +	u32 i, min_refcnt = U32_MAX, refcnt;
> +	unsigned long flags;
> +
> +	/* allocate PC with the minimun refcount */
                                ^^^^^^^
typo 

> +static int mtk_cqdma_probe(struct platform_device *pdev)
> +{
> +	struct mtk_cqdma_device *cqdma;
> +	struct mtk_cqdma_vchan *vc;
> +	struct dma_device *dd;
> +	struct resource *res;
> +	int err;
> +	u32 i;
> +
> +	cqdma = devm_kzalloc(&pdev->dev, sizeof(*cqdma), GFP_KERNEL);
> +	if (!cqdma)
> +		return -ENOMEM;
> +
> +	dd = &cqdma->ddev;
> +
> +	cqdma->clk = devm_clk_get(&pdev->dev, "cqdma");
> +	if (IS_ERR(cqdma->clk)) {
> +		dev_err(&pdev->dev, "No clock for %s\n",
> +			dev_name(&pdev->dev));
> +		return PTR_ERR(cqdma->clk);
> +	}
> +
> +	dma_cap_set(DMA_MEMCPY, dd->cap_mask);
> +
> +	dd->copy_align = MTK_CQDMA_ALIGN_SIZE;
> +	dd->device_alloc_chan_resources = mtk_cqdma_alloc_chan_resources;
> +	dd->device_free_chan_resources = mtk_cqdma_free_chan_resources;
> +	dd->device_tx_status = mtk_cqdma_tx_status;
> +	dd->device_issue_pending = mtk_cqdma_issue_pending;
> +	dd->device_prep_dma_memcpy = mtk_cqdma_prep_dma_memcpy;
> +	dd->device_terminate_all = mtk_cqdma_terminate_all;
> +	dd->src_addr_widths = MTK_CQDMA_DMA_BUSWIDTHS;
> +	dd->dst_addr_widths = MTK_CQDMA_DMA_BUSWIDTHS;
> +	dd->directions = BIT(DMA_MEM_TO_MEM);
> +	dd->residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
> +	dd->dev = &pdev->dev;
> +	INIT_LIST_HEAD(&dd->channels);
> +
> +	if (pdev->dev.of_node && of_property_read_u32(pdev->dev.of_node,
> +						      "dma-requests",
> +						      &cqdma->dma_requests)) {
> +		dev_info(&pdev->dev,
> +			 "Using %u as missing dma-requests property\n",
> +			 MTK_CQDMA_NR_VCHANS);
> +
> +		cqdma->dma_requests = MTK_CQDMA_NR_VCHANS;
> +	}
> +
> +	if (pdev->dev.of_node && of_property_read_u32(pdev->dev.of_node,
> +						      "dma-channels",
> +						      &cqdma->dma_channels)) {
> +		dev_info(&pdev->dev,
> +			 "Using %u as missing dma-channels property\n",
> +			 MTK_CQDMA_NR_PCHANS);
> +
> +		cqdma->dma_channels = MTK_CQDMA_NR_PCHANS;
> +	}
> +
> +	cqdma->pc = devm_kcalloc(&pdev->dev, cqdma->dma_channels,
> +				 sizeof(*cqdma->pc), GFP_KERNEL);
> +	if (!cqdma->pc)
> +		return -ENOMEM;
> +
> +	/* initialization for PCs */
> +	for (i = 0; i < cqdma->dma_channels; ++i) {
> +		cqdma->pc[i] = devm_kcalloc(&pdev->dev, 1,
> +					    sizeof(**cqdma->pc), GFP_KERNEL);
> +		if (!cqdma->pc[i])
> +			return -ENOMEM;
> +
> +		INIT_LIST_HEAD(&cqdma->pc[i]->queue);
> +		spin_lock_init(&cqdma->pc[i]->lock);
> +		refcount_set(&cqdma->pc[i]->refcnt, 0);
> +
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, i);
> +		if (!res) {
> +			dev_err(&pdev->dev, "No mem resource for %s\n",
> +				dev_name(&pdev->dev));
> +			return -EINVAL;
> +		}
> +
> +		cqdma->pc[i]->base = devm_ioremap_resource(&pdev->dev, res);
> +		if (IS_ERR(cqdma->pc[i]->base))
> +			return PTR_ERR(cqdma->pc[i]->base);
> +
> +		/* allocate IRQ resource */
> +		res = platform_get_resource(pdev, IORESOURCE_IRQ, i);
> +		if (!res) {
> +			dev_err(&pdev->dev, "No irq resource for %s\n",
> +				dev_name(&pdev->dev));
> +			return -EINVAL;
> +		}
> +		cqdma->pc[i]->irq = res->start;
> +
> +		err = devm_request_irq(&pdev->dev, cqdma->pc[i]->irq,
> +				       mtk_cqdma_irq, 0, dev_name(&pdev->dev),
> +				       cqdma);
> +		if (err) {
> +			dev_err(&pdev->dev,
> +				"request_irq failed with err %d\n", err);
> +			return -EINVAL;
> +		}
> +	}
> +
> +	/* allocate resource for VCs */
> +	cqdma->vc = devm_kcalloc(&pdev->dev, cqdma->dma_requests,
> +				 sizeof(*cqdma->vc), GFP_KERNEL);
> +	if (!cqdma->vc)
> +		return -ENOMEM;
> +
> +	for (i = 0; i < cqdma->dma_requests; i++) {
> +		vc = &cqdma->vc[i];
> +		vc->vc.desc_free = mtk_cqdma_vdesc_free;
> +		vchan_init(&vc->vc, dd);
> +		init_completion(&vc->issue_completion);
> +	}
> +
> +	err = dma_async_device_register(dd);
> +	if (err)
> +		return err;
> +
> +	err = of_dma_controller_register(pdev->dev.of_node,
> +					 of_dma_xlate_by_chan_id, cqdma);
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"MediaTek CQDMA OF registration failed %d\n", err);
> +		goto err_unregister;
> +	}
> +
> +	err = mtk_cqdma_hw_init(cqdma);
> +	if (err) {
> +		dev_err(&pdev->dev,
> +			"MediaTek CQDMA HW initialization failed %d\n", err);
> +		goto err_unregister;
> +	}
> +
> +	platform_set_drvdata(pdev, cqdma);
> +
> +	/* initialize tasklet for each PC */
> +	for (i = 0; i < cqdma->dma_channels; ++i)
> +		tasklet_init(&cqdma->pc[i]->tasklet, mtk_cqdma_tasklet_cb,
> +			     (unsigned long)cqdma->pc[i]);
> +
> +	dev_info(&pdev->dev, "MediaTek CQDMA driver registered\n");

debug log please

> +static int mtk_cqdma_remove(struct platform_device *pdev)
> +{
> +	struct mtk_cqdma_device *cqdma = platform_get_drvdata(pdev);
> +	struct mtk_cqdma_vchan *vc;
> +	unsigned long flags;
> +	int i;
> +
> +	/* kill VC task */
> +	for (i = 0; i < cqdma->dma_requests; i++) {
> +		vc = &cqdma->vc[i];
> +
> +		list_del(&vc->vc.chan.device_node);
> +		tasklet_kill(&vc->vc.task);
> +	}
> +
> +	/* disable interrupt */
> +	for (i = 0; i < cqdma->dma_channels; i++) {
> +		spin_lock_irqsave(&cqdma->pc[i]->lock, flags);
> +		mtk_dma_clr(cqdma->pc[i], MTK_CQDMA_INT_EN,
> +			    MTK_CQDMA_INT_EN_BIT);
> +		spin_unlock_irqrestore(&cqdma->pc[i]->lock, flags);
> +
> +		/* Waits for any pending IRQ handlers to complete */
> +		synchronize_irq(cqdma->pc[i]->irq);
> +
> +		tasklet_kill(&cqdma->pc[i]->tasklet);
> +	}

please kill VC tasks after this, they can still be fired while you are
disabling interrupt, so interrupt first and then tasklets
-- 
~Vinod
