Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751411AbeCTSvM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 14:51:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50342 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751186AbeCTSvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 14:51:10 -0400
X-Google-Smtp-Source: AG47ELsGnjQflLLWmBiKi+Atq+iN6laE05korcr/MqToxz58PtDaK2UE85hztTZ1LT9E5E5Fz/A6wQ==
Date: Tue, 20 Mar 2018 21:51:06 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: ebiederm@xmission.com, xemul@virtuozzo.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pidns: simpler allocation of pid_* caches
Message-ID: <20180320185106.GA325@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Those pid_* caches are created on demand when a process advances to the new
level of pid namespace. Which means pointers are stable, write only and
thus can be packed into an array instead of spreading them over and using
lists(!) to find them.

Both first and subsequent clone/unshare(CLONE_NEWPID) become faster.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 kernel/pid_namespace.c |   67 +++++++++++++++++--------------------------------
 1 file changed, 24 insertions(+), 43 deletions(-)

--- a/kernel/pid_namespace.c
+++ b/kernel/pid_namespace.c
@@ -23,55 +23,39 @@
 #include <linux/sched/signal.h>
 #include <linux/idr.h>
 
-struct pid_cache {
-	int nr_ids;
-	char name[16];
-	struct kmem_cache *cachep;
-	struct list_head list;
-};
-
-static LIST_HEAD(pid_caches_lh);
 static DEFINE_MUTEX(pid_caches_mutex);
 static struct kmem_cache *pid_ns_cachep;
+/* MAX_PID_NS_LEVEL is needed for limiting size of 'struct pid' */
+#define MAX_PID_NS_LEVEL 32
+/* Write once array, filled from the beginning. */
+static struct kmem_cache *pid_cache[MAX_PID_NS_LEVEL];
 
 /*
  * creates the kmem cache to allocate pids from.
- * @nr_ids: the number of numerical ids this pid will have to carry
+ * @level: pid namespace level
  */
 
-static struct kmem_cache *create_pid_cachep(int nr_ids)
+static struct kmem_cache *create_pid_cachep(unsigned int level)
 {
-	struct pid_cache *pcache;
-	struct kmem_cache *cachep;
-
+	/* Level 0 is init_pid_ns.pid_cachep */
+	struct kmem_cache **pkc = &pid_cache[level - 1];
+	struct kmem_cache *kc;
+	char name[4 + 10 + 1];
+	unsigned int len;
+
+	kc = READ_ONCE(*pkc);
+	if (kc)
+		return kc;
+
+	snprintf(name, sizeof(name), "pid_%u", level + 1);
+	len = sizeof(struct pid) + level * sizeof(struct upid);
 	mutex_lock(&pid_caches_mutex);
-	list_for_each_entry(pcache, &pid_caches_lh, list)
-		if (pcache->nr_ids == nr_ids)
-			goto out;
-
-	pcache = kmalloc(sizeof(struct pid_cache), GFP_KERNEL);
-	if (pcache == NULL)
-		goto err_alloc;
-
-	snprintf(pcache->name, sizeof(pcache->name), "pid_%d", nr_ids);
-	cachep = kmem_cache_create(pcache->name,
-			sizeof(struct pid) + (nr_ids - 1) * sizeof(struct upid),
-			0, SLAB_HWCACHE_ALIGN, NULL);
-	if (cachep == NULL)
-		goto err_cachep;
-
-	pcache->nr_ids = nr_ids;
-	pcache->cachep = cachep;
-	list_add(&pcache->list, &pid_caches_lh);
-out:
+	/* Name collision forces to do allocation under mutex. */
+	if (!*pkc)
+		*pkc = kmem_cache_create(name, len, 0, SLAB_HWCACHE_ALIGN, 0);
 	mutex_unlock(&pid_caches_mutex);
-	return pcache->cachep;
-
-err_cachep:
-	kfree(pcache);
-err_alloc:
-	mutex_unlock(&pid_caches_mutex);
-	return NULL;
+	/* current can fail, but someone else can succeed. */
+	return READ_ONCE(*pkc);
 }
 
 static void proc_cleanup_work(struct work_struct *work)
@@ -80,9 +64,6 @@ static void proc_cleanup_work(struct work_struct *work)
 	pid_ns_release_proc(ns);
 }
 
-/* MAX_PID_NS_LEVEL is needed for limiting size of 'struct pid' */
-#define MAX_PID_NS_LEVEL 32
-
 static struct ucounts *inc_pid_namespaces(struct user_namespace *ns)
 {
 	return inc_ucount(ns, current_euid(), UCOUNT_PID_NAMESPACES);
@@ -119,7 +100,7 @@ static struct pid_namespace *create_pid_namespace(struct user_namespace *user_ns
 
 	idr_init(&ns->idr);
 
-	ns->pid_cachep = create_pid_cachep(level + 1);
+	ns->pid_cachep = create_pid_cachep(level);
 	if (ns->pid_cachep == NULL)
 		goto out_free_idr;
 
