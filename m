Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELv/VniVvzTtqI/LCxw22Y4FHtBrMLeFwx7ABSu4IMIFEWaxg9r6+iM7LeqND5aClJ+b1o0G
ARC-Seal: i=1; a=rsa-sha256; t=1520451905; cv=none;
        d=google.com; s=arc-20160816;
        b=Z931h3jaepU94LiDX8HfQ0U/onIFBPNImWbpJXhvcSaQZW84oEOxwkKvEgW92GDYcX
         99K/79fF6n9eTk5zEsySvCTFfMltJPbtb/iWfPjqHNMQyNoWc6UZWdAeydMDoyJkGxRj
         6XasyB/tyy+MpPfRmhClQmAItgw/fRGWAZmAhLlZzlGL5idfSIR1N+rVi51A+NwZXV8L
         gIYQqGqhA5olz2FXllFoaC+M0UxsQ2hS5GneIh2tyKnoNae/k8YhfuJ7TKtmZUtqvbuP
         UWGZYWbXxDpeyGS5x9s9007H9AJJSPH5CXfAMrOw3xdxE5PdPaIBbxaz7V9/9Bw4uUG9
         Wsrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=TSMjgN2/y/lX87rJ8fTEPPjI5ohIEGRyVkEaRX50evI=;
        b=uDnzpTBuc9iGV/PxEmHmZfuNVe8bbLqsyQk6xhydz8HbHzFE7dNGTXHLe6wkGcmFpR
         Pt3dRPehYe5/2KXdjQJDuRrsUUUT9+CXBqbvdxf5kMMuUXdOLV59kqPk4QQaWP+/z5R6
         QJORWfUHQDI9hDTw+yLD35F/WDWLP4uJysHRDNbacXPAi5PRQr2gRinjDq4MrIHs7C6K
         uEomO1ehya23l0SJ2dp+unY59Ug0kAYTmr8V7n1IzI9ttkr9udjDHx11owaZ/r+ukuvo
         W9HVXitJHtEnXWm0VCPBNvYb78YAoF0KE4DdovYX3aJWwwaCQjH3AwimoPK9pXWY80ct
         rOwQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Anand Jain <anand.jain@oracle.com>,
	Liu Bo <bo.li.liu@oracle.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 024/110] btrfs: use proper endianness accessors for super_copy
Date: Wed,  7 Mar 2018 11:38:07 -0800
Message-Id: <20180307191042.810088712@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191039.748351103@linuxfoundation.org>
References: <20180307191039.748351103@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309090147375870?=
X-GMAIL-MSGID: =?utf-8?q?1594309377521208214?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anand Jain <anand.jain@oracle.com>

commit 3c181c12c431fe33b669410d663beb9cceefcd1b upstream.

The fs_info::super_copy is a byte copy of the on-disk structure and all
members must use the accessor macros/functions to obtain the right
value.  This was missing in update_super_roots and in sysfs readers.

Moving between opposite endianness hosts will report bogus numbers in
sysfs, and mount may fail as the root will not be restored correctly. If
the filesystem is always used on a same endian host, this will not be a
problem.

Fix this by using the btrfs_set_super...() functions to set
fs_info::super_copy values, and for the sysfs, use the cached
fs_info::nodesize/sectorsize values.

CC: stable@vger.kernel.org
Fixes: df93589a17378 ("btrfs: export more from FS_INFO to sysfs")
Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
[ update changelog ]
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 fs/btrfs/sysfs.c       |    8 +++-----
 fs/btrfs/transaction.c |   20 ++++++++++++--------
 2 files changed, 15 insertions(+), 13 deletions(-)

--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -422,7 +422,7 @@ static ssize_t btrfs_nodesize_show(struc
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->nodesize);
+	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->nodesize);
 }
 
 BTRFS_ATTR(nodesize, btrfs_nodesize_show);
@@ -432,8 +432,7 @@ static ssize_t btrfs_sectorsize_show(str
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-			fs_info->super_copy->sectorsize);
+	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->sectorsize);
 }
 
 BTRFS_ATTR(sectorsize, btrfs_sectorsize_show);
@@ -443,8 +442,7 @@ static ssize_t btrfs_clone_alignment_sho
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n",
-			fs_info->super_copy->sectorsize);
+	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->sectorsize);
 }
 
 BTRFS_ATTR(clone_alignment, btrfs_clone_alignment_show);
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1722,19 +1722,23 @@ static void update_super_roots(struct bt
 
 	super = fs_info->super_copy;
 
+	/* update latest btrfs_super_block::chunk_root refs */
 	root_item = &fs_info->chunk_root->root_item;
-	super->chunk_root = root_item->bytenr;
-	super->chunk_root_generation = root_item->generation;
-	super->chunk_root_level = root_item->level;
+	btrfs_set_super_chunk_root(super, root_item->bytenr);
+	btrfs_set_super_chunk_root_generation(super, root_item->generation);
+	btrfs_set_super_chunk_root_level(super, root_item->level);
 
+	/* update latest btrfs_super_block::root refs */
 	root_item = &fs_info->tree_root->root_item;
-	super->root = root_item->bytenr;
-	super->generation = root_item->generation;
-	super->root_level = root_item->level;
+	btrfs_set_super_root(super, root_item->bytenr);
+	btrfs_set_super_generation(super, root_item->generation);
+	btrfs_set_super_root_level(super, root_item->level);
+
 	if (btrfs_test_opt(fs_info, SPACE_CACHE))
-		super->cache_generation = root_item->generation;
+		btrfs_set_super_cache_generation(super, root_item->generation);
 	if (test_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags))
-		super->uuid_tree_generation = root_item->generation;
+		btrfs_set_super_uuid_tree_generation(super,
+						     root_item->generation);
 }
 
 int btrfs_transaction_in_commit(struct btrfs_fs_info *info)
