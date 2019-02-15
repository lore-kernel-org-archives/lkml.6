Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NORMAL_HTTP_TO_IP,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69E1FC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D1221A4C
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 14:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405256AbfBOOKh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 09:10:37 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:3735 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2404668AbfBOOKg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 09:10:36 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id D09B5F5B18BE207BA000;
        Fri, 15 Feb 2019 22:10:31 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.408.0; Fri, 15 Feb 2019 22:10:28 +0800
From:   Mao Wenan <maowenan@huawei.com>
To:     <netdev@vger.kernel.org>, <davem@davemloft.net>,
        <xiyou.wangcong@gmail.com>, <linux-kernel@vger.kernel.org>
Subject: [net-next] net: crypto set sk to NULL when af_alg_release.
Date:   Fri, 15 Feb 2019 22:24:15 +0800
Message-ID: <20190215142415.149153-1-maowenan@huawei.com>
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

KASAN has found use-after-free in sockfs_setattr.
The existed commit 6d8c50dcb029 ("socket: close race condition between sock_close()
and sockfs_setattr()") is to fix this simillar issue, but it seems to ignore
that crypto module forgets to set the sk to NULL after af_alg_release.

KASAN report details as below:
BUG: KASAN: use-after-free in sockfs_setattr+0x120/0x150
Write of size 4 at addr ffff88837b956128 by task syz-executor0/4186

CPU: 2 PID: 4186 Comm: syz-executor0 Not tainted xxx + #1
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
1.10.2-1ubuntu1 04/01/2014
Call Trace:
 dump_stack+0xca/0x13e
 print_address_description+0x79/0x330
 ? vprintk_func+0x5e/0xf0
 kasan_report+0x18a/0x2e0
 ? sockfs_setattr+0x120/0x150
 sockfs_setattr+0x120/0x150
 ? sock_register+0x2d0/0x2d0
 notify_change+0x90c/0xd40
 ? chown_common+0x2ef/0x510
 chown_common+0x2ef/0x510
 ? chmod_common+0x3b0/0x3b0
 ? __lock_is_held+0xbc/0x160
 ? __sb_start_write+0x13d/0x2b0
 ? __mnt_want_write+0x19a/0x250
 do_fchownat+0x15c/0x190
 ? __ia32_sys_chmod+0x80/0x80
 ? trace_hardirqs_on_thunk+0x1a/0x1c
 __x64_sys_fchownat+0xbf/0x160
 ? lockdep_hardirqs_on+0x39a/0x5e0
 do_syscall_64+0xc8/0x580
 entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x462589
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48 89
f7 48 89 d6 48 89
ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3
48 c7 c1 bc ff ff
ff f7 d8 64 89 01 48
RSP: 002b:00007fb4b2c83c58 EFLAGS: 00000246 ORIG_RAX: 0000000000000104
RAX: ffffffffffffffda RBX: 000000000072bfa0 RCX: 0000000000462589
RDX: 0000000000000000 RSI: 00000000200000c0 RDI: 0000000000000007
RBP: 0000000000000005 R08: 0000000000001000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fb4b2c846bc
R13: 00000000004bc733 R14: 00000000006f5138 R15: 00000000ffffffff

Allocated by task 4185:
 kasan_kmalloc+0xa0/0xd0
 __kmalloc+0x14a/0x350
 sk_prot_alloc+0xf6/0x290
 sk_alloc+0x3d/0xc00
 af_alg_accept+0x9e/0x670
 hash_accept+0x4a3/0x650
 __sys_accept4+0x306/0x5c0
 __x64_sys_accept4+0x98/0x100
 do_syscall_64+0xc8/0x580
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Freed by task 4184:
 __kasan_slab_free+0x12e/0x180
 kfree+0xeb/0x2f0
 __sk_destruct+0x4e6/0x6a0
 sk_destruct+0x48/0x70
 __sk_free+0xa9/0x270
 sk_free+0x2a/0x30
 af_alg_release+0x5c/0x70
 __sock_release+0xd3/0x280
 sock_close+0x1a/0x20
 __fput+0x27f/0x7f0
 task_work_run+0x136/0x1b0
 exit_to_usermode_loop+0x1a7/0x1d0
 do_syscall_64+0x461/0x580
 entry_SYSCALL_64_after_hwframe+0x49/0xbe

Syzkaller reproducer:
r0 = perf_event_open(&(0x7f0000000000)={0x0, 0x70, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0,
0x0, 0x0, 0x0, 0x0, 0x0, 0x0, 0x0, @perf_config_ext}, 0x0, 0x0,
0xffffffffffffffff, 0x0)
r1 = socket$alg(0x26, 0x5, 0x0)
getrusage(0x0, 0x0)
bind(r1, &(0x7f00000001c0)=@alg={0x26, 'hash\x00', 0x0, 0x0,
'sha256-ssse3\x00'}, 0x80)
r2 = accept(r1, 0x0, 0x0)
r3 = accept4$unix(r2, 0x0, 0x0, 0x0)
r4 = dup3(r3, r0, 0x0)
fchownat(r4, &(0x7f00000000c0)='\x00', 0x0, 0x0, 0x1000)

Fixes: 6d8c50dcb029 ("socket: close race condition between sock_close() and sockfs_setattr()")
Signed-off-by: Mao Wenan <maowenan@huawei.com>
---
 crypto/af_alg.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/crypto/af_alg.c b/crypto/af_alg.c
index 17eb09d222ff..ec78a04eb136 100644
--- a/crypto/af_alg.c
+++ b/crypto/af_alg.c
@@ -122,8 +122,10 @@ static void alg_do_release(const struct af_alg_type *type, void *private)
 
 int af_alg_release(struct socket *sock)
 {
-	if (sock->sk)
+	if (sock->sk) {
 		sock_put(sock->sk);
+		sock->sk = NULL;
+	}
 	return 0;
 }
 EXPORT_SYMBOL_GPL(af_alg_release);
-- 
2.20.1

