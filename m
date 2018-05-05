Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbeEEFzj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 01:55:39 -0400
Received: from mga01.intel.com ([192.55.52.88]:48864 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750741AbeEEFzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 01:55:37 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,364,1520924400";
   d="scan'208";a="46920723"
Date: Sat, 5 May 2018 13:54:58 +0800
From: kbuild test robot <lkp@intel.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: kbuild-all@01.org, dan.j.williams@intel.com, vinod.koul@intel.com,
        eric.long@spreadtrum.com, broonie@kernel.org, baolin.wang@linaro.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] dmaengine: sprd: Add Spreadtrum DMA configuration
Message-ID: <201805051336.iU9Fsl3b%fengguang.wu@intel.com>
References: <795030fce89ec55d015602fbf4594838a22a9094.1525420581.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <795030fce89ec55d015602fbf4594838a22a9094.1525420581.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: fengguang.wu@intel.com
X-SA-Exim-Scanned: No (on bee); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eric,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on slave-dma/next]
[also build test WARNING on next-20180504]
[cannot apply to linus/master v4.17-rc3]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Baolin-Wang/dmaengine-sprd-Optimize-the-sprd_dma_prep_dma_memcpy/20180505-071137
base:   https://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/dma/sprd-dma.c:780:57: sparse: mixing different enum types
   drivers/dma/sprd-dma.c:780:57:     int enum dma_slave_buswidth  versus
   drivers/dma/sprd-dma.c:780:57:     int enum sprd_dma_datawidth
   drivers/dma/sprd-dma.c:787:57: sparse: mixing different enum types
   drivers/dma/sprd-dma.c:787:57:     int enum dma_slave_buswidth  versus
   drivers/dma/sprd-dma.c:787:57:     int enum sprd_dma_datawidth

vim +780 drivers/dma/sprd-dma.c

   755	
   756	static struct dma_async_tx_descriptor *
   757	sprd_dma_prep_slave_sg(struct dma_chan *chan, struct scatterlist *sgl,
   758			       unsigned int sglen, enum dma_transfer_direction dir,
   759			       unsigned long flags, void *context)
   760	{
   761		struct sprd_dma_chn *schan = to_sprd_dma_chan(chan);
   762		struct sprd_dma_config *slave_cfg = &schan->slave_cfg;
   763		struct sprd_dma_desc *sdesc;
   764		struct scatterlist *sg;
   765		int ret, i;
   766	
   767		/* TODO: now we only support one sg for each DMA configuration. */
   768		if (!is_slave_direction(dir) || sglen > 1)
   769			return NULL;
   770	
   771		sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
   772		if (!sdesc)
   773			return NULL;
   774	
   775		for_each_sg(sgl, sg, sglen, i) {
   776			if (dir == DMA_MEM_TO_DEV) {
   777				slave_cfg->src_addr = sg_dma_address(sg);
   778				slave_cfg->dst_addr = slave_cfg->cfg.dst_addr;
   779				slave_cfg->src_step =
 > 780				sprd_dma_get_step(slave_cfg->cfg.src_addr_width);
   781				slave_cfg->dst_step = SPRD_DMA_NONE_STEP;
   782			} else {
   783				slave_cfg->src_addr = slave_cfg->cfg.src_addr;
   784				slave_cfg->dst_addr = sg_dma_address(sg);
   785				slave_cfg->src_step = SPRD_DMA_NONE_STEP;
   786				slave_cfg->dst_step =
   787				sprd_dma_get_step(slave_cfg->cfg.dst_addr_width);
   788			}
   789	
   790			slave_cfg->block_len = sg_dma_len(sg);
   791			slave_cfg->transcation_len = sg_dma_len(sg);
   792		}
   793	
   794		slave_cfg->req_mode =
   795			(flags >> SPRD_DMA_REQ_SHIFT) & SPRD_DMA_REQ_MODE_MASK;
   796		slave_cfg->int_mode = flags & SPRD_DMA_INT_MASK;
   797	
   798		ret = sprd_dma_config(chan, sdesc, slave_cfg);
   799		if (ret) {
   800			kfree(sdesc);
   801			return NULL;
   802		}
   803	
   804		return vchan_tx_prep(&schan->vc, &sdesc->vd, flags);
   805	}
   806	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
