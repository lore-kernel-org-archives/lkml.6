Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88EFCC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AB9E20898
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 13:09:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB9E20898
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbeHUQ3z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:29:55 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49458 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727153AbeHUQ3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:29:55 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id kKTjDytItk9K; Tue, 21 Aug 2018 15:09:30 +0200 (CEST)
Received: from nazgul.tnic (77-85-47-250.ip.btc-net.bg [77.85.47.250])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5E0AF1EC028D;
        Tue, 21 Aug 2018 15:09:29 +0200 (CEST)
Date:   Tue, 21 Aug 2018 15:09:46 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Manish Narani <manish.narani@xilinx.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com,
        will.deacon@arm.com, michal.simek@xilinx.com, mchehab@kernel.org,
        mdf@kernel.org, edgar.iglesias@xilinx.com,
        shubhrajyoti.datta@xilinx.com, naga.sureshkumar.relli@xilinx.com,
        bharat.kumar.gogada@xilinx.com, stefan.krsmanovic@aggios.com,
        sgoud@xilinx.com, anirudh@xilinx.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-edac@vger.kernel.org
Subject: Re: [PATCH v4 3/4] edac: synopsys: Add EDAC ECC support for ZynqMP
 DDRC
Message-ID: <20180821130946.GD30528@nazgul.tnic>
References: <1533374735-16662-1-git-send-email-manish.narani@xilinx.com>
 <1533374735-16662-4-git-send-email-manish.narani@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1533374735-16662-4-git-send-email-manish.narani@xilinx.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 04, 2018 at 02:55:34PM +0530, Manish Narani wrote:
> Add EDAC ECC support for ZynqMP DDRC IP. Also add support for ECC Error
> Injection in ZynqMP. The corrected and uncorrected error interrupts
> support is added. The Row, Column, Bank, Bank Group and Rank bits
> positions are determined via Address Map registers of Synopsys DDRC.
> 
> Signed-off-by: Manish Narani <manish.narani@xilinx.com>
> ---
>  drivers/edac/Kconfig         |   2 +-
>  drivers/edac/synopsys_edac.c | 864 ++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 848 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
> index 57304b2..b1fc7a16 100644
> --- a/drivers/edac/Kconfig
> +++ b/drivers/edac/Kconfig
> @@ -441,7 +441,7 @@ config EDAC_ALTERA_SDMMC
>  
>  config EDAC_SYNOPSYS
>  	tristate "Synopsys DDR Memory Controller"
> -	depends on ARCH_ZYNQ
> +	depends on ARCH_ZYNQ || ARM64
>  	help
>  	  Support for error detection and correction on the Synopsys DDR
>  	  memory controller.
> diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
> index b3c54e7..82f276b 100644
> --- a/drivers/edac/synopsys_edac.c
> +++ b/drivers/edac/synopsys_edac.c
> @@ -22,6 +22,7 @@
>  #include <linux/edac.h>
>  #include <linux/module.h>
>  #include <linux/platform_device.h>
> +#include <linux/interrupt.h>
>  #include <linux/of.h>
>  
>  #include "edac_module.h"
> @@ -96,6 +97,170 @@
>  #define SCRUB_MODE_MASK		0x7
>  #define SCRUB_MODE_SECDED	0x4
>  
> +/* DDR ECC Quirks */
> +#define DDR_ECC_INTR_SUPPORT	BIT(0)
> +
> +/* DDR ECC Quirks */
> +#define DDR_ECC_INTR_SUPPORT	BIT(0)

This is repeated.

> +#define DDR_ECC_DATA_POISON_SUPPORT BIT(1)
> +
> +/* ZynqMP Enhanced DDR memory controller registers that are relevant to ECC */
> +/* ECC Configuration Registers */
> +#define ECC_CFG0_OFST	0x70
> +#define ECC_CFG1_OFST	0x74
> +
> +/* ECC Status Register */
> +#define ECC_STAT_OFST	0x78
> +
> +/* ECC Clear Register */
> +#define ECC_CLR_OFST	0x7C
> +
> +/* ECC Error count Register */
> +#define ECC_ERRCNT_OFST	0x80

Do you not see how the rest of the defines' values are aligned
vertically in this file?

