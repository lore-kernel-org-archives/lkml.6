Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753450AbeDMGRh (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 02:17:37 -0400
Received: from mail-ot0-f174.google.com ([74.125.82.174]:46658 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753112AbeDMGRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 02:17:35 -0400
X-Google-Smtp-Source: AIpwx49X0TcvOLERjR9J3uM5vezHFHix6arCO49GWsFayuWwpM/wpGWFwTRlm8DPRDqmerQyO3xtJfkgtf4zawVx0jc=
MIME-Version: 1.0
In-Reply-To: <20180413034332.GI6014@localhost>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
 <0c2b76aba6a49e583f920ae582d6815fa9cc4361.1523346135.git.baolin.wang@linaro.org>
 <20180411093634.GC6014@localhost> <CAMz4kuJyKNNuR9WGP8F1NKAET6ZTtN4LtXTTtdnR3Zyxa+OjNw@mail.gmail.com>
 <20180412093735.GF6014@localhost> <CAMz4ku+i+zA0_5U65vc3h3tO-hzWvtCOFDeFU94h3Rm6sJUuKQ@mail.gmail.com>
 <CAMz4ku+EUtk2phRGkxkW6YwUvBLb-O7tmMoucvVEQZbL9EY8Zg@mail.gmail.com> <20180413034332.GI6014@localhost>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Fri, 13 Apr 2018 14:17:34 +0800
Message-ID: <CAMz4kuL_i7u5OCXrtJy92=OisOzgbWk_e-S9dSuBRPenX=ScPA@mail.gmail.com>
Subject: Re: [PATCH 4/5] dmaengine: sprd: Add Spreadtrum DMA configuration
To: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Eric Long <eric.long@spreadtrum.com>, Mark Brown <broonie@kernel.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 April 2018 at 11:43, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Apr 12, 2018 at 07:36:34PM +0800, Baolin Wang wrote:
>> >>> >> +/*
>> >>> >> + * struct sprd_dma_config - DMA configuration structure
>> >>> >> + * @config: dma slave channel config
>> >>> >> + * @fragment_len: specify one fragment transfer length
>> >>> >> + * @block_len: specify one block transfer length
>> >>> >> + * @transcation_len: specify one transcation transfer length
>> >>> >> + * @wrap_ptr: wrap pointer address, once the transfer address reaches the
>> >>> >> + * 'wrap_ptr', the next transfer address will jump to the 'wrap_to' address.
>> >>> >> + * @wrap_to: wrap jump to address
>> >>> >> + * @req_mode: specify the DMA request mode
>> >>> >> + * @int_mode: specify the DMA interrupt type
>> >>> >> + */
>> >>> >> +struct sprd_dma_config {
>> >>> >> +     struct dma_slave_config config;
>> >>> >> +     u32 fragment_len;
>> >>> >
>> >>> > why not use _maxburst?
>> >>>
>> >>> Yes, I can use maxburst.
>> >>>
>> >>> >
>> >>> >> +     u32 block_len;
>> >>> >> +     u32 transcation_len;
>> >>> >
>> >>> > what does block and transaction len refer to here
>> >>>
>> >>>  Our DMA has 3 transfer mode: transaction transfer, block transfer and
>> >>> fragment transfer. One transaction transfer can contain several blocks
>> >>> transfer, and each block can be set proper block step. One block can
>> >>> contain several fragments transfer with proper fragment step. It can
>> >>> generate interrupts when one transaction transfer or block transfer or
>> >>> fragment transfer is completed if user set the interrupt type. So here
>> >>> we should set the length for transaction transfer, block transfer and
>> >>> fragment transfer.
>> >>
>> >> what are the max size these types support?
>> >
>> > These types max size definition:
>> >
>> > #define SPRD_DMA_FRG_LEN_MASK GENMASK(16, 0)
>> >
>> > #define SPRD_DMA_BLK_LEN_MASK GENMASK(16, 0)
>> >
>> > #define SPRD_DMA_TRSC_LEN_MASK GENMASK(27, 0)
>> >
>> >>>
>> >>> >
>> >>> >> +     phys_addr_t wrap_ptr;
>> >>> >> +     phys_addr_t wrap_to;
>> >>> >
>> >>> > this sound sg_list to me, why are we not using that here
>> >>>
>> >>> It is similar to sg list, but it is not one software action, we have
>> >>> hardware registers to help to jump one specified address.
>> >>>
>> >>> >
>> >>> >> +     enum sprd_dma_req_mode req_mode;
>> >>> >
>> >>> > Looking at definition of request mode we have frag, block, transaction list
>> >>> > etc.. That should depend upon dma request. If you have been asked to
>> >>> > transfer a list, you shall configure list mode. if it is a single
>> >>> > transaction then it should be transaction mode!
>> >>>
>> >>> If I understand your points correctly, you mean we can specify the
>> >>> request mode when requesting one slave channel by
>> >>> 'dma_request_slave_channel()'. But we need change the request mode
>> >>> dynamically following different transfer task for this channel, so I
>> >>> am afraid we can not specify the request mode of this channel at
>> >>> requesting time.
>> >>
>> >> Nope a channel has nothing to do with request type. You request and grab a
>> >> channel. Then you prepare a descriptor for a dma transaction. Based on
>> >> transaction requested you should intelligently break it down and create a
>> >> descriptor which uses transaction/block/fragment so that DMA throughput is
>> >> efficient. If prepare has sg list then you should use link list mode.
>> >> Further if you support max length, say 16KB and request is for 20KB you may
>> >> break it down for link list with two segments.
>> >
>> > OK. So I can add one more cell to specify the request mode for this channel.
>> >
>> > dmas = <&apdma 11 SPRD_DMA_BLK_REQ>
>> >
>> >>
>> >> Each prep call has flags associated, that can help you configure interrupt
>> >> behaviour.
>>
>> After more thinking, I think this will be not useful for users, since
>> users need configure one DMA channel through different 3 places,
>> specify the request mode in dts, specify the interrupt type through
>> prep call flags, and other configuration need to be configured through
>> 'struct sprd_dma_config'. That is not one good design for users. What
>> do you think? Thanks.
>
> Agreed, users only care about grabbing a channel, setting a descriptor and
> submitting that.
>
> I think you need to go back and think about this a bit, please do go thru
> dmaengine documentation and see other driver examples.
>
> We don't typically expose these to users, they give us a transfer and we set
> that up in hardware for efficient. Its DMA so people expect us to use fastest
> mechanism available.

But there are some configuration are really special for Spreadtrum
DMA, and must need user to specify how to configure, especially some
scenarios of audio. So I wander if we can add one pointer for
'dma_slave_config' to expand some special DMA configuration
requirements, like:

struct dma_slave_config {
    ......
    unsigned int slave_id;
    void *platform_data;
};

So if some DMA has some special configuration (such as Spreadtrum
DMA), they can user this platform_data pointer. Like xilinx DMA, they
also have some special configuration.

>
> I would say setup as Link list for sg transfers and use one of them modes
> (again think efficiency) for single transfers.
>
> Also use all the parameters in dma_slave_config and also setup capabilities if
> not done.

-- 
Baolin.wang
Best Regards
