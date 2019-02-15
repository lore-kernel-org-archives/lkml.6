Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F5AC43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32946222D0
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 00:05:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390302AbfBPAFz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 19:05:55 -0500
Received: from mail12.gandi.net ([217.70.182.73]:42495 "EHLO gandi.net"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387546AbfBPAFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 19:05:55 -0500
X-Greylist: delayed 390 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Feb 2019 19:05:53 EST
Received: from khany.gandi.net (unknown [10.231.1.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by gandi.net (Postfix) with ESMTPSA id E401B1604BC;
        Fri, 15 Feb 2019 23:59:21 +0000 (UTC)
Received: by khany.gandi.net (Postfix, from userid 1000)
        id 94B36DD164B; Fri, 15 Feb 2019 23:59:19 +0000 (GMT)
From:   baloo@gandi.net
To:     x86@kernel.org
Cc:     Arthur Gautier <baloo@gandi.net>, Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org, Pascal Bouchareine <pascal@gandi.net>
Subject: [PATCH] x86: uaccess: fix regression in unsafe_get_user
Date:   Fri, 15 Feb 2019 23:59:01 +0000
Message-Id: <20190215235901.23541-1-baloo@gandi.net>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arthur Gautier <baloo@gandi.net>

When extracting an initramfs, a filename may be near an allocation boundary.
Should that happen, strncopy_from_user will invoke unsafe_get_user which
may cross the allocation boundary. Should that happen, unsafe_get_user will
trigger a page fault, and strncopy_from_user would then bailout to
byte_at_a_time behavior.

unsafe_get_user is unsafe by nature, and rely on pagefault to detect boundaries.
After 9da3f2b74054 ("x86/fault: BUG() when uaccess helpers fault on kernel addresses")
it may no longer rely on pagefault as the new page fault handler would
trigger a BUG().

This commit allows unsafe_get_user to explicitly trigger pagefaults and
handle them directly with the error target label.

Kernel bug:
[    0.965251] Unpacking initramfs...
[    1.797025] BUG: pagefault on kernel address 0xffffae80c0c7e000 in non-whitelisted uaccess
[    1.798992] BUG: unable to handle kernel paging request at ffffae80c0c7e000
[    1.798992] #PF error: [normal kernel read fault]
[    1.798992] PGD 68526067 P4D 68526067 PUD 68527067 PMD 67f0d067 PTE 0
[    1.798992] Oops: 0000 [#1] SMP PTI
[    1.798992] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 5.0.0-rc6+ #14
[    1.798992] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.10.2-1 04/01/2014
[    1.798992] RIP: 0010:strncpy_from_user+0x67/0xe0
[    1.798992] Code: fe fe 48 39 ca 49 ba 80 80 80 80 80 80 80 80 48 0f 46 ca 31 c0 45 31 db 49 89 c8 4c 89 c1 48 29 c1 48 83 f9 07 76 49 44 89 d9 <4c> 8b 0c 06 85 c9 75 3e 49 8d 0c 19 4c 89 0c 07 49 f7 d1 4c 21 c9
[    1.798992] RSP: 0000:ffffae80c031fc40 EFLAGS: 00050216
[    1.798992] RAX: 0000000000000040 RBX: fefefefefefefeff RCX: 0000000000000000
[    1.798992] RDX: 0000000000000fe0 RSI: ffffae80c0c7dfba RDI: ffff8b3d27cce020
[    1.798992] RBP: 00000000ffffff9c R08: 0000000000000fe0 R09: caccd29190978b86
[    1.798992] R10: 8080808080808080 R11: 0000000000000000 R12: ffffae80c0c7dfba
[    1.798992] R13: ffffae80c031fd00 R14: 0000000000000000 R15: 0000000000000000
[    1.798992] FS:  0000000000000000(0000) GS:ffff8b3d28a00000(0000) knlGS:0000000000000000
[    1.798992] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    1.798992] CR2: ffffae80c0c7e000 CR3: 000000003a60e001 CR4: 0000000000360eb0
[    1.798992] Call Trace:
[    1.798992]  getname_flags+0x69/0x187
[    1.798992]  user_path_at_empty+0x1e/0x41
[    1.798992]  vfs_statx+0x70/0xcc
[    1.798992]  clean_path+0x41/0xa2
[    1.798992]  ? parse_header+0x40/0x10a
[    1.798992]  do_name+0x78/0x2b5
[    1.798992]  write_buffer+0x27/0x37
[    1.798992]  flush_buffer+0x34/0x8b
[    1.798992]  ? md_run_setup+0x8a/0x8a
[    1.798992]  unlz4+0x20b/0x27c
[    1.798992]  ? write_buffer+0x37/0x37
[    1.798992]  ? decompress_method+0x80/0x80
[    1.798992]  unpack_to_rootfs+0x17a/0x2b7
[    1.798992]  ? md_run_setup+0x8a/0x8a
[    1.798992]  ? clean_rootfs+0x159/0x159
[    1.798992]  populate_rootfs+0x5d/0x105
[    1.798992]  do_one_initcall+0x86/0x169
[    1.798992]  ? do_early_param+0x8e/0x8e
[    1.798992]  kernel_init_freeable+0x16a/0x1f4
[    1.798992]  ? rest_init+0xaa/0xaa
[    1.798992]  kernel_init+0xa/0xfa
[    1.798992]  ret_from_fork+0x35/0x40

You may reproduce the issue with the following initrd:
  truncate -s 8388313 a
  SECONDFILENAME=bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb
  truncate -s 10 $SECONDFILENAME
  echo "a\n$SECONDFILENAME" | cpio -o --format=newc | lz4 -l > initrd.img.lz4

This places the second filename in the cpio near the allocation boundary made
by lz4 decompression and should trigger the bug.

Fixes: 9da3f2b74054 ("x86/fault: BUG() when uaccess helpers fault on kernel addresses")

Cc: Jann Horn <jannh@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Pascal Bouchareine <pascal@gandi.net>
Signed-off-by: Arthur Gautier <baloo@gandi.net>
---
 arch/x86/include/asm/uaccess.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 780f2b42c8efe..2c272dc43e05a 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -724,7 +724,9 @@ static __must_check inline bool user_access_begin(const void __user *ptr, size_t
 do {										\
 	int __gu_err;								\
 	__inttype(*(ptr)) __gu_val;						\
+	current->kernel_uaccess_faults_ok++;					\
 	__get_user_size(__gu_val, (ptr), sizeof(*(ptr)), __gu_err, -EFAULT);	\
+	current->kernel_uaccess_faults_ok--;					\
 	(x) = (__force __typeof__(*(ptr)))__gu_val;				\
 	if (unlikely(__gu_err)) goto err_label;					\
 } while (0)
-- 
2.20.1

