Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABB99C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:29:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E0E12146E
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 07:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549092573;
	bh=qkLUzc8qDpmfGse/mYNCtt5cRW0O+PwhLCHbWgiKiEU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=KmWA6/CR/F/7Qb46jlohLRPGA9qR5mP4781Ol8mISvB26s9Sd3JDU8yS8QRXQzcvM
	 3ZLxi0h2mf4Ru2qJqK6rfGZKuAZ+OV5dibRjrgwHaEtbkaRA0/F8iOGvp/Hgiq8Evi
	 f1iHhA4Rhti3Jm0ehAjLnU+j3+5BUKlys7p9RiIA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726711AbfBBH30 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 02:29:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:48674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725922AbfBBH30 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 02:29:26 -0500
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D2822146E;
        Sat,  2 Feb 2019 07:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549092564;
        bh=qkLUzc8qDpmfGse/mYNCtt5cRW0O+PwhLCHbWgiKiEU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PFCoAi4gWVRzZZSupWqMV4ISmHvNJex73/x9gcMQK1fZ3tCVN3E6Esq4JCR1xt1Hc
         212KY4HnQN6ZsmjPalCv6YAmLAFguU7JJ54OKb5F1hV3gokFjvHWpg5fbWHFIu6fsc
         nTEmtTzDmIzJBUM3jwSRzMNbAzonkpH+sRJJd6qA=
Date:   Sat, 2 Feb 2019 08:29:10 +0100
From:   Boris Brezillon <bbrezillon@kernel.org>
To:     <Tudor.Ambarus@microchip.com>
Cc:     <broonie@kernel.org>, <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <Cyrille.Pitchen@microchip.com>,
        <bugalski.piotr@gmail.com>, <linux-spi@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mtd@lists.infradead.org>
Subject: Re: [PATCH v3 13/13] spi: atmel-quadspi: add support for sam9x60
 qspi controller
Message-ID: <20190202082910.0e60a757@bbrezillon>
In-Reply-To: <20190202040653.1217-14-tudor.ambarus@microchip.com>
References: <20190202040653.1217-1-tudor.ambarus@microchip.com>
        <20190202040653.1217-14-tudor.ambarus@microchip.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2 Feb 2019 04:07:46 +0000
<Tudor.Ambarus@microchip.com> wrote:

> From: Tudor Ambarus <tudor.ambarus@microchip.com>
> 
> The sam9x60 qspi controller uses 2 clocks, one for the peripheral register
> access, the other for the qspi core and phy. Both are mandatory. It uses
> different transfer type bits in IFR register. It has dedicated registers
> to specify a read or a write instruction: Read Instruction Code Register
> (RICR) and Write Instruction Code Register (WICR). ICR/RICR/WICR have
> identical fields.
> 
> Tested with sst26vf064b jedec,spi-nor flash. Backward compatibility test
> done on sama5d2 qspi controller and mx25l25635e jedec,spi-nor flash.
> 
> Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
> ---
> v3:
> - reorganize the code and change ops functions pointers to avoid code
>   duplication. From the IP perspective, the transfer type bits are
>   different, and what registers are written: ricr/wicr instead of icr.
> - treat just regular spi transfers. Mem transfers will be added together
>   with dirmap support.
> v2:
> - rework clock handling
> - reorder setting of register values in set_cfg() calls -> move functions
>   that can fail in the upper part of the function body.
> 
>  drivers/spi/atmel-quadspi.c | 295 +++++++++++++++++++++++++++++++++++---------
>  1 file changed, 234 insertions(+), 61 deletions(-)
> 
> diff --git a/drivers/spi/atmel-quadspi.c b/drivers/spi/atmel-quadspi.c
> index c9548942535a..af1e4e25097a 100644
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
> @@ -117,6 +120,7 @@
>  #define QSPI_IFR_CRM                    BIT(14)
>  #define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
>  #define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
> +#define QSPI_IFR_APBTFRTYP_READ		BIT(24)

Maybe add a comment saying it's only available on SAM9X60 or prefix it
with SAM9X60.

