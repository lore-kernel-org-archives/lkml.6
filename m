Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935215AbeB1VwD (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 16:52:03 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:37267 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935042AbeB1VwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 16:52:02 -0500
X-Google-Smtp-Source: AH8x224uuuXde2k9CMdKbgyGZzYPYuuDF8cir92WlHZ/U7RmuDuf+kVNQZMYeqUunhXbZbR9gGY6Ug==
Date: Thu, 1 Mar 2018 00:51:58 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: akpm@linux-foundation.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] uts: create "struct uts_namespace" from kmem_cache
Message-ID: <20180228215158.GA23146@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

So "struct uts_namespace" can enjoy fine-grained SLAB debugging and
usercopy protection.

I'd prefer shorter name "utsns" but there is "user_namespace" already.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/utsname.h |    6 ++++++
 init/main.c             |    2 ++
 kernel/utsname.c        |   20 ++++++++++++++++----
 3 files changed, 24 insertions(+), 4 deletions(-)

--- a/include/linux/utsname.h
+++ b/include/linux/utsname.h
@@ -44,6 +44,8 @@ static inline void put_uts_ns(struct uts_namespace *ns)
 {
 	kref_put(&ns->kref, free_uts_ns);
 }
+
+void uts_ns_init(void);
 #else
 static inline void get_uts_ns(struct uts_namespace *ns)
 {
@@ -61,6 +63,10 @@ static inline struct uts_namespace *copy_utsname(unsigned long flags,
 
 	return old_ns;
 }
+
+static inline void uts_ns_init(void)
+{
+}
 #endif
 
 #ifdef CONFIG_PROC_SYSCTL
--- a/init/main.c
+++ b/init/main.c
@@ -51,6 +51,7 @@
 #include <linux/taskstats_kern.h>
 #include <linux/delayacct.h>
 #include <linux/unistd.h>
+#include <linux/utsname.h>
 #include <linux/rmap.h>
 #include <linux/mempolicy.h>
 #include <linux/key.h>
@@ -689,6 +690,7 @@ asmlinkage __visible void __init start_kernel(void)
 	cred_init();
 	fork_init();
 	proc_caches_init();
+	uts_ns_init();
 	buffer_init();
 	key_init();
 	security_init();
--- a/kernel/utsname.c
+++ b/kernel/utsname.c
@@ -19,6 +19,8 @@
 #include <linux/proc_ns.h>
 #include <linux/sched/task.h>
 
+static struct kmem_cache *uts_ns_cache __ro_after_init;
+
 static struct ucounts *inc_uts_namespaces(struct user_namespace *ns)
 {
 	return inc_ucount(ns, current_euid(), UCOUNT_UTS_NAMESPACES);
@@ -33,7 +35,7 @@ static struct uts_namespace *create_uts_ns(void)
 {
 	struct uts_namespace *uts_ns;
 
-	uts_ns = kmalloc(sizeof(struct uts_namespace), GFP_KERNEL);
+	uts_ns = kmem_cache_alloc(uts_ns_cache, GFP_KERNEL);
 	if (uts_ns)
 		kref_init(&uts_ns->kref);
 	return uts_ns;
@@ -42,7 +44,7 @@ static struct uts_namespace *create_uts_ns(void)
 /*
  * Clone a new ns copying an original utsname, setting refcount to 1
  * @old_ns: namespace to clone
- * Return ERR_PTR(-ENOMEM) on error (failure to kmalloc), new ns otherwise
+ * Return ERR_PTR(-ENOMEM) on error (failure to allocate), new ns otherwise
  */
 static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
 					  struct uts_namespace *old_ns)
@@ -75,7 +77,7 @@ static struct uts_namespace *clone_uts_ns(struct user_namespace *user_ns,
 	return ns;
 
 fail_free:
-	kfree(ns);
+	kmem_cache_free(uts_ns_cache, ns);
 fail_dec:
 	dec_uts_namespaces(ucounts);
 fail:
@@ -113,7 +115,7 @@ void free_uts_ns(struct kref *kref)
 	dec_uts_namespaces(ns->ucounts);
 	put_user_ns(ns->user_ns);
 	ns_free_inum(&ns->ns);
-	kfree(ns);
+	kmem_cache_free(uts_ns_cache, ns);
 }
 
 static inline struct uts_namespace *to_uts_ns(struct ns_common *ns)
@@ -169,3 +171,13 @@ const struct proc_ns_operations utsns_operations = {
 	.install	= utsns_install,
 	.owner		= utsns_owner,
 };
+
+void __init uts_ns_init(void)
+{
+	uts_ns_cache = kmem_cache_create_usercopy(
+			"uts_namespace", sizeof(struct uts_namespace), 0,
+			SLAB_PANIC|SLAB_ACCOUNT,
+			offsetof(struct uts_namespace, name),
+			sizeof_field(struct uts_namespace, name),
+			NULL);
+}
