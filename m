Return-Path: <SRS0=+AQW=M2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 828C5C71122
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:34:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A5DA2087D
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Oct 2018 15:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A5DA2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbeJNXPu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 14 Oct 2018 19:15:50 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:36591 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727809AbeJNXPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Oct 2018 19:15:49 -0400
Received: from [2a02:8011:400e:2:cbab:f00:c93f:614] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiMD-0004cF-5h; Sun, 14 Oct 2018 16:31:05 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1gBiLP-0000E5-HX; Sun, 14 Oct 2018 16:30:15 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        "Manfred Spraul" <manfred@colorfullife.com>,
        "Davidlohr Bueso" <dbueso@suse.de>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        syzbot+d11f321e7f1923157eac80aa990b446596f46439@syzkaller.appspotmail.com,
        "Eric Biggers" <ebiggers@google.com>
Date:   Sun, 14 Oct 2018 16:25:41 +0100
Message-ID: <lsq.1539530741.238695223@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 068/366] ipc/shm: fix use-after-free of shm file via
 remap_file_pages()
In-Reply-To: <lsq.1539530740.755408431@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:cbab:f00:c93f:614
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.60-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Biggers <ebiggers@google.com>

commit 3f05317d9889ab75c7190dcd39491d2a97921984 upstream.

syzbot reported a use-after-free of shm_file_data(file)->file->f_op in
shm_get_unmapped_area(), called via sys_remap_file_pages().

Unfortunately it couldn't generate a reproducer, but I found a bug which
I think caused it.  When remap_file_pages() is passed a full System V
shared memory segment, the memory is first unmapped, then a new map is
created using the ->vm_file.  Between these steps, the shm ID can be
removed and reused for a new shm segment.  But, shm_mmap() only checks
whether the ID is currently valid before calling the underlying file's
->mmap(); it doesn't check whether it was reused.  Thus it can use the
wrong underlying file, one that was already freed.

Fix this by making the "outer" shm file (the one that gets put in
->vm_file) hold a reference to the real shm file, and by making
__shm_open() require that the file associated with the shm ID matches
the one associated with the "outer" file.

Taking the reference to the real shm file is needed to fully solve the
problem, since otherwise sfd->file could point to a freed file, which
then could be reallocated for the reused shm ID, causing the wrong shm
segment to be mapped (and without the required permission checks).

