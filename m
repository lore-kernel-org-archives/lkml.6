Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932308AbeCLXxU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 19:53:20 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:50447 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751333AbeCLXxS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 19:53:18 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <87h8q7erlo.fsf@linutronix.de>
        <20180223150928.GC30522@ZenIV.linux.org.uk>
        <20180223174216.GD30522@ZenIV.linux.org.uk>
        <20180223201317.GG30522@ZenIV.linux.org.uk>
        <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
        <20180224002248.GH30522@ZenIV.linux.org.uk>
        <20180225073950.GI30522@ZenIV.linux.org.uk>
        <87bmgbnhar.fsf_-_@linutronix.de>
        <20180312191351.GN30522@ZenIV.linux.org.uk>
        <877eqhcab3.fsf@xmission.com>
        <20180312203916.GQ30522@ZenIV.linux.org.uk>
        <87woygan6p.fsf@xmission.com>
Date: Mon, 12 Mar 2018 18:52:31 -0500
In-Reply-To: <87woygan6p.fsf@xmission.com> (Eric W. Biederman's message of
        "Mon, 12 Mar 2018 18:28:30 -0500")
Message-ID: <87tvtk97i8.fsf@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1evXFl-0006Cn-60;;;mid=<87tvtk97i8.fsf@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/8QaUQ4hu81FEzgM4QibQCvh0nzuMZAEo=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.1 XMSolicitRefs_0 Weightloss drug
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@ZenIV.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 396 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 4.2 (1.1%), b_tie_ro: 2.9 (0.7%), parse: 1.85 (0.5%),
        extract_message_metadata: 24 (6.1%), get_uri_detail_list: 5 (1.3%),
        tests_pri_-1000: 12 (3.1%), tests_pri_-950: 1.73 (0.4%), tests_pri_-900: 1.35
        (0.3%), tests_pri_-400: 36 (9.1%), check_bayes: 35 (8.7%), b_tokenize: 15
        (3.7%), b_tok_get_all: 10 (2.6%), b_comp_prob: 3.8 (1.0%), b_tok_touch_all:
        3.5 (0.9%), b_finish: 0.75 (0.2%), tests_pri_0: 302 (76.3%),
        check_dkim_signature: 0.70 (0.2%), check_dkim_adsp: 3.1 (0.8%),
        tests_pri_500: 7 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: dcache: remove trylock loops (was Re: [BUG] lock_parent() breakage when used from shrink_dentry_list())
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Al Viro <viro@ZenIV.linux.org.uk> writes:
>
>> On Mon, Mar 12, 2018 at 03:23:44PM -0500, Eric W. Biederman wrote:
>>
>>> Of the two code paths you are concert about:
>>> 
>>> For path path_connected looking at s_root is a heuristic to avoid
>>> calling is_subdir every time we need to do that check.  If the heuristic
>>> fails we still have is_subdir which should remain accurate.  If
>>> is_subdir fails the path is genuinely not connected at that moment
>>> and failing is the correct thing to do.
>>  
>> Umm...  That might be not good enough - the logics is "everything's
>> reachable from ->s_root anyway, so we might as well not bother checking".
>> For NFS it's simply not true.
>
> If I am parsing the code correctly path_connected is broken for nfsv2
> and nfsv3 when NFS_MOUNT_UNSHARED is not set.   nfsv4 appears to make
> a kernel mount of the real root of the filesystem properly setting
> s_root and then finds the child it is mounting.
>
>> We can mount server:/foo/bar/baz on /tmp/a, then server:/foo on /tmp/b
>> and we'll have ->s_root pointing to a subtree of what's reachable at
>> /tmp/b.  Play with renames under /tmp/b and you just might end up with
>> a problem.  And mount on /tmp/a will be (mistakenly) considered to
>> be safe, since it satisfies the heuristics in path_connected().
>
> Agreed.
>
> Which means that if you mount server:/foo/bar/baz first and then
> mount server:/foo with an appropriate rename you might be able
> to see all of server:/foo or possibly server:/
>
> Hmm..
>
> Given that nfs_kill_super calls generic_shutdown_super and
> generic_shutdown_super calls shrink_dcache_for_umount
> I would argue that nfsv2 and nfsv3 are buggy in the same
> case, as shrink_dcache_for_umount is called on something
> that is not the root of the filesystem's dentry tree.

