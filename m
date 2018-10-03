Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87E89C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4076021470
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 19:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4076021470
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbeJDCgi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 22:36:38 -0400
Received: from mail.bootlin.com ([62.4.15.54]:48623 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbeJDCgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 22:36:37 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id B731A207C8; Wed,  3 Oct 2018 21:46:47 +0200 (CEST)
Received: from bbrezillon (91-160-177-164.subs.proxad.net [91.160.177.164])
        by mail.bootlin.com (Postfix) with ESMTPSA id 6844B20618;
        Wed,  3 Oct 2018 21:46:35 +0200 (CEST)
Date:   Wed, 3 Oct 2018 21:46:33 +0200
From:   Boris Brezillon <boris.brezillon@bootlin.com>
To:     Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
Cc:     <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <dwmw2@infradead.org>, <computersforpeace@gmail.com>,
        <marek.vasut@gmail.com>, michals@xilinx.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        nagasuresh12@gmail.com
Subject: Re: [LINUX PATCH v11 3/3] mtd: rawnand: arasan: Add support for
 Arasan NAND Flash Controller
Message-ID: <20181003214633.54e93c00@bbrezillon>
In-Reply-To: <1537878031-22253-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
References: <1537878031-22253-1-git-send-email-naga.sureshkumar.relli@xilinx.com>
        <1537878031-22253-4-git-send-email-naga.sureshkumar.relli@xilinx.com>
X-Mailer: Claws Mail 3.15.0-dirty (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Sep 2018 17:50:31 +0530
Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com> wrote:

> +static int anfc_zero_len_page_write_type_exec(struct nand_chip *chip,
> +					      const struct nand_subop *subop)
> +{
> +	const struct nand_op_instr *instr;
> +	struct anfc_nand_chip *achip = to_anfc_nand(chip);
> +	struct anfc_nand_controller *nfc = to_anfc(chip->controller);
> +	unsigned int op_id;
> +	struct anfc_op nfc_op = {};
> +	struct mtd_info *mtd = nand_to_mtd(chip);
> +	u32 addrcycles;
> +
> +	anfc_parse_instructions(chip, subop, &nfc_op);
> +	nfc->prog = PROG_PGRD;
> +	instr = nfc_op.data_instr;
> +	op_id = nfc_op.data_instr_idx;
> +
> +	addrcycles = achip->raddr_cycles + achip->caddr_cycles;
> +
> +	anfc_prepare_cmd(nfc, nfc_op.cmds[0], NAND_CMD_PAGEPROG, 1,

Why are the second opcode and the number of address cycles hardcoded.
That's simply not future-proof, and I don't want that. Also, I don't
understand why you do that, you have all the information you need in
subop and you keep guessing some parameters.

> +			 mtd->writesize, addrcycles);
> +	anfc_setpagecoladdr(nfc, nfc_op.row, nfc_op.col);
> +
> +	return 0;
> +}