Commit 1ac0b6dec656 ("ipc/shm: handle removed segments gracefully in
shm_mmap()") almost fixed this bug, but it didn't go far enough because
it didn't consider the case where the shm ID is reused.

The following program usually reproduces this bug:

	#include <stdlib.h>
	#include <sys/shm.h>
	#include <sys/syscall.h>
	#include <unistd.h>

	int main()
	{
		int is_parent = (fork() != 0);
		srand(getpid());
		for (;;) {
			int id = shmget(0xF00F, 4096, IPC_CREAT|0700);
			if (is_parent) {
				void *addr = shmat(id, NULL, 0);
				usleep(rand() % 50);
				while (!syscall(__NR_remap_file_pages, addr, 4096, 0, 0, 0));
			} else {
				usleep(rand() % 50);
				shmctl(id, IPC_RMID, NULL);
			}
		}
	}

It causes the following NULL pointer dereference due to a 'struct file'
being used while it's being freed.  (I couldn't actually get a KASAN
use-after-free splat like in the syzbot report.  But I think it's
possible with this bug; it would just take a more extraordinary race...)

	BUG: unable to handle kernel NULL pointer dereference at 0000000000000058
	PGD 0 P4D 0
	Oops: 0000 [#1] SMP NOPTI
	CPU: 9 PID: 258 Comm: syz_ipc Not tainted 4.16.0-05140-gf8cf2f16a7c95 #189
	Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.11.0-20171110_100015-anatol 04/01/2014
	RIP: 0010:d_inode include/linux/dcache.h:519 [inline]
	RIP: 0010:touch_atime+0x25/0xd0 fs/inode.c:1724
	[...]
	Call Trace:
	 file_accessed include/linux/fs.h:2063 [inline]
	 shmem_mmap+0x25/0x40 mm/shmem.c:2149
	 call_mmap include/linux/fs.h:1789 [inline]
	 shm_mmap+0x34/0x80 ipc/shm.c:465
	 call_mmap include/linux/fs.h:1789 [inline]
	 mmap_region+0x309/0x5b0 mm/mmap.c:1712
	 do_mmap+0x294/0x4a0 mm/mmap.c:1483
	 do_mmap_pgoff include/linux/mm.h:2235 [inline]
	 SYSC_remap_file_pages mm/mmap.c:2853 [inline]
	 SyS_remap_file_pages+0x232/0x310 mm/mmap.c:2769
	 do_syscall_64+0x64/0x1a0 arch/x86/entry/common.c:287
	 entry_SYSCALL_64_after_hwframe+0x42/0xb7

[ebiggers@google.com: add comment]
  Link: http://lkml.kernel.org/r/20180410192850.235835-1-ebiggers3@gmail.com
Link: http://lkml.kernel.org/r/20180409043039.28915-1-ebiggers3@gmail.com
Reported-by: syzbot+d11f321e7f1923157eac80aa990b446596f46439@syzkaller.appspotmail.com
Fixes: c8d78c1823f4 ("mm: replace remap_file_pages() syscall with emulation")
Signed-off-by: Eric Biggers <ebiggers@google.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Cc: Manfred Spraul <manfred@colorfullife.com>
Cc: "Eric W . Biederman" <ebiederm@xmission.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 ipc/shm.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -197,6 +197,12 @@ static int __shm_open(struct vm_area_str
 	if (IS_ERR(shp))
 		return PTR_ERR(shp);
 
+	if (shp->shm_file != sfd->file) {
+		/* ID was reused */
+		shm_unlock(shp);
+		return -EINVAL;
+	}
+
 	shp->shm_atim = get_seconds();
 	ipc_update_pid(&shp->shm_lprid, task_tgid(current));
 	shp->shm_nattch++;
@@ -413,8 +419,9 @@ static int shm_mmap(struct file *file, s
 	int ret;
 
 	/*
-	 * In case of remap_file_pages() emulation, the file can represent
-	 * removed IPC ID: propogate shm_lock() error to caller.
+	 * In case of remap_file_pages() emulation, the file can represent an
+	 * IPC ID that was removed, and possibly even reused by another shm
+	 * segment already.  Propagate this case as an error to caller.
 	 */
 	ret =__shm_open(vma);
 	if (ret)
@@ -438,6 +445,7 @@ static int shm_release(struct inode *ino
 	struct shm_file_data *sfd = shm_file_data(file);
 
 	put_ipc_ns(sfd->ns);
+	fput(sfd->file);
 	shm_file_data(file) = NULL;
 	kfree(sfd);
 	return 0;
@@ -1197,7 +1205,16 @@ long do_shmat(int shmid, char __user *sh
 	file->f_mapping = shp->shm_file->f_mapping;
 	sfd->id = shp->shm_perm.id;
 	sfd->ns = get_ipc_ns(ns);
-	sfd->file = shp->shm_file;
+	/*
+	 * We need to take a reference to the real shm file to prevent the
+	 * pointer from becoming stale in cases where the lifetime of the outer
+	 * file extends beyond that of the shm segment.  It's not usually
+	 * possible, but it can happen during remap_file_pages() emulation as
+	 * that unmaps the memory, then does ->mmap() via file reference only.
+	 * We'll deny the ->mmap() if the shm segment was since removed, but to
+	 * detect shm ID reuse we need to compare the file pointers.
+	 */
+	sfd->file = get_file(shp->shm_file);
 	sfd->vm_ops = NULL;
 
 	err = security_mmap_file(file, prot, flags);

