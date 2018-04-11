Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752940AbeDKMNb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 08:13:31 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:45979 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752482AbeDKMN3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 08:13:29 -0400
X-Google-Smtp-Source: AIpwx4+WPHrNnfUPXLC4FGEU5wSzVLnp9AAvclaHfts9uYkGGcXacmnJ/a5MzQxlS8UCypS7mZzCwwuIfK7w77XaxmY=
MIME-Version: 1.0
In-Reply-To: <20180411093634.GC6014@localhost>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
 <0c2b76aba6a49e583f920ae582d6815fa9cc4361.1523346135.git.baolin.wang@linaro.org>
 <20180411093634.GC6014@localhost>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 11 Apr 2018 20:13:28 +0800
Message-ID: <CAMz4kuJyKNNuR9WGP8F1NKAET6ZTtN4LtXTTtdnR3Zyxa+OjNw@mail.gmail.com>
Subject: Re: [PATCH 4/5] dmaengine: sprd: Add Spreadtrum DMA configuration
To: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Eric Long <eric.long@spreadtrum.com>, Mark Brown <broonie@kernel.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 11 April 2018 at 17:36, Vinod Koul <vinod.koul@intel.com> wrote:
> On Tue, Apr 10, 2018 at 03:46:06PM +0800, Baolin Wang wrote:
>
>> +/*
>> + * struct sprd_dma_config - DMA configuration structure
>> + * @config: dma slave channel config
>> + * @fragment_len: specify one fragment transfer length
>> + * @block_len: specify one block transfer length
>> + * @transcation_len: specify one transcation transfer length
>> + * @wrap_ptr: wrap pointer address, once the transfer address reaches the
>> + * 'wrap_ptr', the next transfer address will jump to the 'wrap_to' address.
>> + * @wrap_to: wrap jump to address
>> + * @req_mode: specify the DMA request mode
>> + * @int_mode: specify the DMA interrupt type
>> + */
>> +struct sprd_dma_config {
>> +     struct dma_slave_config config;
>> +     u32 fragment_len;
>
> why not use _maxburst?

Yes, I can use maxburst.

>
>> +     u32 block_len;
>> +     u32 transcation_len;
>
> what does block and transaction len refer to here

 Our DMA has 3 transfer mode: transaction transfer, block transfer and
fragment transfer. One transaction transfer can contain several blocks
transfer, and each block can be set proper block step. One block can
contain several fragments transfer with proper fragment step. It can
generate interrupts when one transaction transfer or block transfer or
fragment transfer is completed if user set the interrupt type. So here
we should set the length for transaction transfer, block transfer and
fragment transfer.

>
>> +     phys_addr_t wrap_ptr;
>> +     phys_addr_t wrap_to;
>
> this sound sg_list to me, why are we not using that here

It is similar to sg list, but it is not one software action, we have
hardware registers to help to jump one specified address.

>
>> +     enum sprd_dma_req_mode req_mode;
>
> Looking at definition of request mode we have frag, block, transaction list
> etc.. That should depend upon dma request. If you have been asked to
> transfer a list, you shall configure list mode. if it is a single
> transaction then it should be transaction mode!

If I understand your points correctly, you mean we can specify the
request mode when requesting one slave channel by
'dma_request_slave_channel()'. But we need change the request mode
dynamically following different transfer task for this channel, so I
am afraid we can not specify the request mode of this channel at
requesting time.

>
>> +     enum sprd_dma_int_type int_mode;
>
> Here again I think driver needs to take a call based on dma_ctrl_flags.

The 'dma_ctrl_flags' defines DMA_PREP_INTERRUPT flag to indicate if a
interrupt is needed after transfer, but it can not distinguish
Spreadtrum special interrupt type of DMA. So can I pass the interrupt
type as one parameter for 'device_prep_slave_sg' interface?

Very appreciated for your useful comments.

-- 
Baolin.wang
Best Regards
