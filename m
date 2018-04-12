Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752700AbeDLLgh (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 07:36:37 -0400
Received: from mail-oi0-f41.google.com ([209.85.218.41]:43123 "EHLO
        mail-oi0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751918AbeDLLgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 07:36:35 -0400
X-Google-Smtp-Source: AIpwx4/m9/H+Ynly609hDSAoUEBVPE37oHVRpltSgPY3MAjM+d9fJaNhrYndNOswInAdg3zGdoXrxs3BDMI+iXVCMSs=
MIME-Version: 1.0
In-Reply-To: <CAMz4ku+i+zA0_5U65vc3h3tO-hzWvtCOFDeFU94h3Rm6sJUuKQ@mail.gmail.com>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
 <0c2b76aba6a49e583f920ae582d6815fa9cc4361.1523346135.git.baolin.wang@linaro.org>
 <20180411093634.GC6014@localhost> <CAMz4kuJyKNNuR9WGP8F1NKAET6ZTtN4LtXTTtdnR3Zyxa+OjNw@mail.gmail.com>
 <20180412093735.GF6014@localhost> <CAMz4ku+i+zA0_5U65vc3h3tO-hzWvtCOFDeFU94h3Rm6sJUuKQ@mail.gmail.com>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Thu, 12 Apr 2018 19:36:34 +0800
Message-ID: <CAMz4ku+EUtk2phRGkxkW6YwUvBLb-O7tmMoucvVEQZbL9EY8Zg@mail.gmail.com>
Subject: Re: [PATCH 4/5] dmaengine: sprd: Add Spreadtrum DMA configuration
To: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Eric Long <eric.long@spreadtrum.com>, Mark Brown <broonie@kernel.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12 April 2018 at 19:30, Baolin Wang <baolin.wang@linaro.org> wrote:
> Hi Vinod,
>
> On 12 April 2018 at 17:37, Vinod Koul <vinod.koul@intel.com> wrote:
>> On Wed, Apr 11, 2018 at 08:13:28PM +0800, Baolin Wang wrote:
>>> Hi Vinod,
>>>
>>> On 11 April 2018 at 17:36, Vinod Koul <vinod.koul@intel.com> wrote:
>>> > On Tue, Apr 10, 2018 at 03:46:06PM +0800, Baolin Wang wrote:
>>> >
>>> >> +/*
>>> >> + * struct sprd_dma_config - DMA configuration structure
>>> >> + * @config: dma slave channel config
>>> >> + * @fragment_len: specify one fragment transfer length
>>> >> + * @block_len: specify one block transfer length
>>> >> + * @transcation_len: specify one transcation transfer length
>>> >> + * @wrap_ptr: wrap pointer address, once the transfer address reaches the
>>> >> + * 'wrap_ptr', the next transfer address will jump to the 'wrap_to' address.
>>> >> + * @wrap_to: wrap jump to address
>>> >> + * @req_mode: specify the DMA request mode
>>> >> + * @int_mode: specify the DMA interrupt type
>>> >> + */
>>> >> +struct sprd_dma_config {
>>> >> +     struct dma_slave_config config;
>>> >> +     u32 fragment_len;
>>> >
>>> > why not use _maxburst?
>>>
>>> Yes, I can use maxburst.
>>>
>>> >
>>> >> +     u32 block_len;
>>> >> +     u32 transcation_len;
>>> >
>>> > what does block and transaction len refer to here
>>>
>>>  Our DMA has 3 transfer mode: transaction transfer, block transfer and
>>> fragment transfer. One transaction transfer can contain several blocks
>>> transfer, and each block can be set proper block step. One block can
>>> contain several fragments transfer with proper fragment step. It can
>>> generate interrupts when one transaction transfer or block transfer or
>>> fragment transfer is completed if user set the interrupt type. So here
>>> we should set the length for transaction transfer, block transfer and
>>> fragment transfer.
>>
>> what are the max size these types support?
>
> These types max size definition:
>
> #define SPRD_DMA_FRG_LEN_MASK GENMASK(16, 0)
>
> #define SPRD_DMA_BLK_LEN_MASK GENMASK(16, 0)
>
> #define SPRD_DMA_TRSC_LEN_MASK GENMASK(27, 0)
>
>>>
>>> >
>>> >> +     phys_addr_t wrap_ptr;
>>> >> +     phys_addr_t wrap_to;
>>> >
>>> > this sound sg_list to me, why are we not using that here
>>>
>>> It is similar to sg list, but it is not one software action, we have
>>> hardware registers to help to jump one specified address.
>>>
>>> >
>>> >> +     enum sprd_dma_req_mode req_mode;
>>> >
>>> > Looking at definition of request mode we have frag, block, transaction list
>>> > etc.. That should depend upon dma request. If you have been asked to
>>> > transfer a list, you shall configure list mode. if it is a single
>>> > transaction then it should be transaction mode!
>>>
>>> If I understand your points correctly, you mean we can specify the
>>> request mode when requesting one slave channel by
>>> 'dma_request_slave_channel()'. But we need change the request mode
>>> dynamically following different transfer task for this channel, so I
>>> am afraid we can not specify the request mode of this channel at
>>> requesting time.
>>
>> Nope a channel has nothing to do with request type. You request and grab a
>> channel. Then you prepare a descriptor for a dma transaction. Based on
>> transaction requested you should intelligently break it down and create a
>> descriptor which uses transaction/block/fragment so that DMA throughput is
>> efficient. If prepare has sg list then you should use link list mode.
>> Further if you support max length, say 16KB and request is for 20KB you may
>> break it down for link list with two segments.
>
> OK. So I can add one more cell to specify the request mode for this channel.
>
> dmas = <&apdma 11 SPRD_DMA_BLK_REQ>
>
>>
>> Each prep call has flags associated, that can help you configure interrupt
>> behaviour.

After more thinking, I think this will be not useful for users, since
users need configure one DMA channel through different 3 places,
specify the request mode in dts, specify the interrupt type through
prep call flags, and other configuration need to be configured through
'struct sprd_dma_config'. That is not one good design for users. What
do you think? Thanks.

-- 
Baolin.wang
Best Regards
