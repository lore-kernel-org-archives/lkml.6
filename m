Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752991AbeEKLoZ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 07:44:25 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:45977 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752617AbeEKLoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 07:44:23 -0400
X-Google-Smtp-Source: AB8JxZoh4wt8KXXDbd+ns3Io8Rhb2dNGGpU8OieOQ/Mh2U6HXhXcYhRi/4vUuH1lHU0jsBBUPE30TDNbqsL1g3s6F9k=
MIME-Version: 1.0
In-Reply-To: <20180511112225.GA30118@vkoul-mobl>
References: <b115795adf9e9a9e611ee0ff353fae5850d1e287.1525863923.git.baolin.wang@linaro.org>
 <67447aabb8e4e051ff39b814a0e169e6a91bb66e.1525863923.git.baolin.wang@linaro.org>
 <20180511112225.GA30118@vkoul-mobl>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 11 May 2018 19:44:22 +0800
Message-ID: <CAMz4kuKi884zyOgXAvYXzUFGv7ea1L0Wxv8AHbf+XjEez+jJTQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dmaengine: sprd: Add Spreadtrum DMA configuration
To: Vinod Koul <vkoul@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Eric Long <eric.long@spreadtrum.com>, Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 11 May 2018 at 19:22, Vinod Koul <vkoul@kernel.org> wrote:
> On 09-05-18, 19:12, Baolin Wang wrote:
>
>> +/*
>> + * struct sprd_dma_config - DMA configuration structure
>> + * @cfg: dma slave channel runtime config
>> + * @src_addr: the source physical address
>> + * @dst_addr: the destination physical address
>> + * @block_len: specify one block transfer length
>> + * @transcation_len: specify one transcation transfer length
>> + * @src_step: source transfer step
>> + * @dst_step: destination transfer step
>> + * @wrap_ptr: wrap pointer address, once the transfer address reaches the
>> + * 'wrap_ptr', the next transfer address will jump to the 'wrap_to' address.
>> + * @wrap_to: wrap jump to address
>> + * @req_mode: specify the DMA request mode
>> + * @int_mode: specify the DMA interrupt type
>> + */
>> +struct sprd_dma_config {
>> +     struct dma_slave_config cfg;
>> +     phys_addr_t src_addr;
>> +     phys_addr_t dst_addr;
>
> these are already in cfg so why duplicate, same for few more here.

We save them in 'struct sprd_dma_config' as one parameter for
sprd_dma_config(), otherwise we need add 2 more parameters (src and
dst) for sprd_dma_config().

>
>> +static enum sprd_dma_datawidth
>> +sprd_dma_get_datawidth(enum dma_slave_buswidth buswidth)
>> +{
>> +     switch (buswidth) {
>> +     case DMA_SLAVE_BUSWIDTH_1_BYTE:
>> +             return SPRD_DMA_DATAWIDTH_1_BYTE;
>> +
>> +     case DMA_SLAVE_BUSWIDTH_2_BYTES:
>> +             return SPRD_DMA_DATAWIDTH_2_BYTES;
>> +
>> +     case DMA_SLAVE_BUSWIDTH_4_BYTES:
>> +             return SPRD_DMA_DATAWIDTH_4_BYTES;
>> +
>> +     case DMA_SLAVE_BUSWIDTH_8_BYTES:
>> +             return SPRD_DMA_DATAWIDTH_8_BYTES;
>> +
>> +     default:
>> +             return SPRD_DMA_DATAWIDTH_4_BYTES;
>
> what is the logic of translation here, sometime you might be able to do that
> with logical operators, see other drivers..

OK. I will change to logical operators.

>
>> +     }
>> +}
>> +
>> +static u32 sprd_dma_get_step(enum dma_slave_buswidth buswidth)
>> +{
>> +     switch (buswidth) {
>> +     case DMA_SLAVE_BUSWIDTH_1_BYTE:
>> +             return SPRD_DMA_BYTE_STEP;
>> +
>> +     case DMA_SLAVE_BUSWIDTH_2_BYTES:
>> +             return SPRD_DMA_SHORT_STEP;
>> +
>> +     case DMA_SLAVE_BUSWIDTH_4_BYTES:
>> +             return SPRD_DMA_WORD_STEP;
>> +
>> +     case DMA_SLAVE_BUSWIDTH_8_BYTES:
>> +             return SPRD_DMA_DWORD_STEP;
>> +
>> +     default:
>> +             return SPRD_DMA_DWORD_STEP;
>> +     }
>
> here as well

Will do.

>
>> +}
>> +
>> +static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
>> +                        struct sprd_dma_config *slave_cfg)
>> +{
>> +     struct sprd_dma_dev *sdev = to_sprd_dma_dev(chan);
>> +     struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
>> +     struct sprd_dma_chn_hw *hw = &sdesc->chn_hw;
>> +     u32 fix_mode = 0, fix_en = 0, wrap_en = 0, wrap_mode = 0;
>> +     u32 src_datawidth, dst_datawidth;
>> +
>> +     if (slave_cfg->cfg.slave_id)
>> +             schan->dev_id = slave_cfg->cfg.slave_id;
>> +
>> +     hw->cfg = SPRD_DMA_DONOT_WAIT_BDONE << SPRD_DMA_WAIT_BDONE_OFFSET;
>> +     hw->wrap_ptr = (u32)((slave_cfg->wrap_ptr & SPRD_DMA_LOW_ADDR_MASK) |
>
> why cast?

Since the wrap_ptr register is always 32bit.

>
>> +             ((slave_cfg->src_addr >> SPRD_DMA_HIGH_ADDR_OFFSET) &
>> +              SPRD_DMA_HIGH_ADDR_MASK));
>
> more readable would be:
>
>         temp = slave_cfg->wrap_ptr & SPRD_DMA_LOW_ADDR_MASK;
>         temp |= slave_cfg->src_addr >> SPRD_DMA_HIGH_ADDR_OFFSET;
>         temp &= SPRD_DMA_HIGH_ADDR_MASK;
>
> and then assign... could help readability in few places...

OK.

>
>> +     hw->wrap_to = (u32)((slave_cfg->wrap_to & SPRD_DMA_LOW_ADDR_MASK) |
>> +             ((slave_cfg->dst_addr >> SPRD_DMA_HIGH_ADDR_OFFSET) &
>> +              SPRD_DMA_HIGH_ADDR_MASK));
>> +
>> +     hw->src_addr = (u32)(slave_cfg->src_addr & SPRD_DMA_LOW_ADDR_MASK);
>> +     hw->des_addr = (u32)(slave_cfg->dst_addr & SPRD_DMA_LOW_ADDR_MASK);
>> +
>> +     if ((slave_cfg->src_step != 0 && slave_cfg->dst_step != 0)
>> +         || (slave_cfg->src_step | slave_cfg->dst_step) == 0) {
>> +             fix_en = 0;
>> +     } else {
>> +             fix_en = 1;
>> +             if (slave_cfg->src_step)
>> +                     fix_mode = 1;
>> +             else
>> +                     fix_mode = 0;
>> +     }
>> +
>> +     if (slave_cfg->wrap_ptr && slave_cfg->wrap_to) {
>> +             wrap_en = 1;
>> +             if (slave_cfg->wrap_to == slave_cfg->src_addr) {
>> +                     wrap_mode = 0;
>> +             } else if (slave_cfg->wrap_to == slave_cfg->dst_addr) {
>> +                     wrap_mode = 1;
>> +             } else {
>> +                     dev_err(sdev->dma_dev.dev, "invalid wrap mode\n");
>> +                     return -EINVAL;
>> +             }
>> +     }
>> +
>> +     hw->intc = slave_cfg->int_mode | SPRD_DMA_CFG_ERR_INT_EN;
>> +
>> +     src_datawidth = sprd_dma_get_datawidth(slave_cfg->cfg.src_addr_width);
>> +     dst_datawidth = sprd_dma_get_datawidth(slave_cfg->cfg.dst_addr_width);
>> +     hw->frg_len = src_datawidth << SPRD_DMA_SRC_DATAWIDTH_OFFSET |
>> +             dst_datawidth << SPRD_DMA_DES_DATAWIDTH_OFFSET |
>> +             slave_cfg->req_mode << SPRD_DMA_REQ_MODE_OFFSET |
>> +             wrap_mode << SPRD_DMA_WRAP_SEL_OFFSET |
>> +             wrap_en << SPRD_DMA_WRAP_EN_OFFSET |
>> +             fix_mode << SPRD_DMA_FIX_SEL_OFFSET |
>> +             fix_en << SPRD_DMA_FIX_EN_OFFSET |
>> +             (slave_cfg->cfg.src_maxburst & SPRD_DMA_FRG_LEN_MASK);
>
> sorry this is not at all readable...

Will fix in next version.

>
>> +static struct dma_async_tx_descriptor *
>> +sprd_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
>> +                    unsigned int sglen, enum dma_transfer_direction dir,
>> +                    unsigned long flags, void *context)
>> +{
>> +     struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
>> +     struct sprd_dma_config *slave_cfg = &schan->slave_cfg;
>> +     struct sprd_dma_desc *sdesc;
>> +     struct scatterlist *sg;
>> +     int ret, i;
>> +
>> +     /* TODO: now we only support one sg for each DMA configuration. */
>
> thats a SW limit right and you will fix it later?

We will add new features to fix it in future.

>
>> +     if (!is_slave_direction(dir) || sglen > 1)
>> +             return NULL;
>> +
>> +     sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
>> +     if (!sdesc)
>> +             return NULL;
>> +
>> +     for_each_sg(sgl, sg, sglen, i) {
>> +             if (dir == DMA_MEM_TO_DEV) {
>> +                     slave_cfg->src_addr = sg_dma_address(sg);
>> +                     slave_cfg->dst_addr = slave_cfg->cfg.dst_addr;
>> +                     slave_cfg->src_step =
>> +                     sprd_dma_get_step(slave_cfg->cfg.src_addr_width);
>> +                     slave_cfg->dst_step = SPRD_DMA_NONE_STEP;
>> +             } else {
>> +                     slave_cfg->src_addr = slave_cfg->cfg.src_addr;
>> +                     slave_cfg->dst_addr = sg_dma_address(sg);
>> +                     slave_cfg->src_step = SPRD_DMA_NONE_STEP;
>> +                     slave_cfg->dst_step =
>> +                     sprd_dma_get_step(slave_cfg->cfg.dst_addr_width);
>
> use a helper for filling this and passing right values for each case?

We need pass many values to this helper, but will try. Thanks.

-- 
Baolin.wang
Best Regards
