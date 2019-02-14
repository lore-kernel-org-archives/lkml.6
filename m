Return-Path: <SRS0=fxkz=QV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9D32C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:45:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EBE0206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Feb 2019 02:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394186AbfBNCpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 21:45:06 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:29663 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388490AbfBNCpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 21:45:06 -0500
X-UUID: feeb73da9c024d11a7a5ab6c9aa5cec3-20190214
X-UUID: feeb73da9c024d11a7a5ab6c9aa5cec3-20190214
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <long.cheng@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 1888075440; Thu, 14 Feb 2019 10:44:58 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by mtkmbs03n1.mediatek.inc
 (172.21.101.181) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Thu, 14 Feb
 2019 10:44:57 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1395.4 via Frontend
 Transport; Thu, 14 Feb 2019 10:44:56 +0800
Message-ID: <1550112296.7678.5.camel@mhfsdcap03>
Subject: Re: [PATCH v10 1/3] dmaengine: 8250_mtk_dma: add MediaTek uart DMA
 support
From:   Long Cheng <long.cheng@mediatek.com>
To:     Vinod Koul <vkoul@kernel.org>
CC:     Randy Dunlap <rdunlap@infradead.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sean Wang <sean.wang@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        Sean Wang <sean.wang@mediatek.com>,
        <dmaengine@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <srv_heupstream@mediatek.com>,
        Yingjoe Chen <yingjoe.chen@mediatek.com>,
        YT Shen <yt.shen@mediatek.com>,
        Zhenbao Liu <zhenbao.liu@mediatek.com>,
        Long Cheng <long.cheng@mediatek.com>
Date:   Thu, 14 Feb 2019 10:44:56 +0800
In-Reply-To: <20190204072154.GJ4296@vkoul-mobl>
References: <1547781016-890-1-git-send-email-long.cheng@mediatek.com>
         <1547781016-890-2-git-send-email-long.cheng@mediatek.com>
         <20190204072154.GJ4296@vkoul-mobl>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-02-04 at 12:51 +0530, Vinod Koul wrote:

Hi Vinod sir,

> On 18-01-19, 11:10, Long Cheng wrote:
> > +static enum dma_status mtk_uart_apdma_tx_status(struct dma_chan *chan,
> > +					 dma_cookie_t cookie,
> > +					 struct dma_tx_state *txstate)
> > +{
> > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > +	enum dma_status ret;
> > +	unsigned long flags;
> > +
> > +	if (!txstate)
> > +		return DMA_ERROR;
> 
> Why, it is not a mandatory arg!

Next version, I will remove it.
> 
> > +	ret = dma_cookie_status(chan, cookie, txstate);
> > +	spin_lock_irqsave(&c->vc.lock, flags);
> > +	if (ret == DMA_IN_PROGRESS) {
> > +		c->rx_status = mtk_uart_apdma_read(c, VFF_RPT) & VFF_RING_SIZE;
> > +		dma_set_residue(txstate, c->rx_status);
> > +	} else if (ret == DMA_COMPLETE && c->dir == DMA_DEV_TO_MEM) {
> > +		dma_set_residue(txstate, c->rx_status);
> 
> what is the point is setting residue to comleted txn, it is zero!
> 
> > +	} else {
> > +		dma_set_residue(txstate, 0);
> 
> naah that doesnt sound correct!
> 
Next version, I will modify the function.

> > +static void mtk_uart_apdma_config_write(struct dma_chan *chan,
> > +			       struct dma_slave_config *cfg,
> > +			       enum dma_transfer_direction dir)
> > +{
> > +	struct mtk_chan *c = to_mtk_uart_apdma_chan(chan);
> > +	struct mtk_uart_apdmadev *mtkd =
> > +				to_mtk_uart_apdma_dev(c->vc.chan.device);
> > +	unsigned int tmp;
> > +
> > +	if (mtk_uart_apdma_read(c, VFF_EN) == VFF_EN_B)
> > +		return;
> > +
> > +	c->dir = dir;
> > +
> > +	if (dir == DMA_DEV_TO_MEM) {
> > +		tmp = cfg->src_addr_width * 1024;
> 
> why multiply by 1024?
> 
Next version, I will modify the this, with 'src_port_window_size' &&
'dst_port_window_size'.

> > +static int mtk_uart_apdma_device_pause(struct dma_chan *chan)
> > +{
> > +	/* just for check caps pass */
> > +	return 0;
> > +}
> 
> please remove, this is not a mandatory fn

Can't remove it. Before the mail, i had explained it. in 8250 uart
framework, will check the function..

thanks.

