Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752198AbeDLJdJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 05:33:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:34730 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750763AbeDLJdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 05:33:08 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,441,1517904000";
   d="scan'208";a="31502075"
Date: Thu, 12 Apr 2018 15:07:36 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Eric Long <eric.long@spreadtrum.com>, Mark Brown <broonie@kernel.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] dmaengine: sprd: Add Spreadtrum DMA configuration
Message-ID: <20180412093735.GF6014@localhost>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
 <0c2b76aba6a49e583f920ae582d6815fa9cc4361.1523346135.git.baolin.wang@linaro.org>
 <20180411093634.GC6014@localhost>
 <CAMz4kuJyKNNuR9WGP8F1NKAET6ZTtN4LtXTTtdnR3Zyxa+OjNw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMz4kuJyKNNuR9WGP8F1NKAET6ZTtN4LtXTTtdnR3Zyxa+OjNw@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 11, 2018 at 08:13:28PM +0800, Baolin Wang wrote:
> Hi Vinod,
> 
> On 11 April 2018 at 17:36, Vinod Koul <vinod.koul@intel.com> wrote:
> > On Tue, Apr 10, 2018 at 03:46:06PM +0800, Baolin Wang wrote:
> >
> >> +/*
> >> + * struct sprd_dma_config - DMA configuration structure
> >> + * @config: dma slave channel config
> >> + * @fragment_len: specify one fragment transfer length
> >> + * @block_len: specify one block transfer length
> >> + * @transcation_len: specify one transcation transfer length
> >> + * @wrap_ptr: wrap pointer address, once the transfer address reaches the
> >> + * 'wrap_ptr', the next transfer address will jump to the 'wrap_to' address.
> >> + * @wrap_to: wrap jump to address
> >> + * @req_mode: specify the DMA request mode
> >> + * @int_mode: specify the DMA interrupt type
> >> + */
> >> +struct sprd_dma_config {
> >> +     struct dma_slave_config config;
> >> +     u32 fragment_len;
> >
> > why not use _maxburst?
> 
> Yes, I can use maxburst.
> 
> >
> >> +     u32 block_len;
> >> +     u32 transcation_len;
> >
> > what does block and transaction len refer to here
> 
>  Our DMA has 3 transfer mode: transaction transfer, block transfer and
> fragment transfer. One transaction transfer can contain several blocks
> transfer, and each block can be set proper block step. One block can
> contain several fragments transfer with proper fragment step. It can
> generate interrupts when one transaction transfer or block transfer or
> fragment transfer is completed if user set the interrupt type. So here
> we should set the length for transaction transfer, block transfer and
> fragment transfer.

what are the max size these types support?

> 
> >
> >> +     phys_addr_t wrap_ptr;
> >> +     phys_addr_t wrap_to;
> >
> > this sound sg_list to me, why are we not using that here
> 
> It is similar to sg list, but it is not one software action, we have
> hardware registers to help to jump one specified address.
> 
> >
> >> +     enum sprd_dma_req_mode req_mode;
> >
> > Looking at definition of request mode we have frag, block, transaction list
> > etc.. That should depend upon dma request. If you have been asked to
> > transfer a list, you shall configure list mode. if it is a single
> > transaction then it should be transaction mode!
> 
> If I understand your points correctly, you mean we can specify the
> request mode when requesting one slave channel by
> 'dma_request_slave_channel()'. But we need change the request mode
> dynamically following different transfer task for this channel, so I
> am afraid we can not specify the request mode of this channel at
> requesting time.

Nope a channel has nothing to do with request type. You request and grab a
channel. Then you prepare a descriptor for a dma transaction. Based on
transaction requested you should intelligently break it down and create a
descriptor which uses transaction/block/fragment so that DMA throughput is
efficient. If prepare has sg list then you should use link list mode.
Further if you support max length, say 16KB and request is for 20KB you may
break it down for link list with two segments.

Each prep call has flags associated, that can help you configure interrupt
behaviour.

Btw other dma controllers have similar capabilities and driver manages these
:)

-- 
~Vinod
