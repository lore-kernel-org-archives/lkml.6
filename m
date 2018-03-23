Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752225AbeCWVop (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Mar 2018 17:44:45 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:51438 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751541AbeCWVon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Mar 2018 17:44:43 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Aleksa Sarai <asarai@suse.de>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
        containers@lists.linux-foundation.org
References: <20180323060457.sxgsd3j2obi33fyw@gordon>
        <87k1u3ti9e.fsf@xmission.com> <87fu4qo4ff.fsf_-_@xmission.com>
Date: Fri, 23 Mar 2018 16:43:42 -0500
In-Reply-To: <87fu4qo4ff.fsf_-_@xmission.com> (Eric W. Biederman's message of
        "Fri, 23 Mar 2018 16:41:40 -0500")
Message-ID: <874ll6o4c1.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ezUUI-0003ZP-8I;;;mid=<874ll6o4c1.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=97.119.121.173;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/5pb9IO0Skb9Zm9YWPKzJUt7ba7bzZJSE=
X-SA-Exim-Connect-IP: 97.119.121.173
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Aleksa Sarai <asarai@suse.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 4575 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 2.9 (0.1%), b_tie_ro: 2.0 (0.0%), parse: 1.07 (0.0%),
        extract_message_metadata: 21 (0.5%), get_uri_detail_list: 3.6 (0.1%),
        tests_pri_-1000: 9 (0.2%), tests_pri_-950: 1.15 (0.0%), tests_pri_-900: 0.96
        (0.0%), tests_pri_-400: 26 (0.6%), check_bayes: 25 (0.5%), b_tokenize: 8
        (0.2%), b_tok_get_all: 8 (0.2%), b_comp_prob: 2.6 (0.1%), b_tok_touch_all:
        3.6 (0.1%), b_finish: 0.66 (0.0%), tests_pri_0: 214 (4.7%),
        check_dkim_signature: 0.49 (0.0%), check_dkim_adsp: 2.7 (0.1%),
        tests_pri_500: 4297 (93.9%), poll_dns_idle: 4292 (93.8%), rewrite_mail: 0.00
        (0.0%)
Subject: [PATCH 2/2] mqueuefs: Fix the permissions and permission checks when mounting mqueuefs
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Aleksa Sarai writes:
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
>
> [1]: https://github.com/docker/docker/issues/36674

After examination of the code it might be safe by chance but it is
definitely wrong.  The missing permission checks are needed in the
general case, and sb->s_user_ns needs to be set to ns->user_ns to give
root in the user namespace the appropriate permissions over the
filesystem.

Fixes: 36735a6a2b5e ("mqueue: switch to on-demand creation of internal mount")
Reported-by: Felix Abecassis <fabecassis@nvidia.com>
Reported-by: Aleksa Sarai <asarai@suse.de>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Unless there are objections I will push these fixes to Linus in a day
or so.

 ipc/mqueue.c | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index d7f309f74dec..832c1ec21318 100644
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
@@ -349,9 +348,9 @@ static struct file_system_type mqueue_fs_type;
  * Return value is pinned only by reference in ->mq_mnt; it will
  * live until ipcns dies.  Caller does not need to drop it.
  */
-static struct vfsmount *mq_internal_mount(void)
+static struct vfsmount *mq_internal_mount(void *nsp)
 {
-	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
+	struct ipc_namespace *ns = nsp;
 	struct vfsmount *m = ns->mq_mnt;
 	if (m)
 		return m;
@@ -373,15 +372,9 @@ static struct dentry *mqueue_mount(struct file_system_type *fs_type,
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
+	struct ipc_namespace *ns = current->nsproxy->ipc_ns;
+	return mount_ns(fs_type, flags, data, ns, ns->user_ns,
+			mq_internal_mount, mqueue_fill_super);
 }
 
 static void init_once(void *foo)
@@ -771,7 +764,7 @@ static int prepare_open(struct dentry *dentry, int oflag, int ro,
 static int do_mq_open(const char __user *u_name, int oflag, umode_t mode,
 		      struct mq_attr *attr)
 {
-	struct vfsmount *mnt = mq_internal_mount();
+	struct vfsmount *mnt = mq_internal_mount(current->nsproxy->ipc_ns);
 	struct dentry *root;
 	struct filename *name;
 	struct path path;
-- 
2.14.1
