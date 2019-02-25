Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CC0C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:27:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB6932087C
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 09:27:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726532AbfBYJ1y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 04:27:54 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:4728 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726376AbfBYJ1y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 04:27:54 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 2142E186CC5E624FC61F;
        Mon, 25 Feb 2019 17:27:52 +0800 (CST)
Received: from localhost (10.177.31.96) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.408.0; Mon, 25 Feb 2019
 17:27:42 +0800
From:   Yue Haibing <yuehaibing@huawei.com>
To:     <steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>,
        <davem@davemloft.net>
CC:     <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] xfrm: correctly check policy index in verify_newpolicy_info
Date:   Mon, 25 Feb 2019 17:27:04 +0800
Message-ID: <20190225092704.26796-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>

UBSAN report this:

UBSAN: Undefined behaviour in net/xfrm/xfrm_policy.c:1289:24
index 6 is out of range for type 'unsigned int [6]'
CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.4.162-514.55.6.9.x86_64+ #13
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
 0000000000000000 1466cf39b41b23c9 ffff8801f6b07a58 ffffffff81cb35f4
 0000000041b58ab3 ffffffff83230f9c ffffffff81cb34e0 ffff8801f6b07a80
 ffff8801f6b07a20 1466cf39b41b23c9 ffffffff851706e0 ffff8801f6b07ae8
Call Trace:
 <IRQ>  [<ffffffff81cb35f4>] __dump_stack lib/dump_stack.c:15 [inline]
 <IRQ>  [<ffffffff81cb35f4>] dump_stack+0x114/0x1a0 lib/dump_stack.c:51
 [<ffffffff81d94225>] ubsan_epilogue+0x12/0x8f lib/ubsan.c:164
 [<ffffffff81d954db>] __ubsan_handle_out_of_bounds+0x16e/0x1b2 lib/ubsan.c:382
 [<ffffffff82a25acd>] __xfrm_policy_unlink+0x3dd/0x5b0 net/xfrm/xfrm_policy.c:1289
 [<ffffffff82a2e572>] xfrm_policy_delete+0x52/0xb0 net/xfrm/xfrm_policy.c:1309
 [<ffffffff82a3319b>] xfrm_policy_timer+0x30b/0x590 net/xfrm/xfrm_policy.c:243
 [<ffffffff813d3927>] call_timer_fn+0x237/0x990 kernel/time/timer.c:1144
 [<ffffffff813d8e7e>] __run_timers kernel/time/timer.c:1218 [inline]
 [<ffffffff813d8e7e>] run_timer_softirq+0x6ce/0xb80 kernel/time/timer.c:1401
 [<ffffffff8120d6f9>] __do_softirq+0x299/0xe10 kernel/softirq.c:273
 [<ffffffff8120e676>] invoke_softirq kernel/softirq.c:350 [inline]
 [<ffffffff8120e676>] irq_exit+0x216/0x2c0 kernel/softirq.c:391
 [<ffffffff82c5edab>] exiting_irq arch/x86/include/asm/apic.h:652 [inline]
 [<ffffffff82c5edab>] smp_apic_timer_interrupt+0x8b/0xc0 arch/x86/kernel/apic/apic.c:926
 [<ffffffff82c5c985>] apic_timer_interrupt+0xa5/0xb0 arch/x86/entry/entry_64.S:735
 <EOI>  [<ffffffff81188096>] ? native_safe_halt+0x6/0x10 arch/x86/include/asm/irqflags.h:52
 [<ffffffff810834d7>] arch_safe_halt arch/x86/include/asm/paravirt.h:111 [inline]
 [<ffffffff810834d7>] default_idle+0x27/0x430 arch/x86/kernel/process.c:446
 [<ffffffff81085f05>] arch_cpu_idle+0x15/0x20 arch/x86/kernel/process.c:437
 [<ffffffff8132abc3>] default_idle_call+0x53/0x90 kernel/sched/idle.c:92
 [<ffffffff8132b32d>] cpuidle_idle_call kernel/sched/idle.c:156 [inline]
 [<ffffffff8132b32d>] cpu_idle_loop kernel/sched/idle.c:251 [inline]
 [<ffffffff8132b32d>] cpu_startup_entry+0x60d/0x9a0 kernel/sched/idle.c:299
 [<ffffffff8113e119>] start_secondary+0x3c9/0x560 arch/x86/kernel/smpboot.c:245

xfrm_add_policy calls verify_newpolicy_info to check user's policy info,
but it doest check policy index correcly, if the policy index(ex. 6) is great
than XFRM_POLICY_MAX which is 3 for now, the validation check will be bypassed.
It will trigger out of bounds access.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: e682adf021be ("xfrm: Try to honor policy index if it's supplied by user")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 net/xfrm/xfrm_user.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index a131f9f..c2de950 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -1424,7 +1424,8 @@ static int verify_newpolicy_info(struct xfrm_userpolicy_info *p)
 	ret = verify_policy_dir(p->dir);
 	if (ret)
 		return ret;
-	if (p->index && ((p->index & XFRM_POLICY_MAX) != p->dir))
+	if (p->index && (p->index > XFRM_POLICY_MAX &&
+			 (p->index & XFRM_POLICY_MAX) != p->dir))
 		return -EINVAL;
 
 	return 0;
-- 
2.7.0


