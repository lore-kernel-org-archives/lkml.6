Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752693AbeDHDQt (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 23:16:49 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:52414 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752034AbeDHDQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 23:16:47 -0400
Date: Sat, 7 Apr 2018 20:16:46 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Dmitry Vyukov <dvyukov@google.com>
Cc: linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: Use struct page for filename
Message-ID: <20180408031646.GB32632@bombadil.infradead.org>
References: <001a114467482dbc4b05692df8f9@google.com>
 <CACT4Y+adiXih0-jfNGHgf1kEQ2=KLY5NdX-87BTDbrQgEAHc9g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+adiXih0-jfNGHgf1kEQ2=KLY5NdX-87BTDbrQgEAHc9g@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 06, 2018 at 03:33:36PM +0200, Dmitry Vyukov wrote:
> On Fri, Apr 6, 2018 at 3:24 PM, syzbot
> <syzbot+75397ee3df5c70164154@syzkaller.appspotmail.com> wrote:
> > cache_from_obj: Wrong slab cache. names_cache but object is from kmalloc-96
> 
> Al, do you see how this can happen?

I don't see how it happened, but when looking at this bug, I thought
"This is very complicated, I think there's a simpler way to handle this".

Here's a proposal.  It won't apply to any existing tree (depends on a
couple of local commits), but I think you'll get the general flavour
of it.  It's mostly compile-tested (build still running, but fs/ and
kernel/ compiled without issue).

 fs/dcache.c              |   7 ----
 fs/namei.c               | 102 ++++++++++++-----------------------------------
 include/linux/fs.h       |  26 ++++++------
 include/linux/mm_types.h |  12 +++++-
 kernel/auditsc.c         |   8 ++--
 5 files changed, 51 insertions(+), 104 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 593079176123..749b82b8fa1c 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3172,10 +3172,6 @@ static void __init dcache_init(void)
 	d_hash_shift = 32 - d_hash_shift;
 }
 
