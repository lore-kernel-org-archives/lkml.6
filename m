Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48609t1J8aYU9zNldIgaLQiwWX2HdC3UsBytAkTHo+k/yzwrYA60zyqDNwWpgD0W1GTedNc
ARC-Seal: i=1; a=rsa-sha256; t=1524406316; cv=none;
        d=google.com; s=arc-20160816;
        b=BEsdLsygh8eZPZH/DfRhwUOiXyXeMLCy3m7lwjcvnYZgqwS4u2dVph7liA29bPoU+R
         tqq1iGocJV+QpTLUEu3YMjjpXEqtFNwwrrLJzUDwgRayAaNT4DyEJSGCsjM560hJZi9B
         C27LsQ0bV7hcIKER8klMXY0Cu9jjAQW1+Wz9lrkV5ZQM2m6fALkwd2xETUKqsJIt71Fg
         hOOhG5oY+lXbGCSjyNCFRcPcVo0vT8p5lh02YmRus2NmgS3RDR1yYMx3gqYEa9KTA9mA
         AL+dg3DyMAau8LeWKlaSs6h+6sxcRxIbjQrsYNbCMuPaLdMfH7dMf4MyTRdnP0W/LdPq
         cOFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=KEaPhl5Dd2R2pvMNzQqp2bNre2rDS5WsZeZAxtMzWiw=;
        b=rhaM/Hfqe5eFabpWq5bN+AJqdV9LHcfsisTrQc2s24W8ZuEqWr4mmg+doi/5ky4s4x
         c103NBacsJhAzl9LFVWBMa9SFf2se3o/0uVPKXK4cmv/Vow8++2446zV2WwBkrvGEt7f
         t5fe2Za5/VNGP7/flU73iqZB8iFcglusteU48WJHKynv4EH2Zv79rjd6Z/1w9/wH6Wn3
         J3BZJ/I8rLs+OcrKVe9ArcIx7eWLrnnnsiyMCFStcAocLySvzxvTFjBZsNbUqg/6ZF1o
         sBy90ARwy+D5xwtb3Gl2shA1EQ/PN0DDdf94+aZLM8ljtGiqopU0BBuwrMhJwvyeWF1k
         uLqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	syzbot+d11f321e7f1923157eac80aa990b446596f46439@syzkaller.appspotmail.com,
	Eric Biggers <ebiggers@google.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Davidlohr Bueso <dbueso@suse.de>,
	Manfred Spraul <manfred@colorfullife.com>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 08/95] ipc/shm: fix use-after-free of shm file via remap_file_pages()
Date: Sun, 22 Apr 2018 15:52:37 +0200
Message-Id: <20180422135210.769584078@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
References: <20180422135210.432103639@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454808019159880?=
X-GMAIL-MSGID: =?utf-8?q?1598455878033786744?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 ipc/shm.c |   23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

--- a/ipc/shm.c
+++ b/ipc/shm.c
@@ -198,6 +198,12 @@ static int __shm_open(struct vm_area_str
 	if (IS_ERR(shp))
 		return PTR_ERR(shp);
 
+	if (shp->shm_file != sfd->file) {
+		/* ID was reused */
+		shm_unlock(shp);
+		return -EINVAL;
+	}
+
 	shp->shm_atim = get_seconds();
 	shp->shm_lprid = task_tgid_vnr(current);
 	shp->shm_nattch++;
@@ -425,8 +431,9 @@ static int shm_mmap(struct file *file, s
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
@@ -450,6 +457,7 @@ static int shm_release(struct inode *ino
 	struct shm_file_data *sfd = shm_file_data(file);
 
 	put_ipc_ns(sfd->ns);
+	fput(sfd->file);
 	shm_file_data(file) = NULL;
 	kfree(sfd);
 	return 0;
@@ -1212,7 +1220,16 @@ long do_shmat(int shmid, char __user *sh
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
