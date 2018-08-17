Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF14AC4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:59:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 800F621A1D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 17:59:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 800F621A1D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbeHQVDh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 17:03:37 -0400
Received: from mail.bootlin.com ([62.4.15.54]:57584 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727160AbeHQVDh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 17:03:37 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id E7F9E215D2; Fri, 17 Aug 2018 19:59:14 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 828BF20763;
        Fri, 17 Aug 2018 19:59:04 +0200 (CEST)
Date:   Fri, 17 Aug 2018 19:59:03 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, <kyungmin.park@samsung.com>,
        <absahu@codeaurora.org>, <peterpandong@micron.com>,
        <frieder.schrempf@exceet.de>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <michals@xilinx.com>,
        <nagasureshkumarrelli@gmail.com>
Subject: Re: [LINUX PATCH v10 2/2] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20180817195903.49963b25@bbrezillon>
In-Reply-To: <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1534511964-20342-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1534511964-20342-3-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Naga,

On Fri, 17 Aug 2018 18:49:24 +0530
Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:

> +static int anfc_exec_op_cmd(struct nand_chip *chip,
> +				   const struct nand_subop *subop)
> +{
> +	const struct nand_op_instr *instr;
> +	struct anfc_op nfc_op = {};
> +	struct anfc_nand_chip *achip = to_anfc_nand(chip);
> +	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	u32 addrcycles;
> +	unsigned int op_id, len = 0;
> +	bool reading;
> +
> +	anfc_parse_instructions(chip, subop, &nfc_op);
> +	instr = nfc_op.data_instr;
> +	op_id = nfc_op.data_instr_idx;
> +	if (nfc_op.data_instr)
> +		len = nand_subop_get_data_len(subop, op_id);
> +
> +	/*
> +	 * The switch case is to prepare a command and to set page/column
> +	 * address. Arasan NAND controller has program register(Off: 0x10)),
> +	 * which needs to be set for every command.
> +	 * Ex: When NAND_CMD_RESET is issued, then we need to set reset bit
> +	 * in program_register. etc..
> +	 */
> +	switch (nfc_op.cmnds[0]) {
> +	case NAND_CMD_SEQIN:
> +		addrcycles = achip->raddr_cycles + achip->caddr_cycles;
> +
> +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], NAND_CMD_PAGEPROG, 1,
> +				 mtd->writesize, addrcycles);
> +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> +		break;
> +	case NAND_CMD_READOOB:
> +		nfc_op.col += mtd->writesize;
> +	case NAND_CMD_READ0:
> +	case NAND_CMD_READ1:
> +		addrcycles = achip->raddr_cycles + achip->caddr_cycles;
> +		anfc_prepare_cmd(nfc, NAND_CMD_READ0, NAND_CMD_READSTART, 1,
> +				 mtd->writesize, addrcycles);
> +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> +		if (!nfc_op.data_instr)
> +			return 0;
> +
> +		anfc_read_data_op(mtd, instr->ctx.data.buf.in, len);
> +		break;
> +	case NAND_CMD_RNDOUT:
> +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], NAND_CMD_RNDOUTSTART, 1,
> +				 mtd->writesize, 2);
> +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> +		nfc->prog = PROG_PGRD;
> +		break;
> +	case NAND_CMD_PARAM:
> +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 1);
> +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> +		nfc->prog = PROG_RDPARAM;
> +		break;
> +	case NAND_CMD_READID:
> +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 1);
> +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> +		nfc->prog = PROG_RDID;
> +		break;
> +	case NAND_CMD_GET_FEATURES:
> +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 1);
> +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> +		nfc->prog = PROG_GET_FEATURE;
> +		break;
> +	case NAND_CMD_SET_FEATURES:
> +		anfc_prepare_cmd(nfc, nfc_op.cmnds[0], 0, 0, 0, 1);
> +		anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> +		nfc->prog = PROG_SET_FEATURE;
> +		break;
> +	case NAND_CMD_ERASE1:
> +		anfc_erase_function(chip, nfc_op);
> +		break;
> +	default:
> +		break;
> +	}

Looks like you have one of these smart controllers where everything is
hardcoded and new commands (like vendor specific commands) can't be
supported, and we're back to abusing ->exec_op(), just like ->cmdfunc()
was abused.

Don't you have a way to send raw CMD/ADDR/DATA cycles? If not, then
we'll have to consider other options, because I don't want to go back
to the situation we are in with ->cmdfunc().

Maybe I already asked, but is there a public spec for this IP?

Thanks,

Boris
