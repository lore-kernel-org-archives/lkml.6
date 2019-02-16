Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02AE4C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 09:17:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2A57222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 09:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbfBPJRk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Feb 2019 04:17:40 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:51616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726647AbfBPJRi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Feb 2019 04:17:38 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 2B168C55A3A9C0FE4F60;
        Sat, 16 Feb 2019 17:17:35 +0800 (CST)
Received: from huawei.com (10.175.102.38) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.408.0; Sat, 16 Feb 2019
 17:17:26 +0800
From:   Tan Xiaojun <tanxiaojun@huawei.com>
To:     <viro@zeniv.linux.org.uk>, <bcrl@kvack.org>
CC:     <linux-aio@kvack.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <wangxiongfeng2@huawei.com>,
        <tanxiaojun@huawei.com>
Subject: [RFC PATCH] aio: add check for timeout to aviod invalid value
Date:   Sat, 16 Feb 2019 17:57:01 +0800
Message-ID: <1550311021-60612-1-git-send-email-tanxiaojun@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.38]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(When I was testing with syzkaller, I found a lot of ubsan problems. Here 
is one of them. I am not sure if it needs to be fixed and how it will be 
fixed. So I sent this patch to ask your opinion.)

Syzkaller reported a UBSAN bug below, which was mainly caused by a large
negative number passed to the timeout of the io_getevents system call.

================================================================================
UBSAN: Undefined behaviour in ./include/linux/ktime.h:42:14
signed integer overflow:
-8427032702788048137 * 1000000000 cannot be represented in type 'long long int'
CPU: 3 PID: 11668 Comm: syz-executor0 Not tainted 4.19.18-514.55.6.9.x86_64+ #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1ubuntu1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0xca/0x13e lib/dump_stack.c:113
 ubsan_epilogue+0xe/0x81 lib/ubsan.c:159
 handle_overflow+0x193/0x1e2 lib/ubsan.c:190
 ktime_set include/linux/ktime.h:42 [inline]
 timespec64_to_ktime include/linux/ktime.h:78 [inline]
 do_io_getevents+0x307/0x390 fs/aio.c:2043
 __do_sys_io_getevents fs/aio.c:2080 [inline]
 __se_sys_io_getevents fs/aio.c:2068 [inline]
 __x64_sys_io_getevents+0x163/0x250 fs/aio.c:2068
 do_syscall_64+0xc8/0x580 arch/x86/entry/common.c:290
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x462589
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fde9b04ec58 EFLAGS: 00000246 ORIG_RAX: 00000000000000d0
RAX: ffffffffffffffda RBX: 000000000072bf00 RCX: 0000000000462589
RDX: 0000000000000006 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000005 R08: 0000000020000100 R09: 0000000000000000
R10: 0000000020000040 R11: 0000000000000246 R12: 00007fde9b04f6bc
R13: 00000000004bd1f0 R14: 00000000006f6b60 R15: 00000000ffffffff
================================================================================
bond0 (unregistering): Released all slaves

The timeout described in "man io_getevents" does not say whether it
can be negative or not, but as a waiting time, a negative number has
no meaning. So I add check to avoid this case.

Signed-off-by: Tan Xiaojun <tanxiaojun@huawei.com>
---
 fs/aio.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/aio.c b/fs/aio.c
index aaaaf4d..28e0fa6 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -2078,10 +2078,15 @@ static long do_io_getevents(aio_context_t ctx_id,
 		struct io_event __user *events,
 		struct timespec64 *ts)
 {
-	ktime_t until = ts ? timespec64_to_ktime(*ts) : KTIME_MAX;
+	ktime_t until;
 	struct kioctx *ioctx = lookup_ioctx(ctx_id);
 	long ret = -EINVAL;
 
+	if (ts && !timespec64_valid(ts))
+		return -EINVAL;
+
+	until = ts ? timespec64_to_ktime(*ts) : KTIME_MAX;
+
 	if (likely(ioctx)) {
 		if (likely(min_nr <= nr && min_nr >= 0))
 			ret = read_events(ioctx, min_nr, nr, events, until);
-- 
2.7.4

