Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752740AbeDKKvc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 11 Apr 2018 06:51:32 -0400
Received: from mail-oi0-f66.google.com ([209.85.218.66]:43086 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751729AbeDKKva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Apr 2018 06:51:30 -0400
X-Google-Smtp-Source: AIpwx4+AxMaX5HgYQYGrT9vMnUGfpZy3W5sz/130q1khqEffuKdFN5jIyCr/FjFv8CyZT9tJruEg8qyXQul4IRFiL18=
MIME-Version: 1.0
In-Reply-To: <20180411094000.GD6014@localhost>
References: <abdda9da96185f764d58bbf61db9010d0f72d1b3.1523346135.git.baolin.wang@linaro.org>
 <0a9fa618bd74e74c135ebee2e40b30d361c1d905.1523346135.git.baolin.wang@linaro.org>
 <20180411094000.GD6014@localhost>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Wed, 11 Apr 2018 18:51:29 +0800
Message-ID: <CAMz4kuK8U2sy1LDSTQFHtM5N8xL2mA9qJA-u+bznHvRUuZK68A@mail.gmail.com>
Subject: Re: [PATCH 5/5] dmaengine: sprd: Add 'device_config' and
 'device_prep_slave_sg' interfaces
To: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Eric Long <eric.long@spreadtrum.com>, Mark Brown <broonie@kernel.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 11 April 2018 at 17:40, Vinod Koul <vinod.koul@intel.com> wrote:
> On Tue, Apr 10, 2018 at 03:46:07PM +0800, Baolin Wang wrote:
>> This patch adds the 'device_config' and 'device_prep_slave_sg' interfaces
>> for users to configure DMA.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
>> ---
>>  drivers/dma/sprd-dma.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 48 insertions(+)
>>
>> diff --git a/drivers/dma/sprd-dma.c b/drivers/dma/sprd-dma.c
>> index f8038de..c923fb0 100644
>> --- a/drivers/dma/sprd-dma.c
>> +++ b/drivers/dma/sprd-dma.c
>> @@ -869,6 +869,52 @@ static int sprd_dma_config(struct dma_chan *chan, struct sprd_dma_desc *sdesc,
>>       return vchan_tx_prep(&schan->vc, &sdesc->vd, flags);
>>  }
>>
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
>> +     if (!is_slave_direction(slave_cfg->config.direction) || sglen > 1)
>
> the slave direction check seems wrong to me. .device_config shall give you
> dma_slave_config. You should check here if dir passed is slave or not. If
> you want to check parameters in slave_config then please use .device_config

Correct. Sorry I missed this and I will fix it in next version.

>
>> +             return NULL;
>> +
>> +     sdesc = kzalloc(sizeof(*sdesc), GFP_NOWAIT);
>> +     if (!sdesc)
>> +             return NULL;
>> +
>> +     for_each_sg(sgl, sg, sglen, i) {
>> +             if (slave_cfg->config.direction == DMA_MEM_TO_DEV)
>> +                     slave_cfg->config.src_addr = sg_dma_address(sg);
>
> Nope slave_config specifies peripheral address and not memory one passed here

OK. Thanks for your comments.

-- 
Baolin.wang
Best Regards
