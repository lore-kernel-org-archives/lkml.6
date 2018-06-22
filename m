Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D90C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAF1621502
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 07:39:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAF1621502
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751424AbeFVHjJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 03:39:09 -0400
Received: from mail.bootlin.com ([62.4.15.54]:43918 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750983AbeFVHjH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 03:39:07 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 74EB220717; Fri, 22 Jun 2018 09:39:05 +0200 (CEST)
Received: from bbrezillon (AAubervilliers-681-1-50-153.w90-88.abo.wanadoo.fr [90.88.168.153])
        by mail.bootlin.com (Postfix) with ESMTPSA id 05D8920012;
        Fri, 22 Jun 2018 09:39:05 +0200 (CEST)
Date:   Fri, 22 Jun 2018 09:39:05 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Piotr Bugalski <bugalski.piotr@gmail.com>
Cc:     Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Cyrille Pitchen <cyrille.pitchen@microchip.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Piotr Bugalski <pbu@cryptera.com>
Subject: Re: [RFC PATCH 1/2] spi: Add QuadSPI driver for Atmel SAMA5D2
Message-ID: <20180622093905.62a3b936@bbrezillon>
In-Reply-To: <alpine.DEB.2.20.1806220719190.21824@carbonite>
References: <20180618162124.21749-1-bugalski.piotr@gmail.com>
        <20180618162124.21749-2-bugalski.piotr@gmail.com>
        <20180621233321.0f25f572@bbrezillon>
        <alpine.DEB.2.20.1806220719190.21824@carbonite>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Piotr,

On Fri, 22 Jun 2018 07:57:10 +0200 (CEST)
Piotr Bugalski <bugalski.piotr@gmail.com> wrote:

> Hi Boris,
> 
> I'm a bit allergic to personal preferences in coding style,

I'm just pointing things that are common kernel coding style practices.
You might not like coding style rules of a particular project, but when
you contribute to this project you should do your best to follow those
rules and keep the coding style consistent.

> anyway
> thank you for comments and some important findings.
> 

[...]

> >> +/*
> >> + * Atmel SAMA5D2 QuadSPI driver.
> >> + *
> >> + * Copyright (C) 2018 Cryptera A/S  
> >
> > A non-negligible portion of this code has been copied from the existing
> > driver. Please keep the existing copyright (you can still add Cryptera's
> > one).
> >  
> 
> Technically this driver were written from scratch, with spi-fsl-qspi
> as example of new interface. Hence the name and code structure.
> But it's the same peripheral as Atmel's driver uses so code looks
> similar. I can unify the code to make comparsion even simpler and
> then update copyright.

Hm, ok. Some constructs really looked like they were copied
from the old driver, hence my comment. I'll let Nicolas give his
opinion on this aspect.

> >> + */
> >> +
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/platform_device.h>
> >> +#include <linux/of_device.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/interrupt.h>
> >> +#include <linux/io.h>
> >> +#include <linux/spi/spi-mem.h>
> >> +#include <linux/delay.h>
> >> +
> >> +#define QSPI_CR         0x0000
> >> +#define QSPI_MR         0x0004
> >> +#define QSPI_RDR        0x0008
> >> +#define QSPI_TDR        0x000c
> >> +#define QSPI_SR         0x0010
> >> +#define QSPI_IER        0x0014
> >> +#define QSPI_IDR        0x0018
> >> +#define QSPI_IMR        0x001c
> >> +#define QSPI_SCR        0x0020
> >> +
> >> +#define QSPI_IAR        0x0030
> >> +#define QSPI_ICR        0x0034
> >> +#define QSPI_IFR        0x0038
> >> +
> >> +#define QSPI_WPMR       0x00e4
> >> +#define QSPI_WPSR       0x00e8
> >> +
> >> +/* Bitfields in QSPI_CR (Control Register) */  
> >
> > I personally prefer when reg offsets are declared next to the reg fields.  
> 
> I don't. But it may not be good place to discuss personal preferences.
> I can change it.

This one is actually not defined in the coding style rules, hence the
"I personally prefer". The reasoning behind this approach is that it's
easier for readers to identify the fields of a specific reg when they're
defined next to each other.

> 
> >  
> >> +#define QSPI_CR_QSPIEN                  BIT(0)
> >> +#define QSPI_CR_QSPIDIS                 BIT(1)
> >> +#define QSPI_CR_SWRST                   BIT(7)
> >> +#define QSPI_CR_LASTXFER                BIT(24)
> >> +
> >> +/* Bitfields in QSPI_ICR (Instruction Code Register) */
> >> +#define QSPI_ICR_INST_MASK              GENMASK(7, 0)
> >> +#define QSPI_ICR_INST(inst)             (((inst) << 0) & QSPI_ICR_INST_MASK)
> >> +#define QSPI_ICR_OPT_MASK               GENMASK(23, 16)
> >> +#define QSPI_ICR_OPT(opt)               (((opt) << 16) & QSPI_ICR_OPT_MASK)
> >> +
> >> +/* Bitfields in QSPI_MR (Mode Register) */
> >> +#define QSPI_MR_SMM                     BIT(0)
> >> +#define QSPI_MR_LLB                     BIT(1)
> >> +#define QSPI_MR_WDRBT                   BIT(2)
> >> +#define QSPI_MR_SMRM                    BIT(3)
> >> +#define QSPI_MR_CSMODE_MASK             GENMASK(5, 4)
> >> +#define QSPI_MR_CSMODE_NOT_RELOADED     (0 << 4)
> >> +#define QSPI_MR_CSMODE_LASTXFER         (1 << 4)
> >> +#define QSPI_MR_CSMODE_SYSTEMATICALLY   (2 << 4)
> >> +#define QSPI_MR_NBBITS_MASK             GENMASK(11, 8)
> >> +#define QSPI_MR_NBBITS(n)               ((((n) - 8) << 8) & QSPI_MR_NBBITS_MASK)
> >> +#define QSPI_MR_DLYBCT_MASK             GENMASK(23, 16)
> >> +#define QSPI_MR_DLYBCT(n)               (((n) << 16) & QSPI_MR_DLYBCT_MASK)
> >> +#define QSPI_MR_DLYCS_MASK              GENMASK(31, 24)
> >> +#define QSPI_MR_DLYCS(n)                (((n) << 24) & QSPI_MR_DLYCS_MASK)
> >> +
> >> +/* Bitfields in QSPI_IFR (Instruction Frame Register) */
> >> +#define QSPI_IFR_WIDTH_MASK             GENMASK(2, 0)
> >> +#define QSPI_IFR_WIDTH_SINGLE_BIT_SPI   (0 << 0)
> >> +#define QSPI_IFR_WIDTH_DUAL_OUTPUT      (1 << 0)
> >> +#define QSPI_IFR_WIDTH_QUAD_OUTPUT      (2 << 0)
> >> +#define QSPI_IFR_WIDTH_DUAL_IO          (3 << 0)
> >> +#define QSPI_IFR_WIDTH_QUAD_IO          (4 << 0)
> >> +#define QSPI_IFR_WIDTH_DUAL_CMD         (5 << 0)
> >> +#define QSPI_IFR_WIDTH_QUAD_CMD         (6 << 0)
> >> +#define QSPI_IFR_INSTEN                 BIT(4)
> >> +#define QSPI_IFR_ADDREN                 BIT(5)
> >> +#define QSPI_IFR_OPTEN                  BIT(6)
> >> +#define QSPI_IFR_DATAEN                 BIT(7)
> >> +#define QSPI_IFR_OPTL_MASK              GENMASK(9, 8)
> >> +#define QSPI_IFR_OPTL_1BIT              (0 << 8)
> >> +#define QSPI_IFR_OPTL_2BIT              (1 << 8)
> >> +#define QSPI_IFR_OPTL_4BIT              (2 << 8)
> >> +#define QSPI_IFR_OPTL_8BIT              (3 << 8)
> >> +#define QSPI_IFR_ADDRL                  BIT(10)
> >> +#define QSPI_IFR_TFRTYP_MASK            GENMASK(13, 12)
> >> +#define QSPI_IFR_TFRTYP_TRSFR_READ      (0 << 12)
> >> +#define QSPI_IFR_TFRTYP_TRSFR_READ_MEM  (1 << 12)
> >> +#define QSPI_IFR_TFRTYP_TRSFR_WRITE     (2 << 12)
> >> +#define QSPI_IFR_TFRTYP_TRSFR_WRITE_MEM (3 << 13)
> >> +#define QSPI_IFR_CRM                    BIT(14)
> >> +#define QSPI_IFR_NBDUM_MASK             GENMASK(20, 16)
> >> +#define QSPI_IFR_NBDUM(n)               (((n) << 16) & QSPI_IFR_NBDUM_MASK)
> >> +
> >> +/* Bitfields in QSPI_SR/QSPI_IER/QSPI_IDR/QSPI_IMR  */
> >> +#define QSPI_SR_RDRF                    BIT(0)
> >> +#define QSPI_SR_TDRE                    BIT(1)
> >> +#define QSPI_SR_TXEMPTY                 BIT(2)
> >> +#define QSPI_SR_OVRES                   BIT(3)
> >> +#define QSPI_SR_CSR                     BIT(8)
> >> +#define QSPI_SR_CSS                     BIT(9)
> >> +#define QSPI_SR_INSTRE                  BIT(10)
> >> +#define QSPI_SR_QSPIENS                 BIT(24)
> >> +
> >> +#define QSPI_SR_CMD_COMPLETED           (QSPI_SR_INSTRE | QSPI_SR_CSR)  
> >
> > Do you really to wait for both INSTRE and CSR to consider the command
> > as complete?
> >  
> 
> This part were really copied from Atmel driver. I wasn't sure so I
> used tested solution.

Okay. I guess that's a question for Cyrille and/or Tudor then.

> >> +
> >> +static inline u32 qspi_readl(struct atmel_qspi *aq, u32 reg)
> >> +{
> >> +	return readl_relaxed(aq->iobase + reg);
> >> +}
> >> +
> >> +static inline void qspi_writel(struct atmel_qspi *aq, u32 reg, u32 value)
> >> +{
> >> +	writel_relaxed(value, aq->iobase + reg);
> >> +}  
> >
> > Please drop those wrappers and use readl/write_relaxed() directly.  
> 
> I like these wrappers, the same pattern were used in spi-fsl-qspi and
> atmel-quadspi drivers. Functions are inlined so why to remove nice
> looking code?

It's not really about code optimization (gcc is good at determining
when to inline simple functions). Kernel devs like to know when
_relaxed() versions of IO accessors are used, and by providing those
wrappers you kind of hide that fact.

