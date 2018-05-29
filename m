Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934412AbeE2N7D (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 09:59:03 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41330 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934894AbeE2N5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 09:57:07 -0400
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: [PATCH] fs/binfmt_misc.c: do not allow offset overflow
Date: Tue, 29 May 2018 10:56:48 -0300
Message-Id: <20180529135648.14254-1-cascardo@canonical.com>
X-Mailer: git-send-email 2.17.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible to overflow the offset to get a negative value, which might
crash the system, or possibly leak kernel data.

Here is a crash log when using 2500000000 as offset:

[ 6050.251552] BUG: unable to handle kernel paging request at ffff989cfd6edca0
[ 6050.252053] IP: load_misc_binary+0x22b/0x470 [binfmt_misc]
[ 6050.252053] PGD 1ef3e067 P4D 1ef3e067 PUD 0
[ 6050.252053] Oops: 0000 [#1] SMP NOPTI
[ 6050.252053] Modules linked in: binfmt_misc kvm_intel ppdev kvm irqbypass joydev input_leds serio_raw mac_hid parport_pc qemu_fw_cfg parpy
[ 6050.252053] CPU: 0 PID: 2499 Comm: bash Not tainted 4.15.0-22-generic #24-Ubuntu
[ 6050.252053] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.1-1 04/01/2014
[ 6050.252053] RIP: 0010:load_misc_binary+0x22b/0x470 [binfmt_misc]
[ 6050.252053] RSP: 0018:ffffb6e383017e18 EFLAGS: 00010202
[ 6050.252053] RAX: 0000000000000003 RBX: ffff989d74a47100 RCX: ffff989cfd6edca0
[ 6050.252053] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff989d7d2e95e5
[ 6050.252053] RBP: ffffb6e383017e48 R08: 0000000000000001 R09: 0000000000000000
[ 6050.252053] R10: 0000000000000000 R11: fefefefefefefeff R12: 0000000000000001
[ 6050.252053] R13: ffff989d7d2e9580 R14: 0000000000000000 R15: ffffffffc0592160
[ 6050.252053] FS:  00007fa424c89740(0000) GS:ffff989d7fc00000(0000) knlGS:0000000000000000
[ 6050.252053] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 6050.252053] CR2: ffff989cfd6edca0 CR3: 000000003db08000 CR4: 00000000000006f0
[ 6050.252053] Call Trace:
[ 6050.252053]  search_binary_handler+0x97/0x1d0
[ 6050.252053]  do_execveat_common.isra.34+0x667/0x810
[ 6050.252053]  SyS_execve+0x31/0x40
[ 6050.252053]  do_syscall_64+0x73/0x130
[ 6050.252053]  entry_SYSCALL_64_after_hwframe+0x3d/0xa2

Use kstrtoint instead of simple_strtoul. It will work as the code already
set the delimiter byte to '\0' and we only do it when the field is not
empty.

Tested with offsets -1, 2500000000, UINT_MAX and INT_MAX. Also tested with
examples documented at Documentation/admin-guide/binfmt-misc.rst and other
registrations from packages on Ubuntu.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
---
 fs/binfmt_misc.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_misc.c b/fs/binfmt_misc.c
index a41b48f82a70..4de191563261 100644
--- a/fs/binfmt_misc.c
+++ b/fs/binfmt_misc.c
@@ -387,8 +387,13 @@ static Node *create_entry(const char __user *buffer, size_t count)
 		s = strchr(p, del);
 		if (!s)
 			goto einval;
-		*s++ = '\0';
-		e->offset = simple_strtoul(p, &p, 10);
+		*s = '\0';
+		if (p != s) {
+			int r = kstrtoint(p, 10, &e->offset);
+			if (r != 0 || e->offset < 0)
+				goto einval;
+		}
+		p = s;
 		if (*p++)
 			goto einval;
 		pr_debug("register: offset: %#x\n", e->offset);
@@ -428,7 +433,8 @@ static Node *create_entry(const char __user *buffer, size_t count)
 		if (e->mask &&
 		    string_unescape_inplace(e->mask, UNESCAPE_HEX) != e->size)
 			goto einval;
-		if (e->size + e->offset > BINPRM_BUF_SIZE)
+		if (e->size > BINPRM_BUF_SIZE ||
+		    BINPRM_BUF_SIZE - e->size < e->offset)
 			goto einval;
 		pr_debug("register: magic/mask length: %i\n", e->size);
 		if (USE_DEBUG) {
-- 
2.17.0
