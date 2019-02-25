Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2D6EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:13:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 758942084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 03:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbfBYDNO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Feb 2019 22:13:14 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34044 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726458AbfBYDNO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Feb 2019 22:13:14 -0500
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6F2E74DFBC90C1D86ACE
        for <linux-kernel@vger.kernel.org>; Mon, 25 Feb 2019 11:13:12 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.408.0; Mon, 25 Feb 2019 11:13:02 +0800
From:   Hongbo Yao <yaohongbo@huawei.com>
To:     <tglx@linutronix.de>, <deepa.kernel@gmail.com>, <arnd@arndb.de>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH] time64: Avoid undefined behaviour in timespec64_add()
Date:   Mon, 25 Feb 2019 11:26:19 +0800
Message-ID: <20190225032619.17070-1-yaohongbo@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into this:
	=========================================================================
	UBSAN: Undefined behaviour in ./include/linux/time64.h:70:2
	signed integer overflow:
	1551059291 + 9223372036854775807 cannot be represented in type 'long
	long int'
	CPU: 5 PID: 20064 Comm: syz-executor.2 Not tainted 4.19.24 #4
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
	1.10.2-1ubuntu1 04/01/2014
	Call Trace:
	 __dump_stack lib/dump_stack.c:77 [inline]
	 dump_stack+0xca/0x13e lib/dump_stack.c:113
	 ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
	 handle_overflow+0x193/0x1e2 lib/ubsan.c:190
	 timespec64_add include/linux/time64.h:70 [inline]
	 timekeeping_inject_offset+0x3ed/0x4e0 kernel/time/timekeeping.c:1301
	 do_adjtimex+0x1e5/0x6c0 kernel/time/timekeeping.c:2360
	 __do_sys_clock_adjtime+0x122/0x200 kernel/time/posix-timers.c:1086
	 do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
	 entry_SYSCALL_64_after_hwframe+0x49/0xbe
	RIP: 0033:0x462eb9
	Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89
	f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01
	f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
	RSP: 002b:00007f888aa2dc58 EFLAGS: 00000246 ORIG_RAX: 0000000000000131
	RAX: ffffffffffffffda RBX: 000000000073bf00 RCX: 0000000000462eb9
	RDX: 0000000000000000 RSI: 00000000200003c0 RDI: 0000000000000000
	RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
	R10: 0000000000000000 R11: 0000000000000246 R12: 00007f888aa2e6bc
	R13: 00000000004bcae8 R14: 00000000006f6868 R15: 00000000ffffffff
	==========================================================================

Since lhs.tv_sec and rhs.tv_sec are both time64_t, this is a signed
addition which will cause undefined behaviour on overflow.

The easiest way to avoid the overflow is to cast one of the arguments to
unsigned (so the addition will be done using unsigned arithmetic).
This patch doesn't change generated code.

Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
---
 include/linux/time64.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/time64.h b/include/linux/time64.h
index 05634afba0db..5926bdd4167f 100644
--- a/include/linux/time64.h
+++ b/include/linux/time64.h
@@ -67,7 +67,7 @@ static inline struct timespec64 timespec64_add(struct timespec64 lhs,
 						struct timespec64 rhs)
 {
 	struct timespec64 ts_delta;
-	set_normalized_timespec64(&ts_delta, lhs.tv_sec + rhs.tv_sec,
+	set_normalized_timespec64(&ts_delta, (timeu64_t)lhs.tv_sec + rhs.tv_sec,
 				lhs.tv_nsec + rhs.tv_nsec);
 	return ts_delta;
 }
-- 
2.20.1