> +
> +/* ECC Corrected Error Address Register */
> +#define ECC_CEADDR0_OFST	0x84
> +#define ECC_CEADDR1_OFST	0x88
> +
> +/* ECC Syndrome Registers */
> +#define ECC_CSYND0_OFST	0x8C
> +#define ECC_CSYND1_OFST	0x90
> +#define ECC_CSYND2_OFST	0x94
> +
> +/* ECC Bit Mask0 Address Register */
> +#define ECC_BITMASK0_OFST	0x98
> +#define ECC_BITMASK1_OFST	0x9C
> +#define ECC_BITMASK2_OFST	0xA0
> +
> +/* ECC UnCorrected Error Address Register */
> +#define ECC_UEADDR0_OFST	0xA4
> +#define ECC_UEADDR1_OFST	0xA8
> +
> +/* ECC Syndrome Registers */
> +#define ECC_UESYND0_OFST	0xAC
> +#define ECC_UESYND1_OFST	0xB0
> +#define ECC_UESYND2_OFST	0xB4
> +
> +/* ECC Poison Address Reg */
> +#define ECC_POISON0_OFST	0xB8
> +#define ECC_POISON1_OFST	0xBC
> +
> +#define ECC_ADDRMAP0_OFFSET	0x200
> +
> +/* Control register bitfield definitions */
> +#define ECC_CTRL_BUSWIDTH_MASK	0x3000
> +#define ECC_CTRL_BUSWIDTH_SHIFT	12
> +#define ECC_CTRL_CLR_CE_ERRCNT	BIT(2)
> +#define ECC_CTRL_CLR_UE_ERRCNT	BIT(3)
> +
> +/* DDR Control Register width definitions  */
> +#define DDRCTL_EWDTH_16		2
> +#define DDRCTL_EWDTH_32		1
> +#define DDRCTL_EWDTH_64		0
> +
> +/* ECC status register definitions */
> +#define ECC_STAT_UECNT_MASK	0xF0000
> +#define ECC_STAT_UECNT_SHIFT	16
> +#define ECC_STAT_CECNT_MASK	0xF00
> +#define ECC_STAT_CECNT_SHIFT	8
> +#define ECC_STAT_BITNUM_MASK	0x7F
> +
> +/* DDR QOS Interrupt register definitions */
> +#define DDR_QOS_IRQ_STAT_OFST	0x20200
> +#define DDR_QOSUE_MASK		0x4
> +#define	DDR_QOSCE_MASK		0x2
> +#define	ECC_CE_UE_INTR_MASK	0x6
> +#define DDR_QOS_IRQ_EN_OFST     0x20208
> +#define DDR_QOS_IRQ_DB_OFST	0x2020C
> +
> +/* ECC Corrected Error Register Mask and Shifts*/
> +#define ECC_CEADDR0_RW_MASK	0x3FFFF
> +#define ECC_CEADDR0_RNK_MASK	BIT(24)
> +#define ECC_CEADDR1_BNKGRP_MASK	0x3000000
> +#define ECC_CEADDR1_BNKNR_MASK	0x70000
> +#define ECC_CEADDR1_BLKNR_MASK	0xFFF
> +#define ECC_CEADDR1_BNKGRP_SHIFT	24
> +#define ECC_CEADDR1_BNKNR_SHIFT	16
> +
> +/* ECC Poison register shifts */
> +#define ECC_POISON0_RANK_SHIFT 24
> +#define ECC_POISON1_BANKGRP_SHIFT 28
> +#define ECC_POISON1_BANKNR_SHIFT 24
> +
> +/* DDR Memory type defines */
> +#define MEM_TYPE_DDR3		0x1
> +#define MEM_TYPE_LPDDR3		0x8
> +#define MEM_TYPE_DDR2		0x4
> +#define MEM_TYPE_DDR4		0x10
> +#define MEM_TYPE_LPDDR4		0x20
> +
> +/* DDRC Software control register */
> +#define DDRC_SWCTL 0x320
> +
> +/* DDRC ECC CE & UE poison mask */
> +#define ECC_CEPOISON_MASK 0x3
> +#define ECC_UEPOISON_MASK 0x1
> +
> +/* DDRC Device config masks */
> +#define DDRC_MSTR_DEV_CONFIG_MASK 0xC0000000
> +#define DDRC_MSTR_DEV_CONFIG_SHIFT	30
> +#define DDRC_MSTR_DEV_CONFIG_X4_MASK	0x0
> +#define DDRC_MSTR_DEV_CONFIG_X8_MASK	0x1
> +#define DDRC_MSTR_DEV_CONFIG_X16_MASK	0x2
> +#define DDRC_MSTR_DEV_CONFIG_X32_MASK	0x3

Those are too long and thus violate the vertical alignment - so you can shorten
them by doing, for example, s/CONFIG_MASK/CFG_MSK/

