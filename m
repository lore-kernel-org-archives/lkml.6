Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753158AbeCYB0X (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 21:26:23 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:48043 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752216AbeCYB0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 21:26:21 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Aleksa Sarai <asarai@suse.de>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org,
        Al Viro <viro@ZenIV.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>
References: <20180323060457.sxgsd3j2obi33fyw@gordon>
        <87k1u3ti9e.fsf@xmission.com> <87fu4qo4ff.fsf_-_@xmission.com>
        <20180323231511.GK30522@ZenIV.linux.org.uk>
        <87in9ljvvx.fsf@xmission.com>
        <20180324214845.GM30522@ZenIV.linux.org.uk>
Date: Sat, 24 Mar 2018 20:25:06 -0500
In-Reply-To: <20180324214845.GM30522@ZenIV.linux.org.uk> (Al Viro's message of
        "Sat, 24 Mar 2018 21:48:45 +0000")
Message-ID: <87r2o9eykt.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ezuQ8-0000Ga-8E;;;mid=<87r2o9eykt.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+wlTr9D2sHbQjHEO2JEk745nojt72m5Lk=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  1.0 XMSubMetaSx_00 1+ Sexy Words
        *  1.2 XMSubMetaSxObfu_03 Obfuscated Sexy Noun-People
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 15035 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 3.2 (0.0%), b_tie_ro: 2.3 (0.0%), parse: 1.36 (0.0%),
        extract_message_metadata: 21 (0.1%), get_uri_detail_list: 4.8 (0.0%),
        tests_pri_-1000: 2.8 (0.0%), tests_pri_-950: 1.14 (0.0%), tests_pri_-900:
        0.97 (0.0%), tests_pri_-400: 37 (0.2%), check_bayes: 36 (0.2%), b_tokenize:
        14 (0.1%), b_tok_get_all: 12 (0.1%), b_comp_prob: 3.1 (0.0%),
        b_tok_touch_all: 4.9 (0.0%), b_finish: 0.65 (0.0%), tests_pri_0: 365 (2.4%),
        check_dkim_signature: 0.61 (0.0%), check_dkim_adsp: 2.9 (0.0%),
        tests_pri_500: 14599 (97.1%), poll_dns_idle: 14588 (97.0%), rewrite_mail:
        0.00 (0.0%)
Subject: [GIT PULL] Revert "mqueue: switch to on-demand creation of internal mount"
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Linus,

Please pull the for-linus branch from the git tree:

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git for-linus

   HEAD: cfb2f6f6e0ba11ea7b263d6b69c170c4b32ac0ea Revert "mqueue: switch to on-demand creation of internal mount"

This fixes a regression that came in the merge window for v4.16.  The
problem is that the permissions for mounting and using the mqueuefs
filesystem are broken.  The necessary permission check is missing
letting people who should not be able to mount mqueuefs mount mqueuefs.
The field sb->s_user_ns is set incorrectly not allowing the mounter of
mqueuefs to remount and otherwise have proper control over the
filesystem.

Al Viro and I see the path to the necessary fixes differently and I am
not even certain at this point he actually sees all of the necessary
fixes.  Given a couple weeks we can probably work something out but I
don't see the review being resolved in time for the final v4.16.  I
don't want v4.16 shipping with a nasty regression.  So unfortunately I
am sending a revert.

Eric

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Sat, 24 Mar 2018 11:28:14 -0500
Subject: [PATCH] Revert "mqueue: switch to on-demand creation of internal mount"

This reverts commit 36735a6a2b5e042db1af956ce4bcc13f3ff99e21.

Aleksa Sarai <asarai@suse.de> writes:
> [REGRESSION v4.16-rc6] [PATCH] mqueue: forbid unprivileged user access to internal mount
>
> Felix reported weird behaviour on 4.16.0-rc6 with regards to mqueue[1],
> which was introduced by 36735a6a2b5e ("mqueue: switch to on-demand
> creation of internal mount").
>
> Basically, the reproducer boils down to being able to mount mqueue if
> you create a new user namespace, even if you don't unshare the IPC
> namespace.
>
> Previously this was not possible, and you would get an -EPERM. The mount
> is the *host* mqueue mount, which is being cached and just returned from
> mqueue_mount(). To be honest, I'm not sure if this is safe or not (or if
> it was intentional -- since I'm not familiar with mqueue).
>
> To me it looks like there is a missing permission check. I've included a
> patch below that I've compile-tested, and should block the above case.
> Can someone please tell me if I'm missing something? Is this actually
> safe?
>
> [1]: https://github.com/docker/docker/issues/36674

The issue is a lot deeper than a missing permission check.  sb->s_user_ns
was is improperly set as well.  So in addition to the filesystem being
mounted when it should not be mounted, so things are not allow that should
be.

We are practically to the release of 4.16 and there is no agreement between
Al Viro and myself on what the code should looks like to fix things properly.
So revert the code to what it was before so that we can take our time
and discuss this properly.

Fixes: 36735a6a2b5e ("mqueue: switch to on-demand creation of internal mount")
Reported-by: Felix Abecassis <fabecassis@nvidia.com>
Reported-by: Aleksa Sarai <asarai@suse.de>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 ipc/mqueue.c | 74 ++++++++++++++++--------------------------------------------
 1 file changed, 19 insertions(+), 55 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index d7f309f74dec..a808f29d4c5a 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -325,9 +325,8 @@ static struct inode *mqueue_get_inode(struct super_block *sb,
 static int mqueue_fill_super(struct super_block *sb, void *data, int silent)
 {
 	struct inode *inode;
-	struct ipc_namespace *ns = data;
+	struct ipc_namespace *ns = sb->s_fs_info;
 
-	sb->s_fs_info = ns;
 	sb->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
@@ -344,44 +343,18 @@ static int mqueue_fill_super(struct super_block *sb, void *data, int silent)
 	return 0;
 }
 
-static struct file_system_type mqueue_fs_type;
-/*
- * Return value is pinned only by reference in ->mq_mnt; it will
- * live until ipcns dies.  Caller does not need to drop it.
- */
-static struct vfsmount *mq_internal_mount(void)
-{
-	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
-	struct vfsmount *m = ns->mq_mnt;
-	if (m)
-		return m;
-	m = kern_mount_data(&mqueue_fs_type, ns);
-	spin_lock(&mq_lock);
-	if (unlikely(ns->mq_mnt)) {
-		spin_unlock(&mq_lock);
-		if (!IS_ERR(m))
-			kern_unmount(m);
-		return ns->mq_mnt;
-	}
-	if (!IS_ERR(m))
-		ns->mq_mnt = m;
-	spin_unlock(&mq_lock);
-	return m;
-}
-
 static struct dentry *mqueue_mount(struct file_system_type *fs_type,
 			 int flags, const char *dev_name,
 			 void *data)
 {
-	struct vfsmount *m;
-	if (flags & SB_KERNMOUNT)
-		return mount_nodev(fs_type, flags, data, mqueue_fill_super);
-	m = mq_internal_mount();
-	if (IS_ERR(m))
-		return ERR_CAST(m);
-	atomic_inc(&m->mnt_sb->s_active);
-	down_write(&m->mnt_sb->s_umount);
-	return dget(m->mnt_root);
+	struct ipc_namespace *ns;
+	if (flags & SB_KERNMOUNT) {
+		ns = data;
+		data = NULL;
+	} else {
+		ns = current->nsproxy->ipc_ns;
+	}
+	return mount_ns(fs_type, flags, data, ns, ns->user_ns, mqueue_fill_super);
 }
 
 static void init_once(void *foo)
@@ -771,16 +744,13 @@ static int prepare_open(struct dentry *dentry, int oflag, int ro,
 static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
 		      struct mq_attr *attr)
 {
-	struct vfsmount *mnt = mq_internal_mount();
-	struct dentry *root;
+	struct vfsmount *mnt = current->nsproxy->ipc_ns->mq_mnt;
+	struct dentry *root = mnt->mnt_root;
 	struct filename *name;
 	struct path path;
 	int fd, error;
 	int ro;
 
-	if (IS_ERR(mnt))
-		return PTR_ERR(mnt);
-
 	audit_mq_open(oflag, mode, attr);
 
 	if (IS_ERR(name = getname(u_name)))
@@ -791,7 +761,6 @@ static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
 		goto out_putname;
 
 	ro = mnt_want_write(mnt);	/* we'll drop it in any case */
-	root = mnt->mnt_root;
 	inode_lock(d_inode(root));
 	path.dentry = lookup_one_len(name->name, root, strlen(name->name));
 	if (IS_ERR(path.dentry)) {
@@ -840,9 +809,6 @@ SYSCALL_DEFINE1(mq_unlink, const char __user *, u_name)
 	struct ipc_namespace *ipc_ns = current->nsproxy->ipc_ns;
 	struct vfsmount *mnt = ipc_ns->mq_mnt;
 
-	if (!mnt)
-		return -ENOENT;
-
 	name = getname(u_name);
 	if (IS_ERR(name))
 		return PTR_ERR(name);
@@ -1569,26 +1535,28 @@ int mq_init_ns(struct ipc_namespace *ns)
 	ns->mq_msgsize_max   = DFLT_MSGSIZEMAX;
 	ns->mq_msg_default   = DFLT_MSG;
 	ns->mq_msgsize_default  = DFLT_MSGSIZE;
-	ns->mq_mnt = NULL;
 
+	ns->mq_mnt = kern_mount_data(&mqueue_fs_type, ns);
+	if (IS_ERR(ns->mq_mnt)) {
+		int err = PTR_ERR(ns->mq_mnt);
+		ns->mq_mnt = NULL;
+		return err;
+	}
 	return 0;
 }
 
 void mq_clear_sbinfo(struct ipc_namespace *ns)
 {
-	if (ns->mq_mnt)
-		ns->mq_mnt->mnt_sb->s_fs_info = NULL;
+	ns->mq_mnt->mnt_sb->s_fs_info = NULL;
 }
 
 void mq_put_mnt(struct ipc_namespace *ns)
 {
-	if (ns->mq_mnt)
-		kern_unmount(ns->mq_mnt);
+	kern_unmount(ns->mq_mnt);
 }
 
 static int __init init_mqueue_fs(void)
 {
-	struct vfsmount *m;
 	int error;
 
 	mqueue_inode_cachep = kmem_cache_create("mqueue_inode_cache",
@@ -1610,10 +1578,6 @@ static int __init init_mqueue_fs(void)
 	if (error)
 		goto out_filesystem;
 
-	m = kern_mount_data(&mqueue_fs_type, &init_ipc_ns);
-	if (IS_ERR(m))
-		goto out_filesystem;
-	init_ipc_ns.mq_mnt = m;
 	return 0;
 
 out_filesystem:
-- 
2.14.1
