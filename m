Return-Path: <SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org>
X-Google-Smtp-Source: AB8JxZpwFz/MzObnPnne+XfOIdVidiGy6Mq7k2WyNAqY6EImi3cd7GGJ9aBv8eta+AlvtaOD30Gp
ARC-Seal: i=1; a=rsa-sha256; t=1526937578; cv=none;
        d=google.com; s=arc-20160816;
        b=gLHcv9pOXxWK0FNRBvPpB39PZopMIED9mU6o/+6tJFDxDgRiqjfmvai0bxskQBFTCp
         ER19OeclU+tcaUp34SwdAIbafxfsU+iacdFQoPopbKVRPBfU8f+sMJ6mdfe8i0ZVEAUz
         sN3s5c/+o3cBjoDmY/UF7oWt+iPdMby7KwSEZ+pwbI/0PYfE1KanwJFHzOvusHo5nTum
         JBEDAKZ0oUreaAysk9wATMXac/22m73pTFMMyTjjVXQJEfm8c2kNw0dfuoWNUpJTnfCl
         eToWsIW3DvoIqEeCU7rn9oErgC32W7vIzr35DLa6IVuc1kmM5sEe2UNIIH+2o1vQP/kr
         htbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=4GbtBvYcPnwd0Ai3VicbcGjxb6qW8TgsIIp+7/cQygg=;
        b=YYp4nKw5niujuQA8RibRqDk3QMBzoIrTSN82FWYo49ekqfsbFhmXpUv5n2o4qPGQK+
         jD28jvJhEbZxctGgfaCqzelchakefwcuNd6SnURYQudM+gq8Oj+GBFN2t+tC5BFeD7x8
         An+PiPHux0PhCbklZ1f7HVoDBihN4KEeMUqUuZYRNHB3s9AR2csAaoG64LdCvUnvEo3F
         zrIU2ih58Fzp3N0TaxvXe7ndWP3Ek0fAQp6THX5zh2PDMGnJYLFlIPrg/uqwlb/rMLvz
         nj0FOwsGWVMTLIEszrKi3rssWL4pWK0uV8BGVtddVqx0IORSou5guUytRljnzdNMIkJb
         e+QQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=L0NcJKYP;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@kernel.org header.s=default header.b=L0NcJKYP;
       spf=pass (google.com: domain of srs0=nia/=ii=linuxfoundation.org=gregkh@kernel.org designates 198.145.29.99 as permitted sender) smtp.mailfrom=SRS0=nia/=II=linuxfoundation.org=gregkh@kernel.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Nikolay Borisov <nborisov@suse.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 46/95] btrfs: Fix delalloc inodes invalidation during transaction abort
Date: Mon, 21 May 2018 23:11:36 +0200
Message-Id: <20180521210457.347313694@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180521210447.219380974@linuxfoundation.org>
References: <20180521210447.219380974@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1601110098844973821?=
X-GMAIL-MSGID: =?utf-8?q?1601110098844973821?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nikolay Borisov <nborisov@suse.com>

commit fe816d0f1d4c31c4c31d42ca78a87660565fc800 upstream.

When a transaction is aborted btrfs_cleanup_transaction is called to
cleanup all the various in-flight bits and pieces which migth be
active. One of those is delalloc inodes - inodes which have dirty
pages which haven't been persisted yet. Currently the process of
freeing such delalloc inodes in exceptional circumstances such as
transaction abort boiled down to calling btrfs_invalidate_inodes whose
sole job is to invalidate the dentries for all inodes related to a
root. This is in fact wrong and insufficient since such delalloc inodes
will likely have pending pages or ordered-extents and will be linked to
the sb->s_inode_list. This means that unmounting a btrfs instance with
an aborted transaction could potentially lead inodes/their pages
visible to the system long after their superblock has been freed. This
in turn leads to a "use-after-free" situation once page shrink is
triggered. This situation could be simulated by running generic/019
which would cause such inodes to be left hanging, followed by
generic/176 which causes memory pressure and page eviction which lead
to touching the freed super block instance. This situation is
additionally detected by the unmount code of VFS with the following
message:

"VFS: Busy inodes after unmount of Self-destruct in 5 seconds.  Have a nice day..."