-/* SLAB cache for __getname() consumers */
-struct kmem_cache *names_cachep __read_mostly;
-EXPORT_SYMBOL(names_cachep);
-
 void __init vfs_caches_init_early(void)
 {
 	int i;
@@ -3189,9 +3185,6 @@ void __init vfs_caches_init_early(void)
 
 void __init vfs_caches_init(void)
 {
-	names_cachep = kmem_cache_create_usercopy("names_cache", PATH_MAX, 0,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC, 0, PATH_MAX, NULL);
-
 	dcache_init();
 	inode_init();
 	files_init();
diff --git a/fs/namei.c b/fs/namei.c
index a09419379f5d..16fb4779d29f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -122,71 +122,46 @@
  * PATH_MAX includes the nul terminator --RR.
  */
 
-#define EMBEDDED_NAME_MAX	(PATH_MAX - offsetof(struct filename, iname))
+struct filename *alloc_filename(void)
+{
+	struct page *page = alloc_page(GFP_KERNEL);
+
+	page->filename.name = page_to_virt(page);
+	return &page->filename;
+}
+
+void putname(struct filename *name)
+{
+	__free_page(container_of(name, struct page, filename));
+}
+
+void filename_get(struct filename *name)
+{
+	page_ref_inc(container_of(name, struct page, filename));
+}
 
 struct filename *
 getname_flags(const char __user *filename, int flags, int *empty)
 {
 	struct filename *result;
-	char *kname;
 	int len;
 
 	result = audit_reusename(filename);
 	if (result)
 		return result;
 
-	result = __getname();
+	result = alloc_filename();
 	if (unlikely(!result))
 		return ERR_PTR(-ENOMEM);
 
-	/*
-	 * First, try to embed the struct filename inside the names_cache
-	 * allocation
-	 */
-	kname = (char *)result->iname;
-	result->name = kname;
-
-	len = strncpy_from_user(kname, filename, EMBEDDED_NAME_MAX);
+	len = strncpy_from_user((char *)result->name, filename, PATH_MAX);
+	if (unlikely(len == PATH_MAX))
+		len = -ENAMETOOLONG;
 	if (unlikely(len < 0)) {
-		__putname(result);
+		putname(result);
 		return ERR_PTR(len);
 	}
 
-	/*
-	 * Uh-oh. We have a name that's approaching PATH_MAX. Allocate a
-	 * separate struct filename so we can dedicate the entire
-	 * names_cache allocation for the pathname, and re-do the copy from
-	 * userland.
-	 */
-	if (unlikely(len == EMBEDDED_NAME_MAX)) {
-		const size_t size = offsetof(struct filename, iname[1]);
-		kname = (char *)result;
-
-		/*
-		 * size is chosen that way we to guarantee that
-		 * result->iname[0] is within the same object and that
-		 * kname can't be equal to result->iname, no matter what.
-		 */
-		result = kzalloc(size, GFP_KERNEL);
-		if (unlikely(!result)) {
-			__putname(kname);
-			return ERR_PTR(-ENOMEM);
-		}
-		result->name = kname;
-		len = strncpy_from_user(kname, filename, PATH_MAX);
-		if (unlikely(len < 0)) {
-			__putname(kname);
-			kfree(result);
-			return ERR_PTR(len);
-		}
-		if (unlikely(len == PATH_MAX)) {
-			__putname(kname);
-			kfree(result);
-			return ERR_PTR(-ENAMETOOLONG);
-		}
-	}
-
-	result->refcnt = 1;
 	/* The empty path is special. */
 	if (unlikely(!len)) {
 		if (empty)
@@ -215,49 +190,22 @@ getname_kernel(const char * filename)
 	struct filename *result;
 	int len = strlen(filename) + 1;
 
-	result = __getname();
+	result = alloc_filename();
 	if (unlikely(!result))
 		return ERR_PTR(-ENOMEM);
 
-	if (len <= EMBEDDED_NAME_MAX) {
-		result->name = (char *)result->iname;
-	} else if (len <= PATH_MAX) {
-		struct filename *tmp;
-
-		tmp = kmalloc(sizeof(*tmp), GFP_KERNEL);
-		if (unlikely(!tmp)) {
-			__putname(result);
-			return ERR_PTR(-ENOMEM);
-		}
-		tmp->name = (char *)result;
-		result = tmp;
-	} else {
-		__putname(result);
+	if (len > PATH_MAX) {
+		putname(result);
 		return ERR_PTR(-ENAMETOOLONG);
 	}
 	memcpy((char *)result->name, filename, len);
 	result->uptr = NULL;
 	result->aname = NULL;
-	result->refcnt = 1;
 	audit_getname(result);
 
 	return result;
 }
 
-void putname(struct filename *name)
-{
-	BUG_ON(name->refcnt <= 0);
-
-	if (--name->refcnt > 0)
-		return;
-
-	if (name->name != name->iname) {
-		__putname(name->name);
-		kfree(name);
-	} else
-		__putname(name);
-}
-
 static int check_acl(struct inode *inode, int mask)
 {
 #ifdef CONFIG_FS_POSIX_ACL
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ab44a19f2ddd..5c93ebc519fe 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2376,15 +2376,6 @@ static inline int break_layout(struct inode *inode, bool wait)
 #endif /* CONFIG_FILE_LOCKING */
 
 /* fs/open.c */
-struct audit_names;
-struct filename {
-	const char		*name;	/* pointer to actual string */
-	const __user char	*uptr;	/* original userland pointer */
-	struct audit_names	*aname;
-	int			refcnt;
-	const char		iname[];
-};
-
 extern long vfs_truncate(const struct path *, loff_t);
 extern int do_truncate(struct dentry *, loff_t start, unsigned int time_attrs,
 		       struct file *filp);
@@ -2399,6 +2390,18 @@ extern struct file *file_open_root(struct dentry *, struct vfsmount *,
 extern struct file * dentry_open(const struct path *, int, const struct cred *);
 extern int filp_close(struct file *, fl_owner_t id);
 
+/* fs/namei.c */
+static inline void *__getname(void)
+{
+	return (void *)__get_free_page(GFP_KERNEL);
+}
+
+static inline void __putname(const void *name)
+{
+	free_page((unsigned long)name);
+}
+
+void filename_get(struct filename *);
 extern struct filename *getname_flags(const char __user *, int, int *);
 extern struct filename *getname(const char __user *);
 extern struct filename *getname_kernel(const char *);
@@ -2421,11 +2424,6 @@ extern int ioctl_preallocate(struct file *filp, void __user *argp);
 extern void __init vfs_caches_init_early(void);
 extern void __init vfs_caches_init(void);
 
-extern struct kmem_cache *names_cachep;
-
-#define __getname()		kmem_cache_alloc(names_cachep, GFP_KERNEL)
-#define __putname(name)		kmem_cache_free(names_cachep, (void *)(name))
-
 #ifdef CONFIG_BLOCK
 extern int register_blkdev(unsigned int, const char *);
 extern void unregister_blkdev(unsigned int, const char *);
diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 97ceec1c6e21..a6ca28ef4277 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -25,6 +25,13 @@
 struct address_space;
 struct mem_cgroup;
 struct hmm;
+struct audit_names;
+
+struct filename {
+	const char		*name;	/* pointer to actual string */
+	const __user char	*uptr;	/* original userland pointer */
+	struct audit_names	*aname;
+};
 
 /*
  * Each physical page in the system has a struct page associated with
@@ -188,6 +195,7 @@ struct page {
 			spinlock_t ptl;
 #endif
 		};
+		struct filename filename;
 	};
 
 #ifdef CONFIG_MEMCG
diff --git a/kernel/auditsc.c b/kernel/auditsc.c
index e80459f7e132..e539550f5983 100644
--- a/kernel/auditsc.c
+++ b/kernel/auditsc.c
@@ -1722,7 +1722,7 @@ __audit_reusename(const __user char *uptr)
 		if (!n->name)
 			continue;
 		if (n->name->uptr == uptr) {
-			n->name->refcnt++;
+			filename_get(n->name);
 			return n->name;
 		}
 	}
@@ -1751,7 +1751,7 @@ void __audit_getname(struct filename *name)
 	n->name = name;
 	n->name_len = AUDIT_NAME_FULL;
 	name->aname = n;
-	name->refcnt++;
+	filename_get(name);
 
 	if (!context->pwd.dentry)
 		get_fs_pwd(current->fs, &context->pwd);
@@ -1825,7 +1825,7 @@ void __audit_inode(struct filename *name, const struct dentry *dentry,
 		return;
 	if (name) {
 		n->name = name;
-		name->refcnt++;
+		filename_get(name);
 	}
 
 out:
@@ -1954,7 +1954,7 @@ void __audit_inode_child(struct inode *parent,
 		if (found_parent) {
 			found_child->name = found_parent->name;
 			found_child->name_len = AUDIT_NAME_FULL;
-			found_child->name->refcnt++;
+			filename_get(found_child->name);
 		}
 	}
 
