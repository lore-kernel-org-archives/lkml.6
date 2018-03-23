Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752347AbeCWVmj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:42:39 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:32823 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751288AbeCWVmi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:42:38 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Aleksa Sarai <asarai@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org
References: <20180323060457.sxgsd3j2obi33fyw@gordon>
        <87k1u3ti9e.fsf@xmission.com>
Date: Fri, 23 Mar 2018 16:41:40 -0500
In-Reply-To: <87k1u3ti9e.fsf@xmission.com> (Eric W. Biederman's message of
        "Fri, 23 Mar 2018 01:31:41 -0500")
Message-ID: <87fu4qo4ff.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ezUSK-0002y1-TM;;;mid=<87fu4qo4ff.fsf_-_@xmission.com>;;;hst=in01.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+fHGiUN/XGQG9V1yF8G0NCr7Z/m5iVAMk=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Aleksa Sarai <asarai@suse.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 331 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 7 (2.2%), b_tie_ro: 4.8 (1.5%), parse: 1.06 (0.3%),
        extract_message_metadata: 13 (3.9%), get_uri_detail_list: 2.8 (0.8%),
        tests_pri_-1000: 5 (1.6%), tests_pri_-950: 1.19 (0.4%), tests_pri_-900: 1.00
        (0.3%), tests_pri_-400: 25 (7.5%), check_bayes: 24 (7.2%), b_tokenize: 10
        (2.9%), b_tok_get_all: 7 (2.1%), b_comp_prob: 2.0 (0.6%), b_tok_touch_all:
        2.9 (0.9%), b_finish: 0.62 (0.2%), tests_pri_0: 270 (81.7%),
        check_dkim_signature: 0.58 (0.2%), check_dkim_adsp: 2.6 (0.8%),
        tests_pri_500: 3.6 (1.1%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH 1/2] fs: Extend mount_ns with support for a fast namespace to vfsmount function
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


If this function is present use it to lookup up the vfsmount except
when performaning internal kernel mounts.  When performing internal
kernel mounts don't look through the list of superblocks just create a
new one.

After a quick survey it appears all callers of mount_ns are candidates
for this optimization.  So extending the generic helper appears
like the right thing.

The motivation for this change is that this optimization was performed
recently on mqueuefs and a permission check was dropped and
sb->s_user_ns was set incorrectly.

To enable fixing mqueuefs this logic was extracted from mqueuefs and
added to mount_ns which gets the permission check correct and set
sb->s_user_ns properly.

Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/nfsd/nfsctl.c      |  3 ++-
 fs/proc/root.c        |  3 ++-
 fs/super.c            | 18 +++++++++++++++---
 include/linux/fs.h    |  1 +
 net/sunrpc/rpc_pipe.c |  2 +-
 5 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
index d107b4426f7e..ffd8d91a68df 100644
--- a/fs/nfsd/nfsctl.c
+++ b/fs/nfsd/nfsctl.c
@@ -1182,7 +1182,8 @@ static struct dentry *nfsd_mount(struct file_system_type *fs_type,
 	int flags, const char *dev_name, void *data)
 {
 	struct net *net = current->nsproxy->net_ns;
-	return mount_ns(fs_type, flags, data, net, net->user_ns, nfsd_fill_super);
+	return mount_ns(fs_type, flags, data, net, net->user_ns,
+			NULL, nfsd_fill_super);
 }
 
 static void nfsd_umount(struct super_block *sb)
diff --git a/fs/proc/root.c b/fs/proc/root.c
index ede8e64974be..4111565b6944 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -98,7 +98,8 @@ static struct dentry *proc_mount(struct file_system_type *fs_type,
 		ns = task_active_pid_ns(current);
 	}
 
-	return mount_ns(fs_type, flags, data, ns, ns->user_ns, proc_fill_super);
+	return mount_ns(fs_type, flags, data, ns, ns->user_ns,
+			NULL, proc_fill_super);
 }
 
 static void proc_kill_sb(struct super_block *sb)
diff --git a/fs/super.c b/fs/super.c
index 672538ca9831..4734d423b403 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1016,18 +1016,30 @@ static int ns_set_super(struct super_block *sb, void *data)
 
 struct dentry *mount_ns(struct file_system_type *fs_type,
 	int flags, void *data, void *ns, struct user_namespace *user_ns,
+	struct vfsmount *(*ns_to_mnt)(void *ns),
 	int (*fill_super)(struct super_block *, void *, int))
 {
 	struct super_block *sb;
-
+	int (*test_super)(struct super_block *, void *) = ns_test_super;
 	/* Don't allow mounting unless the caller has CAP_SYS_ADMIN
 	 * over the namespace.
 	 */
 	if (!(flags & SB_KERNMOUNT) && !ns_capable(user_ns, CAP_SYS_ADMIN))
 		return ERR_PTR(-EPERM);
 
-	sb = sget_userns(fs_type, ns_test_super, ns_set_super, flags,
-			 user_ns, ns);
+	if (ns_to_mnt) {
+		test_super = NULL;
+		if (!(flags & SB_KERNMOUNT)) {
+			struct vfsmount *m = ns_to_mnt(ns);
+			if (IS_ERR(m))
+				return ERR_CAST(m);
+			atomic_inc(&m->mnt_sb->s_active);
+			down_write(&m->mnt_sb->s_umount);
+			return dget(m->mnt_root);
+		}
+	}
+
+	sb = sget_userns(fs_type, test_super, ns_set_super, flags, user_ns, ns);
 	if (IS_ERR(sb))
 		return ERR_CAST(sb);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2a815560fda0..ca7f59ff144c 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2091,6 +2091,7 @@ struct file_system_type {
 
 extern struct dentry *mount_ns(struct file_system_type *fs_type,
 	int flags, void *data, void *ns, struct user_namespace *user_ns,
+	struct vfsmount *(*ns_to_mnt)(void *ns),
 	int (*fill_super)(struct super_block *, void *, int));
 #ifdef CONFIG_BLOCK
 extern struct dentry *mount_bdev(struct file_system_type *fs_type,
diff --git a/net/sunrpc/rpc_pipe.c b/net/sunrpc/rpc_pipe.c
index fc97fc3ed637..824e740fe740 100644
--- a/net/sunrpc/rpc_pipe.c
+++ b/net/sunrpc/rpc_pipe.c
@@ -1448,7 +1448,7 @@ rpc_mount(struct file_system_type *fs_type,
 		int flags, const char *dev_name, void *data)
 {
 	struct net *net = current->nsproxy->net_ns;
-	return mount_ns(fs_type, flags, data, net, net->user_ns, rpc_fill_super);
+	return mount_ns(fs_type, flags, data, net, net->user_ns, NULL, rpc_fill_super);
 }
 
 static void rpc_kill_sb(struct super_block *sb)
-- 
2.14.1
