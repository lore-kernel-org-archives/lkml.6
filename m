Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FE66C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1342B20862
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 12:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1342B20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730734AbeKFVa0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 16:30:26 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:56335 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726976AbeKFVa0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 16:30:26 -0500
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 1F05C3BCD9377;
        Tue,  6 Nov 2018 20:05:30 +0800 (CST)
Received: from [127.0.0.1] (10.177.21.79) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.408.0; Tue, 6 Nov 2018
 20:05:24 +0800
To:     <stable@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        "Leizhen (ThunderTown, Euler)" <thunder.leizhen@huawei.com>,
        "Libin (Huawei)" <huawei.libin@huawei.com>
From:   Tan Xiaojun <tanxiaojun@huawei.com>
Subject: [Question] A UBSAN problem in stable-4.4
Message-ID: <5BE18383.9040806@huawei.com>
Date:   Tue, 6 Nov 2018 20:05:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.21.79]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, all,

I found the following problem (attached to the end) when testing stable-4.4 with
Syzkaller. This is not an easy-to-trigger problem, so the tool does not generate
code for recurring problems.

From the call stack, it is because the first parameter in ktime_sub is large, and
the second parameter offset is a negative number, causing the final result to
overflow into the sign bit and become a large negative number.

--------------
...
ktime_t expires = ktime_sub(hrtimer_get_expires(timer), base->offset);
...
--------------

But I don't know how to fix this problem. The mainline code is also different from
stable-4.4, and I have not found a patch to fix this problem in the mainline
repository.

So I am a bit confused about how to fix it. Can anyone give me some advice?

Thanks.
Xiaojun.

================================================================================
UBSAN: Undefined behaviour in kernel/time/hrtimer.c:615:20
signed integer overflow:
9223372036854775807 - -495588161 cannot be represented in type 'long long int'
CPU: 0 PID: 4542 Comm: syz-executor0 Not tainted 4.4.156-514.55.6.9.x86_64+ #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
 1ffff100391dbf45 ad071d3307b76e03 ffff8801c8edfab0 ffffffff81c9f586
 0000000041b58ab3 ffffffff831fd4e6 ffffffff81c9f478 ffff8801c8edfad8
 ffff8801c8edfa78 00000000000014a9 ad071d3307b76e03 ffffffff837fd660
Call Trace:
 [<ffffffff81c9f586>] __dump_stack lib/dump_stack.c:15 [inline]
 [<ffffffff81c9f586>] dump_stack+0x10e/0x1a8 lib/dump_stack.c:51
 [<ffffffff81d814a6>] ubsan_epilogue+0x12/0x8f lib/ubsan.c:164
 [<ffffffff81d830a1>] handle_overflow+0x23e/0x299 lib/ubsan.c:195
 [<ffffffff81d83157>] __ubsan_handle_sub_overflow+0x2a/0x31 lib/ubsan.c:211
 [<ffffffff813d8c33>] hrtimer_reprogram kernel/time/hrtimer.c:615 [inline]
 [<ffffffff813d8c33>] hrtimer_start_range_ns+0x1083/0x1580 kernel/time/hrtimer.c:1024
 [<ffffffff813fde1f>] hrtimer_start include/linux/hrtimer.h:393 [inline]
 [<ffffffff813fde1f>] alarm_start+0xcf/0x130 kernel/time/alarmtimer.c:328
 [<ffffffff813fed66>] alarm_timer_set+0x296/0x4a0 kernel/time/alarmtimer.c:632
 [<ffffffff813e1a3e>] SYSC_timer_settime kernel/time/posix-timers.c:914 [inline]
 [<ffffffff813e1a3e>] SyS_timer_settime+0x2be/0x3d0 kernel/time/posix-timers.c:885
 [<ffffffff82c2fb61>] entry_SYSCALL_64_fastpath+0x1e/0x9e
================================================================================
================================================================================
UBSAN: Undefined behaviour in kernel/time/hrtimer.c:490:13
signed integer overflow:
9223372036854775807 - -495588161 cannot be represented in type 'long long int'
CPU: 0 PID: 4542 Comm: syz-executor0 Not tainted 4.4.156-514.55.6.9.x86_64+ #8
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.9.3-0-ge2fc41e-prebuilt.qemu-project.org 04/01/2014
 1ffff1003ed40f8b ad071d3307b76e03 ffff8801f6a07ce0 ffffffff81c9f586
 0000000041b58ab3 ffffffff831fd4e6 ffffffff81c9f478 ffff8801f6a07d08
 ffff8801f6a07ca8 000000000000000a ad071d3307b76e03 ffffffff837fd660
Call Trace:
 <IRQ>  [<ffffffff81c9f586>] __dump_stack lib/dump_stack.c:15 [inline]
 <IRQ>  [<ffffffff81c9f586>] dump_stack+0x10e/0x1a8 lib/dump_stack.c:51
 [<ffffffff81d814a6>] ubsan_epilogue+0x12/0x8f lib/ubsan.c:164
 [<ffffffff81d830a1>] handle_overflow+0x23e/0x299 lib/ubsan.c:195
 [<ffffffff81d83157>] __ubsan_handle_sub_overflow+0x2a/0x31 lib/ubsan.c:211
 [<ffffffff813d43ea>] __hrtimer_get_next_event+0x1da/0x2b0 kernel/time/hrtimer.c:490
 [<ffffffff813d9532>] hrtimer_interrupt+0x202/0x580 kernel/time/hrtimer.c:1361
 [<ffffffff8113e7ad>] local_apic_timer_interrupt+0x9d/0x150 arch/x86/kernel/apic/apic.c:901
 [<ffffffff82c32ea0>] smp_apic_timer_interrupt+0x80/0xb0 arch/x86/kernel/apic/apic.c:925
 [<ffffffff82c30ac5>] apic_timer_interrupt+0xa5/0xb0 arch/x86/entry/entry_64.S:563
 <EOI>  [<ffffffff82c2f0fb>] ? arch_local_irq_restore arch/x86/include/asm/paravirt.h:812 [inline]
 <EOI>  [<ffffffff82c2f0fb>] ? __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:162 [inline]
 <EOI>  [<ffffffff82c2f0fb>] ? _raw_spin_unlock_irqrestore+0x3b/0x60 kernel/locking/spinlock.c:191
 [<ffffffff813e1a4f>] unlock_timer include/linux/spinlock.h:362 [inline]
 [<ffffffff813e1a4f>] SYSC_timer_settime kernel/time/posix-timers.c:916 [inline]
 [<ffffffff813e1a4f>] SyS_timer_settime+0x2cf/0x3d0 kernel/time/posix-timers.c:885
 [<ffffffff82c2fb61>] entry_SYSCALL_64_fastpath+0x1e/0x9e
================================================================================




