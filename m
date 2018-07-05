Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23CDFC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:45:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6C9623FAC
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 21:45:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="QcQq1hiM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6C9623FAC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=crapouillou.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753551AbeGEVpW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 17:45:22 -0400
Received: from outils.crapouillou.net ([89.234.176.41]:58666 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753345AbeGEVpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 17:45:21 -0400
Date:   Thu, 05 Jul 2018 23:45:12 +0200
From:   Paul Cercueil <paul@crapouillou.net>
Subject: Re: [PATCH 02/14] dmaengine: dma-jz4780: Separate chan/ctrl registers
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
Message-Id: <1530827112.6642.2@smtp.crapouillou.net>
In-Reply-To: <CANc+2y4dVDQoPP4zJkous=p-HYL+nu1Cxcrv0nqEMABN_4uyZw@mail.gmail.com>
References: <20180703123214.23090-1-paul@crapouillou.net>
        <20180703123214.23090-3-paul@crapouillou.net>
        <CANc+2y4dVDQoPP4zJkous=p-HYL+nu1Cxcrv0nqEMABN_4uyZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1530827118; bh=03PcXefqVgm0djdECK2LUhMllvTTJRgPJmkrRBlqrnI=; h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References:MIME-Version:Content-Type; b=QcQq1hiM3x06Xw2Usz4zx6XCbWtPgj6nV525g4TFyRQ1zFz/47D60VgummmgcPCOq/2zm4NFoznmwBGeL/O8JNeuzL3kRvHYxGBGOCSKgmDfLpEm2dKD/6/wwuqABIAc8OlzQ/q3Ifo58gd1lS9c1O2KRglnYRUGh7rjAYrrKPE=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Paul,
> 
> On 3 July 2018 at 18:02, Paul Cercueil <paul@crapouillou.net> wrote:
>>  The register area of the JZ4780 DMA core can be split into different
>>  sections for different purposes:
>> 
>>  * one set of registers is used to perform actions at the DMA core 
>> level,
>>  that will generally affect all channels;
>> 
>>  * one set of registers per DMA channel, to perform actions at the 
>> DMA
>>  channel level, that will only affect the channel in question.
>> 
>>  The problem rises when trying to support new versions of the JZ47xx
>>  Ingenic SoC. For instance, the JZ4770 has two DMA cores, each one
>>  with six DMA channels, and the register sets are interleaved:
>>  <DMA0 chan regs> <DMA1 chan regs> <DMA0 ctrl regs> <DMA1 ctrl regs>
>> 
>>  By using one memory resource for the channel-specific registers and
>>  one memory resource for the core-specific registers, we can support
>>  the JZ4770, by initializing the driver once per DMA core with 
>> different
>>  addresses.
> 
> As per my understanding device tree should be modified only when
> hardware changes. This looks the other way around. It must be possible
> to achieve what you are trying to do in this patch without changing
> the device tree.

I would agree that devicetree has an ABI that we shouldn't break if
possible.

However DTS support for all the Ingenic SoCs/boards is far from being
complete, and more importantly, all Ingenic-based boards compile the DTS
file within the kernel; so breaking the ABI is not (yet) a problem, and
we should push the big changes right now while it's still possible.

>>  Signed-off-by: Paul Cercueil <paul@crapouillou.net>
>>  ---
>>   .../devicetree/bindings/dma/jz4780-dma.txt    |   6 +-
>>   drivers/dma/dma-jz4780.c                      | 106 
>> +++++++++++-------
>>   2 files changed, 69 insertions(+), 43 deletions(-)
>> 
>>  diff --git a/Documentation/devicetree/bindings/dma/jz4780-dma.txt 
>> b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
>>  index f25feee62b15..f9b1864f5b77 100644
>>  --- a/Documentation/devicetree/bindings/dma/jz4780-dma.txt
>>  +++ b/Documentation/devicetree/bindings/dma/jz4780-dma.txt
>>  @@ -3,7 +3,8 @@
>>   Required properties:
>> 
>>   - compatible: Should be "ingenic,jz4780-dma"
>>  -- reg: Should contain the DMA controller registers location and 
>> length.
>>  +- reg: Should contain the DMA channel registers location and 
>> length, followed
>>  +  by the DMA controller registers location and length.
>>   - interrupts: Should contain the interrupt specifier of the DMA 
>> controller.
>>   - interrupt-parent: Should be the phandle of the interrupt 
>> controller that
>>   - clocks: Should contain a clock specifier for the JZ4780 PDMA 
>> clock.
>>  @@ -22,7 +23,8 @@ Example:
>> 
>>   dma: dma@13420000 {
>>          compatible = "ingenic,jz4780-dma";
>>  -       reg = <0x13420000 0x10000>;
>>  +       reg = <0x13420000 0x400
>>  +              0x13421000 0x40>;
>> 
>>          interrupt-parent = <&intc>;
>>          interrupts = <10>;
>>  diff --git a/drivers/dma/dma-jz4780.c b/drivers/dma/dma-jz4780.c
>>  index b40f491f0367..4d234caf5d62 100644
>>  --- a/drivers/dma/dma-jz4780.c
>>  +++ b/drivers/dma/dma-jz4780.c
>>  @@ -25,26 +25,26 @@
>>   #include "virt-dma.h"
>> 
>>   /* Global registers. */
>>  -#define JZ_DMA_REG_DMAC                0x1000
>>  -#define JZ_DMA_REG_DIRQP       0x1004
>>  -#define JZ_DMA_REG_DDR         0x1008
>>  -#define JZ_DMA_REG_DDRS                0x100c
>>  -#define JZ_DMA_REG_DMACP       0x101c
>>  -#define JZ_DMA_REG_DSIRQP      0x1020
>>  -#define JZ_DMA_REG_DSIRQM      0x1024
>>  -#define JZ_DMA_REG_DCIRQP      0x1028
>>  -#define JZ_DMA_REG_DCIRQM      0x102c
>>  +#define JZ_DMA_REG_DMAC                0x00
>>  +#define JZ_DMA_REG_DIRQP       0x04
>>  +#define JZ_DMA_REG_DDR         0x08
>>  +#define JZ_DMA_REG_DDRS                0x0c
>>  +#define JZ_DMA_REG_DMACP       0x1c
>>  +#define JZ_DMA_REG_DSIRQP      0x20
>>  +#define JZ_DMA_REG_DSIRQM      0x24
>>  +#define JZ_DMA_REG_DCIRQP      0x28
>>  +#define JZ_DMA_REG_DCIRQM      0x2c
>> 
>>   /* Per-channel registers. */
>>   #define JZ_DMA_REG_CHAN(n)     (n * 0x20)
>>  -#define JZ_DMA_REG_DSA(n)      (0x00 + JZ_DMA_REG_CHAN(n))
>>  -#define JZ_DMA_REG_DTA(n)      (0x04 + JZ_DMA_REG_CHAN(n))
>>  -#define JZ_DMA_REG_DTC(n)      (0x08 + JZ_DMA_REG_CHAN(n))
>>  -#define JZ_DMA_REG_DRT(n)      (0x0c + JZ_DMA_REG_CHAN(n))
>>  -#define JZ_DMA_REG_DCS(n)      (0x10 + JZ_DMA_REG_CHAN(n))
>>  -#define JZ_DMA_REG_DCM(n)      (0x14 + JZ_DMA_REG_CHAN(n))
>>  -#define JZ_DMA_REG_DDA(n)      (0x18 + JZ_DMA_REG_CHAN(n))
>>  -#define JZ_DMA_REG_DSD(n)      (0x1c + JZ_DMA_REG_CHAN(n))
>>  +#define JZ_DMA_REG_DSA         0x00
>>  +#define JZ_DMA_REG_DTA         0x04
>>  +#define JZ_DMA_REG_DTC         0x08
>>  +#define JZ_DMA_REG_DRT         0x0c
>>  +#define JZ_DMA_REG_DCS         0x10
>>  +#define JZ_DMA_REG_DCM         0x14
>>  +#define JZ_DMA_REG_DDA         0x18
>>  +#define JZ_DMA_REG_DSD         0x1c
>> 
>>   #define JZ_DMA_DMAC_DMAE       BIT(0)
>>   #define JZ_DMA_DMAC_AR         BIT(2)
>>  @@ -140,7 +140,8 @@ enum jz_version {
>> 
>>   struct jz4780_dma_dev {
>>          struct dma_device dma_device;
>>  -       void __iomem *base;
>>  +       void __iomem *chn_base;
>>  +       void __iomem *ctrl_base;
>>          struct clk *clk;
>>          unsigned int irq;
>>          unsigned int nb_channels;
>>  @@ -174,16 +175,28 @@ static inline struct jz4780_dma_dev 
>> *jz4780_dma_chan_parent(
>>                              dma_device);
>>   }
>> 
>>  -static inline uint32_t jz4780_dma_readl(struct jz4780_dma_dev 
>> *jzdma,
>>  +static inline uint32_t jz4780_dma_chn_readl(struct jz4780_dma_dev 
>> *jzdma,
>>  +       unsigned int chn, unsigned int reg)
>>  +{
>>  +       return readl(jzdma->chn_base + reg + JZ_DMA_REG_CHAN(chn));
>>  +}
>>  +
>>  +static inline void jz4780_dma_chn_writel(struct jz4780_dma_dev 
>> *jzdma,
>>  +       unsigned int chn, unsigned int reg, uint32_t val)
>>  +{
>>  +       writel(val, jzdma->chn_base + reg + JZ_DMA_REG_CHAN(chn));
>>  +}
>>  +
>>  +static inline uint32_t jz4780_dma_ctrl_readl(struct jz4780_dma_dev 
>> *jzdma,
>>          unsigned int reg)
>>   {
>>  -       return readl(jzdma->base + reg);
>>  +       return readl(jzdma->ctrl_base + reg);
>>   }
>> 
>>  -static inline void jz4780_dma_writel(struct jz4780_dma_dev *jzdma,
>>  +static inline void jz4780_dma_ctrl_writel(struct jz4780_dma_dev 
>> *jzdma,
>>          unsigned int reg, uint32_t val)
>>   {
>>  -       writel(val, jzdma->base + reg);
>>  +       writel(val, jzdma->ctrl_base + reg);
>>   }
>> 
>>   static struct jz4780_dma_desc *jz4780_dma_desc_alloc(
>>  @@ -478,17 +491,18 @@ static void jz4780_dma_begin(struct 
>> jz4780_dma_chan *jzchan)
>>          }
>> 
>>          /* Use 8-word descriptors. */
>>  -       jz4780_dma_writel(jzdma, JZ_DMA_REG_DCS(jzchan->id), 
>> JZ_DMA_DCS_DES8);
>>  +       jz4780_dma_chn_writel(jzdma, jzchan->id,
>>  +                             JZ_DMA_REG_DCS, JZ_DMA_DCS_DES8);
>> 
>>          /* Write descriptor address and initiate descriptor fetch. 
>> */
>>          desc_phys = jzchan->desc->desc_phys +
>>                      (jzchan->curr_hwdesc * 
>> sizeof(*jzchan->desc->desc));
>>  -       jz4780_dma_writel(jzdma, JZ_DMA_REG_DDA(jzchan->id), 
>> desc_phys);
>>  -       jz4780_dma_writel(jzdma, JZ_DMA_REG_DDRS, BIT(jzchan->id));
>>  +       jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DDA, 
>> desc_phys);
>>  +       jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DDRS, 
>> BIT(jzchan->id));
>> 
>>          /* Enable the channel. */
>>  -       jz4780_dma_writel(jzdma, JZ_DMA_REG_DCS(jzchan->id),
>>  -                         JZ_DMA_DCS_DES8 | JZ_DMA_DCS_CTE);
>>  +       jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS,
>>  +                             JZ_DMA_DCS_DES8 | JZ_DMA_DCS_CTE);
>>   }
>> 
>>   static void jz4780_dma_issue_pending(struct dma_chan *chan)
>>  @@ -514,7 +528,7 @@ static int jz4780_dma_terminate_all(struct 
>> dma_chan *chan)
>>          spin_lock_irqsave(&jzchan->vchan.lock, flags);
>> 
>>          /* Clear the DMA status and stop the transfer. */
>>  -       jz4780_dma_writel(jzdma, JZ_DMA_REG_DCS(jzchan->id), 0);
>>  +       jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS, 0);
>>          if (jzchan->desc) {
>>                  vchan_terminate_vdesc(&jzchan->desc->vdesc);
>>                  jzchan->desc = NULL;
>>  @@ -563,8 +577,8 @@ static size_t jz4780_dma_desc_residue(struct 
>> jz4780_dma_chan *jzchan,
>>                  residue += desc->desc[i].dtc << 
>> jzchan->transfer_shift;
>> 
>>          if (next_sg != 0) {
>>  -               count = jz4780_dma_readl(jzdma,
>>  -                                        
>> JZ_DMA_REG_DTC(jzchan->id));
>>  +               count = jz4780_dma_chn_readl(jzdma, jzchan->id,
>>  +                                        JZ_DMA_REG_DTC);
>>                  residue += count << jzchan->transfer_shift;
>>          }
>> 
>>  @@ -611,8 +625,8 @@ static void jz4780_dma_chan_irq(struct 
>> jz4780_dma_dev *jzdma,
>> 
>>          spin_lock(&jzchan->vchan.lock);
>> 
>>  -       dcs = jz4780_dma_readl(jzdma, JZ_DMA_REG_DCS(jzchan->id));
>>  -       jz4780_dma_writel(jzdma, JZ_DMA_REG_DCS(jzchan->id), 0);
>>  +       dcs = jz4780_dma_chn_readl(jzdma, jzchan->id, 
>> JZ_DMA_REG_DCS);
>>  +       jz4780_dma_chn_writel(jzdma, jzchan->id, JZ_DMA_REG_DCS, 0);
>> 
>>          if (dcs & JZ_DMA_DCS_AR) {
>>                  dev_warn(&jzchan->vchan.chan.dev->device,
>>  @@ -651,7 +665,7 @@ static irqreturn_t jz4780_dma_irq_handler(int 
>> irq, void *data)
>>          uint32_t pending, dmac;
>>          int i;
>> 
>>  -       pending = jz4780_dma_readl(jzdma, JZ_DMA_REG_DIRQP);
>>  +       pending = jz4780_dma_ctrl_readl(jzdma, JZ_DMA_REG_DIRQP);
>> 
>>          for (i = 0; i < jzdma->nb_channels; i++) {
>>                  if (!(pending & (1<<i)))
>>  @@ -661,12 +675,12 @@ static irqreturn_t jz4780_dma_irq_handler(int 
>> irq, void *data)
>>          }
>> 
>>          /* Clear halt and address error status of all channels. */
>>  -       dmac = jz4780_dma_readl(jzdma, JZ_DMA_REG_DMAC);
>>  +       dmac = jz4780_dma_ctrl_readl(jzdma, JZ_DMA_REG_DMAC);
>>          dmac &= ~(JZ_DMA_DMAC_HLT | JZ_DMA_DMAC_AR);
>>  -       jz4780_dma_writel(jzdma, JZ_DMA_REG_DMAC, dmac);
>>  +       jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC, dmac);
>> 
>>          /* Clear interrupt pending status. */
>>  -       jz4780_dma_writel(jzdma, JZ_DMA_REG_DIRQP, 0);
>>  +       jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DIRQP, 0);
>> 
>>          return IRQ_HANDLED;
>>   }
>>  @@ -804,9 +818,19 @@ static int jz4780_dma_probe(struct 
>> platform_device *pdev)
>>                  return -EINVAL;
>>          }
>> 
>>  -       jzdma->base = devm_ioremap_resource(dev, res);
>>  -       if (IS_ERR(jzdma->base))
>>  -               return PTR_ERR(jzdma->base);
>>  +       jzdma->chn_base = devm_ioremap_resource(dev, res);
>>  +       if (IS_ERR(jzdma->chn_base))
>>  +               return PTR_ERR(jzdma->chn_base);
>>  +
>>  +       res = platform_get_resource(pdev, IORESOURCE_MEM, 1);
>>  +       if (!res) {
>>  +               dev_err(dev, "failed to get I/O memory\n");
>>  +               return -EINVAL;
>>  +       }
>>  +
>>  +       jzdma->ctrl_base = devm_ioremap_resource(dev, res);
>>  +       if (IS_ERR(jzdma->ctrl_base))
>>  +               return PTR_ERR(jzdma->ctrl_base);
>> 
>>          ret = platform_get_irq(pdev, 0);
>>          if (ret < 0) {
>>  @@ -864,9 +888,9 @@ static int jz4780_dma_probe(struct 
>> platform_device *pdev)
>>           * Also set the FMSC bit - it increases MSC performance, so 
>> it makes
>>           * little sense not to enable it.
>>           */
>>  -       jz4780_dma_writel(jzdma, JZ_DMA_REG_DMAC,
>>  +       jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMAC,
>>                            JZ_DMA_DMAC_DMAE | JZ_DMA_DMAC_FMSC);
>>  -       jz4780_dma_writel(jzdma, JZ_DMA_REG_DMACP, 0);
>>  +       jz4780_dma_ctrl_writel(jzdma, JZ_DMA_REG_DMACP, 0);
>> 
>>          INIT_LIST_HEAD(&dd->channels);
>> 
>>  --
>>  2.18.0
>> 
>> 
> 
> Regards,
> PrasannaKumar

