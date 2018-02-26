Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751730AbeBZQnF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:43:05 -0500
Received: from mail-qk0-f182.google.com ([209.85.220.182]:39362 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbeBZQnB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:43:01 -0500
X-Google-Smtp-Source: AG47ELuPgOIVuHhkKMXHbWvJ75TrPnAznqQIIvoP7dIEh8dcOLBo3szV1YwKURt7DeSte8MaEe+0thMAeMNLEDjJ5oM=
MIME-Version: 1.0
In-Reply-To: <20180226145628.11892-2-Eugeniy.Paltsev@synopsys.com>
References: <20180226145628.11892-1-Eugeniy.Paltsev@synopsys.com> <20180226145628.11892-2-Eugeniy.Paltsev@synopsys.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 26 Feb 2018 18:42:59 +0200
Message-ID: <CAHp75Vc6KtppecYJBtuXTGCzXySOUZiYqxBfb6w69f1j3J0jDQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dmaengine: Introduce DW AXI DMAC driver
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
Cc: dmaengine <dmaengine@vger.kernel.org>,
        linux-snps-arc@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Vinod Koul <vinod.koul@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>,
        Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 4:56 PM, Eugeniy Paltsev
<Eugeniy.Paltsev@synopsys.com> wrote:
> This patch adds support for the DW AXI DMAC controller.
> DW AXI DMAC is a part of HSDK development board from Synopsys.
>
> In this driver implementation only DMA_MEMCPY transfers are
> supported.

> +/*
> + * Synopsys DesignWare AXI DMA Controller driver.
> + *
> + * Copyright (C) 2017-2018 Synopsys, Inc. (www.synopsys.com)
> + * Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> + *

> + * SPDX-License-Identifier:    GPL-2.0

According to license-rules.rst it should be first line in the file
with C++ style comment.

> + */

> +static inline void
> +axi_chan_iowrite64(struct axi_dma_chan *chan, u32 reg, u64 val)
> +{
> +       /*
> +        * We split one 64 bit write for two 32 bit write as some HW doesn't
> +        * support 64 bit access.
> +        */

> +       iowrite32((u32)val, chan->chan_regs + reg);
> +       iowrite32(val >> 32, chan->chan_regs + reg + 4);

upper_32_bits()
lower_32_bits()

?

> +}

> +static int dma_chan_pause(struct dma_chan *dchan)
> +{
> +       struct axi_dma_chan *chan = dchan_to_axi_dma_chan(dchan);
> +       unsigned long flags;
> +       unsigned int timeout = 20; /* timeout iterations */

> +       int ret = -EAGAIN;

Perhaps,

int ret;
...

> +       u32 val;
> +
> +       spin_lock_irqsave(&chan->vc.lock, flags);
> +
> +       val = axi_dma_ioread32(chan->chip, DMAC_CHEN);
> +       val |= BIT(chan->id) << DMAC_CHAN_SUSP_SHIFT |
> +              BIT(chan->id) << DMAC_CHAN_SUSP_WE_SHIFT;
> +       axi_dma_iowrite32(chan->chip, DMAC_CHEN, val);
> +

> +       do  {
> +               if (axi_chan_irq_read(chan) & DWAXIDMAC_IRQ_SUSPENDED) {
> +                       ret = 0;
> +                       break;
> +               }

...
if (...)
 break;
...

> +               udelay(2);
> +       } while (--timeout);

...
ret = timeout ? 0 : -EAGAIN;

?

> +
> +       axi_chan_irq_clear(chan, DWAXIDMAC_IRQ_SUSPENDED);
> +
> +       chan->is_paused = true;
> +
> +       spin_unlock_irqrestore(&chan->vc.lock, flags);
> +
> +       return ret;
> +}

> +/* pm_runtime callbacks */

Noise.

> +#ifdef CONFIG_PM

__maybe_unused

> +static int axi_dma_runtime_suspend(struct device *dev)
> +{
> +       struct axi_dma_chip *chip = dev_get_drvdata(dev);
> +
> +       return axi_dma_suspend(chip);
> +}
> +
> +static int axi_dma_runtime_resume(struct device *dev)
> +{
> +       struct axi_dma_chip *chip = dev_get_drvdata(dev);
> +
> +       return axi_dma_resume(chip);
> +}
> +#endif

> +static int parse_device_properties(struct axi_dma_chip *chip)
> +{

> +       ret = device_property_read_u32(dev, "snps,dma-masters", &tmp);

Why it has prefix?

> +       ret = device_property_read_u32(dev, "snps,data-width", &tmp);

Ditto.

> +       ret = device_property_read_u32_array(dev, "snps,block-size", carr,
> +                                            chip->dw->hdata->nr_channels);

(perhaps this one can be moved outside of local namespace)

> +       ret = device_property_read_u32_array(dev, "snps,priority", carr,
> +                                            chip->dw->hdata->nr_channels);

Can you use just "priority"?

> +       /* axi-max-burst-len is optional property */
> +       ret = device_property_read_u32(dev, "snps,axi-max-burst-len", &tmp);

"dma-burst-sz" ?

> +       chip->core_clk = devm_clk_get(chip->dev, "core-clk");

Does the name come from datasheet?

> +       chip->cfgr_clk = devm_clk_get(chip->dev, "cfgr-clk");

Ditto?

> +       for (i = 0; i < hdata->nr_channels; i++) {

> +               chan->id = (u8)i;

Hmm... Do you need explicit casting?

> +       }

> +       /* Enable clk before accessing to registers */
> +       clk_prepare_enable(chip->cfgr_clk);
> +       clk_prepare_enable(chip->core_clk);

Each of them may fail. Is it okay?

> +static const struct dev_pm_ops dw_axi_dma_pm_ops = {
> +       SET_RUNTIME_PM_OPS(axi_dma_runtime_suspend, axi_dma_runtime_resume, NULL)
> +};

No system suspend?

> +/*
> + * Synopsys DesignWare AXI DMA Controller driver.
> + *
> + * Copyright (C) 2017-2018 Synopsys, Inc. (www.synopsys.com)
> + * Author: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
> + *

> + * SPDX-License-Identifier:    GPL-2.0

First line, but C style of the comment.

> + */

-- 
With Best Regards,
Andy Shevchenko
