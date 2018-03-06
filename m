Return-Path: <pasha.tatashin@oracle.com>
X-Google-Smtp-Source: AG47ELuDVcYVfBUqudgK5VCK10le+gjPh09w2fQoo2JFBf5jxYl4xYjMheTwO7gI6kfAKnxj5IE+
ARC-Seal: i=1; a=rsa-sha256; t=1520295986; cv=none;
        d=google.com; s=arc-20160816;
        b=VYMCNp9963TPFiAeumfS6jpDe1KNEDKBt8WMr+QgplL/j6Q3dCELcYzc4D+0MEMoQ9
         ymPVbNdu3BB1EsMpYvnLV6AgWfVEqTcqVfJC3xAeNATkn4jPIjlatR8ZXW7DVDer2uEk
         LyMmA5taC7jPtP4tt6o4+cWdneXTmMtqOlOhN63+P3dReyEa0tU6nzlCYndVDfziqOBX
         q/rJF1P82+nGyccDgB/XmEgGg7ZGkfS0zFLlrp/YZ9yECQF2ttZrbVLbpdpdsiiylWIB
         wdONBOJxyepYlkzmx/eXcEMSyRZF1D/Wvq1OToYVUo4QFJxUO40UWapBJRuc/K/hSIwk
         Wdrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:to:from
         :dkim-signature:arc-authentication-results;
        bh=XAY3/a1hjoDu3QqCa+Dsmj71oh5kp9BSMf+BCRpg918=;
        b=xvU5kKEz8tulzohZf5MiXXXcWfK666tEogaM7GdeHB2BI/0QoJJ4O3ob9urRAYTUSu
         e358CjxE2t6ll5MgSuuV62wMYTYSyc5Thd9WgZCqhWrXwzuvrEVhnI29IMllnQUarBnH
         qRenbql8yE7/lXGnotLMR2I/vRQ48GdJV7i7hib6x7uFkbHc4QdObtyuN4gnovnYa9YW
         LcIAarnfslXkRqR/tLypXqkacGman1opM/qubYz4dKrYU0HnHabjCXcW8QczaBXhuvTA
         DHkQHJkf4rxJt0j99BhgOqOJXO4UtEvidDVX6OclGNLDJc58u49xgMlic72S3HV4VMxu
         sACw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=jj9JAs1R;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@oracle.com header.s=corp-2017-10-26 header.b=jj9JAs1R;
       spf=pass (google.com: domain of pasha.tatashin@oracle.com designates 156.151.31.86 as permitted sender) smtp.mailfrom=pasha.tatashin@oracle.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=oracle.com
From: Pavel Tatashin <pasha.tatashin@oracle.com>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux-kernel@vger.kernel.org, Alexander.Levin@microsoft.com,
        dan.j.williams@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        pankaj.laxminarayan.bharadiya@intel.com, akuster@mvista.com,
        cminyard@mvista.com, pasha.tatashin@oracle.com,
        gregkh@linuxfoundation.org, stable@vger.kernel.org
Subject: [PATCH 4.1 29/65] kaiser: stack map PAGE_SIZE at THREAD_SIZE-PAGE_SIZE
Date: Mon,  5 Mar 2018 19:25:02 -0500
Message-Id: <20180306002538.1761-30-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180306002538.1761-1-pasha.tatashin@oracle.com>
References: <20180306002538.1761-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8823 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=995
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1803060003
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594145884808560889?=
X-GMAIL-MSGID: =?utf-8?q?1594145884808560889?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Hugh Dickins <hughd@google.com>

Kaiser only needs to map one page of the stack; and
kernel/fork.c did not build on powerpc (no __PAGE_KERNEL).
It's all cleaner if linux/kaiser.h provides kaiser_map_thread_stack()
and kaiser_unmap_thread_stack() wrappers around asm/kaiser.h's
kaiser_add_mapping() and kaiser_remove_mapping().  And use
linux/kaiser.h in init/main.c to avoid the #ifdefs there.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
(cherry picked from commit 003e476716906afa135faf605ae0a5c3598c0293)
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>

Conflicts:
	init/main.c
---
 include/linux/kaiser.h | 40 +++++++++++++++++++++++++++++++++-------
 init/main.c            |  6 +-----
 kernel/fork.c          |  7 ++-----
 3 files changed, 36 insertions(+), 17 deletions(-)

