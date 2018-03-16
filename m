Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELvt1l04f5kK+bWw6iI60KsCnnpEs8Q43ee1jqrQ3Y1CbOg+vSZ0X4lffViyYN+z9dGH5DkJ
ARC-Seal: i=1; a=rsa-sha256; t=1521214619; cv=none;
        d=google.com; s=arc-20160816;
        b=wce+qdJPthJGjOSMaggLrhbIq1+7c877dLvNtNj2UZOgU+lCzILsiSgfpLyqKgtI5z
         efrLOiLDTV54ar2FNT/ew/bdhJGe3bLsMPUOklUphih3dpx+4DdiQTtlVpVe1sm15tsj
         nr6nkeWqP2wCoQcx7b+mf7kG5gQzY9QyjfbUuVk6pLX9CFltNcvISaFc8c2NbvY/x+BW
         tg/sXjhaCkhPUAmN5Qi/9tOB4dXDr+fsL7fT8XkJ6/Qq2AGGkMOscnOA9qcffnQANkNv
         oS+dBp7cM2N4WqPqDY9sUNDJtthqPz00RJM7JQHo13YNGlPxyKjudubdc6aiEuVs9dzH
         CADA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=ZDVXQlt8nhcn1dg62DITg0IWn/i1CJKggHzO9O1GpW0=;
        b=vwshdHlC0QSQKs1EqCJ2gUiU16dhCw14emkGF5GrcK6KtKysfuZ4OB1PqMMB/sYAlv
         OcRjBTq+eR6QxB504yxy8qF603Vl2smYqxy6cK33HhRbYHLvtWJa8lOKrE36PfGmltoi
         a6/nfWzmwhF/q9ACvGQ6bxVNiZQKPNc9Vjx8pUDm2j6yRdEVRW5KGrjFePNQ2d6UqARd
         KOwNAvHim4ZHE2NoRDXPHQIcOlx/8P7/BYnEVUwpdnY6A8rDHMXu5aDotjqYLNILg5iU
         FDifzRVM906glWI3EXm2Lddn6CgudUZEQbcdL045paeQyPTDmgl7ZJ0DZ69+eux1JX+w
         mqZw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>,
	Anand Jain <anand.jain@oracle.com>,
	Liu Bo <bo.li.liu@oracle.com>,
	David Sterba <dsterba@suse.com>
Subject: [PATCH 4.14 026/109] [PATCH] Revert "btrfs: use proper endianness accessors for super_copy"
Date: Fri, 16 Mar 2018 16:22:55 +0100
Message-Id: <20180316152331.374866372@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152329.844663293@linuxfoundation.org>
References: <20180316152329.844663293@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109141496550585?=
X-GMAIL-MSGID: =?utf-8?q?1595109141496550585?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

This reverts commit 3c181c12c431fe33b669410d663beb9cceefcd1b as it
causes breakage on big endian systems with btrfs images.

Reported-by: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
Cc: Anand Jain <anand.jain@oracle.com>
Cc: Liu Bo <bo.li.liu@oracle.com>
Cc: David Sterba <dsterba@suse.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/sysfs.c       |    8 +++++---
 fs/btrfs/transaction.c |   20 ++++++++------------
 2 files changed, 13 insertions(+), 15 deletions(-)

--- a/fs/btrfs/sysfs.c
+++ b/fs/btrfs/sysfs.c
@@ -422,7 +422,7 @@ static ssize_t btrfs_nodesize_show(struc
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->nodesize);
+	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->nodesize);
 }
 
 BTRFS_ATTR(nodesize, btrfs_nodesize_show);
@@ -432,7 +432,8 @@ static ssize_t btrfs_sectorsize_show(str
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->sectorsize);
+	return snprintf(buf, PAGE_SIZE, "%u\n",
+			fs_info->super_copy->sectorsize);
 }
 
 BTRFS_ATTR(sectorsize, btrfs_sectorsize_show);
@@ -442,7 +443,8 @@ static ssize_t btrfs_clone_alignment_sho
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->sectorsize);
+	return snprintf(buf, PAGE_SIZE, "%u\n",
+			fs_info->super_copy->sectorsize);
 }
 
 BTRFS_ATTR(clone_alignment, btrfs_clone_alignment_show);
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1722,23 +1722,19 @@ static void update_super_roots(struct bt
 
 	super = fs_info->super_copy;
 
-	/* update latest btrfs_super_block::chunk_root refs */
 	root_item = &fs_info->chunk_root->root_item;
-	btrfs_set_super_chunk_root(super, root_item->bytenr);
-	btrfs_set_super_chunk_root_generation(super, root_item->generation);
-	btrfs_set_super_chunk_root_level(super, root_item->level);
+	super->chunk_root = root_item->bytenr;
+	super->chunk_root_generation = root_item->generation;
+	super->chunk_root_level = root_item->level;
 
-	/* update latest btrfs_super_block::root refs */
 	root_item = &fs_info->tree_root->root_item;
-	btrfs_set_super_root(super, root_item->bytenr);
-	btrfs_set_super_generation(super, root_item->generation);
-	btrfs_set_super_root_level(super, root_item->level);
-
+	super->root = root_item->bytenr;
+	super->generation = root_item->generation;
+	super->root_level = root_item->level;
 	if (btrfs_test_opt(fs_info, SPACE_CACHE))
-		btrfs_set_super_cache_generation(super, root_item->generation);
+		super->cache_generation = root_item->generation;
 	if (test_bit(BTRFS_FS_UPDATE_UUID_TREE_GEN, &fs_info->flags))
-		btrfs_set_super_uuid_tree_generation(super,
-						     root_item->generation);
+		super->uuid_tree_generation = root_item->generation;
 }
 
 int btrfs_transaction_in_commit(struct btrfs_fs_info *info)
