Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933482AbeBVRVb (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 12:21:31 -0500
Received: from smtprelay2.synopsys.com ([198.182.60.111]:42901 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933210AbeBVRVa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 12:21:30 -0500
Subject: Re: [BUG] ARCv2: MCIP: GFRC: mcip cmd/readback concurrency
To: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
References: <1519309604.2982.27.camel@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Message-ID: <cb771978-00a6-2243-ba7e-8517644a3101@synopsys.com>
Date: Thu, 22 Feb 2018 09:21:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519309604.2982.27.camel@synopsys.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.10.161.84]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/22/2018 06:26 AM, Eugeniy Paltsev wrote:
> To read any data from ARconnect we have special interface
> which includes two AUX registers: MCIP_CMD and MCIP_READBACK.
> We write command to MCIP_CMD and read data from MCIP_READBACK
> after that.
>
> We have only one instance of this registers per cluster, so we need
> to held global lock before access them. This lock is defined
> in arch/arc/kernel/mcip.c
>
>
> To read GFRC value we also use MCIP_CMD/MCIP_READBACK pair, but
> we take only local lock instead of global 'mcip_lock' lock:

This was not an omission but on purpose given the hardware is designed that way. 
We obviously want to avoid the spinlock when possible specially when everyone is 
only reading it and timer readout needs to be super fast. Thing is each core has a 
"private snapshot" of internal counter. So the READ_H* cmd read their own 
snapshots, without need for serializing globally. We do however want a consistent 
LO-HI - hence the need to disable local interrupts around.

> ---------->[drivers/clocksource/arc_timer.c]<----------
> static u64 arc_read_gfrc(struct clocksource *cs)
> {
> 	unsigned long flags;
> 	u32 l, h;
>
> 	local_irq_save(flags);
>
> 	__mcip_cmd(CMD_GFRC_READ_LO, 0);
> 	l = read_aux_reg(ARC_REG_MCIP_READBACK);
>
> 	__mcip_cmd(CMD_GFRC_READ_HI, 0);
> 	h = read_aux_reg(ARC_REG_MCIP_READBACK);
>
> 	local_irq_restore(flags);
>
> 	return (((u64)h) << 32) | l;
> }
> -------------------------->8---------------------------
>
> So we can break any command (like inter core interrupt send)
> which uses MCIP_CMD/MCIP_READBACK pair when we read time from GFRC.
>
> One possible solution is to create function like gfrc_read() in mcip.c
> which will use global 'mcip_lock' and call it from current 'arc_read_gfrc'
> function.
>
> Or we can create a wrapper like 'mcip_read' in arch/arc/kernel/mcip.c
> with next functionality:
> ------->8--------
> u32 mcip_read(u32 cmd)
> {
> 	u32 ret;
>
> 	raw_spin_lock_irqsave(&mcip_lock);
>
> 	__mcip_cmd(cmd, 0);
> 	ret = read_aux_reg(ARC_REG_MCIP_READBACK);
>
> 	raw_spin_unlock_irqrestore(&mcip_lock);
>
> 	return ret;
> }
> ------->8--------

This is a good idea in general. Mind you however that all use cases are different 
- as in we do multiple things not juct cmd + readback. e.g. for GFRC halt progrog 
we do cmd + readback + cmd. but see if you can come up with something reasonable 
to encapsulate the spin lock.