Ah.  I see now there is now the s_roots list that handles
that bit of strangeness.

So one path is to simply remove the heuristic from
path_connected.

Another path is to have nfsv2 and nfsv3 not set s_root at all.
Leaving the heuristic working for the rest of the filesystems,
and generally simplifying the code.

Something like the diff below I should think.

Eric

 fs/dcache.c      |  3 ++-
 fs/nfs/getroot.c | 35 +----------------------------------
 fs/nfs/super.c   |  2 --
 3 files changed, 3 insertions(+), 37 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 7c38f39958bc..ebe63ca026da 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1501,7 +1501,8 @@ void shrink_dcache_for_umount(struct super_block *sb)
 
 	dentry = sb->s_root;
 	sb->s_root = NULL;
-	do_one_tree(dentry);
+	if (dentry)
+		do_one_tree(dentry);
 
 	while (!hlist_bl_empty(&sb->s_roots)) {
 		dentry = dget(hlist_bl_entry(hlist_bl_first(&sb->s_roots), struct dentry, d_hash));
diff --git a/fs/nfs/getroot.c b/fs/nfs/getroot.c
index 391dafaf9182..f609d583fd2b 100644
--- a/fs/nfs/getroot.c
+++ b/fs/nfs/getroot.c
@@ -36,35 +36,6 @@
 
 #define NFSDBG_FACILITY		NFSDBG_CLIENT
 
-/*
- * Set the superblock root dentry.
- * Note that this function frees the inode in case of error.
- */
-static int nfs_superblock_set_dummy_root(struct super_block *sb, struct inode *inode)
-{
-	/* The mntroot acts as the dummy root dentry for this superblock */
-	if (sb->s_root == NULL) {
-		sb->s_root = d_make_root(inode);
-		if (sb->s_root == NULL)
-			return -ENOMEM;
-		ihold(inode);
-		/*
-		 * Ensure that this dentry is invisible to d_find_alias().
-		 * Otherwise, it may be spliced into the tree by
-		 * d_splice_alias if a parent directory from the same
-		 * filesystem gets mounted at a later time.
-		 * This again causes shrink_dcache_for_umount_subtree() to
-		 * Oops, since the test for IS_ROOT() will fail.
-		 */
-		spin_lock(&d_inode(sb->s_root)->i_lock);
-		spin_lock(&sb->s_root->d_lock);
-		hlist_del_init(&sb->s_root->d_u.d_alias);
-		spin_unlock(&sb->s_root->d_lock);
-		spin_unlock(&d_inode(sb->s_root)->i_lock);
-	}
-	return 0;
-}
-
 /*
  * get an NFS2/NFS3 root dentry from the root filehandle
  */
@@ -102,11 +73,7 @@ struct dentry *nfs_get_root(struct super_block *sb, struct nfs_fh *mntfh,
 		goto out;
 	}
 
-	error = nfs_superblock_set_dummy_root(sb, inode);
-	if (error != 0) {
-		ret = ERR_PTR(error);
-		goto out;
-	}
+	/* Leave nfsv2 and nfsv3 s_root == NULL */
 
 	/* root dentries normally start off anonymous and get spliced in later
 	 * if the dentry tree reaches them; however if the dentry already
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 29bacdc56f6a..30b45ea4dfe9 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2625,9 +2625,7 @@ struct dentry *nfs_fs_mount_common(struct nfs_server *server,
 		}
 		s->s_bdi->ra_pages = server->rpages * NFS_MAX_READAHEAD;
 		server->super = s;
-	}
 
-	if (!s->s_root) {
 		/* initial superblock/root creation */
 		mount_info->fill_super(s, mount_info);
 		nfs_get_cache_cookie(s, mount_info->parsed, mount_info->cloned);
