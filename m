Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752562AbeEKMU0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 08:20:26 -0400
Received: from mail-oi0-f54.google.com ([209.85.218.54]:33254 "EHLO
        mail-oi0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750726AbeEKMUZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 08:20:25 -0400
X-Google-Smtp-Source: AB8JxZqNyXBO2zn3eTplJT4ipwK0d4du/kxbtwCPNctoJWtmLnTJ1Tg3jVMJ9Kyh96Q9h4dBmcTEwdVjQNG05c5brWg=
MIME-Version: 1.0
In-Reply-To: <20180511120457.GD30118@vkoul-mobl>
References: <b115795adf9e9a9e611ee0ff353fae5850d1e287.1525863923.git.baolin.wang@linaro.org>
 <67447aabb8e4e051ff39b814a0e169e6a91bb66e.1525863923.git.baolin.wang@linaro.org>
 <20180511112225.GA30118@vkoul-mobl> <CAMz4kuKi884zyOgXAvYXzUFGv7ea1L0Wxv8AHbf+XjEez+jJTQ@mail.gmail.com>
 <20180511115306.GC30118@vkoul-mobl> <CAMz4kuLXCB9RipP6zicc6efMaKWHycGFwsbMZNiQDAobsUCpvw@mail.gmail.com>
 <20180511120457.GD30118@vkoul-mobl>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 11 May 2018 20:20:24 +0800
Message-ID: <CAMz4kuKP2+SGoAqQPkt2sFuh3DZiO=7tQ=KHrbPUwQBqn-Mkgw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dmaengine: sprd: Add Spreadtrum DMA configuration
To: Vinod Koul <vinod.koul@linaro.org>
Cc: Vinod Koul <vkoul@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
        Eric Long <eric.long@spreadtrum.com>, Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, dmaengine@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11 May 2018 at 20:04, Vinod Koul <vinod.koul@linaro.org> wrote:
> On 11-05-18, 19:58, Baolin Wang wrote:
>> On 11 May 2018 at 19:53, Vinod Koul <vkoul@kernel.org> wrote:
>> >> >
>> >> >> +/*
>> >> >> + * struct sprd_dma_config - DMA configuration structure
>> >> >> + * @cfg: dma slave channel runtime config
>> >> >> + * @src_addr: the source physical address
>> >> >> + * @dst_addr: the destination physical address
>> >> >> + * @block_len: specify one block transfer length
>> >> >> + * @transcation_len: specify one transcation transfer length
>> >> >> + * @src_step: source transfer step
>> >> >> + * @dst_step: destination transfer step
>> >> >> + * @wrap_ptr: wrap pointer address, once the transfer address reaches the
>> >> >> + * 'wrap_ptr', the next transfer address will jump to the 'wrap_to' address.
>> >> >> + * @wrap_to: wrap jump to address
>> >> >> + * @req_mode: specify the DMA request mode
>> >> >> + * @int_mode: specify the DMA interrupt type
>> >> >> + */
>> >> >> +struct sprd_dma_config {
>> >> >> +     struct dma_slave_config cfg;
>> >> >> +     phys_addr_t src_addr;
>> >> >> +     phys_addr_t dst_addr;
>> >> >
>> >> > these are already in cfg so why duplicate, same for few more here.
>> >>
>> >> We save them in 'struct sprd_dma_config' as one parameter for
>> >> sprd_dma_config(), otherwise we need add 2 more parameters (src and
>> >> dst) for sprd_dma_config().
>> >
>> > I am not sure I follow...
>> >
>> > I meant you can use sprd_dma_config.cfg->src_addr/dst_addr and remove src_addr &
>> > dst_addr in the sprd_dma_config. It duplicate..
>>
>> But we can not set values if dir == DMA_MEM_TO_DEV, since they
>> represent the device address, right?
>> sprd_dma_config.cfg->src_addr = sg_dma_address(sg);
>
> Ah right and that is another issue to fix then :) we should not store addresses
> you get for prep_ calls. They are supposed to be stored in the descriptor.
> Current approach is not correct.

OK. But we do not want to touch the descriptor structure, so we plan
to add 2 more parameters for sprd_dma_config().
And remove these 2 values from struct sprd_dma_config.

>
> You can get different prepare calls  (i think fixing this will remove 1 sg
> limitation).. and use the argument values and store in respective descriptors.
> Pls do see the other driver examples..
>
> --
> ~Vinod



-- 
Baolin.wang
Best Regards
