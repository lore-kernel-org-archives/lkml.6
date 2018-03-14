Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751492AbeCNXV1 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 19:21:27 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:47569 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751131AbeCNXVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 19:21:25 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Al Viro <viro@ZenIV.linux.org.uk>
Cc: John Ogness <john.ogness@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>, Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+55aFyP9JtyzUzA_S2sdKCK+8CZtNoA3UkXg5X4J0Hf2_ekjg@mail.gmail.com>
        <20180224002248.GH30522@ZenIV.linux.org.uk>
        <20180225073950.GI30522@ZenIV.linux.org.uk>
        <87bmgbnhar.fsf_-_@linutronix.de>
        <20180312191351.GN30522@ZenIV.linux.org.uk>
        <877eqhcab3.fsf@xmission.com>
        <20180312203916.GQ30522@ZenIV.linux.org.uk>
        <87woygan6p.fsf@xmission.com> <87tvtk97i8.fsf@xmission.com>
        <20180313003751.GT30522@ZenIV.linux.org.uk>
        <20180313005010.GV30522@ZenIV.linux.org.uk>
Date: Wed, 14 Mar 2018 18:20:29 -0500
In-Reply-To: <20180313005010.GV30522@ZenIV.linux.org.uk> (Al Viro's message of
        "Tue, 13 Mar 2018 00:50:11 +0000")
Message-ID: <87muzai6rm.fsf_-_@xmission.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ewFhs-00046s-Mz;;;mid=<87muzai6rm.fsf_-_@xmission.com>;;;hst=in02.mta.xmission.com;;;ip=174.19.85.160;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX194dKeYDENhQkxw0o8oEt1Tng1B3DrsEv0=
X-SA-Exim-Connect-IP: 174.19.85.160
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.7 XMSubLong Long Subject
        *  0.0 TVD_RCVD_IP Message was received from an IP address
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.1 XMSolicitRefs_0 Weightloss drug
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Al Viro <viro@ZenIV.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 375 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 3.4 (0.9%), b_tie_ro: 2.2 (0.6%), parse: 1.55 (0.4%),
        extract_message_metadata: 24 (6.3%), get_uri_detail_list: 5 (1.4%),
        tests_pri_-1000: 12 (3.1%), tests_pri_-950: 1.73 (0.5%), tests_pri_-900: 1.41
        (0.4%), tests_pri_-400: 36 (9.6%), check_bayes: 35 (9.2%), b_tokenize: 14
        (3.7%), b_tok_get_all: 10 (2.7%), b_comp_prob: 4.0 (1.1%), b_tok_touch_all:
        4.2 (1.1%), b_finish: 0.75 (0.2%), tests_pri_0: 284 (75.9%),
        check_dkim_signature: 0.68 (0.2%), check_dkim_adsp: 3.3 (0.9%),
        tests_pri_500: 6 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: [PATCH] fs: Teach path_connected to handle nfs filesystems with multiple roots.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On nfsv2 and nfsv3 the nfs server can export subsets of the same
filesystem and report the same filesystem identifier, so that the nfs
client can know they are the same filesystem.  The subsets can be from
disjoint directory trees.  The nfsv2 and nfsv3 filesystems provides no
way to find the common root of all directory trees exported form the
server with the same filesystem identifier.

The practical result is that in struct super s_root for nfs s_root is
not necessarily the root of the filesystem.  The nfs mount code sets
s_root to the root of the first subset of the nfs filesystem that the
kernel mounts.

This effects the dcache invalidation code in generic_shutdown_super
currently called shrunk_dcache_for_umount and that code for years
has gone through an additional list of dentries that might be dentry
trees that need to be freed to accomodate nfs.

When I wrote path_connected I did not realize nfs was so special, and
it's hueristic for avoiding calling is_subdir can fail.

The practical case where this fails is when there is a move of a
directory from the subtree exposed by one nfs mount to the subtree
exposed by another nfs mount.  This move can happen either locally or
remotely.  With the remote case requiring that the move directory be cached
before the move and that after the move someone walks the path
to where the move directory now exists and in so doing causes the
already cached directory to be moved in the dcache through the magic
of d_splice_alias.

If someone whose working directory is in the move directory or a
subdirectory and now starts calling .. from the initial mount of nfs
(where s_root == mnt_root), then path_connected as a heuristic will
not bother with the is_subdir check.  As s_root really is not the root
of the nfs filesystem this heuristic is wrong, and the path may
actually not be connected and path_connected can fail.

The is_subdir function might be cheap enough that we can call it
unconditionally.  Verifying that will take some benchmarking and
the result may not be the same on all kernels this fix needs
to be backported to.  So I am avoiding that for now.

Filesystems with snapshots such as nilfs and btrfs do something
similar.  But as the directory tree of the snapshots are disjoint
from one another and from the main directory tree rename won't move
things between them and this problem will not occur.

Cc: stable@vger.kernel.org
Reported-by: Al Viro <viro@ZenIV.linux.org.uk>
Fixes: 397d425dc26d ("vfs: Test for and handle paths that are unreachable from their mnt_root")
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---

Al do you want to push this one to Linus or shall I?

 fs/namei.c         | 5 +++--
 fs/nfs/super.c     | 2 ++
 include/linux/fs.h | 1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 921ae32dbc80..cafa365eeb70 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -559,9 +559,10 @@ static int __nd_alloc_stack(struct nameidata *nd)
 static bool path_connected(const struct path *path)
 {
 	struct vfsmount *mnt = path->mnt;
+	struct super_block *sb = mnt->mnt_sb;
 
-	/* Only bind mounts can have disconnected paths */
-	if (mnt->mnt_root == mnt->mnt_sb->s_root)
+	/* Bind mounts and multi-root filesystems can have disconnected paths */
+	if (!(sb->s_iflags & SB_I_MULTIROOT) && (mnt->mnt_root == sb->s_root))
 		return true;
 
 	return is_subdir(path->dentry, mnt->mnt_root);
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index 29bacdc56f6a..5e470e233c83 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2631,6 +2631,8 @@ struct dentry *nfs_fs_mount_common(struct nfs_server *server,
 		/* initial superblock/root creation */
 		mount_info->fill_super(s, mount_info);
 		nfs_get_cache_cookie(s, mount_info->parsed, mount_info->cloned);
+		if (!(server->flags & NFS_MOUNT_UNSHARED))
+			s->s_iflags |= SB_I_MULTIROOT;
 	}
 
 	mntroot = nfs_get_root(s, mount_info->mntfh, dev_name);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2a815560fda0..0430e03febaa 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1317,6 +1317,7 @@ extern int send_sigurg(struct fown_struct *fown);
 #define SB_I_CGROUPWB	0x00000001	/* cgroup-aware writeback enabled */
 #define SB_I_NOEXEC	0x00000002	/* Ignore executables on this fs */
 #define SB_I_NODEV	0x00000004	/* Ignore devices on this fs */
+#define SB_I_MULTIROOT	0x00000008	/* Multiple roots to the dentry tree */
 
 /* sb->s_iflags to limit user namespace mounts */
 #define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
-- 
2.14.1
