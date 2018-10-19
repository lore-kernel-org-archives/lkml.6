Return-Path: <SRS0=xTli=M7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 772FAECDE3D
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CB5D21476
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Oct 2018 07:29:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CB5D21476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbeJSPeQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Oct 2018 11:34:16 -0400
Received: from mail-sz2.amlogic.com ([211.162.65.114]:23115 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726340AbeJSPeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Oct 2018 11:34:15 -0400
Received: from [10.28.18.51] (10.28.18.51) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Fri, 19 Oct
 2018 15:29:13 +0800
Subject: Re: [PATCH v5 2/2] mtd: rawnand: meson: add support for Amlogic NAND
 flash controller
To:     Boris Brezillon <boris.brezillon@bootlin.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>
CC:     <linux-mtd@lists.infradead.org>, Yixun Lan <yixun.lan@amlogic.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        Marek Vasut <marek.vasut@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh@kernel.org>, Jian Hu <jian.hu@amlogic.com>,
        Hanjie Lin <hanjie.lin@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <1539839345-14021-1-git-send-email-jianxin.pan@amlogic.com>
 <1539839345-14021-3-git-send-email-jianxin.pan@amlogic.com>
 <20181018162449.3fe433e7@bbrezillon>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <30ceed2f-03a2-8e4c-b267-df14d052f13d@amlogic.com>
Date:   Fri, 19 Oct 2018 15:29:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181018162449.3fe433e7@bbrezillon>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.51]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2018/10/18 22:24, Boris Brezillon wrote:
> On Thu, 18 Oct 2018 13:09:05 +0800
> Jianxin Pan <jianxin.pan@amlogic.com> wrote:
> 
>> +static int meson_nfc_exec_op(struct nand_chip *chip,
>> +			     const struct nand_operation *op, bool check_only)
>> +{
>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>> +	struct meson_nfc *nfc = nand_get_controller_data(chip);
>> +	const struct nand_op_instr *instr = NULL;
>> +	int ret = 0, cmd;
>> +	unsigned int op_id;
>> +	int i;
>> +
>> +	for (op_id = 0; op_id < op->ninstrs; op_id++) {
>> +		instr = &op->instrs[op_id];
>> +		switch (instr->type) {
>> +		case NAND_OP_CMD_INSTR:
>> +			if (instr->ctx.cmd.opcode == NAND_CMD_STATUS)
>> +				meson_nfc_cmd_idle(nfc, nfc->timing.twb);
> 
> Hm, I don't want drivers to base their decisions on the opcode value.
> There's a ->delay_ns field in the instruction object, can't you use
> that one instead? Also, I don't understand why this is only needed for
> the STATUS command. It should normally be applied to all instructions.
> 
em, it should be applied to all instructions.
i will fix it and use instr->delay_ns instead.

>> +			cmd = nfc->param.chip_select | NFC_CMD_CLE;
>> +			cmd |= instr->ctx.cmd.opcode & 0xff;
>> +			writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +			if (instr->ctx.cmd.opcode == NAND_CMD_STATUS)
>> +				meson_nfc_cmd_idle(nfc, nfc->timing.twhr);
>> +			break;
>> +
>> +		case NAND_OP_ADDR_INSTR:
>> +			for (i = 0; i < instr->ctx.addr.naddrs; i++) {
>> +				cmd = nfc->param.chip_select | NFC_CMD_ALE;
>> +				cmd |= instr->ctx.addr.addrs[i] & 0xff;
>> +				writel(cmd, nfc->reg_base + NFC_REG_CMD);
>> +			}
>> +			break;
>> +
>> +		case NAND_OP_DATA_IN_INSTR:
>> +			meson_nfc_read_buf(mtd, instr->ctx.data.buf.in,
>> +					   instr->ctx.data.len);
>> +			break;
>> +
>> +		case NAND_OP_DATA_OUT_INSTR:
>> +			meson_nfc_write_buf(mtd, instr->ctx.data.buf.out,
>> +					    instr->ctx.data.len);
>> +			break;
>> +
>> +		case NAND_OP_WAITRDY_INSTR:
>> +			meson_nfc_queue_rb(nfc, instr->ctx.waitrdy.timeout_ms);
>> +			break;
>> +		}
>> +	}
>> +	return ret;
>> +}
> 
> .
> 