> 
> >  
> >> +
> >> +static int atmel_qspi_init(struct atmel_qspi *aq)
> >> +{
> >> +	unsigned long rate;
> >> +	u32 scbr;
> >> +
> >> +	qspi_writel(aq, QSPI_WPMR, QSPI_WPMR_WPKEY_PASSWD);
> >> +
> >> +	/* software reset */
> >> +	qspi_writel(aq, QSPI_CR, QSPI_CR_SWRST);
> >> +
> >> +	/* set QSPI mode */
> >> +	qspi_writel(aq, QSPI_MR, QSPI_MR_SMM);  
> >
> > It's already done in ->exec_op(), I think you can remove it here.
> >  
> 
> I prefer initialize peripheral before first use. Single register write
> is not big effort.

I'm fine with that, but then, why should we initialize the IP in SMM
mode? Can't you write 0 to this _MR reg?

> 
> >> +
> >> +	rate = clk_get_rate(aq->clk);
> >> +	if (!rate)
> >> +		return -EINVAL;
> >> +
> >> +	/* set baudrate */
> >> +	scbr = DIV_ROUND_UP(rate, aq->clk_rate);
> >> +	if (scbr > 0)
> >> +		scbr--;  
> >
> > Add a blank line here.
> >  
> >> +	qspi_writel(aq, QSPI_SCR, QSPI_SCR_SCBR(scbr));  
> >
> > The baudrate setting should be done in an spi_controller->setup() hook,
> > and the expected rate is available in spi_device->max_speed_hz.
> >  
> 
> Ok, I'll change it.
> 
> >> +
> >> +	/* enable qspi controller */
> >> +	qspi_writel(aq, QSPI_CR, QSPI_CR_QSPIEN);
> >> +
> >> +	return 0;
> >> +}
> >> +
> >> +static int atmel_qspi_adjust_op_size(struct spi_mem *mem, struct spi_mem_op *op)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >> +static inline bool is_compatible(const struct spi_mem_op *op,
> >> +				 const struct qspi_mode *mode)
> >> +{
> >> +	if (op->cmd.buswidth != mode->cmd_buswidth)
> >> +		return false;  
> >
> > Add a blank line here  
> 
> Looks like personal preferences again... I hate too personalized code.

It's mainly about being able to quickly identify different if() blocks.

> Maybe I'll just merge these three if-s into one horrible large.
> 
> >  
> >> +	if (op->addr.nbytes && op->addr.buswidth != mode->addr_buswidth)
> >> +		return false;  
> >
> > here
> >  
> >> +	if (op->data.nbytes && op->data.buswidth != mode->data_buswidth)
> >> +		return false;  
> >
> > and here.
> >  
> >> +	return true;


> >> +
> >> +static bool atmel_qspi_supports_op(struct spi_mem *mem,
> >> +				   const struct spi_mem_op *op)
> >> +{
> >> +	if (find_mode(op) < 0)
> >> +		return false;
> >> +
> >> +	// special case not supported by hardware  
> >
> > We try to avoid using C++ style comments in the kernel.
> >  
> 
> Sure, my mistake.
> 
> >> +	if ((op->addr.nbytes == 2) && (op->cmd.buswidth != op->addr.buswidth) &&  
> >
> > You don't need those extra parenthesis around each test.
> >  
> 
> It's just convention. Some people prefer to have extra bracket to make
> code easier to read, while other think opposite.

Except it's not even consistent in this file, see the

	if (op->addr.nbytes && op->addr.buswidth != mode->addr_buswidth)

test above.

> I don't really know
> which option is better.

We try to avoid those parens when doing simple '2 operands' operations

	if (a == b && c == d)

but add them in case one of the operand results from another operation

	if (a == (b * c) && c == d)

> >> +
> >> +	qspi_writel(aq, QSPI_IAR, addr);
> >> +	qspi_writel(aq, QSPI_ICR, icr);
> >> +	qspi_writel(aq, QSPI_IFR, ifr);  
> >
> > You should probably read the _SR register before starting a new operation
> > to make sure all status flags have been cleared.
> >  
> 
> I'm not sure about it, but there was SR read in Atmel's driver.
> I can put it here.

It's probably safer, otherwise you might get status from previous
operations.

> >> +static int atmel_qspi_probe(struct platform_device *pdev)
> >> +{
> >> +	struct spi_controller *ctrl;
> >> +	struct atmel_qspi *aq;
> >> +	struct device_node *np = pdev->dev.of_node;
> >> +	struct device_node *child;
> >> +	struct resource *res;
> >> +	int irq, err = 0;
> >> +
> >> +	ctrl = spi_alloc_master(&pdev->dev, sizeof(*aq));
> >> +	if (!ctrl)
> >> +		return -ENOMEM;
> >> +
> >> +	ctrl->mode_bits = SPI_RX_DUAL | SPI_RX_QUAD | SPI_TX_DUAL | SPI_TX_QUAD;
> >> +	ctrl->bus_num = -1;
> >> +	ctrl->mem_ops = &atmel_qspi_mem_ops;
> >> +	ctrl->num_chipselect = 1;
> >> +	ctrl->dev.of_node = pdev->dev.of_node;
> >> +	platform_set_drvdata(pdev, ctrl);
> >> +
> >> +	aq = spi_controller_get_devdata(ctrl);
> >> +
> >> +	if (of_get_child_count(np) != 1)
> >> +		return -ENODEV;  
> >
> > Hm, I think the core already complains if there are more children than  
> > ->num_chipselect, so I'd say this is useless. Also, you can have a  
> > controller without any devices under, so, nchildren == 0 is a valid
> > case.
> >  
> 
> This trick were inspired by atmel-quadspi code. If clk frequency can
> be taken from spi_device, all this of-child related ugliness can be
> removed.

Yep.

> >> +static struct platform_driver atmel_qspi_driver = {
> >> +	.driver = {
> >> +		.name = "atmel_spi_qspi",  
> >
> > 			"atmel-qspi",
> >  
> 
> I expected new driver to exists in parallel with atmel-qspi.
> If it's replacement, then re-use name makes sense.

I think the old driver name was "atmel_qspi", but I prefer dashes to
underscores :-). Anyway, _spi_qspi seems redundant, since qspi already
implies spi.

Regards,

Boris
