Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id t/5FJM5BGltIZAAAmS7hNA
	; Fri, 08 Jun 2018 08:44:06 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0DFE1608FF; Fri,  8 Jun 2018 08:44:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 0BC4B60998;
	Fri,  8 Jun 2018 08:43:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0BC4B60998
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753010AbeFHInt (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 04:43:49 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:38807 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752682AbeFHInr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 04:43:47 -0400
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fRCzm-0006tl-Tc; Fri, 08 Jun 2018 10:43:42 +0200
Received: from sha by ptx.hi.pengutronix.de with local (Exim 4.89)
        (envelope-from <sha@pengutronix.de>)
        id 1fRCzm-0004Zj-It; Fri, 08 Jun 2018 10:43:42 +0200
Date: Fri, 8 Jun 2018 10:43:42 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Robin Gong <yibin.gong@nxp.com>
Cc: vkoul@kernel.org, dan.j.williams@intel.com,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com
Subject: Re: [PATCH v2 1/5] dmaengine: imx-sdma: add virt-dma support
Message-ID: <20180608084342.35wtettm7w6gp7jl@pengutronix.de>
References: <1528465490-19684-1-git-send-email-yibin.gong@nxp.com>
 <1528465490-19684-2-git-send-email-yibin.gong@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528465490-19684-2-git-send-email-yibin.gong@nxp.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-IRC: #ptxdist @freenode
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
X-Uptime: 10:43:13 up 168 days, 17:01, 102 users,  load average: 0.10, 0.13,
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

On Fri, Jun 08, 2018 at 09:44:46PM +0800, Robin Gong wrote:
> The legacy sdma driver has below limitations or drawbacks:
>   1. Hardcode the max BDs number as "PAGE_SIZE / sizeof(*)", and alloc
>      one page size for one channel regardless of only few BDs needed
>      most time. But in few cases, the max PAGE_SIZE maybe not enough.
>   2. One SDMA channel can't stop immediatley once channel disabled which
>      means SDMA interrupt may come in after this channel terminated.There
>      are some patches for this corner case such as commit "2746e2c389f9",
>      but not cover non-cyclic.
> 
> The common virt-dma overcomes the above limitations. It can alloc bd
> dynamically and free bd once this tx transfer done. No memory wasted or
> maximum limititation here, only depends on how many memory can be requested
> from kernel. For No.2, such issue can be workaround by checking if there
> is available descript("sdmac->desc") now once the unwanted interrupt
> coming. At last the common virt-dma is easier for sdma driver maintain.
> 
> The main changes as below:
>   --new "sdma_desc" structure containing virt_dma_desc and some members
>     which moved from "sdma_channel" such as "num_bd","bd_phys","bd",etc,
>     since multi descriptors may exist on virtual dma framework
>     rather than only one as before.
>   --remove some members of "sdma_channel" structure since it's handled
>     by virtual dma common framework, such as "tasklet", "dma_chan",etc.
>   --add specific BD0 for channel0 since such bd descriptor is must and
>     basic for other dma channel, no need alloc/free as other channel,so
>     request it during probe.
>   --remove sdma_request_channel(),sdma_tx_submit(),etc.
>   --alloc/free bd descriptor added and code changes for virtual dma.
> 
> Signed-off-by: Robin Gong <yibin.gong@nxp.com>
> ---
>  drivers/dma/Kconfig    |   1 +
>  drivers/dma/imx-sdma.c | 332 ++++++++++++++++++++++++++++++++-----------------
>  2 files changed, 220 insertions(+), 113 deletions(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index ca1680a..d4a4230 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -250,6 +250,7 @@ config IMX_SDMA
>  	tristate "i.MX SDMA support"
>  	depends on ARCH_MXC
>  	select DMA_ENGINE
> +	select DMA_VIRTUAL_CHANNELS
>  	help
>  	  Support the i.MX SDMA engine. This engine is integrated into
>  	  Freescale i.MX25/31/35/51/53/6 chips.
> diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
> index ccd03c3..8d0c1fd 100644
> --- a/drivers/dma/imx-sdma.c
> +++ b/drivers/dma/imx-sdma.c
> @@ -48,6 +48,7 @@
>  #include <linux/mfd/syscon/imx6q-iomuxc-gpr.h>
>  
>  #include "dmaengine.h"
> +#include "virt-dma.h"
>  
>  /* SDMA registers */
>  #define SDMA_H_C0PTR		0x000
> @@ -296,6 +297,31 @@ struct sdma_context_data {
>  struct sdma_engine;
>  
>  /**
> + * struct sdma_desc - descriptor structor for one transfer
> + * @vd			descriptor for virt dma
> + * @num_bd		max NUM_BD. number of descriptors currently handling
> + * @buf_tail		ID of the buffer that was processed
> + * @buf_ptail		ID of the previous buffer that was processed
> + * @period_len		period length, used in cyclic.
> + * @chn_real_count	the real count updated from bd->mode.count
> + * @chn_count		the transfer count setuped
> + * @sdmac		sdma_channel pointer
> + * @bd			pointer of alloced bd
> + */
> +struct sdma_desc {
> +	struct virt_dma_desc	vd;
> +	unsigned int		num_bd;
> +	dma_addr_t		bd_phys;
> +	unsigned int		buf_tail;
> +	unsigned int		buf_ptail;
> +	unsigned int		period_len;
> +	unsigned int		chn_real_count;
> +	unsigned int		chn_count;
> +	struct sdma_channel	*sdmac;
> +	struct sdma_buffer_descriptor *bd;
> +};
> +
> +/**
>   * struct sdma_channel - housekeeping for a SDMA channel
>   *
>   * @sdma		pointer to the SDMA engine for this channel
> @@ -305,11 +331,10 @@ struct sdma_engine;
>   * @event_id0		aka dma request line
>   * @event_id1		for channels that use 2 events
>   * @word_size		peripheral access size
> - * @buf_tail		ID of the buffer that was processed
> - * @buf_ptail		ID of the previous buffer that was processed
> - * @num_bd		max NUM_BD. number of descriptors currently handling
>   */
>  struct sdma_channel {
> +	struct virt_dma_chan		vc;
> +	struct sdma_desc		*desc;
>  	struct sdma_engine		*sdma;
>  	unsigned int			channel;
>  	enum dma_transfer_direction		direction;
> @@ -317,12 +342,6 @@ struct sdma_channel {
>  	unsigned int			event_id0;
>  	unsigned int			event_id1;
>  	enum dma_slave_buswidth		word_size;
> -	unsigned int			buf_tail;
> -	unsigned int			buf_ptail;
> -	unsigned int			num_bd;
> -	unsigned int			period_len;
> -	struct sdma_buffer_descriptor	*bd;
> -	dma_addr_t			bd_phys;
>  	unsigned int			pc_from_device, pc_to_device;
>  	unsigned int			device_to_device;
>  	unsigned long			flags;
> @@ -330,13 +349,10 @@ struct sdma_channel {
>  	unsigned long			event_mask[2];
>  	unsigned long			watermark_level;
>  	u32				shp_addr, per_addr;
> -	struct dma_chan			chan;
>  	spinlock_t			lock;
> -	struct dma_async_tx_descriptor	desc;
>  	enum dma_status			status;
>  	unsigned int			chn_count;
>  	unsigned int			chn_real_count;

These are no longer used here and should be removed.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
