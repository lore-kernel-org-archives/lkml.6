Return-Path: <SRS0=Wtxu=QH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494D0C169C4
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:32:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CD3C218EA
	for <linux-kernel@archiver.kernel.org>; Thu, 31 Jan 2019 16:32:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548952345;
	bh=pRYtaMupNVk7LlJRNrlcw0o3kLDpKQgPy4Dr4Yi+nz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=Np3rh2W2UGrek97NYjGU7iF/xi8PqwbI5nC70LOy7VU2UxKi4wN3jQ0b9247fNKtr
	 X3hANlw8HyOaAUROJ487YgyBAEVh6kHsbMd+4MkXjmF3hMuRcrEIQo3Q0dYWyPBQeR
	 KzSPW3fdrlZT5eaQJlHxxXbs3Xu1otEXXwTIYB2E=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388509AbfAaQcX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 31 Jan 2019 11:32:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:44930 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727189AbfAaQcX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Jan 2019 11:32:23 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C8D20869;
        Thu, 31 Jan 2019 16:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548952341;
        bh=pRYtaMupNVk7LlJRNrlcw0o3kLDpKQgPy4Dr4Yi+nz0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mLf2SAvj0TcyNWwcKHM1AEZ4Te6b5fGC2PFPQ5ukNRYOShN7tYn5f/d4GUItfzN77
         Q2bfFs1wZbYxFiBbLppwNn/6lVc4cgjjevJzwuOlr7//kVU/qQRYf7jOP3H1z8UBh4
         0U2uTGwGVSZPq2/Hh7H13KEu2dQZvjKmK9h/a8xc=
Date:   Thu, 31 Jan 2019 17:32:07 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v2 10/10] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Message-ID: <20190131173207.56481a42@bbrezillon>
In-Reply-To: <20190131161515.21605-11-tudor.ambarus@microchip.com>
References: <20190131161515.21605-1-tudor.ambarus@microchip.com>
        <20190131161515.21605-11-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Jan 2019 16:15:51 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
> access, the other for the qspi core and phy. Both are mandatory. It uses
> dedicated register for Read Instruction Code Register (RICR) and
> Write Instruction Code Register (WICR). ICR/RICR/WICR have identical
> fields.
> 
> Tested with sst26vf064b jedec,spi-nor flash. Backward compatibility test
> done on sama5d2 qspi controller and mx25l25635e jedec,spi-nor flash.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v2:
> - rework clock handling
> - reorder setting of register values in set_cfg() calls -> move functions
>   that can fail in the upper part of the function body.
> 
>  drivers/spi/atmel-quadspi.c | 296 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 239 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index d3e76acf8517..80c934f3e479 100644
> --- a/drivers/spi/atmel-quadspi.c
> +++ b/drivers/spi/atmel-quadspi.c
> @@ -19,6 +19,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_platform.h>
>  #include <linux/platform_device.h>
>  #include <linux/spi/spi-mem.h>
>  
> @@ -35,7 +36,9 @@
>  
>  #define QSPI_IAR     0x0030  /* Instruction Address Register */
>  #define QSPI_ICR     0x0034  /* Instruction Code Register */
> +#define QSPI_WICR    0x0034  /* Write Instruction Code Register */
>  #define QSPI_IFR     0x0038  /* Instruction Frame Register */
> +#define QSPI_RICR    0x003C  /* Read Instruction Code Register */
>  
>  #define QSPI_SMR     0x0040  /* Scrambling Mode Register */
>  #define QSPI_SKR     0x0044  /* Scrambling Key Register */
> @@ -88,7 +91,7 @@
>  #define QSPI_SCR_DLYBS_MASK             GENMASK(23, 16)
>  #define QSPI_SCR_DLYBS(n)               (((n) << 16) & QSPI_SCR_DLYBS_MASK)
>  
> -/* Bitfields in QSPI_ICR (Instruction Code Register) */
> +/* Bitfields in QSPI_ICR (Read/Write Instruction Code Register) */
>  #define QSPI_ICR_INST_MASK              GENMASK(7, 0)
>  #define QSPI_ICR_INST(inst)             (((inst) << 0) & QSPI_ICR_INST_MASK)
>  #define QSPI_ICR_OPT_MASK               GENMASK(23, 16)
> @@ -113,6 +116,8 @@
>  #define QSPI_IFR_OPTL_4BIT              (2 << 8)
>  #define QSPI_IFR_OPTL_8BIT              (3 << 8)
>  #define QSPI_IFR_ADDRL                  BIT(10)
> +#define QSPI_IFR_TFRTYP_TRSFR_MEM	BIT(12)
> +#define QSPI_IFR_TFRTYP_TRSFR_REG	(0 << 12)

You don't need to define TRSFR_REG, just set QSPI_IFR_TFRTYP_TRSFR_MEM
when you do a mem transfer and do nothing when this is a regular
transfer.

>  #define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
>  #define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
>  #define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)

Looks like the read/write flag is on bit 13. Can we just add

#define QSPI_IFR_TFRTYP_TRSFR_WRITE	BIT(13)

and drop all others def? This way the implementation is consistent
between sam9x60 and sama5d2.

> @@ -121,6 +126,8 @@
>  #define QSPI_IFR_CRM                    BIT(14)
>  #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
>  #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
> +#define QSPI_IFR_APBTFRTYP_WRITE	(0 << 24)

