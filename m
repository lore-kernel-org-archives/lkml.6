Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751671AbeEQFOx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 01:14:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:48096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750727AbeEQFOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 01:14:51 -0400
Date: Thu, 17 May 2018 10:44:47 +0530
From: Vinod <vkoul@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: dan.j.williams@intel.com, eric.long@spreadtrum.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] dmaengine: sprd: Add Spreadtrum DMA configuration
Message-ID: <20180517051447.GS13271@vkoul-mobl>
References: <08819489e52add194fecf2b4b234fff9deecdb4c.1526043689.git.baolin.wang@linaro.org>
 <85413038c111c58747194dd5736834be9adb0f20.1526043689.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85413038c111c58747194dd5736834be9adb0f20.1526043689.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-18, 21:06, Baolin Wang wrote:
> +struct sprd_dma_config {
> +	struct dma_slave_config cfg;
> +	u32 block_len;
> +	u32 transcation_len;

/s/transcation/transaction

now in code I see block_len and this filled by len which is sg_dma_len()?
So why two varibales when you are using only one.

Second, you are storing parameters programmed thru _prep call into
_dma_config. That is not correct.

We use these to store channel parameters and NOT transaction parameters which
would differ with each txn. No wonder you can only support only 1 txn :)

Lastly, if these are same values why not use src/dstn_max_burst?

