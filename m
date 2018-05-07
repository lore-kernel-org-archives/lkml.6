Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752023AbeEGH4e (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 03:56:34 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:38508 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751378AbeEGH4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 03:56:32 -0400
X-Google-Smtp-Source: AB8JxZrzstPumuaUXqQ4jJgGG4ygGCzAatC2FrUcAYgwjYHa7EsIlMOINWszo7eNWGqmZiq/D0lzXQ==
Message-Id: <20180507075606.786573575@gmail.com>
User-Agent: quilt/0.65
Date: Mon, 07 May 2018 10:52:15 +0300
From: Cyrill Gorcunov <gorcunov@gmail.com>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Jonathan de Boyne Pollard
        <J.deBoynePollard-newsgroups@NTLWorld.COM>,
        Andrey Vagin <avagin@openvz.org>,
        Andrew Morton <akpm@linuxfoundation.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Michal Hocko <mhocko@kernel.org>, Cyrill Gorcunov <gorcunov@gmail.com>
Subject: [rfc linux-next 2/3] [RFC] prctl: prctl_set_mm -- Make prctl_set_mm_map to accept map as an argument
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline; filename=prctl-use-prctl_map
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once we make it to accept struct prctl_mm_map as an argument it will
be possible to reuse this functionallity for the rest of PR_SET_MM_x
operations. Here we simply allocate struct prctl_mm_map in a caller
and provide it downstairs.

CC: Jonathan de Boyne Pollard <J.deBoynePollard-newsgroups@NTLWorld.COM>
CC: Andrey Vagin <avagin@openvz.org>
CC: Andrew Morton <akpm@linuxfoundation.org>
CC: Michael Kerrisk <mtk.manpages@gmail.com>
CC: Yang Shi <yang.shi@linux.alibaba.com>
CC: Michal Hocko <mhocko@kernel.org>
Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
---
 kernel/sys.c |   59 +++++++++++++++++++++++++++++++----------------------------
 1 file changed, 31 insertions(+), 28 deletions(-)

Index: linux-ml.git/kernel/sys.c
===================================================================
--- linux-ml.git.orig/kernel/sys.c
+++ linux-ml.git/kernel/sys.c
@@ -1969,9 +1969,8 @@ exit_err:
 	goto exit;
 }
 
-static int prctl_set_mm_map(int opt, const void __user *addr, unsigned long data_size)
+static int prctl_set_mm_map(struct prctl_mm_map *prctl_map)
 {
-	struct prctl_mm_map prctl_map = { .exe_fd = (u32)-1, };
 	unsigned long user_auxv[AT_VECTOR_SIZE];
 	struct mm_struct *mm = current->mm;
 	int error;
@@ -1979,21 +1978,15 @@ static int prctl_set_mm_map(int opt, con
 	BUILD_BUG_ON(sizeof(user_auxv) != sizeof(mm->saved_auxv));
 	BUILD_BUG_ON(sizeof(struct prctl_mm_map) > 256);
 
-	if (data_size != sizeof(prctl_map))
-		return -EINVAL;
-
-	if (copy_from_user(&prctl_map, addr, sizeof(prctl_map)))
-		return -EFAULT;
-
-	error = validate_prctl_map(&prctl_map);
+	error = validate_prctl_map(prctl_map);
 	if (error)
 		return error;
 
-	if (prctl_map.auxv_size) {
+	if (prctl_map->auxv_size) {
 		memset(user_auxv, 0, sizeof(user_auxv));
 		if (copy_from_user(user_auxv,
-				   (const void __user *)prctl_map.auxv,
-				   prctl_map.auxv_size))
+				   (const void __user *)prctl_map->auxv,
+				   prctl_map->auxv_size))
 			return -EFAULT;
 
 		/* Last entry must be AT_NULL as specification requires */
@@ -2001,8 +1994,8 @@ static int prctl_set_mm_map(int opt, con
 		user_auxv[AT_VECTOR_SIZE - 1] = AT_NULL;
 	}
 
-	if (prctl_map.exe_fd != (u32)-1) {
-		error = prctl_set_mm_exe_file(mm, prctl_map.exe_fd);
+	if (prctl_map->exe_fd != (u32)-1) {
+		error = prctl_set_mm_exe_file(mm, prctl_map->exe_fd);
 		if (error)
 			return error;
 	}
@@ -2026,17 +2019,17 @@ static int prctl_set_mm_map(int opt, con
 	 */
 
 	spin_lock(&mm->arg_lock);
-	mm->start_code	= prctl_map.start_code;
-	mm->end_code	= prctl_map.end_code;
-	mm->start_data	= prctl_map.start_data;
-	mm->end_data	= prctl_map.end_data;
-	mm->start_brk	= prctl_map.start_brk;
-	mm->brk		= prctl_map.brk;
-	mm->start_stack	= prctl_map.start_stack;
-	mm->arg_start	= prctl_map.arg_start;
-	mm->arg_end	= prctl_map.arg_end;
-	mm->env_start	= prctl_map.env_start;
-	mm->env_end	= prctl_map.env_end;
+	mm->start_code	= prctl_map->start_code;
+	mm->end_code	= prctl_map->end_code;
+	mm->start_data	= prctl_map->start_data;
+	mm->end_data	= prctl_map->end_data;
+	mm->start_brk	= prctl_map->start_brk;
+	mm->brk		= prctl_map->brk;
+	mm->start_stack	= prctl_map->start_stack;
+	mm->arg_start	= prctl_map->arg_start;
+	mm->arg_end	= prctl_map->arg_end;
+	mm->env_start	= prctl_map->env_start;
+	mm->env_end	= prctl_map->env_end;
 	spin_unlock(&mm->arg_lock);
 
 	/*
@@ -2047,7 +2040,7 @@ static int prctl_set_mm_map(int opt, con
 	 * not introduce additional locks here making the kernel
 	 * more complex.
 	 */
-	if (prctl_map.auxv_size)
+	if (prctl_map->auxv_size)
 		memcpy(mm->saved_auxv, user_auxv, sizeof(user_auxv));
 
 	up_read(&mm->mmap_sem);
@@ -2063,8 +2056,18 @@ static int prctl_set_mm(int opt, unsigne
 		return put_user((unsigned int)sizeof(struct prctl_mm_map),
 				(unsigned int __user *)addr);
 
-	if (opt == PR_SET_MM_MAP)
-		return prctl_set_mm_map(opt, (const void __user *)addr, arg4);
+	if (opt == PR_SET_MM_MAP) {
+		struct prctl_mm_map prctl_map = { .exe_fd = (u32)-1, };
+
+		if (arg4 != sizeof(prctl_map))
+			return -EINVAL;
+
+		if (copy_from_user(&prctl_map, (const void __user *)addr,
+				   sizeof(prctl_map)))
+			return -EFAULT;
+
+		return prctl_set_mm_map(&prctl_map);
+	}
 #endif
 
 	pr_warn_once("PR_SET_MM_* has been removed. Use PR_SET_MM_MAP instead\n");
