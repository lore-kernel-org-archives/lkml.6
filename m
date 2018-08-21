Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7624C04E83
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 23:19:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5ECAC217B7
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 23:19:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="ajds/Zpo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ECAC217B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbeHVClK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 22:41:10 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35497 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbeHVClJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 22:41:09 -0400
Received: by mail-pg1-f194.google.com with SMTP id z4-v6so43144pgv.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Aug 2018 16:18:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iXRu6mqKrKlPHH0Xoja1r/KUw3eBTunSLRtdhX6rtss=;
        b=ajds/Zpo6SuBC5FbDABU8lPssoPNl0E+84zV+65h/gmRN7iQ+4aFqF/hq3OkdkkrS4
         tq8/xRtfjYdjUeegmhLVMzeJngJlrwvCcmXxCHcHjXWuBEIsAwT6ZnT3MMi4zH4Mlh32
         Sjai166qYArpVa91kcw2O5s52Jq7EZXv3ZW7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iXRu6mqKrKlPHH0Xoja1r/KUw3eBTunSLRtdhX6rtss=;
        b=R7yWPoyM6fg1euDNEZTIZTkqCy4Tet83Ix9YqNGLfscAINSj8YWG2+qkrDh43pTLba
         i4Kh3nbmBK+kXjVEYg27IojY4EgHHv/w6OLzrBeqG2M0mIbxeycmTa8HQafWho0sRj2+
         wcM6y8dQ1kKxd08DSUBrVhn48EaN3OSukoS4EwxDBkuYY97QPcIkvaeDcyz+8bsdZLUC
         VnThAZNe/5io9U5nB6mo+RfpEj8ag+KGACCEVaMk9N+s3TC3j1KdoAHF94sa0wtQIR4U
         e9D2FCBU8Ne2PlObGOcWxsNrqAOwRHTUOAWuy9VMqZVRLCv/CGRPbk4qGtL+CYKaBwrF
         52YA==
X-Gm-Message-State: APzg51C5SU52DABfjmbP0+EkbLWiCB5+2e12fmGeK8khO2iGJPwPEi+P
        HpQEgOm2pr/UzP1xdxWznPqupk8YVxI=
X-Google-Smtp-Source: ANB0VdZnxasPeMX1LXzLzlnkDHkJqir3RZRfYps8S2hSoSHCXlQc6Nrn6LHnGho/RVDbHinakF8YMw==
X-Received: by 2002:a62:3a08:: with SMTP id h8-v6mr100419pfa.61.1534893538175;
        Tue, 21 Aug 2018 16:18:58 -0700 (PDT)
Received: from joelaf.mtv.corp.google.com ([2620:0:1000:1601:3aef:314f:b9ea:889f])
        by smtp.gmail.com with ESMTPSA id a16-v6sm37356pgv.29.2018.08.21.16.18.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Aug 2018 16:18:57 -0700 (PDT)
From:   Joel Fernandes <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        willy@infradead.org, stable@vger.kernel.org, peterz@infradead.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        NeilBrown <neilb@suse.com>
Subject: [PATCH v2] mm: shmem: Correctly annotate new inodes for lockdep
Date:   Tue, 21 Aug 2018 16:18:35 -0700
Message-Id: <20180821231835.166639-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.1017.ga543ac7ca45-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Joel Fernandes (Google)" <joel@joelfernandes.org>

Directories and inodes don't necessarily need to be in the same
lockdep class. For ex, hugetlbfs splits them out too to prevent
false positives in lockdep. Annotate correctly after new inode
creation. If its a directory inode, it will be put into a different
class.

This should fix a lockdep splat reported by syzbot:

> ======================================================
> WARNING: possible circular locking dependency detected
> 4.18.0-rc8-next-20180810+ #36 Not tainted
> ------------------------------------------------------
> syz-executor900/4483 is trying to acquire lock:
> 00000000d2bfc8fe (&sb->s_type->i_mutex_key#9){++++}, at: inode_lock
> include/linux/fs.h:765 [inline]
> 00000000d2bfc8fe (&sb->s_type->i_mutex_key#9){++++}, at:
> shmem_fallocate+0x18b/0x12e0 mm/shmem.c:2602
>
> but task is already holding lock:
> 0000000025208078 (ashmem_mutex){+.+.}, at: ashmem_shrink_scan+0xb4/0x630
> drivers/staging/android/ashmem.c:448
>
> which lock already depends on the new lock.
>
> -> #2 (ashmem_mutex){+.+.}:
>        __mutex_lock_common kernel/locking/mutex.c:925 [inline]
>        __mutex_lock+0x171/0x1700 kernel/locking/mutex.c:1073
>        mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1088
>        ashmem_mmap+0x55/0x520 drivers/staging/android/ashmem.c:361
>        call_mmap include/linux/fs.h:1844 [inline]
>        mmap_region+0xf27/0x1c50 mm/mmap.c:1762
>        do_mmap+0xa10/0x1220 mm/mmap.c:1535
>        do_mmap_pgoff include/linux/mm.h:2298 [inline]
>        vm_mmap_pgoff+0x213/0x2c0 mm/util.c:357
>        ksys_mmap_pgoff+0x4da/0x660 mm/mmap.c:1585
>        __do_sys_mmap arch/x86/kernel/sys_x86_64.c:100 [inline]
>        __se_sys_mmap arch/x86/kernel/sys_x86_64.c:91 [inline]
>        __x64_sys_mmap+0xe9/0x1b0 arch/x86/kernel/sys_x86_64.c:91
>        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> -> #1 (&mm->mmap_sem){++++}:
>        __might_fault+0x155/0x1e0 mm/memory.c:4568
>        _copy_to_user+0x30/0x110 lib/usercopy.c:25
>        copy_to_user include/linux/uaccess.h:155 [inline]
>        filldir+0x1ea/0x3a0 fs/readdir.c:196
>        dir_emit_dot include/linux/fs.h:3464 [inline]
>        dir_emit_dots include/linux/fs.h:3475 [inline]
>        dcache_readdir+0x13a/0x620 fs/libfs.c:193
>        iterate_dir+0x48b/0x5d0 fs/readdir.c:51
>        __do_sys_getdents fs/readdir.c:231 [inline]
>        __se_sys_getdents fs/readdir.c:212 [inline]
>        __x64_sys_getdents+0x29f/0x510 fs/readdir.c:212
>        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> -> #0 (&sb->s_type->i_mutex_key#9){++++}:
>        lock_acquire+0x1e4/0x540 kernel/locking/lockdep.c:3924
>        down_write+0x8f/0x130 kernel/locking/rwsem.c:70
>        inode_lock include/linux/fs.h:765 [inline]
>        shmem_fallocate+0x18b/0x12e0 mm/shmem.c:2602
>        ashmem_shrink_scan+0x236/0x630 drivers/staging/android/ashmem.c:455
>        ashmem_ioctl+0x3ae/0x13a0 drivers/staging/android/ashmem.c:797
>        vfs_ioctl fs/ioctl.c:46 [inline]
>        file_ioctl fs/ioctl.c:501 [inline]
>        do_vfs_ioctl+0x1de/0x1720 fs/ioctl.c:685
>        ksys_ioctl+0xa9/0xd0 fs/ioctl.c:702
>        __do_sys_ioctl fs/ioctl.c:709 [inline]
>        __se_sys_ioctl fs/ioctl.c:707 [inline]
>        __x64_sys_ioctl+0x73/0xb0 fs/ioctl.c:707
>        do_syscall_64+0x1b9/0x820 arch/x86/entry/common.c:290
>        entry_SYSCALL_64_after_hwframe+0x49/0xbe
>
> other info that might help us debug this:
>
> Chain exists of:
>   &sb->s_type->i_mutex_key#9 --> &mm->mmap_sem --> ashmem_mutex
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(ashmem_mutex);
>                                lock(&mm->mmap_sem);
>                                lock(ashmem_mutex);
>   lock(&sb->s_type->i_mutex_key#9);
>
>  *** DEADLOCK ***
>
> 1 lock held by syz-executor900/4483:
>  #0: 0000000025208078 (ashmem_mutex){+.+.}, at:
> ashmem_shrink_scan+0xb4/0x630 drivers/staging/android/ashmem.c:448

Reported-by: syzbot <syzkaller@googlegroups.com>
Cc: willy@infradead.org
Cc: stable@vger.kernel.org
Cc: peterz@infradead.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: NeilBrown <neilb@suse.com>
Suggested-by: NeilBrown <neilb@suse.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
v1->v2: Added Reviewed-by of NeilBrown and CC Andrew.

 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 41b9bbf24e16..8264bbdbb6a5 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2226,6 +2226,8 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 			mpol_shared_policy_init(&info->policy, NULL);
 			break;
 		}
+
+		lockdep_annotate_inode_mutex_key(inode);
 	} else
 		shmem_free_inode(sb);
 	return inode;
-- 
2.18.0.1017.ga543ac7ca45-goog

