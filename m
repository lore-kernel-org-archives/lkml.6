Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359AAC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:53:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FC4A21852
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 07:53:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729604AbfB0Hw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 02:52:58 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:4176 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726702AbfB0Hw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 02:52:58 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 03F42E518EBE1F578CB8
        for <linux-kernel@vger.kernel.org>; Wed, 27 Feb 2019 15:52:56 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.408.0; Wed, 27 Feb 2019 15:52:49 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <tglx@linutronix.de>, <deepa.kernel@gmail.com>, <arnd@arndb.de>
CC:     <linux-kernel@vger.kernel.org>, <wangxiongfeng2@huawei.com>
Subject: [PATCH v2] posix-cpu-timers: Avoid undefined behaviour in timespec64_to_ns()
Date:   Wed, 27 Feb 2019 15:52:02 +0800
Message-ID: <1551253922-3307-1-git-send-email-wangxiongfeng2@huawei.com>
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
UBSAN: Undefined behaviour in ./include/linux/time64.h:120:27
signed integer overflow:
8243129037239968815 * 1000000000 cannot be represented in type 'long long int'
CPU: 5 PID: 28854 Comm: syz-executor.1 Not tainted 4.19.24 #4
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xca/0x13e lib/dump_stack.c:113
 ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
 handle_overflow+0x193/0x1e2 lib/ubsan.c:190
 timespec64_to_ns include/linux/time64.h:120 [inline]
 posix_cpu_timer_set+0x95a/0xb70 kernel/time/posix-cpu-timers.c:687
 do_timer_settime+0x198/0x2a0 kernel/time/posix-timers.c:892
 __do_sys_timer_settime kernel/time/posix-timers.c:918 [inline]
 __se_sys_timer_settime kernel/time/posix-timers.c:904 [inline]
 __x64_sys_timer_settime+0x18d/0x260 kernel/time/posix-timers.c:904
 do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x462eb9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f14e4127c58 EFLAGS: 00000246 ORIG_RAX: 00000000000000df
RAX: ffffffffffffffda RBX: 000000000073bfa0 RCX: 0000000000462eb9
RDX: 0000000020000080 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000004 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f14e41286bc
R13: 00000000004c54cc R14: 0000000000704278 R15: 00000000ffffffff
================================================================================

It is because 'it_interval.tv_sec' is larger than 'KTIME_SEC_MAX' and
'it_interval.tv_sec * NSEC_PER_SEC' overflows in 'timespec64_to_ns()'.

This patch use 'timespec64_valid_restrict()' to check whether
'it_interval.tv_sec' is larger than 'KTIME_SEC_MAX'.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 kernel/time/posix-timers.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 0e84bb7..97b773c 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -853,8 +853,8 @@ static int do_timer_settime(timer_t timer_id, int flags,
 	unsigned long flag;
 	int error = 0;
 
-	if (!timespec64_valid(&new_spec64->it_interval) ||
-	    !timespec64_valid(&new_spec64->it_value))
+	if (!timespec64_valid_strict(&new_spec64->it_interval) ||
+	    !timespec64_valid_strict(&new_spec64->it_value))
 		return -EINVAL;
 
 	if (old_spec64)
-- 
1.7.12.4

