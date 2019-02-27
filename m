Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92865C43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5EC812084D
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 09:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfB0JX4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 04:23:56 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:44564 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725881AbfB0JX4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 04:23:56 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 1BCBC98127135C782527;
        Wed, 27 Feb 2019 17:23:54 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.408.0; Wed, 27 Feb 2019 17:23:47 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <john.stultz@linaro.org>, <tglx@linutronix.de>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>
Subject: [RFC PATCH] timekeeping: Avoid undefined behaviour in 'ktime_get_with_offset()'
Date:   Wed, 27 Feb 2019 17:23:01 +0800
Message-ID: <1551259381-15907-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I ran Syzkaller testsuite, I got the following call trace.
================================================================================
UBSAN: Undefined behaviour in kernel/time/timekeeping.c:801:8
signed integer overflow:
500152103386 + 9223372036854775807 cannot be represented in type 'long long int'
CPU: 6 PID: 13904 Comm: syz-executor.0 Not tainted 4.19.25 #5
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xca/0x13e lib/dump_stack.c:113
 ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
 handle_overflow+0x193/0x1e2 lib/ubsan.c:190
 ktime_get_with_offset+0x26a/0x2d0 kernel/time/timekeeping.c:801
 common_hrtimer_arm+0x14d/0x220 kernel/time/posix-timers.c:817
 common_timer_set+0x337/0x530 kernel/time/posix-timers.c:863
 do_timer_settime+0x198/0x290 kernel/time/posix-timers.c:892
 __do_sys_timer_settime kernel/time/posix-timers.c:918 [inline]
 __se_sys_timer_settime kernel/time/posix-timers.c:904 [inline]
 __x64_sys_timer_settime+0x18d/0x260 kernel/time/posix-timers.c:904
 do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x462eb9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7968072c58 EFLAGS: 00000246 ORIG_RAX: 00000000000000df
RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000462eb9
RDX: 00000000200000c0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f79680736bc
R13: 00000000004c54cc R14: 0000000000704278 R15: 00000000ffffffff
================================================================================

It it because global variable 'offsets' is set with a very large but still
valid value. It overflows when we add 'tk->tkr_mono.base' with 'offsets'.

Because 'ktime_get_with_offset()' is a frequently used function, it may
effect the performance if we use 'ktime_add_safe()' to avoid this
undefined behaviour, so we use 'ktime_add_unsafe()' instead.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawe.com>
---
 kernel/time/timekeeping.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ac5dbf2..f9c39a6 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -792,7 +792,7 @@ ktime_t ktime_get_with_offset(enum tk_offsets offs)
 
 	do {
 		seq = read_seqcount_begin(&tk_core.seq);
-		base = ktime_add(tk->tkr_mono.base, *offset);
+		base = ktime_add_unsafe(tk->tkr_mono.base, *offset);
 		nsecs = timekeeping_get_ns(&tk->tkr_mono);
 
 	} while (read_seqcount_retry(&tk_core.seq, seq));
-- 
1.7.12.4

