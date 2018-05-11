Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753020AbeEKLxM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 07:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:45564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752578AbeEKLxK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 07:53:10 -0400
Date: Fri, 11 May 2018 17:23:06 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Eric Long <eric.long@spreadtrum.com>, Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] dmaengine: sprd: Add Spreadtrum DMA configuration
Message-ID: <20180511115306.GC30118@vkoul-mobl>
References: <b115795adf9e9a9e611ee0ff353fae5850d1e287.1525863923.git.baolin.wang@linaro.org>
 <67447aabb8e4e051ff39b814a0e169e6a91bb66e.1525863923.git.baolin.wang@linaro.org>
 <20180511112225.GA30118@vkoul-mobl>
 <CAMz4kuKi884zyOgXAvYXzUFGv7ea1L0Wxv8AHbf+XjEez+jJTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz4kuKi884zyOgXAvYXzUFGv7ea1L0Wxv8AHbf+XjEez+jJTQ@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11-05-18, 19:44, Baolin Wang wrote:
> Hi Vinod,
> 
> On 11 May 2018 at 19:22, Vinod Koul <vkoul@kernel.org> wrote:
> > On 09-05-18, 19:12, Baolin Wang wrote:
> >
> >> +/*
> >> + * struct sprd_dma_config - DMA configuration structure
> >> + * @cfg: dma slave channel runtime config
> >> + * @src_addr: the source physical address
> >> + * @dst_addr: the destination physical address
> >> + * @block_len: specify one block transfer length
> >> + * @transcation_len: specify one transcation transfer length
> >> + * @src_step: source transfer step
> >> + * @dst_step: destination transfer step
> >> + * @wrap_ptr: wrap pointer address, once the transfer address reaches the
> >> + * 'wrap_ptr', the next transfer address will jump to the 'wrap_to' address.
> >> + * @wrap_to: wrap jump to address
> >> + * @req_mode: specify the DMA request mode
> >> + * @int_mode: specify the DMA interrupt type
> >> + */
> >> +struct sprd_dma_config {
> >> +     struct dma_slave_config cfg;
> >> +     phys_addr_t src_addr;
> >> +     phys_addr_t dst_addr;
> >
> > these are already in cfg so why duplicate, same for few more here.
> 
> We save them in 'struct sprd_dma_config' as one parameter for
> sprd_dma_config(), otherwise we need add 2 more parameters (src and
> dst) for sprd_dma_config().

I am not sure I follow...

I meant you can use sprd_dma_config.cfg->src_addr/dst_addr and remove src_addr &
dst_addr in the sprd_dma_config. It duplicate..

Same for few more params...

> >> +     if (!is_slave_direction(dir) || sglen > 1)
> >> +             return NULL;
> >> +
> >> +     sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
> >> +     if (!sdesc)
> >> +             return NULL;
> >> +
> >> +     for_each_sg(sgl, sg, sglen, i) {
> >> +             if (dir == DMA_MEM_TO_DEV) {
> >> +                     slave_cfg->src_addr = sg_dma_address(sg);
> >> +                     slave_cfg->dst_addr = slave_cfg->cfg.dst_addr;
> >> +                     slave_cfg->src_step =
> >> +                     sprd_dma_get_step(slave_cfg->cfg.src_addr_width);
> >> +                     slave_cfg->dst_step = SPRD_DMA_NONE_STEP;
> >> +             } else {
> >> +                     slave_cfg->src_addr = slave_cfg->cfg.src_addr;
> >> +                     slave_cfg->dst_addr = sg_dma_address(sg);
> >> +                     slave_cfg->src_step = SPRD_DMA_NONE_STEP;
> >> +                     slave_cfg->dst_step =
> >> +                     sprd_dma_get_step(slave_cfg->cfg.dst_addr_width);
> >
> > use a helper for filling this and passing right values for each case?
> 
> We need pass many values to this helper, but will try. Thanks.

I think 5 and that may help to look it better :)

-- 
~Vinod
