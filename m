Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DBD0C5CFE7
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:25:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F39A20862
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 06:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F39A20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726460AbeGKG1n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 02:27:43 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:47965 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726223AbeGKG1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 02:27:43 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fd8YJ-00073Q-LR; Wed, 11 Jul 2018 08:24:39 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fd8YE-0007IX-9w; Wed, 11 Jul 2018 08:24:34 +0200
Date:   Wed, 11 Jul 2018 08:24:34 +0200
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     Robin Gong <yibin.gong@nxp.com>
Cc:     vkoul@kernel.org, dan.j.williams@intel.com, shawnguo@kernel.org,
        fabio.estevam@nxp.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: Re: [PATCH v1 1/4] dmaengine: imx-sdma: add memcpy interface
Message-ID: <20180711062434.x6waumlh6wtfmvzy@pengutronix.de>
References: <1531239793-11781-1-git-send-email-yibin.gong@nxp.com>
 <1531239793-11781-2-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1531239793-11781-2-git-send-email-yibin.gong@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL:  http://www.pengutronix.de/
X-IRC:  #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 08:11:22 up 28 days, 15:20, 59 users,  load average: 0.13, 0.15,
 0.15
User-Agent: NeoMutt/20170113 (1.7.2)
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 11, 2018 at 12:23:10AM +0800, Robin Gong wrote:
> Add MEMCPY support, meanwhile, add SDMA_BD_MAX_CNT instead
> of '0xffff'.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
> +static struct dma_async_tx_descriptor *sdma_prep_memcpy(
> +		struct dma_chan *chan, dma_addr_t dma_dst,
> +		dma_addr_t dma_src, size_t len, unsigned long flags)
> +{
> +	struct sdma_channel *sdmac = to_sdma_chan(chan);
> +	struct sdma_engine *sdma = sdmac->sdma;
> +	int channel = sdmac->channel;
> +	size_t count;
> +	int i = 0, param;
> +	struct sdma_buffer_descriptor *bd;
> +	struct sdma_desc *desc;
> +
> +	if (!chan || !len)
> +		return NULL;
> +
> +	dev_dbg(sdma->dev, "memcpy: %pad->%pad, len=%zu, channel=%d.\n",
> +		&dma_src, &dma_dst, len, channel);
> +
> +	desc = sdma_transfer_init(sdmac, DMA_MEM_TO_MEM, len / SDMA_BD_MAX_CNT
> +					+ 1);
> +	if (!desc)
> +		goto err_out;
> +
> +	do {
> +		count = min_t(size_t, len, SDMA_BD_MAX_CNT);

When len is bigger than 0xffff you initialize count to 0xffff...

> +		bd = &desc->bd[i];
> +		bd->buffer_addr = dma_src;
> +		bd->ext_buffer_addr = dma_dst;
> +		bd->mode.count = count;
> +		desc->chn_count += count;
> +
> +		switch (sdmac->word_size) {
> +		case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +			bd->mode.command = 0;
> +			if ((count | dma_src | dma_dst) & 3)
> +				goto err_bd_out;
> +			break;

...In which case you bail out here with an error.

Please make sure bigger transfers are working.

> +		case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +			bd->mode.command = 2;
> +			if ((count | dma_src | dma_dst) & 1)
> +				goto err_bd_out;
> +			break;
> +		case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +			bd->mode.command = 1;
> +			break;
> +		default:
> +			goto err_bd_out;
> +		}
> +
> +		dma_src += count;
> +		dma_dst += count;
> +		len -= count;
> +		i++;
> +
> +		param = BD_DONE | BD_EXTD | BD_CONT;

Probably better readable if you drop BD_CONT here and do a

	if (len) {
		param |= BD_CONT;
	} else  {
		...
	}

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
