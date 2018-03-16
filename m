Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELu241zTDwBILfVvs3zvFETpsM3v8t0diaA0lggyRnnHJ6bhWtFQjtfkUVa6li5oWh3GbhMI
ARC-Seal: i=1; a=rsa-sha256; t=1521214807; cv=none;
        d=google.com; s=arc-20160816;
        b=RXcuVtpw6mo/ZbEV0wM0lilkeERyaZNrMQLMnV/KZJ+Fg6XkxTrSZCga3XD7NScuDB
         ayILgOM8k52kC09JIfgv5ZZWHHxaPoID+6cGLfKJ1QJvPtnQRJ8GGZ86kBxzCLXICRVP
         usNjCfDCB+1YgPaYUrZ9P9HetEs6zm6+9/cbm97/8d1b1amA1MKmiagPe3NZdCDh6Qll
         9CpTpo/FIeKryTuf9mLcqv7otEp6yLXnV7wThUtzM3bi6xBqPKebFO7uMfF/PNdRd/fJ
         dVFza+iQq92i6ocVwYqdcrTJIs7nSUITOU4WnSnlo5q2e0XM/w2e7BHPnfuCeb/yZkVi
         xY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YgDF2nOBr0qQAv3cKPn0jzB7mLts8oL4JrfFRhTgdpM=;
        b=0qXbSv4F4japnYHkHKz4iuHhG1oy/YcK9+ZK9GXAG+0jPWqcHk1gqT+Cpt70Gws/ct
         KC4+BTS5bknc+e+UFZkaQK7wTqYDTyG+HGCwIBx/vST9ueRpnWp4R3hIaK0Gd/IFvAMR
         E7o1bxl3nWMwdpf+TZlqNHF/eA4FrYqWjQ7fYRFcpe3xONpNsKdMFZimGPctBWhdHN9y
         B93IWqY/1OWFcnAY2DH5ROQXMXLXiC5o4m/n/nZB9KybxUtEwobJY3TwZOzNmTkkc8xA
         aW3XcsXDo4zU72N3DjKX38fsQ0VmNqjtb7BVhDnVNQ+DFK1uH5bGTnGdOAEopitwxUOd
         dE7A==
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
Subject: [PATCH 4.15 025/128] [PATCH] Revert "btrfs: use proper endianness accessors for super_copy"
Date: Fri, 16 Mar 2018 16:22:46 +0100
Message-Id: <20180316152337.761888084@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180316152336.199007505@linuxfoundation.org>
References: <20180316152336.199007505@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595109141496550585?=
X-GMAIL-MSGID: =?utf-8?q?1595109338527781941?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -423,7 +423,7 @@ static ssize_t btrfs_nodesize_show(struc
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->nodesize);
+	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->super_copy->nodesize);
 }
 
 BTRFS_ATTR(, nodesize, btrfs_nodesize_show);
@@ -433,7 +433,8 @@ static ssize_t btrfs_sectorsize_show(str
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->sectorsize);
+	return snprintf(buf, PAGE_SIZE, "%u\n",
+			fs_info->super_copy->sectorsize);
 }
 
 BTRFS_ATTR(, sectorsize, btrfs_sectorsize_show);
@@ -443,7 +444,8 @@ static ssize_t btrfs_clone_alignment_sho
 {
 	struct btrfs_fs_info *fs_info = to_fs_info(kobj);
 
-	return snprintf(buf, PAGE_SIZE, "%u\n", fs_info->sectorsize);
+	return snprintf(buf, PAGE_SIZE, "%u\n",
+			fs_info->super_copy->sectorsize);
 }
 
 BTRFS_ATTR(, clone_alignment, btrfs_clone_alignment_show);
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1723,23 +1723,19 @@ static void update_super_roots(struct bt
 
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