As for the other defs, I don't think you need to define _WRITE.

> +#define QSPI_IFR_APBTFRTYP_READ		BIT(24)
>  
>  /* Bitfields in QSPI_SMR (Scrambling Mode Register) */
>  #define QSPI_SMR_SCREN                  BIT(0)
> @@ -137,16 +144,37 @@
>  #define QSPI_WPSR_WPVSRC(src)           (((src) << 8) & QSPI_WPSR_WPVSRC)
>  
>  
> +/* Describes register values. */
> +struct atmel_qspi_cfg {
> +	u32 icr;
> +	u32 iar;
> +	u32 ifr;
> +};
> +
> +struct atmel_qspi_caps;
> +
>  struct atmel_qspi {
>  	void __iomem		*regs;
>  	void __iomem		*mem;
>  	struct clk		*clk;

Can we rename that on pclk?

> +	struct clk		*qspick;
>  	struct platform_device	*pdev;
> +	const struct atmel_qspi_caps *caps;
>  	u32			pending;
>  	u32			mr;
>  	struct completion	cmd_completion;
>  };
>  

...

> +
> +static int atmel_sam9x60_qspi_set_cfg(void __iomem *base,
> +				      const struct spi_mem_op *op,
> +				      struct atmel_qspi_cfg *cfg)
> +{
> +	int ret = atmel_qspi_set_mode(cfg, op);
> +
> +	if (ret)
> +		return ret;
> +
> +	ret = atmel_qspi_set_address_mode(cfg, op);
> +	if (ret)
> +		return ret;
> +
> +	cfg->ifr |= QSPI_IFR_INSTEN;
> +	cfg->icr |= QSPI_ICR_INST(op->cmd.opcode);
> +
> +	/* Set data enable */
> +	if (op->data.nbytes)
> +		cfg->ifr |= QSPI_IFR_DATAEN;
> +
> +	if (!op->addr.nbytes) {
> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_REG;
> +		if (op->data.dir == SPI_MEM_DATA_OUT)
> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_WRITE;
> +		else
> +			cfg->ifr |= QSPI_IFR_APBTFRTYP_READ;
> +	} else {
> +		cfg->ifr |= QSPI_IFR_TFRTYP_TRSFR_MEM;

Can you try doing only regular transfers and let me know if it still
works. Support for mem transfers can then be added along with dirmap
support.

> +	}
>  
>  	/* Clear pending interrupts */
>  	(void)readl_relaxed(base + QSPI_SR);
>  
>  	/* Set QSPI Instruction Frame registers */
> -	writel_relaxed(iar, base + QSPI_IAR);
> -	writel_relaxed(icr, base + QSPI_ICR);
> -	writel_relaxed(ifr, base + QSPI_IFR);
> +	writel_relaxed(cfg->iar, base + QSPI_IAR);
> +	if (op->data.dir == SPI_MEM_DATA_OUT)
> +		writel_relaxed(cfg->icr, base + QSPI_ICR);
> +	else
> +		writel_relaxed(cfg->icr, base + QSPI_RICR);
> +	writel_relaxed(cfg->ifr, base + QSPI_IFR);
> +
> +	return 0;
> +}
> +

...

> @@ -443,32 +578,52 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	/* Enable the peripheral clock */
>  	err = clk_prepare_enable(aq->clk);
>  	if (err) {
> -		dev_err(&pdev->dev, "failed to enable the peripheral clock\n");
> +		dev_err(dev, "failed to enable the peripheral clock\n");
>  		goto exit;
>  	}
>  
> +	if (caps->has_qspick) {
> +		/* Get the QSPI system clock */
> +		aq->qspick = devm_clk_get(dev, "qspick");
> +		if (IS_ERR(aq->qspick)) {
> +			dev_err(dev, "missing system clock\n");
> +			err = PTR_ERR(aq->qspick);
> +			goto disable_clk;
> +		}
> +
> +		/* Enable the QSPI system clock */
> +		err = clk_prepare_enable(aq->qspick);
> +		if (err) {
> +			dev_err(dev,
> +				"failed to enable the QSPI system clock\n");
> +			goto disable_clk;
> +		}
> +	}
> +
>  	/* Request the IRQ */
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(&pdev->dev, "missing IRQ\n");
> +		dev_err(dev, "missing IRQ\n");
>  		err = irq;
> -		goto disable_clk;
> +		goto disable_qspick;
>  	}
> -	err = devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
> -			       0, dev_name(&pdev->dev), aq);
> +	err = devm_request_irq(dev, irq, atmel_qspi_interrupt, 0,
> +			       dev_name(dev), aq);
>  	if (err)
> -		goto disable_clk;
> +		goto disable_qspick;
>  
>  	err = atmel_qspi_init(aq);
>  	if (err)
> -		goto disable_clk;
> +		goto disable_qspick;
>  
>  	err = spi_register_controller(ctrl);
>  	if (err)
> -		goto disable_clk;
> +		goto disable_qspick;
>  
>  	return 0;
>  
> +disable_qspick:
> +	clk_disable_unprepare(aq->qspick);
>  disable_clk:

We should probably rename this label disable_pclk.

>  	clk_disable_unprepare(aq->clk);
>  exit:
