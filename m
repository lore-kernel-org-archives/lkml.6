Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 434C0C6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:26:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17E824098
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 18:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="nCs/XSUp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E17E824098
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754004AbeGES0r (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 14:26:47 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:50534 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753831AbeGES0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 14:26:45 -0400
Date:   Thu, 05 Jul 2018 20:26:38 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 01/14] dmaengine: dma-jz4780: Avoid hardcoding number of
 channels
To:     PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Cc:     Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Mathieu Malaterre <malat@debian.org>,
        Daniel Silsby <dansilsby@gmail.com>, dmaengine@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Message-Id: <1530815198.6642.1@smtp.crapouillou.net>
In-Reply-To: <CANc+2y4ZJDKou4x570zNv82fSAxiOpbZfd3rFNB2M5Ft1C3eiQ@mail.gmail.com>
References: <20180703123214.23090-1-paul@crapouillou.net>
        <20180703123214.23090-2-paul@crapouillou.net>
        <CANc+2y4ZJDKou4x570zNv82fSAxiOpbZfd3rFNB2M5Ft1C3eiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530815203; bh=HLmy3EXSLh/2z2u+ZTpztzI8v43ggPFSeQ6BOeVuZzs=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type; b=nCs/XSUp0t2I8Hj8fUyjuBx9ZyOBO7enXaYgfNfNnT3UgLOowDjSvRoPOiA8K5wPSBZMIYU/r3SlBIBMHrfiUj4RnPg1qKYDtzO2Y1D1NkaX3HQpWnBIOKq6aaVLbfMEP6BbCkQrq4f1BH18RuvuBzWBvrB04Y/j0yKdFtgV4oM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi PrasannaKumar,

> Hi Paul,
> 
> On 3 July 2018 at 18:02, Paul Cercueil <paul@crapouillou.net> wrote:
>>  As part of the work to support various other Ingenic JZ47xx SoC 
>> versions,
>>  which don't feature the same number of DMA channels per core, we now
>>  deduce the number of DMA channels available from the devicetree
>>  compatible string.
>> 
>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   drivers/dma/dma-jz4780.c | 53 
>> +++++++++++++++++++++++++++++-----------
>>   1 file changed, 39 insertions(+), 14 deletions(-)
>> 
>>  diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
>>  index 85820a2d69d4..b40f491f0367 100644
>>  --- a/drivers/dma/dma-jz4780.c
>>  +++ b/drivers/dma/dma-jz4780.c
>>  @@ -16,6 +16,7 @@
>>   #include <linux/interrupt.h>
>>   #include <linux/module.h>
>>   #include <linux/of.h>
>>  +#include <linux/of_device.h>
>>   #include <linux/of_dma.h>
>>   #include <linux/platform_device.h>
>>   #include <linux/slab.h>
>>  @@ -23,8 +24,6 @@
>>   #include "dmaengine.h"
>>   #include "virt-dma.h"
>> 
>>  -#define JZ_DMA_NR_CHANNELS     32
>>  -
>>   /* Global registers. */
>>   #define JZ_DMA_REG_DMAC                0x1000
>>   #define JZ_DMA_REG_DIRQP       0x1004
>>  @@ -135,14 +134,20 @@ struct jz4780_dma_chan {
>>          unsigned int curr_hwdesc;
>>   };
>> 
>>  +enum jz_version {
>>  +       ID_JZ4780,
>>  +};
>>  +
>>   struct jz4780_dma_dev {
>>          struct dma_device dma_device;
>>          void __iomem *base;
>>          struct clk *clk;
>>          unsigned int irq;
>>  +       unsigned int nb_channels;
>>  +       enum jz_version version;
>> 
>>          uint32_t chan_reserved;
>>  -       struct jz4780_dma_chan chan[JZ_DMA_NR_CHANNELS];
>>  +       struct jz4780_dma_chan chan[];
> 
> Looks like a variable length array in struct. I think there is some
> effort to remove the usage of VLA. Can you revisit this? I may be
> wrong, please feel free to correct.

Are you sure? It's the first time I hear about it.
Could anybody confirm?

>>   };
>> 
>>   struct jz4780_dma_filter_data {
>>  @@ -648,7 +653,7 @@ static irqreturn_t jz4780_dma_irq_handler(int 
>> irq, void *data)
>> 
>>          pending = jz4780_dma_readl(jzdma, JZ_DMA_REG_DIRQP);
>> 
>>  -       for (i = 0; i < JZ_DMA_NR_CHANNELS; i++) {
>>  +       for (i = 0; i < jzdma->nb_channels; i++) {
>>                  if (!(pending & (1<<i)))
>>                          continue;
>> 
>>  @@ -728,7 +733,7 @@ static struct dma_chan 
>> *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
>>          data.channel = dma_spec->args[1];
>> 
>>          if (data.channel > -1) {
>>  -               if (data.channel >= JZ_DMA_NR_CHANNELS) {
>>  +               if (data.channel >= jzdma->nb_channels) {
>>                          dev_err(jzdma->dma_device.dev,
>>                                  "device requested non-existent 
>> channel %u\n",
>>                                  data.channel);
>>  @@ -752,19 +757,45 @@ static struct dma_chan 
>> *jz4780_of_dma_xlate(struct of_phandle_args *dma_spec,
>>          }
>>   }
>> 
>>  +static const unsigned int jz4780_dma_nb_channels[] = {
>>  +       [ID_JZ4780] = 32,
>>  +};
>>  +
>>  +static const struct of_device_id jz4780_dma_dt_match[] = {
>>  +       { .compatible = "ingenic,jz4780-dma", .data = (void 
>> *)ID_JZ4780 },
>>  +       {},
>>  +};
>>  +MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
>>  +
>>   static int jz4780_dma_probe(struct platform_device *pdev)
>>   {
>>          struct device *dev = &pdev->dev;
>>  +       const struct of_device_id *of_id = of_match_device(
>>  +                       jz4780_dma_dt_match, dev);
>>          struct jz4780_dma_dev *jzdma;
>>          struct jz4780_dma_chan *jzchan;
>>          struct dma_device *dd;
>>          struct resource *res;
>>  +       enum jz_version version;
>>  +       unsigned int nb_channels;
>>          int i, ret;
>> 
>>  -       jzdma = devm_kzalloc(dev, sizeof(*jzdma), GFP_KERNEL);
>>  +       if (of_id)
>>  +               version = (enum jz_version)of_id->data;
>>  +       else
>>  +               version = ID_JZ4780; /* Default when not probed 
>> from DT */
>>  +
>>  +       nb_channels = jz4780_dma_nb_channels[version];
>>  +
>>  +       jzdma = devm_kzalloc(dev, sizeof(*jzdma)
>>  +                               + sizeof(*jzdma->chan) * 
>> nb_channels,
>>  +                               GFP_KERNEL);
>>          if (!jzdma)
>>                  return -ENOMEM;
>> 
>>  +       jzdma->nb_channels = nb_channels;
>>  +       jzdma->version = version;
>>  +
>>          platform_set_drvdata(pdev, jzdma);
>> 
>>          res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>>  @@ -839,7 +870,7 @@ static int jz4780_dma_probe(struct 
>> platform_device *pdev)
>> 
>>          INIT_LIST_HEAD(&dd->channels);
>> 
>>  -       for (i = 0; i < JZ_DMA_NR_CHANNELS; i++) {
>>  +       for (i = 0; i < jzdma->nb_channels; i++) {
>>                  jzchan = &jzdma->chan[i];
>>                  jzchan->id = i;
>> 
>>  @@ -884,19 +915,13 @@ static int jz4780_dma_remove(struct 
>> platform_device *pdev)
>> 
>>          free_irq(jzdma->irq, jzdma);
>> 
>>  -       for (i = 0; i < JZ_DMA_NR_CHANNELS; i++)
>>  +       for (i = 0; i < jzdma->nb_channels; i++)
>>                  tasklet_kill(&jzdma->chan[i].vchan.task);
>> 
>>          dma_async_device_unregister(&jzdma->dma_device);
>>          return 0;
>>   }
>> 
>>  -static const struct of_device_id jz4780_dma_dt_match[] = {
>>  -       { .compatible = "ingenic,jz4780-dma", .data = NULL },
>>  -       {},
>>  -};
>>  -MODULE_DEVICE_TABLE(of, jz4780_dma_dt_match);
>>  -
>>   static struct platform_driver jz4780_dma_driver = {
>>          .probe          = jz4780_dma_probe,
>>          .remove         = jz4780_dma_remove,
>>  --
>>  2.18.0
>> 
>> 

