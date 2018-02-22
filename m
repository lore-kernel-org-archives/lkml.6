Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932889AbeBVO0v (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:26:51 -0500
Received: from smtprelay.synopsys.com ([198.182.47.9]:40835 "EHLO
        smtprelay.synopsys.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932726AbeBVO0s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:26:48 -0500
From: Eugeniy Paltsev <Eugeniy.Paltsev@synopsys.com>
To: Vineet Gupta <Vineet.Gupta1@synopsys.com>,
        "linux-snps-arc@lists.infradead.org"
        <linux-snps-arc@lists.infradead.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexey Brodkin" <Alexey.Brodkin@synopsys.com>
Subject: [BUG] ARCv2: MCIP: GFRC: mcip cmd/readback concurrency
Thread-Topic: [BUG] ARCv2: MCIP: GFRC: mcip cmd/readback concurrency
Thread-Index: AQHTq+kqpL2oAa7DC0yw5+SmDRy3Nw==
Date: Thu, 22 Feb 2018 14:26:44 +0000
Message-ID: <1519309604.2982.27.camel@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.121.3.43]
Content-Type: text/plain; charset="utf-8"
Content-ID: <54992489DC61334FA9DC8672D2BBD554@internal.synopsys.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1MEQuU0017102

To read any data from ARconnect we have special interface
which includes two AUX registers: MCIP_CMD and MCIP_READBACK.
We write command to MCIP_CMD and read data from MCIP_READBACK
after that.

We have only one instance of this registers per cluster, so we need
to held global lock before access them. This lock is defined
in arch/arc/kernel/mcip.c


To read GFRC value we also use MCIP_CMD/MCIP_READBACK pair, but 
we take only local lock instead of global 'mcip_lock' lock:

---------->[drivers/clocksource/arc_timer.c]<----------
static u64 arc_read_gfrc(struct clocksource *cs)
{
	unsigned long flags;
	u32 l, h;

	local_irq_save(flags);

	__mcip_cmd(CMD_GFRC_READ_LO, 0);
	l = read_aux_reg(ARC_REG_MCIP_READBACK);

	__mcip_cmd(CMD_GFRC_READ_HI, 0);
	h = read_aux_reg(ARC_REG_MCIP_READBACK);

	local_irq_restore(flags);

	return (((u64)h) << 32) | l;
}
-------------------------->8---------------------------

So we can break any command (like inter core interrupt send)
which uses MCIP_CMD/MCIP_READBACK pair when we read time from GFRC. 

One possible solution is to create function like gfrc_read() in mcip.c
which will use global 'mcip_lock' and call it from current 'arc_read_gfrc'
function.

Or we can create a wrapper like 'mcip_read' in arch/arc/kernel/mcip.c
with next functionality:
------->8--------
u32 mcip_read(u32 cmd)
{
	u32 ret;

	raw_spin_lock_irqsave(&mcip_lock);

	__mcip_cmd(cmd, 0);
	ret = read_aux_reg(ARC_REG_MCIP_READBACK);

	raw_spin_unlock_irqrestore(&mcip_lock);

	return ret;
}
------->8--------

-- 
 Eugeniy Paltsev