> +
> +#define DDR_MAX_ROW_SHIFT	18
> +#define DDR_MAX_COL_SHIFT	14
> +#define DDR_MAX_BANK_SHIFT	3
> +#define DDR_MAX_BANKGRP_SHIFT	2
> +
> +#define ROW_MAX_VAL_MASK	0xF
> +#define COL_MAX_VAL_MASK	0xF
> +#define BANK_MAX_VAL_MASK	0x1F
> +#define BANKGRP_MAX_VAL_MASK	0x1F
> +#define RANK_MAX_VAL_MASK	0x1F
> +
> +#define ROW_B0_BASE		6
> +#define ROW_B1_BASE		7
> +#define ROW_B2_BASE		8
> +#define ROW_B3_BASE		9
> +#define ROW_B4_BASE		10
> +#define ROW_B5_BASE		11
> +#define ROW_B6_BASE		12
> +#define ROW_B7_BASE		13
> +#define ROW_B8_BASE		14
> +#define ROW_B9_BASE		15
> +#define ROW_B10_BASE		16
> +#define ROW_B11_BASE		17
> +#define ROW_B12_BASE		18
> +#define ROW_B13_BASE		19
> +#define ROW_B14_BASE		20
> +#define ROW_B15_BASE		21
> +#define ROW_B16_BASE		22
> +#define ROW_B17_BASE		23
> +
> +#define COL_B2_BASE		2
> +#define COL_B3_BASE		3
> +#define COL_B4_BASE		4
> +#define COL_B5_BASE		5
> +#define COL_B6_BASE		6
> +#define COL_B7_BASE		7
> +#define COL_B8_BASE		8
> +#define COL_B9_BASE		9
> +#define COL_B10_BASE		10
> +#define COL_B11_BASE		11
> +#define COL_B12_BASE		12
> +#define COL_B13_BASE		13
> +
> +#define BANK_B0_BASE		2
> +#define BANK_B1_BASE		3
> +#define BANK_B2_BASE		4
> +
> +#define BANKGRP_B0_BASE		2
> +#define BANKGRP_B1_BASE		3
> +
> +#define RANK_B0_BASE		6
> +
>  /**
>   * struct ecc_error_info - ECC error log information
>   * @row:	Row number
> @@ -103,6 +268,8 @@
>   * @bank:	Bank number
>   * @bitpos:	Bit position
>   * @data:	Data causing the error
> + * @bankgrpnr:	Bank group number
> + * @blknr:	Block number
>   */
>  struct ecc_error_info {
>  	u32 row;
> @@ -110,6 +277,8 @@ struct ecc_error_info {
>  	u32 bank;
>  	u32 bitpos;
>  	u32 data;
> +	u32 bankgrpnr;
> +	u32 blknr;
>  };
>  
>  /**
> @@ -128,12 +297,18 @@ struct synps_ecc_status {
>  
>  /**
>   * struct synps_edac_priv - DDR memory controller private instance data
> - * @baseaddr:	Base address of the DDR controller
> - * @message:	Buffer for framing the event specific info
> - * @stat:	ECC status information
> - * @p_data:	Pointer to platform data
> - * @ce_cnt:	Correctable Error count
> - * @ue_cnt:	Uncorrectable Error count
> + * @baseaddr:		Base address of the DDR controller
> + * @message:		Buffer for framing the event specific info
> + * @stat:		ECC status information
> + * @p_data:		Pointer to platform data
> + * @ce_cnt:		Correctable Error count
> + * @ue_cnt:		Uncorrectable Error count
> + * @poison_addr:	Data poison address
> + * @row_shift:		Value of row shifts
> + * @col_shift:		Value of col shifts
> + * @bank_shift:		Value of bank shifts
> + * @bankgrp_shift:	Value of bank group shifts
> + * @rank_shift:		Value of rank shifts

We know it is a value - explaining what those shifts are would be much
more helpful.

>   */
>  struct synps_edac_priv {
>  	void __iomem *baseaddr;
> @@ -142,6 +317,12 @@ struct synps_edac_priv {
>  	const struct synps_platform_data *p_data;
>  	u32 ce_cnt;
>  	u32 ue_cnt;
> +	ulong poison_addr;
> +	u32 row_shift[18];
> +	u32 col_shift[14];
> +	u32 bank_shift[3];
> +	u32 bankgrp_shift[2];
> +	u32 rank_shift[1];
>  };
>  
>  /**
> @@ -166,7 +347,7 @@ struct synps_platform_data {
>   *
>   * Determines there is any ecc error or not
>   *
> - * Return: one if there is no error otherwise returns zero
> + * Return: 1 if there is no error otherwise returns 0
>   */
>  static int synps_edac_geterror_info(struct synps_edac_priv *priv)
>  {
> @@ -221,6 +402,72 @@ static int synps_edac_geterror_info(struct synps_edac_priv *priv)
>  }
>  
>  /**
> + * synps_enh_edac_geterror_info - Get the current ecc error info
> + * @base:	Pointer to the base address of the ddr memory controller
> + * @p:		Pointer to the synopsys ecc status structure
> + *
> + * Determines there is any ecc error or not
> + *
> + * Return: one if there is no error otherwise returns zero
> + */

That's one sloppy comment - the function arguments are wrong and the
description text needs to have correct english sentences ending with a
fullstop.

> +static int synps_enh_edac_geterror_info(struct synps_edac_priv *priv)

What is that prefix "synps_enh_edac" even supposed to mean? Especially
since this is a static function which doesn't need any prefixing...
Check your other functions too.

> +{
> +	void __iomem *base;
> +	struct synps_ecc_status *p;
> +	u32 regval, clearval = 0;
> +
> +	if (!priv)
> +		return 1;
> +
> +	base = priv->baseaddr;
> +	p = &priv->stat;
> +
> +	regval = readl(base + ECC_STAT_OFST);
> +	if (!regval)
> +		return 1;
> +
> +	p->ce_cnt = (regval & ECC_STAT_CECNT_MASK) >> ECC_STAT_CECNT_SHIFT;
> +	p->ue_cnt = (regval & ECC_STAT_UECNT_MASK) >> ECC_STAT_UECNT_SHIFT;
> +	p->ceinfo.bitpos = (regval & ECC_STAT_BITNUM_MASK);
> +
> +	regval = readl(base + ECC_CEADDR0_OFST);
> +	if (!(p->ce_cnt))
> +		goto ue_err;
> +
> +	p->ceinfo.row = (regval & ECC_CEADDR0_RW_MASK);
> +	regval = readl(base + ECC_CEADDR1_OFST);
> +	p->ceinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
> +					ECC_CEADDR1_BNKNR_SHIFT;
> +	p->ceinfo.bankgrpnr = (regval &	ECC_CEADDR1_BNKGRP_MASK) >>
> +					ECC_CEADDR1_BNKGRP_SHIFT;
> +	p->ceinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
> +	p->ceinfo.data = readl(base + ECC_CSYND0_OFST);
> +	edac_dbg(3, "ce bit position: %d data: %d\n", p->ceinfo.bitpos,
> +		 p->ceinfo.data);
> +
> +ue_err:
> +	regval = readl(base + ECC_UEADDR0_OFST);
> +	if (!(p->ue_cnt))
> +		goto out;
> +
> +	p->ueinfo.row = (regval & ECC_CEADDR0_RW_MASK);
> +	regval = readl(base + ECC_UEADDR1_OFST);
> +	p->ueinfo.bankgrpnr = (regval & ECC_CEADDR1_BNKGRP_MASK) >>
> +					ECC_CEADDR1_BNKGRP_SHIFT;
> +	p->ueinfo.bank = (regval & ECC_CEADDR1_BNKNR_MASK) >>
> +					ECC_CEADDR1_BNKNR_SHIFT;
> +	p->ueinfo.blknr = (regval & ECC_CEADDR1_BLKNR_MASK);
> +	p->ueinfo.data = readl(base + ECC_UESYND0_OFST);
> +out:
> +	clearval = ECC_CTRL_CLR_CE_ERR | ECC_CTRL_CLR_CE_ERRCNT;
> +	clearval |= ECC_CTRL_CLR_UE_ERR | ECC_CTRL_CLR_UE_ERRCNT;
> +	writel(clearval, base + ECC_CLR_OFST);
> +	writel(0x0, base + ECC_CLR_OFST);
> +
> +	return 0;
> +}
> +
> +/**
>   * synps_edac_handle_error - Handle controller error types CE and UE
>   * @mci:	Pointer to the edac memory controller instance
>   * @p:		Pointer to the synopsys ecc status structure
> @@ -235,9 +482,17 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
>  
>  	if (p->ce_cnt) {
>  		pinf = &p->ceinfo;
> -		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> -			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
> -			 "CE", pinf->row, pinf->bank, pinf->col);
> +		if (priv->p_data->quirks == 0)

		if (!...

> +			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> +				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
> +				 "CE", pinf->row, pinf->bank, pinf->col);
> +		else
> +			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> +				 "DDR ECC error type :%s Row %d Bank %d Col %d "
> +				 "BankGroup Number %d Block Number %d",
> +				 "CE", pinf->row, pinf->bank, pinf->col,
> +				 pinf->bankgrpnr, pinf->blknr);
> +

Pls integrate checkpatch.pl into your patch creation workflow - some of
the warnings do make sense:

WARNING: quoted string split across lines
#380: FILE: drivers/edac/synopsys_edac.c:492:
+                                "DDR ECC error type :%s Row %d Bank %d Col %d "
+                                "BankGroup Number %d Block Number %d",

WARNING: quoted string split across lines
#401: FILE: drivers/edac/synopsys_edac.c:510:
+                                "DDR ECC error type :%s Row %d Bank %d Col %d "
+                                "BankGroup Number %d Block Number %d",

total: 0 errors, 2 warnings, 1005 lines checked


>  		edac_mc_handle_error(HW_EVENT_ERR_CORRECTED, mci,
>  				     p->ce_cnt, 0, 0, 0, 0, 0, -1,
>  				     priv->message, "");
> @@ -245,9 +500,17 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
>  
>  	if (p->ue_cnt) {
>  		pinf = &p->ueinfo;
> -		snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> -			 "DDR ECC error type :%s Row %d Bank %d Col %d ",
> -			 "UE", pinf->row, pinf->bank, pinf->col);
> +		if (priv->p_data->quirks == 0)

		if (!...

> +			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> +				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
> +				"UE", pinf->row, pinf->bank, pinf->col);
> +		else
> +			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
> +				 "DDR ECC error type :%s Row %d Bank %d Col %d "
> +				 "BankGroup Number %d Block Number %d",
> +				 "UE", pinf->row, pinf->bank, pinf->col,
> +				 pinf->bankgrpnr, pinf->blknr);
> +
>  		edac_mc_handle_error(HW_EVENT_ERR_UNCORRECTED, mci,
>  				     p->ue_cnt, 0, 0, 0, 0, 0, -1,
>  				     priv->message, "");
> @@ -257,6 +520,41 @@ static void synps_edac_handle_error(struct mem_ctl_info *mci,
>  }
>  
>  /**
> + * synps_edac_intr_handler - synps edac isr

Either explain in plain english what this is or don't write a comment at
all. "isr" is not helping.

Also, it is EDAC and not "edac" - check your whole patch for lowercased
abbreviations like "ddr", "ecc", ..., and correct them.

> + * @irq:        irq number
> + * @dev_id:     device id poniter

Also, check your patch for spelling errors: "poniter" is some new type
of pony or?

:)

> + *
> + * This is the Isr routine called by edac core interrupt thread.
> + * Used to check and post ECC errors.
> + *
> + * Return: IRQ_NONE, if interrupt not set or IRQ_HANDLED otherwise

All those sentences need to end with a fullstop. Check your whole patch.

> + */
> +static irqreturn_t synps_edac_intr_handler(int irq, void *dev_id)
> +{
> +	struct mem_ctl_info *mci = dev_id;
> +	struct synps_edac_priv *priv = mci->pvt_info;
> +	const struct synps_platform_data *p_data = priv->p_data;
> +	int status, regval;
> +
> +	regval = readl(priv->baseaddr + DDR_QOS_IRQ_STAT_OFST) &
> +			(DDR_QOSCE_MASK | DDR_QOSUE_MASK);

Do the & in a second line:

	regval &= ...

for better readability.

> +	if (!(regval & ECC_CE_UE_INTR_MASK))
> +		return IRQ_NONE;

<----- newline here.

> +	status = p_data->edac_geterror_info(priv);
> +	if (status)
> +		return IRQ_NONE;
> +
> +	priv->ce_cnt += priv->stat.ce_cnt;
> +	priv->ue_cnt += priv->stat.ue_cnt;
> +	synps_edac_handle_error(mci, &priv->stat);
> +
> +	edac_dbg(3, "Total error count ce %d ue %d\n",
> +		 priv->ce_cnt, priv->ue_cnt);
> +	writel(regval, priv->baseaddr + DDR_QOS_IRQ_STAT_OFST);
> +	return IRQ_HANDLED;
> +}
> +
> +/**
>   * synps_edac_check - Check controller for ECC errors
>   * @mci:	Pointer to the edac memory controller instance
>   *
> @@ -312,6 +610,40 @@ static enum dev_type synps_edac_get_dtype(const void __iomem *base)
>  }
>  
>  /**
> + * synps_enh_edac_get_dtype - Return the controller memory width
> + * @base:	Pointer to the ddr memory controller base address
> + *
> + * Get the EDAC device type width appropriate for the current controller
> + * configuration.
> + *
> + * Return: a device type width enumeration.
> + */
> +static enum dev_type synps_enh_edac_get_dtype(const void __iomem *base)
> +{
> +	enum dev_type dt;
> +	u32 width;
> +
> +	width = readl(base + CTRL_OFST);
> +	width = (width & ECC_CTRL_BUSWIDTH_MASK) >>
> +		ECC_CTRL_BUSWIDTH_SHIFT;

Let it stick out instead of breaking it this way.

> +	switch (width) {
> +	case DDRCTL_EWDTH_16:
> +		dt = DEV_X2;
> +		break;
> +	case DDRCTL_EWDTH_32:
> +		dt = DEV_X4;
> +		break;
> +	case DDRCTL_EWDTH_64:
> +		dt = DEV_X8;
> +		break;
> +	default:
> +		dt = DEV_UNKNOWN;
> +	}
> +
> +	return dt;
> +}
> +
> +/**
>   * synps_edac_get_eccstate - Return the controller ecc enable/disable status
>   * @base:	Pointer to the ddr memory controller base address
>   *
> @@ -337,6 +669,32 @@ static bool synps_edac_get_eccstate(void __iomem *base)
>  }
>  
>  /**
> + * synps_enh_edac_get_eccstate - Return the controller ecc enable/disable status
> + * @base:	Pointer to the ddr memory controller base address
> + *
> + * Get the ECC enable/disable status for the controller
> + *
> + * Return: a ecc status boolean i.e true/false - enabled/disabled.
> + */
> +static bool synps_enh_edac_get_eccstate(void __iomem *base)
> +{
> +	enum dev_type dt;
> +	u32 ecctype;
> +	bool state = false;

You don't need state at all, just do...

> +
> +	dt = synps_enh_edac_get_dtype(base);
> +	if (dt == DEV_UNKNOWN)
> +		return state;

		return false;

> +
> +	ecctype = readl(base + ECC_CFG0_OFST) & SCRUB_MODE_MASK;
> +	if ((ecctype == SCRUB_MODE_SECDED) &&
> +	    ((dt == DEV_X2) || (dt == DEV_X4) || (dt == DEV_X8)))
> +		state = true;

		return true;

> +
> +	return state;

	return false;

> +}
> +
> +/**
>   * synps_edac_get_memsize - reads the size of the attached memory device
>   *
>   * Return: the memory size in bytes
> @@ -375,6 +733,35 @@ static enum mem_type synps_edac_get_mtype(const void __iomem *base)
>  }
>  
>  /**
> + * synps_enh_edac_get_mtype - Returns controller memory type
> + * @base:	pointer to the synopsys ecc status structure
> + *
> + * Get the EDAC memory type appropriate for the current controller
> + * configuration.
> + *
> + * Return: a memory type enumeration.
> + */
> +static enum mem_type synps_enh_edac_get_mtype(const void __iomem *base)
> +{
> +	enum mem_type mt;
> +	u32 memtype;
> +
> +	memtype = readl(base + CTRL_OFST);
> +
> +	mt = MEM_UNKNOWN;

You don't need this default assignment...

> +	if ((memtype & MEM_TYPE_DDR3) || (memtype & MEM_TYPE_LPDDR3))
> +		mt = MEM_DDR3;
> +	else if (memtype & MEM_TYPE_DDR2)
> +		mt = MEM_RDDR2;
> +	else if ((memtype & MEM_TYPE_LPDDR4) || (memtype & MEM_TYPE_DDR4))
> +		mt = MEM_DDR4;
> +	else
> +		mt = MEM_EMPTY;

... if you do the catch-all here.

> +
> +	return mt;
> +}
> +
> +/**
>   * synps_edac_init_csrows - Initialize the cs row data
>   * @mci:	Pointer to the edac memory controller instance
>   *
> @@ -442,8 +829,13 @@ static int synps_edac_mc_init(struct mem_ctl_info *mci,
>  	mci->dev_name = SYNPS_EDAC_MOD_STRING;
>  	mci->mod_name = SYNPS_EDAC_MOD_VER;
>  
> -	edac_op_state = EDAC_OPSTATE_POLL;
> -	mci->edac_check = synps_edac_check;
> +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
> +		edac_op_state = EDAC_OPSTATE_INT;
> +	} else {
> +		edac_op_state = EDAC_OPSTATE_POLL;
> +		mci->edac_check = synps_edac_check;
> +	}
> +
>  	mci->ctl_page_to_phys = NULL;
>  
>  	status = synps_edac_init_csrows(mci);
> @@ -459,13 +851,409 @@ static const struct synps_platform_data zynq_edac_def = {
>  	.quirks			= 0,
>  };
>  
> +static const struct synps_platform_data zynqmp_enh_edac_def = {
> +	.edac_geterror_info	= synps_enh_edac_geterror_info,
> +	.edac_get_mtype		= synps_enh_edac_get_mtype,
> +	.edac_get_dtype		= synps_enh_edac_get_dtype,
> +	.edac_get_eccstate	= synps_enh_edac_get_eccstate,
> +	.quirks			= (DDR_ECC_INTR_SUPPORT |
> +				   DDR_ECC_DATA_POISON_SUPPORT),
> +};
> +
>  static const struct of_device_id synps_edac_match[] = {
>  	{ .compatible = "xlnx,zynq-ddrc-a05", .data = (void *)&zynq_edac_def },
> +	{ .compatible = "xlnx,zynqmp-ddrc-2.40a",
> +				.data = (void *)&zynqmp_enh_edac_def},

Align those struct members vertically like this:

static const struct of_device_id synps_edac_match[] = {
        {
                .compatible = "xlnx,zynq-ddrc-a05",
                .data = (void *)&zynq_edac_def
        },
        {
                .compatible = "xlnx,zynqmp-ddrc-2.40a",
                .data = (void *)&zynqmp_enh_edac_def
        },
        { /* end of table */ }
};

