Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B78C4321D
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 518B32150F
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 14:08:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 518B32150F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amlogic.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbeHVRdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 13:33:38 -0400
Received: from mail-sz2.amlogic.com ([211.162.65.114]:55559 "EHLO
        mail-sz2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728197AbeHVRdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 13:33:38 -0400
Received: from [10.28.18.196] (10.28.18.196) by mail-sz2.amlogic.com
 (10.28.11.6) with Microsoft SMTP Server (TLS) id 15.0.1320.4; Wed, 22 Aug
 2018 22:08:42 +0800
Subject: Re: [RFC PATCH v2 2/2] mtd: rawnand: meson: add support for Amlogic
 NAND flash controller
To:     Boris Brezillon <boris.brezillon@bootlin.com>
CC:     Yixun Lan <yixun.lan@amlogic.com>, <linux-mtd@lists.infradead.org>,
        Rob Herring <robh@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Richard Weinberger <richard@nod.at>,
        <linux-kernel@vger.kernel.org>,
        Marek Vasut <marek.vasut@gmail.com>,
        Jian Hu <jian.hu@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Carlo Caione <carlo@caione.org>,
        <linux-amlogic@lists.infradead.org>,
        Brian Norris <computersforpeace@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Jerome Brunet <jbrunet@baylibre.com>
References: <20180719094612.5833-1-yixun.lan@amlogic.com>
 <20180719094612.5833-3-yixun.lan@amlogic.com>
 <20180801235045.5b4d8211@bbrezillon>
 <42877a0d-9830-0626-3f64-e49a326eaa3c@amlogic.com>
 <20180817155608.5929b37a@bbrezillon>
From:   Liang Yang <liang.yang@amlogic.com>
Message-ID: <96e538a5-1232-11f2-8b9e-5ddb09dcc2de@amlogic.com>
Date:   Wed, 22 Aug 2018 22:08:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180817155608.5929b37a@bbrezillon>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.28.18.196]
X-ClientProxiedBy: mail-sz2.amlogic.com (10.28.11.6) To mail-sz2.amlogic.com
 (10.28.11.6)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Boris,

There is a question below. please see my comments.

Thanks.

On 8/17/2018 9:56 PM, Boris Brezillon wrote:
> On Fri, 17 Aug 2018 21:03:59 +0800
> Liang Yang <liang.yang@amlogic.com> wrote:
> 
>> Hi Boris,
>> On 2018/8/2 5:50, Boris Brezillon wrote:
>>
>>> Hi Yixun,
>>>
>>> On Thu, 19 Jul 2018 17:46:12 +0800
>>> Yixun Lan <yixun.lan@amlogic.com> wrote:
>>>
>>> I haven't finished reviewing the driver yet (I'll try to do that later
>>> this week), but I already pointed a few things to fix/improve.
>>>   
>>>> +
>>>> +static int meson_nfc_exec_op(struct nand_chip *chip,
>>>> +			     const struct nand_operation *op, bool check_only)
>>>> +{
>>>> +	struct mtd_info *mtd = nand_to_mtd(chip);
>>>> +	struct meson_nfc *nfc = nand_get_controller_data(chip);
>>>> +	const struct nand_op_instr *instr = NULL;
>>>> +	int ret = 0, cmd;
>>>> +	unsigned int op_id;
>>>> +	int i;
>>>> +
>>>> +	for (op_id = 0; op_id < op->ninstrs; op_id++) {
>>>> +		instr = &op->instrs[op_id];
>>>> +		switch (instr->type) {
>>>> +		case NAND_OP_CMD_INSTR:
>>>> +			cmd = nfc->param.chip_select | NFC_CMD_CLE;
>>>> +			cmd |= instr->ctx.cmd.opcode & 0xff;
>>>> +			writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>> +			meson_nfc_cmd_idle(nfc, NAND_TWB_TIME_CYCLE);
>>
>>>> +			meson_nfc_drain_cmd(nfc);
>>> I don't know exactly how the NAND controller works, but it's usually
>>>> +			break;
>>>> +
>>>> +		case NAND_OP_ADDR_INSTR:
>>>> +			for (i = 0; i < instr->ctx.addr.naddrs; i++) {
>>>> +				cmd = nfc->param.chip_select | NFC_CMD_ALE;
>>>> +				cmd |= instr->ctx.addr.addrs[i] & 0xff;
>>>> +				writel(cmd, nfc->reg_base + NFC_REG_CMD);
>>>> +			}
>>>> +			break;
>>>> +
>>>> +		case NAND_OP_DATA_IN_INSTR:
>>>> +			meson_nfc_read_buf(mtd, instr->ctx.data.buf.in,
>>>> +					   instr->ctx.data.len);
>>>> +			break;
>>>> +
>>>> +		case NAND_OP_DATA_OUT_INSTR:
>>>> +			meson_nfc_write_buf(mtd, instr->ctx.data.buf.out,
>>>> +					    instr->ctx.data.len);
> 
>>
>>>> +			break;
>>>> +
>>>> +		case NAND_OP_WAITRDY_INSTR:
>>>> +			mdelay(instr->ctx.waitrdy.timeout_ms);
>>>> +			ret = nand_soft_waitrdy(chip,
>>>> +						instr->ctx.waitrdy.timeout_ms);
>>> Hm, i'd be surprised if the controller does not have a way to optimize
>>> waits on R/B transitions.
>>
>> When i delete the delay here, erasing operation will be failed.
>> Does it mean NFC send 0x70 to nand device when rb is busy(low)?
> 
> I was not even talking about the delay, but yes, mdelay() seems way too
> big. Remember that it's a timeout, and you usually don't have to wait
> that much. You can do ndelay(instr->ctx.delay_ns) before calling
> nand_soft_waitrdy() to make sure tWB is enforced.
> 
> Anyway, that's not what I was initially referring to. What I meant is
> that nand_soft_waitrdy() should be replaced by native R/B pin or status
> polling wait logic so that the CPU is released while waiting for a R/B
> transition.
> 
>> If so, i will ask our NFC designer for comfirmation or grasping the waveform.
> 
> You have to wait tWB, that's for sure.
> 
we have a maximum 32 commands fifo. when command is written into 
NFC_REG_CMD, it doesn't mean that command is executing right now, maybe 
it is buffering on the queue.Assume one ERASE operation, when 2nd 
command(0xd0) is written into NFC_REG_CMD and then come into 
NAND_OP_WAITRDY_INSTR, if I read the RB status by register, it may be 
wrong because 0xd0 may not being executed. it is unusual unless 
buffering two many command.
so it seems that i still need to use nand_soft_waitrdy or wait cmd is 
executed somewhere.
>>
> 
