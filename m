Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754116AbeDTCiQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 22:38:16 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:42676 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753954AbeDTCiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 22:38:14 -0400
X-Google-Smtp-Source: AIpwx4/GyOEJbIrp0AdsAtIZHCaO1XArlfDC07wTiOBquljpLuYORIHXROjxwYGfKm12cfop2v6yng==
Date: Fri, 20 Apr 2018 11:38:09 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Cyrill Gorcunov <gorcunov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Michal Hocko <mhocko@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>, Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Pavel Emelyanov <xemul@virtuozzo.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>
Subject: Re: [v2] prctl: Deprecate non PR_SET_MM_MAP operations
Message-ID: <20180420023809.GD6397@jagdpanzerIV>
References: <20180405182651.GM15783@uranus.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180405182651.GM15783@uranus.lan>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (04/05/18 21:26), Cyrill Gorcunov wrote:
[..]
> -
>  #ifdef CONFIG_CHECKPOINT_RESTORE
>  	if (opt == PR_SET_MM_MAP || opt == PR_SET_MM_MAP_SIZE)
>  		return prctl_set_mm_map(opt, (const void __user *)addr, arg4);
>  #endif
>  
> -	if (!capable(CAP_SYS_RESOURCE))
> -		return -EPERM;
> -
> -	if (opt == PR_SET_MM_EXE_FILE)
> -		return prctl_set_mm_exe_file(mm, (unsigned int)addr);
> -
> -	if (opt == PR_SET_MM_AUXV)
> -		return prctl_set_auxv(mm, addr, arg4);

Then validate_prctl_map() and prctl_set_mm_exe_file() can be moved
under CONFIG_CHECKPOINT_RESTORE ifdef.

---

 kernel/sys.c | 126 +++++++++++++++++++++++++++++------------------------------
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
