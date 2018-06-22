Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AF9C43144
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D94E2459C
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 16:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="zReoytu1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D94E2459C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934104AbeFVQMz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 12:12:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:51310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751317AbeFVQMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 12:12:54 -0400
Received: from localhost.localdomain (unknown [49.65.250.211])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3BA9F2459A;
        Fri, 22 Jun 2018 16:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529683973;
        bh=K09tiA2Js1HgMIKRzq/fmIzmN2R8tDN9JwNSleJdHaQ=;
        h=From:To:Cc:Subject:Date:From;
        b=zReoytu1565R72p8f4RSUcHe4hbP9mhcBQ3lbPJgvZr1IuxblIjITEj/gxulPI15Z
         vZjLTkVaWZdrq+p7zpXr9O4IzrDGmAchSUORs1EJbbTR4F+1a1/OQc2xBlBbxspIbQ
         JHZT86l0t8litChgxgUeJXmPY9yc9YrxWZJgMpqM=
From:   Chao Yu <chao@kernel.org>
To:     jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs: fix to do sanity check with secs_per_zone
Date:   Sat, 23 Jun 2018 00:12:36 +0800
Message-Id: <20180622161236.3453-1-chao@kernel.org>
X-Mailer: git-send-email 2.16.2.17.g38e79b1fd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chao Yu <yuchao0@huawei.com>

As Wen Xu reported in below link:

https://bugzilla.kernel.org/show_bug.cgi?id=200183

- Overview
Divide zero in reset_curseg() when mounting a crafted f2fs image

- Reproduce

- Kernel message
[  588.281510] divide error: 0000 [#1] SMP KASAN PTI
[  588.282701] CPU: 0 PID: 1293 Comm: mount Not tainted 4.18.0-rc1+ #4
[  588.284000] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS Ubuntu-1.8.2-1ubuntu1 04/01/2014
[  588.286178] RIP: 0010:reset_curseg+0x94/0x1a0
[  588.298166] RSP: 0018:ffff8801e88d7940 EFLAGS: 00010246
[  588.299360] RAX: 0000000000000014 RBX: ffff8801e1d46d00 RCX: ffffffffb88bf60b
[  588.300809] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffff8801e1d46d64
[  588.305272] R13: 0000000000000000 R14: 0000000000000014 R15: 0000000000000000
[  588.306822] FS:  00007fad85008840(0000) GS:ffff8801f6e00000(0000) knlGS:0000000000000000
[  588.308456] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  588.309623] CR2: 0000000001705078 CR3: 00000001f30f8000 CR4: 00000000000006f0
[  588.311085] Call Trace:
[  588.311637]  f2fs_build_segment_manager+0x103f/0x3410
[  588.316136]  ? f2fs_commit_super+0x1b0/0x1b0
[  588.317031]  ? set_blocksize+0x90/0x140
[  588.319473]  f2fs_mount+0x15/0x20
[  588.320166]  mount_fs+0x60/0x1a0
[  588.320847]  ? alloc_vfsmnt+0x309/0x360
[  588.321647]  vfs_kern_mount+0x6b/0x1a0
[  588.322432]  do_mount+0x34a/0x18c0
[  588.323175]  ? strndup_user+0x46/0x70
[  588.323937]  ? copy_mount_string+0x20/0x20
[  588.324793]  ? memcg_kmem_put_cache+0x1b/0xa0
[  588.325702]  ? kasan_check_write+0x14/0x20
[  588.326562]  ? _copy_from_user+0x6a/0x90
[  588.327375]  ? memdup_user+0x42/0x60
[  588.328118]  ksys_mount+0x83/0xd0
[  588.328808]  __x64_sys_mount+0x67/0x80
[  588.329607]  do_syscall_64+0x78/0x170
[  588.330400]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
[  588.331461] RIP: 0033:0x7fad848e8b9a
[  588.336022] RSP: 002b:00007ffd7c5b6be8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
[  588.337547] RAX: ffffffffffffffda RBX: 00000000016f8030 RCX: 00007fad848e8b9a
[  588.338999] RDX: 00000000016f8210 RSI: 00000000016f9f30 RDI: 0000000001700ec0
[  588.340442] RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000013
[  588.341887] R10: 00000000c0ed0000 R11: 0000000000000206 R12: 0000000001700ec0
[  588.343341] R13: 00000000016f8210 R14: 0000000000000000 R15: 0000000000000003
[  588.354891] ---[ end trace 4ce02f25ff7d3df5 ]---
[  588.355862] RIP: 0010:reset_curseg+0x94/0x1a0
[  588.360742] RSP: 0018:ffff8801e88d7940 EFLAGS: 00010246
[  588.361812] RAX: 0000000000000014 RBX: ffff8801e1d46d00 RCX: ffffffffb88bf60b
[  588.363485] RDX: 0000000000000000 RSI: dffffc0000000000 RDI: ffff8801e1d46d64
[  588.365213] RBP: ffff8801e88d7968 R08: ffffed003c32266f R09: ffffed003c32266f
[  588.366661] R10: 0000000000000001 R11: ffffed003c32266e R12: ffff8801f0337700
[  588.368110] R13: 0000000000000000 R14: 0000000000000014 R15: 0000000000000000
[  588.370057] FS:  00007fad85008840(0000) GS:ffff8801f6e00000(0000) knlGS:0000000000000000
[  588.372099] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  588.373291] CR2: 0000000001705078 CR3: 00000001f30f8000 CR4: 00000000000006f0

- Location
https://elixir.bootlin.com/linux/latest/source/fs/f2fs/segment.c#L2147
        curseg->zone = GET_ZONE_FROM_SEG(sbi, curseg->segno);

If secs_per_zone is corrupted due to fuzzing test, it will cause divide
zero operation when using GET_ZONE_FROM_SEG macro, so we should do more
sanity check with secs_per_zone during mount to avoid this issue.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index a269131df36f..26c35f0cc651 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2236,9 +2236,9 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		return 1;
 	}
 
-	if (secs_per_zone > total_sections) {
+	if (secs_per_zone > total_sections || !secs_per_zone) {
 		f2fs_msg(sb, KERN_INFO,
-			"Wrong secs_per_zone (%u > %u)",
+			"Wrong secs_per_zone / total_sections (%u, %u)",
 			secs_per_zone, total_sections);
 		return 1;
 	}
-- 
2.16.2.17.g38e79b1fd