>  MODULE_DEVICE_TABLE(of, synps_edac_match);
>  
> +#define to_mci(k) container_of(k, struct mem_ctl_info, dev)
> +
> +/**
> + * ddr_poison_setup -	update poison registers
> + * @priv:		Pointer to synps_edac_priv struct
> + *
> + * Update poison registers as per ddr mapping
> + * Return: none.
> + */
> +static void ddr_poison_setup(struct synps_edac_priv *priv)
> +{
> +	int col = 0, row = 0, bank = 0, bankgrp = 0, rank = 0, regval;
> +	int index;
> +	ulong hif_addr = 0;
> +
> +	hif_addr = priv->poison_addr >> 3;
> +
> +	for (index = 0; index < DDR_MAX_ROW_SHIFT; index++) {
> +		if (priv->row_shift[index])
> +			row |= (((hif_addr >> priv->row_shift[index]) &
> +						BIT(0)) << index);
> +		else
> +			break;
> +	}
> +
> +	for (index = 0; index < DDR_MAX_COL_SHIFT; index++) {
> +		if (priv->col_shift[index] || index < 3)
> +			col |= (((hif_addr >> priv->col_shift[index]) &
> +						BIT(0)) << index);
> +		else
> +			break;
> +	}
> +
> +	for (index = 0; index < DDR_MAX_BANK_SHIFT; index++) {
> +		if (priv->bank_shift[index])
> +			bank |= (((hif_addr >> priv->bank_shift[index]) &
> +						BIT(0)) << index);
> +		else
> +			break;
> +	}
> +
> +	for (index = 0; index < DDR_MAX_BANKGRP_SHIFT; index++) {
> +		if (priv->bankgrp_shift[index])
> +			bankgrp |= (((hif_addr >> priv->bankgrp_shift[index])
> +						& BIT(0)) << index);
> +		else
> +			break;
> +	}
> +
> +	if (priv->rank_shift[0])
> +		rank = (hif_addr >> priv->rank_shift[0]) & BIT(0);
> +
> +	regval = (rank << ECC_POISON0_RANK_SHIFT) | col;
> +	writel(regval, priv->baseaddr + ECC_POISON0_OFST);
> +	regval = (bankgrp << ECC_POISON1_BANKGRP_SHIFT) |
> +			 (bank << ECC_POISON1_BANKNR_SHIFT) | row;
> +	writel(regval, priv->baseaddr + ECC_POISON1_OFST);

Those 4 lines could use some readability improvements.

> +}
> +
> +/**
> + * inject_data_error_show - Get Poison0 & 1 register contents
> + * @dev:	Pointer to the device struct
> + * @mattr:	Pointer to device attributes
> + * @data:	Pointer to user data

That "pointer to" is kinda silly. Just explain what those things are.
Ditto for the rest of the driver.

> + *
> + * Get the Poison0 and Poison1 register contents
> + * Return: Number of bytes copied.
> + */
> +static ssize_t inject_data_error_show(struct device *dev,
> +					      struct device_attribute *mattr,
> +					      char *data)

