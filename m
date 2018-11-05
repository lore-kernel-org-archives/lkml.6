Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4742C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:39:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 632F02085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 16:39:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 632F02085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387592AbeKFB7s (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 20:59:48 -0500
Received: from mail.bootlin.com ([62.4.15.54]:48980 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387420AbeKFB7s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 20:59:48 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 8AAEC20798; Mon,  5 Nov 2018 17:39:16 +0100 (CET)
Received: from bbrezillon (aaubervilliers-681-1-93-44.w90-88.abo.wanadoo.fr [90.88.34.44])
        by mail.bootlin.com (Postfix) with ESMTPSA id 21348206D8;
        Mon,  5 Nov 2018 17:39:06 +0100 (CET)
Date:   Mon, 5 Nov 2018 17:39:05 +0100
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     <christophe.kerello@st.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <robh+dt@kernel.org>,
        <mark.rutland@arm.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v2 2/3] mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND
 flash controller driver
Message-ID: <20181105173905.385dd06e@bbrezillon>
In-Reply-To: <1538732520-2800-3-git-send-email-christophe.kerello@st.com>
References: <1538732520-2800-1-git-send-email-christophe.kerello@st.com>
        <1538732520-2800-3-git-send-email-christophe.kerello@st.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On Fri, 5 Oct 2018 11:41:59 +0200
<christophe.kerello@st.com> wrote:

A few more comments.

> +/* Sequencer read/write configuration */
> +static void stm32_fmc2_rw_page_init(struct nand_chip *chip, int page,
> +				    int raw, bool write_data)
> +{
> +	struct stm32_fmc2 *fmc2 = nand_get_controller_data(chip);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	u32 csqcfgr1, csqcfgr2, csqcfgr3;
> +	u32 csqar1, csqar2;
> +	u32 ecc_offset = mtd->writesize + FMC2_BBM_LEN;
> +	u32 pcr = readl_relaxed(fmc2->io_base + FMC2_PCR);
> +
> +	if (write_data)
> +		pcr |= FMC2_PCR_WEN;
> +	else
> +		pcr &= ~FMC2_PCR_WEN;
> +	writel_relaxed(pcr, fmc2->io_base + FMC2_PCR);
> +
> +	/*
> +	 * - Set Program Page/Page Read command
> +	 * - Enable DMA request data
> +	 * - Set timings
> +	 */
> +	csqcfgr1 = FMC2_CSQCFGR1_DMADEN | FMC2_CSQCFGR1_CMD1T;
> +	if (write_data)
> +		csqcfgr1 |= FMC2_CSQCFGR1_CMD1(NAND_CMD_SEQIN);
> +	else
> +		csqcfgr1 |= FMC2_CSQCFGR1_CMD1(NAND_CMD_READ0) |
> +			    FMC2_CSQCFGR1_CMD2EN |
> +			    FMC2_CSQCFGR1_CMD2(NAND_CMD_READSTART) |
> +			    FMC2_CSQCFGR1_CMD2T;
> +
> +	/*
> +	 * - Set Random Data Input/Random Data Read command
> +	 * - Enable the sequencer to access the Spare data area
> +	 * - Enable  DMA request status decoding for read
> +	 * - Set timings
> +	 */
> +	if (write_data)
> +		csqcfgr2 = FMC2_CSQCFGR2_RCMD1(NAND_CMD_RNDIN);
> +	else
> +		csqcfgr2 = FMC2_CSQCFGR2_RCMD1(NAND_CMD_RNDOUT) |
> +			   FMC2_CSQCFGR2_RCMD2EN |
> +			   FMC2_CSQCFGR2_RCMD2(NAND_CMD_RNDOUTSTART) |
> +			   FMC2_CSQCFGR2_RCMD1T |
> +			   FMC2_CSQCFGR2_RCMD2T;
> +	if (!raw) {
> +		csqcfgr2 |= write_data ? 0 : FMC2_CSQCFGR2_DMASEN;
> +		csqcfgr2 |= FMC2_CSQCFGR2_SQSDTEN;
> +	}
> +
> +	/*
> +	 * - Set the number of sectors to be written
> +	 * - Set timings
> +	 */
> +	csqcfgr3 = FMC2_CSQCFGR3_SNBR(chip->ecc.steps - 1);
> +	if (write_data) {
> +		csqcfgr3 |= FMC2_CSQCFGR3_RAC2T;
> +		if (chip->chipsize > SZ_128M)
> +			csqcfgr3 |= FMC2_CSQCFGR3_AC5T;
> +		else
> +			csqcfgr3 |= FMC2_CSQCFGR3_AC4T;
> +	}
> +
> +	/*
> +	 * Set the fourth first address cycles
> +	 * Byte 1 and byte 2 => column, we start at 0x0
> +	 * Byte 3 and byte 4 => page
> +	 */
> +	csqar1 = FMC2_CSQCAR1_ADDC3(page);
> +	csqar1 |= FMC2_CSQCAR1_ADDC4(page >> 8);
> +
> +	/*
> +	 * - Set chip enable number
> +	 * - Set ecc byte offset in the spare area
> +	 * - Calculate the number of address cycles to be issued
> +	 * - Set byte 5 of address cycle if needed
> +	 */
> +	csqar2 = FMC2_CSQCAR2_NANDCEN(fmc2->cs_sel);
> +	if (chip->options & NAND_BUSWIDTH_16)
> +		csqar2 |= FMC2_CSQCAR2_SAO(ecc_offset >> 1);
> +	else
> +		csqar2 |= FMC2_CSQCAR2_SAO(ecc_offset);
> +	if (chip->chipsize > SZ_128M) {

Can you use

	if (chip->options & NAND_ROW_ADDR_3)

instead?

> +		csqcfgr1 |= FMC2_CSQCFGR1_ACYNBR(5);
> +		csqar2 |= FMC2_CSQCAR2_ADDC5(page >> 16);
> +	} else {
> +		csqcfgr1 |= FMC2_CSQCFGR1_ACYNBR(4);
> +	}

[...]

> +
> +void stm32_fmc2_write_data(struct nand_chip *chip, const void *buf,
> +			   unsigned int len, bool force_8bit)
> +{
> +	struct stm32_fmc2 *fmc2 = nand_get_controller_data(chip);
> +	void __iomem *io_addr_w = fmc2->data_base[fmc2->cs_sel];
> +	const u8 *p = buf;
> +	unsigned int i;
> +
> +	if (force_8bit)
> +		goto write_8bit;
> +
> +	if (IS_ALIGNED(len, sizeof(u32))) {
> +		const u32 *p = buf;

I'm pretty sure the framework provides no alignment guarantee on buf.
You'd better assume buf might not be aligned on 32 or 16 bits.

> +
> +		len /= sizeof(u32);
> +		for (i = 0; i < len; i++)
> +			writel_relaxed(p[i], io_addr_w);
> +		return;
> +	}
> +
> +	if (chip->options & NAND_BUSWIDTH_16) {
> +		const u16 *p = buf;
> +
> +		len /= sizeof(u16);
> +		for (i = 0; i < len; i++)
> +			writew_relaxed(p[i], io_addr_w);
> +		return;
> +	}
> +
> +write_8bit:
> +	for (i = 0; i < len; i++)
> +		writeb_relaxed(p[i], io_addr_w);

Is 8bit access really enforced by the byte accessor? In this case, how
can you be sure 32-bit accesses are doing the right thing? Isn't there
a bit somewhere in the config reg to configure the bus width?

> +}

Regards,

Boris
