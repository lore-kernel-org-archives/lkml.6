Return-Path: <SRS0=6f18=J7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3A1ECDFB0
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 01:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9DFD208CC
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Jul 2018 01:10:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeWtHXaW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9DFD208CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732248AbeGOBbS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Jul 2018 21:31:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:51624 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731952AbeGOBbS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jul 2018 21:31:18 -0400
Received: from localhost (unknown [104.132.152.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 304342089F;
        Sun, 15 Jul 2018 01:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531617020;
        bh=IYWx7Ph0MuJdinicKPgiJfi/1xdAuDV1VE/s7EL3w98=;
        h=From:To:Cc:Subject:Date:From;
        b=BeWtHXaWUgVhw47OaI8Vk1qbvlBURk2nqMUABTaNBN+4DarodPTbND3BhpSxpipjN
         NI6Ek13Db0llVjulBFc3PNivBSP2CqdPA+aIdoDs+av5ySFKUFgKONlQNhIc6C6mCo
         6KXByxPr5SeP/VkAe1vanjCdVJbA76EMiz53QUzM=
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid potential deadlock in f2fs_sbi_store
Date:   Sun, 15 Jul 2018 10:10:17 +0900
Message-Id: <20180715011017.11237-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.17.0.441.gb46fe60e1d-goog
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[  155.018460] ======================================================
[  155.021431] WARNING: possible circular locking dependency detected
[  155.024339] 4.18.0-rc3+ #5 Tainted: G           OE
[  155.026879] ------------------------------------------------------
[  155.029783] umount/2901 is trying to acquire lock:
[  155.032187] 00000000c4282f1f (kn->count#130){++++}, at: kernfs_remove+0x1f/0x30
[  155.035439]
[  155.035439] but task is already holding lock:
[  155.038892] 0000000056e4307b (&type->s_umount_key#41){++++}, at: deactivate_super+0x33/0x50
[  155.042602]
[  155.042602] which lock already depends on the new lock.
[  155.042602]
[  155.047465]
[  155.047465] the existing dependency chain (in reverse order) is:
[  155.051354]
[  155.051354] -> #1 (&type->s_umount_key#41){++++}:
[  155.054768]        f2fs_sbi_store+0x61/0x460 [f2fs]
[  155.057083]        kernfs_fop_write+0x113/0x1a0
[  155.059277]        __vfs_write+0x36/0x180
[  155.061250]        vfs_write+0xbe/0x1b0
[  155.063179]        ksys_write+0x55/0xc0
[  155.065068]        do_syscall_64+0x60/0x1b0
[  155.067071]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  155.069529]
[  155.069529] -> #0 (kn->count#130){++++}:
[  155.072421]        __kernfs_remove+0x26f/0x2e0
[  155.074452]        kernfs_remove+0x1f/0x30
[  155.076342]        kobject_del.part.5+0xe/0x40
[  155.078354]        f2fs_put_super+0x12d/0x290 [f2fs]
[  155.080500]        generic_shutdown_super+0x6c/0x110
[  155.082655]        kill_block_super+0x21/0x50
[  155.084634]        kill_f2fs_super+0x9c/0xc0 [f2fs]
[  155.086726]        deactivate_locked_super+0x3f/0x70
[  155.088826]        cleanup_mnt+0x3b/0x70
[  155.090584]        task_work_run+0x93/0xc0
[  155.092367]        exit_to_usermode_loop+0xf0/0x100
[  155.094466]        do_syscall_64+0x162/0x1b0
[  155.096312]        entry_SYSCALL_64_after_hwframe+0x49/0xbe
[  155.098603]
[  155.098603] other info that might help us debug this:
[  155.098603]
[  155.102418]  Possible unsafe locking scenario:
[  155.102418]
[  155.105134]        CPU0                    CPU1
[  155.107037]        ----                    ----
[  155.108910]   lock(&type->s_umount_key#41);
[  155.110674]                                lock(kn->count#130);
[  155.113010]                                lock(&type->s_umount_key#41);
[  155.115608]   lock(kn->count#130);

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/sysfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 5344e21853b2..bca1236fd6fa 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -287,8 +287,10 @@ static ssize_t f2fs_sbi_store(struct f2fs_attr *a,
 	bool gc_entry = (!strcmp(a->attr.name, "gc_urgent") ||
 					a->struct_type == GC_THREAD);
 
-	if (gc_entry)
-		down_read(&sbi->sb->s_umount);
+	if (gc_entry) {
+		if (!down_read_trylock(&sbi->sb->s_umount))
+			return -EAGAIN;
+	}
 	ret = __sbi_store(a, sbi, buf, count);
 	if (gc_entry)
 		up_read(&sbi->sb->s_umount);
-- 
2.17.0.441.gb46fe60e1d-goog

