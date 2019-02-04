Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2774DC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E8269217D9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 07:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549265006;
	bh=HDgwpkhTpoTEVDPKrkmykrNSqq9yCCJYhstkDTGaZWE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=SXyeQ2bn1fr029YR6jy7LZFpEfg8Vl2edN9w350blrH5HKKnbvAZ+41deu2yl9mGi
	 rBReGDBwknGHopTh+/ILtvESQjwG69cQDS6gWRBgnbEzRRAOO+w001MEBkveyeXP4o
	 oNrJD+TrpucX1v/0xd8XRrWeqgTFYDcYfmlYOE3Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728076AbfBDHXX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 02:23:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:49500 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725854AbfBDHXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 02:23:23 -0500
Received: from localhost (unknown [171.76.74.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 92B4A2083B;
        Mon,  4 Feb 2019 07:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549265002;
        bh=HDgwpkhTpoTEVDPKrkmykrNSqq9yCCJYhstkDTGaZWE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nUKyNq6Hts9oKpqFVbZ/mpkxPAtFK43ibh8WLBgzpsTvo7+BLeLG5N0+7brbVEffc
         WQAhP+A6rr5jgbzfuyTzgN6G6JdhQPfOglnHO9KqhfXhN3TKwqUlBNTOueG8khTv9Z
         Lrpbh+ZuDSqochHp+jcQVvER3BRaDmXY7Yb8fB4Q=
Date:   Mon, 4 Feb 2019 12:51:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Long Cheng <long.cheng@mediatek.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, srv_heupstream@mediatek.com,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>
Subject: Re: [PATCH v10 1/3] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
Message-ID: <20190204072154.GJ4296@vkoul-mobl>
References: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
 <1547781016-890-2-git-send-email-long.cheng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1547781016-890-2-git-send-email-long.cheng@mediatek.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-01-19, 11:10, Long Cheng wrote:
> +static enum dma_status mtk_uart_apdma_tx_status(struct dma_chan *chan,
> +					 dma_cookie_t cookie,
> +					 struct dma_tx_state *txstate)
> +{
> +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> +	enum dma_status ret;
> +	unsigned long flags;
> +
> +	if (!txstate)
> +		return DMA_ERROR;

Why, it is not a mandatory arg!

> +	ret = dma_cookie_status(chan, cookie, txstate);
> +	spin_lock_irqsave(&c->vc.lock, flags);
> +	if (ret == DMA_IN_PROGRESS) {
> +		c->rx_status = mtk_uart_apdma_read(c, VFF_RPT) & VFF_RING_SIZE;
> +		dma_set_residue(txstate, c->rx_status);
> +	} else if (ret == DMA_COMPLETE && c->dir == DMA_DEV_TO_MEM) {
> +		dma_set_residue(txstate, c->rx_status);

what is the point is setting residue to comleted txn, it is zero!

> +	} else {
> +		dma_set_residue(txstate, 0);

naah that doesnt sound correct!

> +static void mtk_uart_apdma_config_write(struct dma_chan *chan,
> +			       struct dma_slave_config *cfg,
> +			       enum dma_transfer_direction dir)
> +{
> +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> +	struct mtk_uart_apdmadev *mtkd =
> +				to_mtk_uart_apdma_dev(c->vc.chan.device);
> +	unsigned int tmp;
> +
> +	if (mtk_uart_apdma_read(c, VFF_EN) == VFF_EN_B)
> +		return;
> +
> +	c->dir = dir;
> +
> +	if (dir == DMA_DEV_TO_MEM) {
> +		tmp = cfg->src_addr_width * 1024;

why multiply by 1024?

> +static int mtk_uart_apdma_device_pause(struct dma_chan *chan)
> +{
> +	/* just for check caps pass */
> +	return 0;
> +}

please remove, this is not a mandatory fn
-- 
~Vinod
