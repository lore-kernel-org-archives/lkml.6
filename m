Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84DBC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:00:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90BCE2086A
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 07:00:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rvbtbLSX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90BCE2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbeIKL6H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 07:58:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:54966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726746AbeIKL6G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 07:58:06 -0400
Received: from localhost (unknown [171.76.126.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4D5E2086E;
        Tue, 11 Sep 2018 07:00:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1536649213;
        bh=bdYi9uHEbURCNxxgmaHD0YbysZhz3M3eLotl2c4QiUw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rvbtbLSXoEHfD0CsESlSH0KgtY27LMtBJJezgV4M9qF/luM27hwxyVIoCF1oi7dza
         GETRaWcNNqcxlPhK8ZMGr23M/ytAnqzvSZ1nPFA1xNwNNpU91qStvpDxpH8bCywDVI
         e5l1WQhiOQyZnvC1gYn4hQa7NnVuNY52J2i4wGX8=
Date:   Tue, 11 Sep 2018 12:30:03 +0530
From:   Vinod <vkoul@kernel.org>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     dmaengine@vger.kernel.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/2] dmaengine: uniphier-mdmac: add UniPhier MIO DMAC
 driver
Message-ID: <20180911070003.GI2634@vkoul-mobl>
References: <1535074873-15617-1-git-send-email-yamada.masahiro@socionext.com>
 <1535074873-15617-3-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1535074873-15617-3-git-send-email-yamada.masahiro@socionext.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-08-18, 10:41, Masahiro Yamada wrote:

> +/* mc->vc.lock must be held by caller */
> +static u32 __uniphier_mdmac_get_residue(struct uniphier_mdmac_desc *md)
> +{
> +	u32 residue = 0;
> +	int i;
> +
> +	for (i = md->sg_cur; i < md->sg_len; i++)
> +		residue += sg_dma_len(&md->sgl[i]);

so if the descriptor is submitted to hardware, we return the descriptor
length, which is not correct.

Two cases are required to be handled:
1. Descriptor is in queue (IMO above logic is fine for that, but it can
be calculated at descriptor submit and looked up here)

2. Descriptor is running (interesting case), you need to read current
register and offset that from descriptor length and return

> +static struct dma_async_tx_descriptor *uniphier_mdmac_prep_slave_sg(
> +					struct dma_chan *chan,
> +					struct scatterlist *sgl,
> +					unsigned int sg_len,
> +					enum dma_transfer_direction direction,
> +					unsigned long flags, void *context)
> +{
> +	struct virt_dma_chan *vc = to_virt_chan(chan);
> +	struct uniphier_mdmac_desc *md;
> +
> +	if (!is_slave_direction(direction))
> +		return NULL;
> +
> +	md = kzalloc(sizeof(*md), GFP_KERNEL);

_prep calls can be invoked from atomic context, so this should be
GFP_NOWAIT, see Documentation/driver-api/dmaengine/provider.rst

> +	if (!md)
> +		return NULL;
> +
> +	md->sgl = sgl;
> +	md->sg_len = sg_len;
> +	md->dir = direction;
> +
> +	return vchan_tx_prep(vc, &md->vd, flags);

this seems missing stuff. Where do you do register calculation for the
descriptor and where is slave_config here, how do you know where to
send/receive data form/to (peripheral)

> +static enum dma_status uniphier_mdmac_tx_status(struct dma_chan *chan,
> +						dma_cookie_t cookie,
> +						struct dma_tx_state *txstate)
> +{
> +	struct virt_dma_chan *vc;
> +	struct virt_dma_desc *vd;
> +	struct uniphier_mdmac_chan *mc;
> +	struct uniphier_mdmac_desc *md = NULL;
> +	enum dma_status stat;
> +	unsigned long flags;
> +
> +	stat = dma_cookie_status(chan, cookie, txstate);
> +	if (stat == DMA_COMPLETE)
> +		return stat;
> +
> +	vc = to_virt_chan(chan);
> +
> +	spin_lock_irqsave(&vc->lock, flags);
> +
> +	mc = to_uniphier_mdmac_chan(vc);
> +
> +	if (mc->md && mc->md->vd.tx.cookie == cookie)
> +		md = mc->md;
> +
> +	if (!md) {
> +		vd = vchan_find_desc(vc, cookie);
> +		if (vd)
> +			md = to_uniphier_mdmac_desc(vd);
> +	}
> +
> +	if (md)
> +		txstate->residue = __uniphier_mdmac_get_residue(md);

txstate can be NULL and should be checked...

> +static int uniphier_mdmac_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct uniphier_mdmac_device *mdev;
> +	struct dma_device *ddev;
> +	struct resource *res;
> +	int nr_chans, ret, i;
> +
> +	nr_chans = platform_irq_count(pdev);
> +	if (nr_chans < 0)
> +		return nr_chans;
> +
> +	ret = dma_set_mask(dev, DMA_BIT_MASK(32));
> +	if (ret)
> +		return ret;
> +
> +	mdev = devm_kzalloc(dev, struct_size(mdev, channels, nr_chans),
> +			    GFP_KERNEL);

kcalloc variant?

> +	if (!mdev)
> +		return -ENOMEM;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	mdev->reg_base = devm_ioremap_resource(dev, res);
> +	if (IS_ERR(mdev->reg_base))
> +		return PTR_ERR(mdev->reg_base);
> +
> +	mdev->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(mdev->clk)) {
> +		dev_err(dev, "failed to get clock\n");
> +		return PTR_ERR(mdev->clk);
> +	}
> +
> +	ret = clk_prepare_enable(mdev->clk);
> +	if (ret)
> +		return ret;
> +
> +	ddev = &mdev->ddev;
> +	ddev->dev = dev;
> +	dma_cap_set(DMA_PRIVATE, ddev->cap_mask);
> +	ddev->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
> +	ddev->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_UNDEFINED);
> +	ddev->directions = BIT(DMA_MEM_TO_DEV) | BIT(DMA_DEV_TO_MEM);
> +	ddev->residue_granularity = DMA_RESIDUE_GRANULARITY_SEGMENT;
> +	ddev->device_prep_slave_sg = uniphier_mdmac_prep_slave_sg;
> +	ddev->device_terminate_all = uniphier_mdmac_terminate_all;
> +	ddev->device_synchronize = uniphier_mdmac_synchronize;
> +	ddev->device_tx_status = uniphier_mdmac_tx_status;
> +	ddev->device_issue_pending = uniphier_mdmac_issue_pending;

No device_config?
-- 
~Vinod