> +static enum sprd_dma_datawidth
> +sprd_dma_get_datawidth(enum dma_slave_buswidth buswidth)
> +{
> +	switch (buswidth) {
> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +	case DMA_SLAVE_BUSWIDTH_8_BYTES:
> +		return ffs(buswidth) - 1;
> +	default:
> +		return SPRD_DMA_DATAWIDTH_4_BYTES;

Does default make sense, should we error out?

> +static u32 sprd_dma_get_step(enum dma_slave_buswidth buswidth)
> +{
> +	switch (buswidth) {
> +	case DMA_SLAVE_BUSWIDTH_1_BYTE:
> +	case DMA_SLAVE_BUSWIDTH_2_BYTES:
> +	case DMA_SLAVE_BUSWIDTH_4_BYTES:
> +	case DMA_SLAVE_BUSWIDTH_8_BYTES:
> +		return buswidth;
> +
> +	default:
> +		return SPRD_DMA_DWORD_STEP;

Does default make sense, should we error out?

> +static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
> +			   dma_addr_t src, dma_addr_t dst,
> +			   struct sprd_dma_config *slave_cfg)
> +{
> +	struct sprd_dma_dev *sdev = to_sprd_dma_dev(chan);
> +	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
> +	struct sprd_dma_chn_hw *hw = &sdesc->chn_hw;
> +	u32 fix_mode = 0, fix_en = 0, wrap_en = 0, wrap_mode = 0;
> +	u32 src_datawidth, dst_datawidth, temp;
> +
> +	if (slave_cfg->cfg.slave_id)
> +		schan->dev_id = slave_cfg->cfg.slave_id;
> +
> +	hw->cfg = SPRD_DMA_DONOT_WAIT_BDONE << SPRD_DMA_WAIT_BDONE_OFFSET;
> +
> +	temp = slave_cfg->wrap_ptr & SPRD_DMA_LOW_ADDR_MASK;
> +	temp |= (src >> SPRD_DMA_HIGH_ADDR_OFFSET) & SPRD_DMA_HIGH_ADDR_MASK;
> +	hw->wrap_ptr = temp;
> +
> +	temp = slave_cfg->wrap_to & SPRD_DMA_LOW_ADDR_MASK;
> +	temp |= (dst >> SPRD_DMA_HIGH_ADDR_OFFSET) & SPRD_DMA_HIGH_ADDR_MASK;
> +	hw->wrap_to = temp;
> +
> +	hw->src_addr = src & SPRD_DMA_LOW_ADDR_MASK;
> +	hw->des_addr = dst & SPRD_DMA_LOW_ADDR_MASK;
> +
> +	if ((slave_cfg->src_step != 0 && slave_cfg->dst_step != 0)
> +	    || (slave_cfg->src_step | slave_cfg->dst_step) == 0) {

this check doesnt seem right to me, what are you trying here?

> +		fix_en = 0;
> +	} else {
> +		fix_en = 1;
> +		if (slave_cfg->src_step)
> +			fix_mode = 1;
> +		else
> +			fix_mode = 0;
> +	}
> +
> +	if (slave_cfg->wrap_ptr && slave_cfg->wrap_to) {
> +		wrap_en = 1;
> +		if (slave_cfg->wrap_to == src) {
> +			wrap_mode = 0;
> +		} else if (slave_cfg->wrap_to == dst) {
> +			wrap_mode = 1;
> +		} else {
> +			dev_err(sdev->dma_dev.dev, "invalid wrap mode\n");
> +			return -EINVAL;
> +		}
> +	}
> +
> +	hw->intc = slave_cfg->int_mode | SPRD_DMA_CFG_ERR_INT_EN;
> +
> +	src_datawidth = sprd_dma_get_datawidth(slave_cfg->cfg.src_addr_width);
> +	dst_datawidth = sprd_dma_get_datawidth(slave_cfg->cfg.dst_addr_width);
> +
> +	temp = src_datawidth << SPRD_DMA_SRC_DATAWIDTH_OFFSET;
> +	temp |= dst_datawidth << SPRD_DMA_DES_DATAWIDTH_OFFSET;
> +	temp |= slave_cfg->req_mode << SPRD_DMA_REQ_MODE_OFFSET;
> +	temp |= wrap_mode << SPRD_DMA_WRAP_SEL_OFFSET;
> +	temp |= wrap_en << SPRD_DMA_WRAP_EN_OFFSET;
> +	temp |= fix_mode << SPRD_DMA_FIX_SEL_OFFSET;
> +	temp |= fix_en << SPRD_DMA_FIX_EN_OFFSET;
> +	temp |= slave_cfg->cfg.src_maxburst & SPRD_DMA_FRG_LEN_MASK;
> +	hw->frg_len = temp;
> +
> +	hw->blk_len = slave_cfg->block_len & SPRD_DMA_BLK_LEN_MASK;
> +	hw->trsc_len = slave_cfg->transcation_len & SPRD_DMA_TRSC_LEN_MASK;
> +
> +	temp = (slave_cfg->dst_step & SPRD_DMA_TRSF_STEP_MASK) <<
> +		SPRD_DMA_DEST_TRSF_STEP_OFFSET;
> +	temp |= (slave_cfg->src_step & SPRD_DMA_TRSF_STEP_MASK) <<
> +		SPRD_DMA_SRC_TRSF_STEP_OFFSET;
> +	hw->trsf_step = temp;
> +
> +	hw->frg_step = 0;
> +	hw->src_blk_step = 0;
> +	hw->des_blk_step = 0;
> +	return 0;
> +}
> +static struct dma_async_tx_descriptor *
> +sprd_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
> +		       unsigned int sglen, enum dma_transfer_direction dir,
> +		       unsigned long flags, void *context)
> +{
> +	struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
> +	struct sprd_dma_config *slave_cfg = &schan->slave_cfg;
> +	u32 src_step = 0, dst_step = 0, len = 0;
> +	dma_addr_t src = 0, dst = 0;
> +	struct sprd_dma_desc *sdesc;
> +	struct scatterlist *sg;
> +	int ret, i;
> +
> +	/* TODO: now we only support one sg for each DMA configuration. */
> +	if (!is_slave_direction(dir) || sglen > 1)
> +		return NULL;
> +
> +	sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
> +	if (!sdesc)
> +		return NULL;
> +
> +	for_each_sg(sgl, sg, sglen, i) {
> +		len = sg_dma_len(sg);
> +
> +		if (dir == DMA_MEM_TO_DEV) {
> +			src = sg_dma_address(sg);
> +			dst = slave_cfg->cfg.dst_addr;
> +			src_step = sprd_dma_get_step(slave_cfg->cfg.src_addr_width);
> +			dst_step = SPRD_DMA_NONE_STEP;
> +		} else {
> +			src = slave_cfg->cfg.src_addr;
> +			dst = sg_dma_address(sg);
> +			src_step = SPRD_DMA_NONE_STEP;
> +			dst_step = sprd_dma_get_step(slave_cfg->cfg.dst_addr_width);
> +		}
> +	}
> +
> +	sprd_dma_fill_config(slave_cfg, src_step, dst_step, len, flags);
> +
> +	ret = sprd_dma_config(chan, sdesc, src, dst, slave_cfg);
> +	if (ret) {
> +		kfree(sdesc);
> +		return NULL;
> +	}

Am more intrigued here, the above call fills you config struct but you do not
use it.. so what is the use of that. 

-- 
~Vinod
