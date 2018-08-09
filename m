Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3F34C4646D
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC1D21C2E
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 02:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYeu/RF2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC1D21C2E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbeHIEyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 00:54:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:54210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725878AbeHIEyx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 00:54:53 -0400
Received: from localhost (unknown [122.167.122.62])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 656B821C16;
        Thu,  9 Aug 2018 02:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533781944;
        bh=Kh9QLmQCs+iqX5c7pmkk4iAxFS/9BJ7iOaQbIrYikR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pYeu/RF2Z1cJr4k8/gwy4ZSyr8xiXdIYQXU99RBeoYrbieXzcukij33otW0vzumXY
         vgkJVHmOPqJbVaV+ctWDxPyIiCAqPkAcN5MT67qhaKz13y/W65h9lAUvem1b01Ifyg
         REnAvavoekvmZR8d7MNBA+VXSA4c+MB+IL7V3/G0=
Date:   Thu, 9 Aug 2018 08:02:15 +0530
From:   Vinod <vkoul@kernel.org>
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     dan.j.williams@intel.com, eric.long@spreadtrum.com,
        broonie@kernel.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dmaengine: sprd: Support DMA link-list mode
Message-ID: <20180809023215.GO2395@vkoul-mobl>
References: <78730daa2eaa66fa8089f196a52b51ce62579d1f.1532591566.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <78730daa2eaa66fa8089f196a52b51ce62579d1f.1532591566.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-07-18, 16:00, Baolin Wang wrote:
> From: Eric Long <eric.long@spreadtrum.com>
> 
> The Spreadtrum DMA can support the link-list transaction mode, which means
> DMA controller can do transaction one by one automatically once we linked
> these transaction by link-list register.
> 
> Signed-off-by: Eric Long <eric.long@spreadtrum.com>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
> ---
>  drivers/dma/sprd-dma.c       |   82 ++++++++++++++++++++++++++++++++++++++----
>  include/linux/dma/sprd-dma.h |   69 +++++++++++++++++++++++++++++++++++
>  2 files changed, 144 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
> index 55df0d4..649bd2c 100644
> --- a/drivers/dma/sprd-dma.c
> +++ b/drivers/dma/sprd-dma.c
> @@ -68,6 +68,7 @@
>  
>  /* SPRD_DMA_CHN_CFG register definition */
>  #define SPRD_DMA_CHN_EN			BIT(0)
> +#define SPRD_DMA_LINKLIST_EN		BIT(4)
>  #define SPRD_DMA_WAIT_BDONE_OFFSET	24
>  #define SPRD_DMA_DONOT_WAIT_BDONE	1
>  
> @@ -103,7 +104,7 @@
>  #define SPRD_DMA_REQ_MODE_MASK		GENMASK(1, 0)
>  #define SPRD_DMA_FIX_SEL_OFFSET		21
>  #define SPRD_DMA_FIX_EN_OFFSET		20
> -#define SPRD_DMA_LLIST_END_OFFSET	19
> +#define SPRD_DMA_LLIST_END		BIT(19)
>  #define SPRD_DMA_FRG_LEN_MASK		GENMASK(16, 0)
>  
>  /* SPRD_DMA_CHN_BLK_LEN register definition */
> @@ -164,6 +165,7 @@ struct sprd_dma_desc {
>  struct sprd_dma_chn {
>  	struct virt_dma_chan	vc;
>  	void __iomem		*chn_base;
> +	struct sprd_dma_linklist	linklist;
>  	struct dma_slave_config	slave_cfg;
>  	u32			chn_num;
>  	u32			dev_id;
> @@ -582,7 +584,8 @@ static int sprd_dma_get_step(enum dma_slave_buswidth buswidth)
>  }
>  
>  static int sprd_dma_fill_desc(struct dma_chan *chan,
> -			      struct sprd_dma_desc *sdesc,
> +			      struct sprd_dma_chn_hw *hw,
> +			      unsigned int sglen, int sg_index,
>  			      dma_addr_t src, dma_addr_t dst, u32 len,
>  			      enum dma_transfer_direction dir,
>  			      unsigned long flags,
> @@ -590,7 +593,6 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
>  {
>  	struct sprd_dma_dev *sdev = to_sprd_dma_dev(chan);
>  	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
> -	struct sprd_dma_chn_hw *hw = &sdesc->chn_hw;
>  	u32 req_mode = (flags >> SPRD_DMA_REQ_SHIFT) & SPRD_DMA_REQ_MODE_MASK;
>  	u32 int_mode = flags & SPRD_DMA_INT_MASK;
>  	int src_datawidth, dst_datawidth, src_step, dst_step;
> @@ -670,12 +672,58 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
>  	temp |= (src_step & SPRD_DMA_TRSF_STEP_MASK) << SPRD_DMA_SRC_TRSF_STEP_OFFSET;
>  	hw->trsf_step = temp;
>  
> +	/* link-list configuration */
> +	if (schan->linklist.phy_addr) {
> +		if (sg_index == sglen - 1)
> +			hw->frg_len |= SPRD_DMA_LLIST_END;
> +
> +		hw->cfg |= SPRD_DMA_LINKLIST_EN;
> +		hw->llist_ptr = schan->linklist.phy_addr +
> +			((sg_index + 1) % sglen) * sizeof(*hw) +
> +			SPRD_DMA_CHN_SRC_ADDR;
> +	} else {
> +		hw->llist_ptr = 0;
> +	}
> +
>  	hw->frg_step = 0;
>  	hw->src_blk_step = 0;
>  	hw->des_blk_step = 0;
>  	return 0;
>  }
>  
> +static int sprd_dma_fill_linklist_desc(struct dma_chan *chan,
> +				       unsigned int sglen, int sg_index,
> +				       dma_addr_t src, dma_addr_t dst, u32 len,
> +				       enum dma_transfer_direction dir,
> +				       unsigned long flags,
> +				       struct dma_slave_config *slave_cfg)
> +{
> +	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
> +	struct sprd_dma_chn_hw *hw;
> +
> +	if (sglen < 2 || !schan->linklist.virt_addr)
> +		return -EINVAL;

why the limitation of 2 here?

> +
> +	hw = (struct sprd_dma_chn_hw *)(schan->linklist.virt_addr +
> +					sg_index * sizeof(*hw));
> +
> +	return sprd_dma_fill_desc(chan, hw, sglen, sg_index, src, dst, len, dir,
> +				  flags, slave_cfg);
> +}
> +
> +static int sprd_dma_fill_chn_desc(struct dma_chan *chan,
> +				  struct sprd_dma_desc *sdesc,
> +				  dma_addr_t src, dma_addr_t dst, u32 len,
> +				  enum dma_transfer_direction dir,
> +				  unsigned long flags,
> +				  struct dma_slave_config *slave_cfg)
> +{
> +	struct sprd_dma_chn_hw *hw = &sdesc->chn_hw;
> +
> +	return sprd_dma_fill_desc(chan, hw, 0, 0, src, dst, len, dir,
> +				  flags, slave_cfg);
> +}

this fn does not do much, so why not call sprd_dma_fill_desc() instead
from caller!

> +
>  static struct dma_async_tx_descriptor *
>  sprd_dma_prep_dma_memcpy(struct dma_chan *chan, dma_addr_t dest, dma_addr_t src,
>  			 size_t len, unsigned long flags)
> @@ -744,10 +792,20 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
>  	u32 len = 0;
>  	int ret, i;
>  
> -	/* TODO: now we only support one sg for each DMA configuration. */
> -	if (!is_slave_direction(dir) || sglen > 1)
> +	if (!is_slave_direction(dir))
>  		return NULL;
>  
> +	if (context) {
> +		struct sprd_dma_linklist *ll_cfg =
> +			(struct sprd_dma_linklist *)context;
> +
> +		schan->linklist.phy_addr = ll_cfg->phy_addr;
> +		schan->linklist.virt_addr = ll_cfg->virt_addr;
> +	} else {
> +		schan->linklist.phy_addr = 0;
> +		schan->linklist.virt_addr = 0;
> +	}
> +
>  	sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
>  	if (!sdesc)
>  		return NULL;
> @@ -762,10 +820,20 @@ static int sprd_dma_fill_desc(struct dma_chan *chan,
>  			src = slave_cfg->src_addr;
>  			dst = sg_dma_address(sg);
>  		}
> +
> +		if (sglen < 2)
> +			break;

?

> +
> +		ret = sprd_dma_fill_linklist_desc(chan, sglen, i, src, dst, len,
> +						  dir, flags, slave_cfg);
> +		if (ret) {
> +			kfree(sdesc);
> +			return NULL;
> +		}
>  	}
>  
> -	ret = sprd_dma_fill_desc(chan, sdesc, src, dst, len, dir, flags,
> -				 slave_cfg);
> +	ret = sprd_dma_fill_chn_desc(chan, sdesc, src, dst, len, dir, flags,
> +				     slave_cfg);
>  	if (ret) {
>  		kfree(sdesc);
>  		return NULL;
> diff --git a/include/linux/dma/sprd-dma.h b/include/linux/dma/sprd-dma.h
> index b0115e3..c51c705 100644
> --- a/include/linux/dma/sprd-dma.h
> +++ b/include/linux/dma/sprd-dma.h
> @@ -58,4 +58,73 @@ enum sprd_dma_int_type {
>  	SPRD_DMA_CFGERR_INT,
>  };
>  
> +/*
> + * struct sprd_dma_linklist - DMA link-list address structure
> + * @virt_addr: link-list virtual address to configure link-list node
> + * @phy_addr: link-list physical address to link DMA transfer
> + *
> + * The Spreadtrum DMA controller supports the link-list mode, that means slaves
> + * can supply several groups configurations (each configuration represents one
> + * DMA transfer) saved in memory, and DMA controller will link these groups
> + * configurations by writing the physical address of each configuration into the
> + * link-list register.
> + *
> + * Just as shown below, the link-list pointer register will be pointed to the
> + * phycial address of 'configuration 1', and the 'configuration 1' link-list

/s/phycial/physical

> + * pointer will be pointed to 'configuration 2', and so on.
> + * Once trigger the DMA transfer, the DMA controller will load 'configureation

/s/configureation/configuration

> + * 1' to its registers automatically, after 'configuration 1' transation is

/s/transation/transaction

> + * done, DMA controller will load 'configuration 2' automatically, until all
> + * DMA transactions are done.
> + *
> + * Note: The last link-list pointer should point to the physical address
> + * of 'configuration 1', which can avoid DMA controller loads incorrect
> + * configuration when the last configuration transaction is done.
> + *
> + *     DMA controller                    linklist memory
> + * ======================             -----------------------
> + *|                      |           |    configuration 1    |<---
> + *|   DMA controller     |   ------->|                       |   |
> + *|                      |   |       |                       |   |
> + *|                      |   |       |                       |   |
> + *|                      |   |       |                       |   |
> + *| linklist pointer reg |----   ----|    linklist pointer   |   |
> + * ======================        |    -----------------------    |
> + *                               |                               |
> + *                               |    -----------------------    |
> + *                               |   |    configuration 2    |   |
> + *                               --->|                       |   |
> + *                                   |                       |   |
> + *                                   |                       |   |
> + *                                   |                       |   |
> + *                               ----|    linklist pointer   |   |
> + *                               |    -----------------------    |
> + *                               |                               |
> + *                               |    -----------------------    |
> + *                               |   |    configuration 3    |   |
> + *                               --->|                       |   |
> + *                                   |                       |   |
> + *                                   |           .           |   |
> + *                                               .               |
> + *                                               .               |
> + *                                               .               |
> + *                               |               .               |
> + *                               |    -----------------------    |
> + *                               |   |    configuration n    |   |
> + *                               --->|                       |   |
> + *                                   |                       |   |
> + *                                   |                       |   |
> + *                                   |                       |   |
> + *                                   |    linklist pointer   |----
> + *                                    -----------------------
> + *
> + * To support the link-list mode, DMA slaves should allocate one segment memory
> + * from always-on IRAM or dma coherent memory to store these groups of DMA
> + * configuration, and pass the virtual and physical addess to DMA controller.

/s/addess/address

> + */
> +struct sprd_dma_linklist {
> +	unsigned long virt_addr;
> +	phys_addr_t phy_addr;
> +};
> +
>  #endif
> -- 
> 1.7.9.5

-- 
~Vinod