>  
>  /* Bitfields in QSPI_SMR (Scrambling Mode Register) */
>  #define QSPI_SMR_SCREN                  BIT(0)
> @@ -133,16 +137,39 @@
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
>  	struct clk		*pclk;
> +	struct clk		*qspick;
>  	struct platform_device	*pdev;
> +	const struct atmel_qspi_caps *caps;
>  	u32			pending;
>  	u32			smm;
>  	struct completion	cmd_completion;
>  };
>  
> +struct atmel_qspi_ops {
> +	void (*set_tfrtyp)(const struct spi_mem_op *op,
> +			   struct atmel_qspi_cfg *cfg);
> +	void (*write_regs)(void __iomem *base, const struct spi_mem_op *op,
> +			   const struct atmel_qspi_cfg *cfg);
> +};
> +
> +struct atmel_qspi_caps {
> +	const struct atmel_qspi_ops *ops;
> +	bool has_qspick;
> +};
> +
>  struct atmel_qspi_mode {
>  	u8 cmd_buswidth;
>  	u8 addr_buswidth;
> @@ -200,30 +227,36 @@ static bool atmel_qspi_supports_op(struct spi_mem *mem,
>  	return true;
>  }
>  
> -static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +static int atmel_qspi_set_mode(struct atmel_qspi_cfg *cfg,
> +			       const struct spi_mem_op *op)
>  {
> -	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
> -	void __iomem *base = aq->regs;
> -	int mode;
> -	u32 dummy_cycles = 0;
> -	u32 iar, icr, ifr, sr;
> -	int err = 0;
> -
> -	iar = 0;
> -	icr = QSPI_ICR_INST(op->cmd.opcode);
> -	ifr = QSPI_IFR_INSTEN;
> +	int mode = atmel_qspi_find_mode(op);
>  
> -	/* Set the QSPI controller in Serial Memory Mode */
> -	if (aq->smm != QSPI_MR_SMM) {
> -		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);
> -		aq->smm = QSPI_MR_SMM;
> -	}
> -
> -	mode = atmel_qspi_find_mode(op);
>  	if (mode < 0)
>  		return mode;
> +	cfg->ifr = sama5d2_qspi_modes[mode].config;

Looks like modes are the same for sama5d2 and sam9x60, so maybe you
should rename the sama5d2_qspi_modes variable into something more
generic.

> +	return 0;
> +}
>  
> -	ifr |= sama5d2_qspi_modes[mode].config;
> +/*

Kernel doc headers should starts with /**, but maybe you did that on
purpose to avoid having this header parsed in case someone decides to
add this file to the list of files parsed for doc creation.

> + * atmel_qspi_set_address_mode() - set address mode.
> + * @cfg:	contains register values
> + * @op:		describes a SPI memory operation
> + *
> + * The controller allows 24 and 32-bit addressing while NAND-flash requires
> + * 16-bit long. Handling 8-bit long addresses is done using the option field.
> + * For the 16-bit addresses, the workaround depends of the number of requested
> + * dummy bits. If there are 8 or more dummy cycles, the address is shifted and
> + * sent with the first dummy byte. Otherwise opcode is disabled and the first
> + * byte of the address contains the command opcode (works only if the opcode and
> + * address use the same buswidth). The limitation is when the 16-bit address is
> + * used without enough dummy cycles and the opcode is using a different buswidth
> + * than the address.

This comment would better be placed directly in the function just
before the switch() statement.

> + */
> +static int atmel_qspi_set_address_mode(struct atmel_qspi_cfg *cfg,
> +				       const struct spi_mem_op *op)
> +{
> +	u32 dummy_cycles = 0;
>  
>  	if (op->dummy.buswidth && op->dummy.nbytes)
>  		dummy_cycles = op->dummy.nbytes * 8 / op->dummy.buswidth;
> @@ -233,28 +266,28 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  		case 0:
>  			break;
>  		case 1:
> -			ifr |= QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
> -			icr |= QSPI_ICR_OPT(op->addr.val & 0xff);
> +			cfg->ifr |= QSPI_IFR_OPTEN | QSPI_IFR_OPTL_8BIT;
> +			cfg->icr = QSPI_ICR_OPT(op->addr.val & 0xff);
>  			break;
>  		case 2:
>  			if (dummy_cycles < 8 / op->addr.buswidth) {
> -				ifr &= ~QSPI_IFR_INSTEN;
> -				ifr |= QSPI_IFR_ADDREN;
> -				iar = (op->cmd.opcode << 16) |
> -					(op->addr.val & 0xffff);
> +				cfg->ifr &= ~QSPI_IFR_INSTEN;
> +				cfg->ifr |= QSPI_IFR_ADDREN;
> +				cfg->iar = (op->cmd.opcode << 16) |
> +					   (op->addr.val & 0xffff);
>  			} else {
> -				ifr |= QSPI_IFR_ADDREN;
> -				iar = (op->addr.val << 8) & 0xffffff;
> +				cfg->ifr |= QSPI_IFR_ADDREN;
> +				cfg->iar = (op->addr.val << 8) & 0xffffff;
>  				dummy_cycles -= 8 / op->addr.buswidth;
>  			}
>  			break;
>  		case 3:
> -			ifr |= QSPI_IFR_ADDREN;
> -			iar = op->addr.val & 0xffffff;
> +			cfg->ifr |= QSPI_IFR_ADDREN;
> +			cfg->iar = op->addr.val & 0xffffff;
>  			break;
>  		case 4:
> -			ifr |= QSPI_IFR_ADDREN | QSPI_IFR_ADDRL;
> -			iar = op->addr.val & 0x7ffffff;
> +			cfg->ifr |= QSPI_IFR_ADDREN | QSPI_IFR_ADDRL;
> +			cfg->iar = op->addr.val & 0x7ffffff;
>  			break;
>  		default:
>  			return -ENOTSUPP;
> @@ -263,22 +296,99 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  
>  	/* Set number of dummy cycles */
>  	if (dummy_cycles)
> -		ifr |= QSPI_IFR_NBDUM(dummy_cycles);
> +		cfg->ifr |= QSPI_IFR_NBDUM(dummy_cycles);
>  
> -	/* Set data enable */
> -	if (op->data.nbytes)
> -		ifr |= QSPI_IFR_DATAEN;
> +	return 0;
> +}
>  
> +static void atmel_qspi_sama5d2_set_tfrtyp(const struct spi_mem_op *op,
> +					  struct atmel_qspi_cfg *cfg)
> +{
>  	if (op->data.dir == SPI_MEM_DATA_OUT)
> -		ifr |= QSPI_IFR_SAMA5D2_WRITE_TRSFR;
> +		cfg->ifr |= QSPI_IFR_SAMA5D2_WRITE_TRSFR;
> +}
>  
> +static void atmel_qspi_sama5d2_write_regs(void __iomem *base,
> +					  const struct spi_mem_op *op,
> +					  const struct atmel_qspi_cfg *cfg)
> +{
>  	/* Clear pending interrupts */
>  	(void)readl_relaxed(base + QSPI_SR);
>  
>  	/* Set QSPI Instruction Frame registers */
> -	writel_relaxed(iar, base + QSPI_IAR);
> -	writel_relaxed(icr, base + QSPI_ICR);
> -	writel_relaxed(ifr, base + QSPI_IFR);
> +	writel_relaxed(cfg->iar, base + QSPI_IAR);
> +	writel_relaxed(cfg->icr, base + QSPI_ICR);
> +	writel_relaxed(cfg->ifr, base + QSPI_IFR);
> +}
> +
> +static void atmel_qspi_sam9x60_set_tfrtyp(const struct spi_mem_op *op,
> +					  struct atmel_qspi_cfg *cfg)
> +{
> +	if (!op->addr.nbytes && op->data.dir == SPI_MEM_DATA_IN)
> +		cfg->ifr |= QSPI_IFR_APBTFRTYP_READ;
> +}
> +
> +static void atmel_qspi_sam9x60_write_regs(void __iomem *base,
> +					  const struct spi_mem_op *op,
> +					  const struct atmel_qspi_cfg *cfg)
> +{
> +	/* Clear pending interrupts */
> +	(void)readl_relaxed(base + QSPI_SR);
> +
> +	/* Set QSPI Instruction Frame registers */
> +	writel_relaxed(cfg->iar, base + QSPI_IAR);
> +	if (op->data.dir == SPI_MEM_DATA_IN)
> +		writel_relaxed(cfg->icr, base + QSPI_RICR);
> +	else
> +		writel_relaxed(cfg->icr, base + QSPI_ICR);
> +	writel_relaxed(cfg->ifr, base + QSPI_IFR);
> +}
> +
> +static int atmel_qspi_set_cfg(struct atmel_qspi *aq,
> +			      const struct spi_mem_op *op,
> +			      struct atmel_qspi_cfg *cfg)
> +{
> +	void __iomem *base = aq->regs;
> +	int ret;
> +
> +	/* Set the QSPI controller in Serial Memory Mode */
> +	if (aq->smm != QSPI_MR_SMM) {
> +		writel_relaxed(QSPI_MR_SMM, base + QSPI_MR);

					    aq->reqs +

and you can get rid of base.

> +		aq->smm = QSPI_MR_SMM;
> +	}
> +
> +	ret = atmel_qspi_set_mode(cfg, op);
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
> +	aq->caps->ops->set_tfrtyp(op, cfg);
> +	aq->caps->ops->write_regs(base, op, cfg);
> +
> +	return 0;
> +}
> +
> +static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
> +{
> +	struct atmel_qspi *aq = spi_controller_get_devdata(mem->spi->master);
> +	void __iomem *base = aq->regs;
> +	struct atmel_qspi_cfg cfg = {0};
> +	u32 sr;
> +	int err;
> +
> +	err = atmel_qspi_set_cfg(aq, op, &cfg);
> +	if (err)
> +		return err;
>  
>  	/* Skip to the final steps if there is no data */
>  	if (op->data.nbytes) {
> @@ -287,11 +397,11 @@ static int atmel_qspi_exec_op(struct spi_mem *mem, const struct spi_mem_op *op)
>  
>  		/* Send/Receive data */
>  		if (op->data.dir == SPI_MEM_DATA_IN)
> -			_memcpy_fromio(op->data.buf.in,
> -				aq->mem + iar, op->data.nbytes);
> +			_memcpy_fromio(op->data.buf.in, aq->mem + cfg.iar,
> +				       op->data.nbytes);
>  		else
> -			_memcpy_toio(aq->mem + iar,
> -				op->data.buf.out, op->data.nbytes);
> +			_memcpy_toio(aq->mem + cfg.iar, op->data.buf.out,
> +				     op->data.nbytes);
>  
>  		/* Release the chip-select */
>  		writel_relaxed(QSPI_CR_LASTXFER, base + QSPI_CR);
> @@ -391,9 +501,22 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	struct spi_controller *ctrl;
>  	struct atmel_qspi *aq;
>  	struct resource *res;
> +	const struct atmel_qspi_caps *caps;
> +	struct device *dev = &pdev->dev;

If you really want to do this &pdev->dev -> dev conversion (which I
don't think is necessary given that we don't have over 80 chars lines),
please do it in separate patch.

>  	int irq, err = 0;
>  
> -	ctrl = spi_alloc_master(&pdev->dev, sizeof(*aq));
> +	caps = of_device_get_match_data(dev);
> +	if (!caps) {
> +		dev_err(dev, "Could not retrieve QSPI caps\n");
> +		return -EINVAL;
> +	}
> +
> +	if (!caps->ops->set_tfrtyp || !caps->ops->write_regs) {
> +		dev_err(dev, "Could not retrieve QSPI ops\n");
> +		return -EINVAL;
> +	}
> +
> +	ctrl = spi_alloc_master(dev, sizeof(*aq));
>  	if (!ctrl)
>  		return -ENOMEM;
>  
> @@ -409,32 +532,33 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  
>  	init_completion(&aq->cmd_completion);
>  	aq->pdev = pdev;
> +	aq->caps = caps;
>  
>  	/* Map the registers */
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_base");
> -	aq->regs = devm_ioremap_resource(&pdev->dev, res);
> +	aq->regs = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(aq->regs)) {
> -		dev_err(&pdev->dev, "missing registers\n");
> +		dev_err(dev, "missing registers\n");
>  		err = PTR_ERR(aq->regs);
>  		goto exit;
>  	}
>  
>  	/* Map the AHB memory */
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "qspi_mmap");
> -	aq->mem = devm_ioremap_resource(&pdev->dev, res);
> +	aq->mem = devm_ioremap_resource(dev, res);
>  	if (IS_ERR(aq->mem)) {
> -		dev_err(&pdev->dev, "missing AHB memory\n");
> +		dev_err(dev, "missing AHB memory\n");
>  		err = PTR_ERR(aq->mem);
>  		goto exit;
>  	}
>  
>  	/* Get the peripheral clock */
> -	aq->pclk = devm_clk_get(&pdev->dev, "pclk");
> +	aq->pclk = devm_clk_get(dev, "pclk");
>  	if (IS_ERR(aq->pclk))
> -		aq->pclk = devm_clk_get(&pdev->dev, NULL);
> +		aq->pclk = devm_clk_get(dev, NULL);
>  
>  	if (IS_ERR(aq->pclk)) {
> -		dev_err(&pdev->dev, "missing peripheral clock\n");
> +		dev_err(dev, "missing peripheral clock\n");
>  		err = PTR_ERR(aq->pclk);
>  		goto exit;
>  	}
> @@ -442,32 +566,52 @@ static int atmel_qspi_probe(struct platform_device *pdev)
>  	/* Enable the peripheral clock */
>  	err = clk_prepare_enable(aq->pclk);
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
> +			goto disable_pclk;
> +		}
> +
> +		/* Enable the QSPI system clock */
> +		err = clk_prepare_enable(aq->qspick);
> +		if (err) {
> +			dev_err(dev,
> +				"failed to enable the QSPI system clock\n");
> +			goto disable_pclk;
> +		}
> +	}
> +
>  	/* Request the IRQ */
>  	irq = platform_get_irq(pdev, 0);
>  	if (irq < 0) {
> -		dev_err(&pdev->dev, "missing IRQ\n");
> +		dev_err(dev, "missing IRQ\n");
>  		err = irq;
> -		goto disable_pclk;
> +		goto disable_qspick;
>  	}
> -	err = devm_request_irq(&pdev->dev, irq, atmel_qspi_interrupt,
> -			       0, dev_name(&pdev->dev), aq);
> +	err = devm_request_irq(dev, irq, atmel_qspi_interrupt, 0,
> +			       dev_name(dev), aq);
>  	if (err)
> -		goto disable_pclk;
> +		goto disable_qspick;
>  
>  	err = atmel_qspi_init(aq);
>  	if (err)
> -		goto disable_pclk;
> +		goto disable_qspick;
>  
>  	err = spi_register_controller(ctrl);
>  	if (err)
> -		goto disable_pclk;
> +		goto disable_qspick;
>  
>  	return 0;
>  
> +disable_qspick:
> +	clk_disable_unprepare(aq->qspick);
>  disable_pclk:
>  	clk_disable_unprepare(aq->pclk);
>  exit:
> @@ -483,6 +627,7 @@ static int atmel_qspi_remove(struct platform_device *pdev)
>  
>  	spi_unregister_controller(ctrl);
>  	writel_relaxed(QSPI_CR_QSPIDIS, aq->regs + QSPI_CR);
> +	clk_disable_unprepare(aq->qspick);
>  	clk_disable_unprepare(aq->pclk);
>  	return 0;
>  }
> @@ -491,6 +636,7 @@ static int __maybe_unused atmel_qspi_suspend(struct device *dev)
>  {
>  	struct atmel_qspi *aq = dev_get_drvdata(dev);
>  
> +	clk_disable_unprepare(aq->qspick);
>  	clk_disable_unprepare(aq->pclk);
>  
>  	return 0;
> @@ -501,6 +647,7 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
>  	struct atmel_qspi *aq = dev_get_drvdata(dev);
>  
>  	clk_prepare_enable(aq->pclk);
> +	clk_prepare_enable(aq->qspick);
>  
>  	return atmel_qspi_init(aq);
>  }
> @@ -508,8 +655,34 @@ static int __maybe_unused atmel_qspi_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(atmel_qspi_pm_ops, atmel_qspi_suspend,
>  			 atmel_qspi_resume);
>  
> +static const struct atmel_qspi_ops atmel_sama5d2_qspi_ops = {
> +	.set_tfrtyp = atmel_qspi_sama5d2_set_tfrtyp,
> +	.write_regs = atmel_qspi_sama5d2_write_regs,
> +};
> +
> +static const struct atmel_qspi_caps atmel_sama5d2_qspi_caps = {
> +	.ops = &atmel_sama5d2_qspi_ops,
> +};
> +
> +static const struct atmel_qspi_ops atmel_sam9x60_qspi_ops = {
> +	.set_tfrtyp = atmel_qspi_sam9x60_set_tfrtyp,
> +	.write_regs = atmel_qspi_sam9x60_write_regs,
> +};
> +
> +static const struct atmel_qspi_caps atmel_sam9x60_qspi_caps = {
> +	.ops = &atmel_sam9x60_qspi_ops,
> +	.has_qspick = true,
> +};
> +
>  static const struct of_device_id atmel_qspi_dt_ids[] = {
> -	{ .compatible = "atmel,sama5d2-qspi" },
> +	{
> +		.compatible = "atmel,sama5d2-qspi",
> +		.data = &atmel_sama5d2_qspi_caps,
> +	},
> +	{
> +		.compatible = "microchip,sam9x60-qspi",
> +		.data = &atmel_sam9x60_qspi_caps,
> +	},
>  	{ /* sentinel */ }
>  };
>  