Additionally btrfs hits WARN_ON(!RB_EMPTY_ROOT(&root->inode_tree));
in free_fs_root for the same reason.

This patch aims to rectify the sitaution by doing the following:

1. Change btrfs_destroy_delalloc_inodes so that it calls
invalidate_inode_pages2 for every inode on the delalloc list, this
ensures that all the pages of the inode are released. This function
boils down to calling btrfs_releasepage. During test I observed cases
where inodes on the delalloc list were having an i_count of 0, so this
necessitates using igrab to be sure we are working on a non-freed inode.

2. Since calling btrfs_releasepage might queue delayed iputs move the
call out to btrfs_cleanup_transaction in btrfs_error_commit_super before
calling run_delayed_iputs for the last time. This is necessary to ensure
that delayed iputs are run.

Note: this patch is tagged for 4.14 stable but the fix applies to older
versions too but needs to be backported manually due to conflicts.

CC: stable@vger.kernel.org # 4.14.x: 2b8773313494: btrfs: Split btrfs_del_delalloc_inode into 2 functions
CC: stable@vger.kernel.org # 4.14.x
Signed-off-by: Nikolay Borisov <nborisov@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ add comment to igrab ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/disk-io.c |   26 +++++++++++++++-----------
 1 file changed, 15 insertions(+), 11 deletions(-)

--- a/fs/btrfs/disk-io.c
+++ b/fs/btrfs/disk-io.c
@@ -3905,6 +3905,7 @@ void close_ctree(struct btrfs_fs_info *f
 	set_bit(BTRFS_FS_CLOSING_DONE, &fs_info->flags);
 
 	btrfs_free_qgroup_config(fs_info);
+	ASSERT(list_empty(&fs_info->delalloc_roots));
 
 	if (percpu_counter_sum(&fs_info->delalloc_bytes)) {
 		btrfs_info(fs_info, "at unmount delalloc count %lld",
@@ -4203,15 +4204,15 @@ static int btrfs_check_super_valid(struc
 
 static void btrfs_error_commit_super(struct btrfs_fs_info *fs_info)
 {
+	/* cleanup FS via transaction */
+	btrfs_cleanup_transaction(fs_info);
+
 	mutex_lock(&fs_info->cleaner_mutex);
 	btrfs_run_delayed_iputs(fs_info);
 	mutex_unlock(&fs_info->cleaner_mutex);
 
 	down_write(&fs_info->cleanup_work_sem);
 	up_write(&fs_info->cleanup_work_sem);
-
-	/* cleanup FS via transaction */
-	btrfs_cleanup_transaction(fs_info);
 }
 
 static void btrfs_destroy_ordered_extents(struct btrfs_root *root)
@@ -4334,19 +4335,23 @@ static void btrfs_destroy_delalloc_inode
 	list_splice_init(&root->delalloc_inodes, &splice);
 
 	while (!list_empty(&splice)) {
+		struct inode *inode = NULL;
 		btrfs_inode = list_first_entry(&splice, struct btrfs_inode,
 					       delalloc_inodes);
-
-		list_del_init(&btrfs_inode->delalloc_inodes);
-		clear_bit(BTRFS_INODE_IN_DELALLOC_LIST,
-			  &btrfs_inode->runtime_flags);
+		__btrfs_del_delalloc_inode(root, btrfs_inode);
 		spin_unlock(&root->delalloc_lock);
 
-		btrfs_invalidate_inodes(btrfs_inode->root);
-
+		/*
+		 * Make sure we get a live inode and that it'll not disappear
+		 * meanwhile.
+		 */
+		inode = igrab(&btrfs_inode->vfs_inode);
+		if (inode) {
+			invalidate_inode_pages2(inode->i_mapping);
+			iput(inode);
+		}
 		spin_lock(&root->delalloc_lock);
 	}
-
 	spin_unlock(&root->delalloc_lock);
 }
 
@@ -4362,7 +4367,6 @@ static void btrfs_destroy_all_delalloc_i
 	while (!list_empty(&splice)) {
 		root = list_first_entry(&splice, struct btrfs_root,
 					 delalloc_root);
-		list_del_init(&root->delalloc_root);
 		root = btrfs_grab_fs_root(root);
 		BUG_ON(!root);
 		spin_unlock(&fs_info->delalloc_root_lock);
