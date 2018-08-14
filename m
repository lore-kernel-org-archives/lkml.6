Return-Path: <SRS0=Rtk1=K5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA02C46464
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:17:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03723216EE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Aug 2018 16:17:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="RJGdLcg4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03723216EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbeHNTEr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Aug 2018 15:04:47 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40307 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731019AbeHNTEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Aug 2018 15:04:47 -0400
Received: by mail-pg1-f195.google.com with SMTP id x5-v6so9312464pgp.7
        for <linux-kernel@vger.kernel.org>; Tue, 14 Aug 2018 09:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6BL5K3kVJVHWOHPhAygE7zY9VQyoDJoHovVdB5Nsq7I=;
        b=RJGdLcg48Ix4sJp3W4wrHEtQ0se+/lHwBtmRcnmkLuga7JCcEIrqI+j/2wGw98UFxR
         COWZMGOVeIm8wjXn7P8Uz66PU4rEcFb88w3aNS28nQMSsUiYVXbp/PRZMfqQ4c19mxG+
         M8cE94ILiHsf+6kzKd2pDyhFLb40a4Qr87JI0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6BL5K3kVJVHWOHPhAygE7zY9VQyoDJoHovVdB5Nsq7I=;
        b=PNDM+yPi1wuPqiJN4ndGa9+ayd6B5ltAPiOM2ZuWZfUsWdO+u012Ee3CulabM3fAWj
         2xHkuT8Mjm2HkRw3no/bEg/Ll8ZjWskRGSs5I6bvCshElBBFS03yXK7Rsu+7lVNaglFd
         HoSf0V46p8WAnwF7VjNtzv+Or5eLFB0+M3svqPz5zIWjh6QhIwj/aE6HIt8xizZ0SeT3
         2kO5GuRNkLJ9J2i5k7feR85FQQgAa5ngRpY7VD3GtKjbuXbQBSA/0A0i/VlZnVPF6eLa
         BaLSAWtcN91K6rab3WRnJsJVQkQhPBsLLbkfp3rr6ljhVOnpvy5xzD24c8g4ZLdZyaBe
         /8Fg==
X-Gm-Message-State: AOUpUlGO2uI6DjHPQ19QvabU/pgI5EO2DVf0bDc2qeE/OR0LK0Q1tBZa
        7hByO3i1XBzfEFLm3hp7hpW/BxK2MJ8=
X-Google-Smtp-Source: AA+uWPyDIMy2MUI1CsgcH5nnwqoZV2lcuo6jSidnyXcvPFFd1xqsBPGWDTxPflgNw6smlCE7/wsZEg==
X-Received: by 2002:a62:3601:: with SMTP id d1-v6mr24064739pfa.41.1534263418065;
        Tue, 14 Aug 2018 09:16:58 -0700 (PDT)
Received: from joelaf-glaptop0.roam.corp.google.com (c-98-210-118-128.hsd1.ca.comcast.net. [98.210.118.128])
        by smtp.gmail.com with ESMTPSA id x15-v6sm20988611pgc.46.2018.08.14.09.16.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Aug 2018 09:16:57 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     kernel-team@android.com, Joel Fernandes <joel@joelfernandes.org>,
        willy@infradead.org, stable@vger.kernel.org, peterz@infradead.org,
        linux-mm@kvack.org, Neil Brown <neilb@suse.com>
Subject: [PATCH] mm: shmem: Correctly annotate new inodes
Date:   Tue, 14 Aug 2018 09:16:52 -0700
Message-Id: <20180814161652.28831-1-joel@joelfernandes.org>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
Suggested-by: Neil Brown <neilb@suse.com>
Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 mm/shmem.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/shmem.c b/mm/shmem.c
index 2cab84403055..4429a8fd932d 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2225,6 +2225,8 @@ static struct inode *shmem_get_inode(struct super_block *sb, const struct inode
 			mpol_shared_policy_init(&info->policy, NULL);
 			break;
 		}
+
+		lockdep_annotate_inode_mutex_key(inode);
 	} else
 		shmem_free_inode(sb);
 	return inode;
-- 
2.18.0.597.ga71716f1ad-goog

