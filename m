Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELt3Q7y1ksRSHYYHJrcDyMgl69LXu7+PLBWR0ivn3Hdd6N3MQGKXP9ThBscGPM/jngG6st/v
ARC-Seal: i=1; a=rsa-sha256; t=1521484088; cv=none;
        d=google.com; s=arc-20160816;
        b=Gp7/zVYQW3Bt/aLZ91mp1aa7AJnVXki0O8+3uObhjkZTgazDkn/0HW/cUFxXXfuvTJ
         XDYlBQkY9fv7+dBXA7kHX7iIq3sIQtMrBvlkyHthVvyAPtAbFili30n/l+z0RWylhXuy
         vqhcuZnpNS0r4JK6fAIhuVJHD2XDm80GCQIQUdsL6aNbDdmgEUzzwVqTWplET+fI2oj0
         DVgZJ9CoLpXOQiBIsqAwHeFHl/BzNFXTkNgEdmKHlwlPuXg5xTA8ONzFxCdfAfX3f9HR
         bjrN+ZzxcUQB1wz7EYe6Yn5UZ8kYLsEgH0UOArrOP1dCAOLrzGdv26KN6zyzvsMJC+Jb
         C9jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=Cai26+8snd7qFUyVJ4bUmfrarI0gXiE8ulO4sZ3Vxg8=;
        b=yhrD+0aeIvpVK/v+Kn/vkzoE1ifMuI05kpP1zardJvpZ+ZTdCc20CJG/JLgntWPeSq
         G5oIVpn3Vyh8AHWjjjoIWsFoKSpZDCWNi86u78Q9W9JxdDYKns9RQSYlBkdbTCpJ2Iu2
         q57NG6jWQxCIdYEW47mwPR6IwPZvu8y6IQO5HE0KH+bhfC0fuugU+kxKwEAZ/IjAT/OB
         29GjrVa1Yu+YB+gPEwmFXEUKMfJ2ROb2HfjsfqkFLjevMC3wEGxrP6fmhgzAEWC1yqOZ
         R9Q2dIJvBExTDjO8zWG961Rs+/NcRPJcRt5/TtHQ3f/iUWiE9tqeD6TxkG8xKV9WsM/0
         mjQw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Al Viro <viro@ZenIV.linux.org.uk>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH 4.9 228/241] fs: Teach path_connected to handle nfs filesystems with multiple roots.
Date: Mon, 19 Mar 2018 19:08:13 +0100
Message-Id: <20180319180800.613855060@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391007817216634?=
X-GMAIL-MSGID: =?utf-8?q?1595391699472307171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric W. Biederman <ebiederm@xmission.com>

commit 95dd77580ccd66a0da96e6d4696945b8cea39431 upstream.

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
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/namei.c         |    5 +++--
 fs/nfs/super.c     |    2 ++
 include/linux/fs.h |    1 +
 3 files changed, 6 insertions(+), 2 deletions(-)

--- a/fs/namei.c
+++ b/fs/namei.c
@@ -578,9 +578,10 @@ static int __nd_alloc_stack(struct namei
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
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -2613,6 +2613,8 @@ struct dentry *nfs_fs_mount_common(struc
 		/* initial superblock/root creation */
 		mount_info->fill_super(s, mount_info);
 		nfs_get_cache_cookie(s, mount_info->parsed, mount_info->cloned);
+		if (!(server->flags & NFS_MOUNT_UNSHARED))
+			s->s_iflags |= SB_I_MULTIROOT;
 	}
 
 	mntroot = nfs_get_root(s, mount_info->mntfh, dev_name);
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1319,6 +1319,7 @@ struct mm_struct;
 #define SB_I_CGROUPWB	0x00000001	/* cgroup-aware writeback enabled */
 #define SB_I_NOEXEC	0x00000002	/* Ignore executables on this fs */
 #define SB_I_NODEV	0x00000004	/* Ignore devices on this fs */
+#define SB_I_MULTIROOT	0x00000008	/* Multiple roots to the dentry tree */
 
 /* sb->s_iflags to limit user namespace mounts */
 #define SB_I_USERNS_VISIBLE		0x00000010 /* fstype already mounted */