diff --git a/include/linux/kaiser.h b/include/linux/kaiser.h
index 9db5433c2284..4a4d6d911a14 100644
--- a/include/linux/kaiser.h
+++ b/include/linux/kaiser.h
@@ -1,26 +1,52 @@
-#ifndef _INCLUDE_KAISER_H
-#define _INCLUDE_KAISER_H
+#ifndef _LINUX_KAISER_H
+#define _LINUX_KAISER_H
 
 #ifdef CONFIG_KAISER
 #include <asm/kaiser.h>
+
+static inline int kaiser_map_thread_stack(void *stack)
+{
+	/*
+	 * Map that page of kernel stack on which we enter from user context.
+	 */
+	return kaiser_add_mapping((unsigned long)stack +
+			THREAD_SIZE - PAGE_SIZE, PAGE_SIZE, __PAGE_KERNEL);
+}
+
+static inline void kaiser_unmap_thread_stack(void *stack)
+{
+	/*
+	 * Note: may be called even when kaiser_map_thread_stack() failed.
+	 */
+	kaiser_remove_mapping((unsigned long)stack +
+			THREAD_SIZE - PAGE_SIZE, PAGE_SIZE);
+}
 #else
 
 /*
  * These stubs are used whenever CONFIG_KAISER is off, which
- * includes architectures that support KAISER, but have it
- * disabled.
+ * includes architectures that support KAISER, but have it disabled.
  */
 
 static inline void kaiser_init(void)
 {
 }
-static inline void kaiser_remove_mapping(unsigned long start, unsigned long size)
+static inline int kaiser_add_mapping(unsigned long addr,
+				     unsigned long size, unsigned long flags)
+{
+	return 0;
+}
+static inline void kaiser_remove_mapping(unsigned long start,
+					 unsigned long size)
 {
 }
-static inline int kaiser_add_mapping(unsigned long addr, unsigned long size, unsigned long flags)
+static inline int kaiser_map_thread_stack(void *stack)
 {
 	return 0;
 }
+static inline void kaiser_unmap_thread_stack(void *stack)
+{
+}
 
 #endif /* !CONFIG_KAISER */
-#endif /* _INCLUDE_KAISER_H */
+#endif /* _LINUX_KAISER_H */
diff --git a/init/main.c b/init/main.c
index de1951eaf1cc..c8d3596a721f 100644
--- a/init/main.c
+++ b/init/main.c
@@ -81,15 +81,13 @@
 #include <linux/integrity.h>
 #include <linux/proc_ns.h>
 #include <linux/io.h>
+#include <linux/kaiser.h>
 
 #include <asm/io.h>
 #include <asm/bugs.h>
 #include <asm/setup.h>
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
-#ifdef CONFIG_KAISER
-#include <asm/kaiser.h>
-#endif
 
 static int kernel_init(void *);
 
@@ -490,9 +488,7 @@ static void __init mm_init(void)
 	pgtable_init();
 	vmalloc_init();
 	ioremap_huge_init();
-#ifdef CONFIG_KAISER
 	kaiser_init();
-#endif
 }
 
 asmlinkage __visible void __init start_kernel(void)
diff --git a/kernel/fork.c b/kernel/fork.c
index eb1ca74c48ce..823bcff9b047 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -168,12 +168,9 @@ static struct thread_info *alloc_thread_info_node(struct task_struct *tsk,
 	return page ? page_address(page) : NULL;
 }
 
-extern void kaiser_remove_mapping(unsigned long start_addr, unsigned long size);
 static inline void free_thread_info(struct thread_info *ti)
 {
-#ifdef CONFIG_KAISER
-	kaiser_remove_mapping((unsigned long)ti, THREAD_SIZE);
-#endif
+	kaiser_unmap_thread_stack(ti);
 	free_kmem_pages((unsigned long)ti, THREAD_SIZE_ORDER);
 }
 # else
@@ -351,7 +348,7 @@ static struct task_struct *dup_task_struct(struct task_struct *orig)
 
 	tsk->stack = ti;
 
-	err= kaiser_add_mapping((unsigned long)tsk->stack, THREAD_SIZE, __PAGE_KERNEL);
+	err = kaiser_map_thread_stack(tsk->stack);
 	if (err)
 		goto free_ti;
 #ifdef CONFIG_SECCOMP
-- 
2.16.2