Align arguments on the opening brace.

More importantly, you need to put all that injection functionality
behind CONFIG_EDAC_DEBUG - you don't want to expose the injection
capabilities on a production machine.

> +{
> +	struct mem_ctl_info *mci = to_mci(dev);
> +	struct synps_edac_priv *priv = mci->pvt_info;
> +
> +	return sprintf(data, "Poison0 Addr: 0x%08x\n\rPoison1 Addr: 0x%08x\n\r"
> +			"Error injection Address: 0x%lx\n\r",
> +			readl(priv->baseaddr + ECC_POISON0_OFST),
> +			readl(priv->baseaddr + ECC_POISON1_OFST),
> +			priv->poison_addr);
> +}
> +
> +/**
> + * inject_data_error_store - Configure Poison0 Poison1 registers
> + * @dev:	Pointer to the device struct
> + * @mattr:	Pointer to device attributes
> + * @data:	Pointer to user data
> + * @count:	read the size bytes from buffer
> + *
> + * Configures the Poison0 and Poison1 register contents as per user given
> + * address
> + * Return: Number of bytes copied.
> + */
> +static ssize_t inject_data_error_store(struct device *dev,
> +					       struct device_attribute *mattr,
> +					       const char *data, size_t count)
> +{
> +	struct mem_ctl_info *mci = to_mci(dev);
> +	struct synps_edac_priv *priv = mci->pvt_info;
> +
> +	if (kstrtoul(data, 0, &priv->poison_addr))
> +		return -EINVAL;
> +
> +	ddr_poison_setup(priv);
> +
> +	return count;
> +}
> +
> +/**
> + * inject_data_poison_show - Shows type of Data poison
> + * @dev:	Pointer to the device struct
> + * @mattr:	Pointer to device attributes
> + * @data:	Pointer to user data
> + *
> + * Shows the type of Error injection enabled, either UE or CE
> + * Return: Number of bytes copied.
> + */
> +static ssize_t inject_data_poison_show(struct device *dev,
> +					      struct device_attribute *mattr,
> +					      char *data)
> +{
> +	struct mem_ctl_info *mci = to_mci(dev);
> +	struct synps_edac_priv *priv = mci->pvt_info;
> +
> +	return sprintf(data, "Data Poisoning: %s\n\r",
> +			(((readl(priv->baseaddr + ECC_CFG1_OFST)) & 0x3) == 0x3)
> +			? ("Correctable Error") : ("UnCorrectable Error"));
> +}
> +
> +/**
> + * inject_data_poison_store - Enbles Data poison CE/UE
> + * @dev:	Pointer to the device struct
> + * @mattr:	Pointer to device attributes
> + * @data:	Pointer to user data
> + * @count:	read the size bytes from buffer
> + *
> + * Enables the CE or UE Data poison
> + * Return: Number of bytes copied.
> + */
> +static ssize_t inject_data_poison_store(struct device *dev,
> +					       struct device_attribute *mattr,
> +					       const char *data, size_t count)
> +{
> +	struct mem_ctl_info *mci = to_mci(dev);
> +	struct synps_edac_priv *priv = mci->pvt_info;
> +
> +	writel(0, priv->baseaddr + DDRC_SWCTL);
> +	if (strncmp(data, "CE", 2) == 0)
> +		writel(ECC_CEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
> +	else
> +		writel(ECC_UEPOISON_MASK, priv->baseaddr + ECC_CFG1_OFST);
> +	writel(1, priv->baseaddr + DDRC_SWCTL);
> +
> +	return count;
> +}
> +
> +static DEVICE_ATTR_RW(inject_data_error);
> +static DEVICE_ATTR_RW(inject_data_poison);
> +
> +/**
> + * synps_edac_create_sysfs_attributes - Create sysfs entries
> + * @mci:	Pointer to the edac memory controller instance
> + *
> + * Create sysfs attributes for injecting ECC errors using data poison.
> + *
> + * Return: 0 if sysfs creation was successful, else return negative error code.
> + */
> +static int synps_edac_create_sysfs_attributes(struct mem_ctl_info *mci)
> +{
> +	int rc;
> +
> +	rc = device_create_file(&mci->dev, &dev_attr_inject_data_error);
> +	if (rc < 0)
> +		return rc;
> +	rc = device_create_file(&mci->dev, &dev_attr_inject_data_poison);
> +	if (rc < 0)
> +		return rc;
> +	return 0;
> +}
> +
> +/**
> + * synps_edac_remove_sysfs_attributes - Removes sysfs entries
> + * @mci:	Pointer to the edac memory controller instance
> + *
> + * Removes sysfs attributes.
> + *
> + * Return: none.
> + */
> +static void synps_edac_remove_sysfs_attributes(struct mem_ctl_info *mci)
> +{
> +	device_remove_file(&mci->dev, &dev_attr_inject_data_error);
> +	device_remove_file(&mci->dev, &dev_attr_inject_data_poison);
> +}
> +
> +/**
> + * setup_address_map -	Set Address Map by querying ADDRMAP registers
> + * @priv:		Pointer to synps_edac_priv struct
> + *
> + * Set Address Map by querying ADDRMAP registers
> + * Return: none.
> + */
> +static void setup_address_map(struct synps_edac_priv *priv)
> +{
> +	u32 addrmap[12], addrmap_row_b2_10;
> +	int index;
> +	u32 width, memtype;
> +
> +	memtype = readl(priv->baseaddr + CTRL_OFST);
> +	width = (memtype & ECC_CTRL_BUSWIDTH_MASK) >> ECC_CTRL_BUSWIDTH_SHIFT;
> +
> +	for (index = 0; index < 12; index++) {
> +		u32 addrmap_offset;
> +
> +		addrmap_offset = ECC_ADDRMAP0_OFFSET + (index * 4);
> +		addrmap[index] = readl(priv->baseaddr + addrmap_offset);
> +	}
> +
> +	priv->row_shift[0] = (addrmap[5] & ROW_MAX_VAL_MASK) + ROW_B0_BASE;
> +	priv->row_shift[1] = ((addrmap[5] >> 8) &
> +			ROW_MAX_VAL_MASK) + ROW_B1_BASE;
> +
> +	addrmap_row_b2_10 = (addrmap[5] >> 16) & ROW_MAX_VAL_MASK;
> +	if (addrmap_row_b2_10 != ROW_MAX_VAL_MASK) {
> +		for (index = 2; index < 11; index++)
> +			priv->row_shift[index] = addrmap_row_b2_10 +
> +				index + ROW_B0_BASE;
> +
> +	} else {
> +		priv->row_shift[2] = (addrmap[9] &
> +				ROW_MAX_VAL_MASK) + ROW_B2_BASE;
> +		priv->row_shift[3] = ((addrmap[9] >> 8) &
> +				ROW_MAX_VAL_MASK) + ROW_B3_BASE;
> +		priv->row_shift[4] = ((addrmap[9] >> 16) &
> +				ROW_MAX_VAL_MASK) + ROW_B4_BASE;
> +		priv->row_shift[5] = ((addrmap[9] >> 24) &
> +				ROW_MAX_VAL_MASK) + ROW_B5_BASE;
> +		priv->row_shift[6] = (addrmap[10] &
> +				ROW_MAX_VAL_MASK) + ROW_B6_BASE;
> +		priv->row_shift[7] = ((addrmap[10] >> 8) &
> +				ROW_MAX_VAL_MASK) + ROW_B7_BASE;
> +		priv->row_shift[8] = ((addrmap[10] >> 16) &
> +				ROW_MAX_VAL_MASK) + ROW_B8_BASE;
> +		priv->row_shift[9] = ((addrmap[10] >> 24) &
> +				ROW_MAX_VAL_MASK) + ROW_B9_BASE;
> +		priv->row_shift[10] = (addrmap[11] &
> +				ROW_MAX_VAL_MASK) + ROW_B10_BASE;
> +	}
> +
> +	priv->row_shift[11] = (((addrmap[5] >> 24) & ROW_MAX_VAL_MASK) ==
> +				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[5] >> 24) &
> +				ROW_MAX_VAL_MASK) + ROW_B11_BASE);
> +	priv->row_shift[12] = ((addrmap[6] & ROW_MAX_VAL_MASK) ==
> +				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[6] &
> +				ROW_MAX_VAL_MASK) + ROW_B12_BASE);
> +	priv->row_shift[13] = (((addrmap[6] >> 8) & ROW_MAX_VAL_MASK) ==
> +				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 8) &
> +				ROW_MAX_VAL_MASK) + ROW_B13_BASE);
> +	priv->row_shift[14] = (((addrmap[6] >> 16) & ROW_MAX_VAL_MASK) ==
> +				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 16) &
> +				ROW_MAX_VAL_MASK) + ROW_B14_BASE);
> +	priv->row_shift[15] = (((addrmap[6] >> 24) & ROW_MAX_VAL_MASK) ==
> +				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[6] >> 24) &
> +				ROW_MAX_VAL_MASK) + ROW_B15_BASE);
> +	priv->row_shift[16] = ((addrmap[7] & ROW_MAX_VAL_MASK) ==
> +				ROW_MAX_VAL_MASK) ? 0 : ((addrmap[7] &
> +				ROW_MAX_VAL_MASK) + ROW_B16_BASE);
> +	priv->row_shift[17] = (((addrmap[7] >> 8) & ROW_MAX_VAL_MASK) ==
> +				ROW_MAX_VAL_MASK) ? 0 : (((addrmap[7] >> 8) &
> +				ROW_MAX_VAL_MASK) + ROW_B17_BASE);
> +
> +	priv->col_shift[0] = 0;
> +	priv->col_shift[1] = 1;
> +	priv->col_shift[2] = (addrmap[2] & COL_MAX_VAL_MASK) + COL_B2_BASE;
> +	priv->col_shift[3] = ((addrmap[2] >> 8) &
> +			COL_MAX_VAL_MASK) + COL_B3_BASE;
> +	priv->col_shift[4] = (((addrmap[2] >> 16) & COL_MAX_VAL_MASK) ==
> +			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 16) &
> +					COL_MAX_VAL_MASK) + COL_B4_BASE);
> +	priv->col_shift[5] = (((addrmap[2] >> 24) & COL_MAX_VAL_MASK) ==
> +			COL_MAX_VAL_MASK) ? 0 : (((addrmap[2] >> 24) &
> +					COL_MAX_VAL_MASK) + COL_B5_BASE);
> +	priv->col_shift[6] = ((addrmap[3] & COL_MAX_VAL_MASK) ==
> +			COL_MAX_VAL_MASK) ? 0 : ((addrmap[3] &
> +					COL_MAX_VAL_MASK) + COL_B6_BASE);
> +	priv->col_shift[7] = (((addrmap[3] >> 8) & COL_MAX_VAL_MASK) ==
> +			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 8) &
> +					COL_MAX_VAL_MASK) + COL_B7_BASE);
> +	priv->col_shift[8] = (((addrmap[3] >> 16) & COL_MAX_VAL_MASK) ==
> +			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 16) &
> +					COL_MAX_VAL_MASK) + COL_B8_BASE);
> +	priv->col_shift[9] = (((addrmap[3] >> 24) & COL_MAX_VAL_MASK) ==
> +			COL_MAX_VAL_MASK) ? 0 : (((addrmap[3] >> 24) &
> +					COL_MAX_VAL_MASK) + COL_B9_BASE);
> +	if (width == DDRCTL_EWDTH_64) {
> +		if (memtype & MEM_TYPE_LPDDR3) {
> +			priv->col_shift[10] = ((addrmap[4] &
> +				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
> +				((addrmap[4] & COL_MAX_VAL_MASK) +
> +				 COL_B10_BASE);
> +			priv->col_shift[11] = (((addrmap[4] >> 8) &
> +				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
> +				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
> +				 COL_B11_BASE);
> +		} else {
> +			priv->col_shift[11] = ((addrmap[4] &
> +				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
> +				((addrmap[4] & COL_MAX_VAL_MASK) +
> +				 COL_B10_BASE);
> +			priv->col_shift[13] = (((addrmap[4] >> 8) &
> +				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
> +				(((addrmap[4] >> 8) & COL_MAX_VAL_MASK) +
> +				 COL_B11_BASE);
> +		}
> +	} else if (width == DDRCTL_EWDTH_32) {
> +		if (memtype & MEM_TYPE_LPDDR3) {
> +			priv->col_shift[10] = (((addrmap[3] >> 24) &
> +				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
> +				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
> +				 COL_B9_BASE);
> +			priv->col_shift[11] = ((addrmap[4] &
> +				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
> +				((addrmap[4] & COL_MAX_VAL_MASK) +
> +				 COL_B10_BASE);
> +		} else {
> +			priv->col_shift[11] = (((addrmap[3] >> 24) &
> +				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
> +				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
> +				 COL_B9_BASE);
> +			priv->col_shift[13] = ((addrmap[4] &
> +				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
> +				((addrmap[4] & COL_MAX_VAL_MASK) +
> +				 COL_B10_BASE);
> +		}
> +	} else {
> +		if (memtype & MEM_TYPE_LPDDR3) {
> +			priv->col_shift[10] = (((addrmap[3] >> 16) &
> +				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
> +				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
> +				 COL_B8_BASE);
> +			priv->col_shift[11] = (((addrmap[3] >> 24) &
> +				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
> +				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
> +				 COL_B9_BASE);
> +			priv->col_shift[13] = ((addrmap[4] &
> +				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
> +				((addrmap[4] & COL_MAX_VAL_MASK) +
> +				 COL_B10_BASE);
> +		} else {
> +			priv->col_shift[11] = (((addrmap[3] >> 16) &
> +				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
> +				(((addrmap[3] >> 16) & COL_MAX_VAL_MASK) +
> +				 COL_B8_BASE);
> +			priv->col_shift[13] = (((addrmap[3] >> 24) &
> +				COL_MAX_VAL_MASK) == COL_MAX_VAL_MASK) ? 0 :
> +				(((addrmap[3] >> 24) & COL_MAX_VAL_MASK) +
> +				 COL_B9_BASE);
> +		}
> +	}
> +
> +	if (width) {
> +		for (index = 9; index > width; index--) {
> +			priv->col_shift[index] = priv->col_shift[index - width];
> +			priv->col_shift[index - width] = 0;
> +		}
> +	}
> +
> +	priv->bank_shift[0] = (addrmap[1] & BANK_MAX_VAL_MASK) + BANK_B0_BASE;
> +	priv->bank_shift[1] = ((addrmap[1] >> 8) &
> +				BANK_MAX_VAL_MASK) + BANK_B1_BASE;
> +	priv->bank_shift[2] = (((addrmap[1] >> 16) &
> +				BANK_MAX_VAL_MASK) == BANK_MAX_VAL_MASK) ? 0 :
> +				(((addrmap[1] >> 16) & BANK_MAX_VAL_MASK) +
> +				 BANK_B2_BASE);
> +
> +	priv->bankgrp_shift[0] = (addrmap[8] &
> +				BANKGRP_MAX_VAL_MASK) + BANKGRP_B0_BASE;
> +	priv->bankgrp_shift[1] = (((addrmap[8] >> 8) & BANKGRP_MAX_VAL_MASK) ==
> +				BANKGRP_MAX_VAL_MASK) ? 0 : (((addrmap[8] >> 8)
> +				& BANKGRP_MAX_VAL_MASK) + BANKGRP_B1_BASE);
> +
> +	priv->rank_shift[0] = ((addrmap[0] & RANK_MAX_VAL_MASK) ==
> +				RANK_MAX_VAL_MASK) ? 0 : ((addrmap[0] &
> +				RANK_MAX_VAL_MASK) + RANK_B0_BASE);
> +}

The assignments in that whole function are really unreadable. You could
define macros maybe and hide all the details in them as the assignments
look pretty regular...

> +
>  /**
>   * synps_edac_mc_probe - Check controller and bind driver
>   * @pdev:	Pointer to the platform_device struct
> @@ -480,7 +1268,7 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  	struct mem_ctl_info *mci;
>  	struct edac_mc_layer layers[2];
>  	struct synps_edac_priv *priv;
> -	int rc;
> +	int rc, irq, status;
>  	struct resource *res;
>  	void __iomem *baseaddr;
>  	const struct of_device_id *match;
> @@ -529,6 +1317,27 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  		goto free_edac_mc;
>  	}
>  
> +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT) {
> +		irq = platform_get_irq(pdev, 0);
> +		if (irq < 0) {
> +			edac_printk(KERN_ERR, EDAC_MC,
> +					"No irq %d in DT\n", irq);
> +			return -ENODEV;

			goto free_edac_mc;

otherwise you leak memory.

> +		}
> +
> +		status = devm_request_irq(&pdev->dev, irq,
> +			synps_edac_intr_handler,
> +			0, dev_name(&pdev->dev), mci);
> +		if (status < 0) {
> +			edac_printk(KERN_ERR, EDAC_MC, "Failed to request Irq\n");
> +			goto free_edac_mc;
> +		}
> +
> +		/* Enable UE/CE Interrupts */
> +		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
> +			priv->baseaddr + DDR_QOS_IRQ_EN_OFST);
> +	}
> +
>  	rc = edac_mc_add_mc(mci);
>  	if (rc) {
>  		edac_printk(KERN_ERR, EDAC_MC,
> @@ -536,11 +1345,24 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  		goto free_edac_mc;
>  	}
>  
> +	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT) {
> +		if (synps_edac_create_sysfs_attributes(mci)) {
> +			edac_printk(KERN_ERR, EDAC_MC,
> +					"Failed to create sysfs entries\n");
> +			goto free_edac_mc;
> +		}
> +	}
> +
> +	if (of_device_is_compatible(pdev->dev.of_node,
> +				    "xlnx,zynqmp-ddrc-2.40a"))
> +		setup_address_map(priv);
> +
>  	/*
>  	 * Start capturing the correctable and uncorrectable errors. A write of
>  	 * 0 starts the counters.
>  	 */
> -	writel(0x0, baseaddr + ECC_CTRL_OFST);
> +	if (!(priv->p_data->quirks & DDR_ECC_INTR_SUPPORT))
> +		writel(0x0, baseaddr + ECC_CTRL_OFST);
>  	return rc;
>  
>  free_edac_mc:
> @@ -558,8 +1380,16 @@ static int synps_edac_mc_probe(struct platform_device *pdev)
>  static int synps_edac_mc_remove(struct platform_device *pdev)
>  {
>  	struct mem_ctl_info *mci = platform_get_drvdata(pdev);
> +	struct synps_edac_priv *priv;
>  
> +	priv = mci->pvt_info;
> +	if (priv->p_data->quirks & DDR_ECC_INTR_SUPPORT)
> +		/* Disable UE/CE Interrupts */
> +		writel((DDR_QOSUE_MASK | DDR_QOSCE_MASK),
> +			priv->baseaddr + DDR_QOS_IRQ_DB_OFST);
>  	edac_mc_del_mc(&pdev->dev);
> +	if (priv->p_data->quirks & DDR_ECC_DATA_POISON_SUPPORT)
> +		synps_edac_remove_sysfs_attributes(mci);
>  	edac_mc_free(mci);
>  
>  	return 0;
> -- 
> 2.1.1
> 
> 

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--

