Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753992AbeDTH3K (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 03:29:10 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34217 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753935AbeDTH3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 03:29:08 -0400
X-Google-Smtp-Source: AIpwx487ZMXuood+hJKSlTA8IlbVPz31J+OXjkyM1UlzuTbFVsRNqCSpO/x9n/dNOqyKGKYo1ulSBQ==
Date: Fri, 20 Apr 2018 16:29:03 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [v2] prctl: Deprecate non PR_SET_MM_MAP operations
Message-ID: <20180420072903.GA594@jagdpanzerIV>
References: <20180405182651.GM15783@uranus.lan>
 <20180420023809.GD6397@jagdpanzerIV>
 <20180420070257.GJ19578@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180420070257.GJ19578@uranus.lan>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/20/18 10:02), Cyrill Gorcunov wrote:
> On Fri, Apr 20, 2018 at 11:38:09AM +0900, Sergey Senozhatsky wrote:
> > On (04/05/18 21:26), Cyrill Gorcunov wrote:
> > [..]
> > > -
> > >  #ifdef CONFIG_CHECKPOINT_RESTORE
> > >  	if (opt == PR_SET_MM_MAP || opt == PR_SET_MM_MAP_SIZE)
> > >  		return prctl_set_mm_map(opt, (const void __user *)addr, arg4);
> > >  #endif
> > >  
> > > -	if (!capable(CAP_SYS_RESOURCE))
> > > -		return -EPERM;
> > > -
> > > -	if (opt == PR_SET_MM_EXE_FILE)
> > > -		return prctl_set_mm_exe_file(mm, (unsigned int)addr);
> > > -
> > > -	if (opt == PR_SET_MM_AUXV)
> > > -		return prctl_set_auxv(mm, addr, arg4);
> > 
> > Then validate_prctl_map() and prctl_set_mm_exe_file() can be moved
> > under CONFIG_CHECKPOINT_RESTORE ifdef.
> 
> I don't mind. Could you please make the patch on top of linux-next?

As far as I can see, it's not in linux-next yet. So the following is
against the mmots tree. I wouldn't mind it if we could just squash the
patches.

=======================================================================

From: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Subject: [PATCH] prctl: Don't compile some of prctl functions when CRUI
 disabled

CHECKPOINT_RESTORE is the only user of validate_prctl_map()
and prctl_set_mm_exe_file(), so we can move those two under
CONFIG_CHECKPOINT_RESTORE.

Signed-off-by: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
---
 kernel/sys.c | 126 +++++++++++++++++++++++++--------------------------
 1 file changed, 63 insertions(+), 63 deletions(-)

diff --git a/kernel/sys.c b/kernel/sys.c
index 6bdffe264303..86e5ef1a5612 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1815,68 +1815,7 @@ SYSCALL_DEFINE1(umask, int, mask)
 	return mask;
 }
 
-static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
-{
-	struct fd exe;
-	struct file *old_exe, *exe_file;
-	struct inode *inode;
-	int err;
-
-	exe = fdget(fd);
-	if (!exe.file)
-		return -EBADF;
-
-	inode = file_inode(exe.file);
-
-	/*
-	 * Because the original mm->exe_file points to executable file, make
-	 * sure that this one is executable as well, to avoid breaking an
-	 * overall picture.
-	 */
-	err = -EACCES;
-	if (!S_ISREG(inode->i_mode) || path_noexec(&exe.file->f_path))
-		goto exit;
-
-	err = inode_permission(inode, MAY_EXEC);
-	if (err)
-		goto exit;
-
-	/*
-	 * Forbid mm->exe_file change if old file still mapped.
-	 */
-	exe_file = get_mm_exe_file(mm);
-	err = -EBUSY;
-	if (exe_file) {
-		struct vm_area_struct *vma;
-
-		down_read(&mm->mmap_sem);
-		for (vma = mm->mmap; vma; vma = vma->vm_next) {
-			if (!vma->vm_file)
-				continue;
-			if (path_equal(&vma->vm_file->f_path,
-				       &exe_file->f_path))
-				goto exit_err;
-		}
-
-		up_read(&mm->mmap_sem);
-		fput(exe_file);
-	}
-
-	err = 0;
-	/* set the new file, lockless */
-	get_file(exe.file);
-	old_exe = xchg(&mm->exe_file, exe.file);
-	if (old_exe)
-		fput(old_exe);
-exit:
-	fdput(exe);
-	return err;
-exit_err:
-	up_read(&mm->mmap_sem);
-	fput(exe_file);
-	goto exit;
-}
-
+#ifdef CONFIG_CHECKPOINT_RESTORE
 /*
  * WARNING: we don't require any capability here so be very careful
  * in what is allowed for modification from userspace.
@@ -1968,7 +1907,68 @@ static int validate_prctl_map(struct prctl_mm_map *prctl_map)
 	return error;
 }
 
-#ifdef CONFIG_CHECKPOINT_RESTORE
+static int prctl_set_mm_exe_file(struct mm_struct *mm, unsigned int fd)
+{
+	struct fd exe;
+	struct file *old_exe, *exe_file;
+	struct inode *inode;
+	int err;
+
+	exe = fdget(fd);
+	if (!exe.file)
+		return -EBADF;
+
+	inode = file_inode(exe.file);
+
+	/*
+	 * Because the original mm->exe_file points to executable file, make
+	 * sure that this one is executable as well, to avoid breaking an
+	 * overall picture.
+	 */
+	err = -EACCES;
+	if (!S_ISREG(inode->i_mode) || path_noexec(&exe.file->f_path))
+		goto exit;
+
+	err = inode_permission(inode, MAY_EXEC);
+	if (err)
+		goto exit;
+
+	/*
+	 * Forbid mm->exe_file change if old file still mapped.
+	 */
+	exe_file = get_mm_exe_file(mm);
+	err = -EBUSY;
+	if (exe_file) {
+		struct vm_area_struct *vma;
+
+		down_read(&mm->mmap_sem);
+		for (vma = mm->mmap; vma; vma = vma->vm_next) {
+			if (!vma->vm_file)
+				continue;
+			if (path_equal(&vma->vm_file->f_path,
+				       &exe_file->f_path))
+				goto exit_err;
+		}
+
+		up_read(&mm->mmap_sem);
+		fput(exe_file);
+	}
+
+	err = 0;
+	/* set the new file, lockless */
+	get_file(exe.file);
+	old_exe = xchg(&mm->exe_file, exe.file);
+	if (old_exe)
+		fput(old_exe);
+exit:
+	fdput(exe);
+	return err;
+exit_err:
+	up_read(&mm->mmap_sem);
+	fput(exe_file);
+	goto exit;
+}
+
 static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data_size)
 {
 	struct prctl_mm_map prctl_map = { .exe_fd = (u32)-1, };
-- 
2.17.0
