Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C31AC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D2B2F2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:19:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2B2F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729127AbeLJRTi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:19:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40774 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbeLJRNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1A02F13AA6;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C7AB55C7AA;
        Mon, 10 Dec 2018 17:13:34 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 7259B224266; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 27/52] fuse: Maintain a list of busy elements
Date:   Mon, 10 Dec 2018 12:12:53 -0500
Message-Id: <20181210171318.16998-28-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.29]); Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This list will be used selecting fuse_dax_mapping to free when number of
free mappings drops below a threshold.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c   | 8 ++++++++
 fs/fuse/fuse_i.h | 7 +++++++
 fs/fuse/inode.c  | 4 ++++
 3 files changed, 19 insertions(+)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 449a6b315327..94ad76382a6f 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -275,6 +275,10 @@ static int fuse_setup_one_mapping(struct inode *inode,
 	/* Protected by fi->i_dmap_sem */
 	fuse_dax_interval_tree_insert(dmap, &fi->dmap_tree);
 	fi->nr_dmaps++;
+	spin_lock(&fc->lock);
+	list_add_tail(&dmap->busy_list, &fc->busy_ranges);
+	fc->nr_busy_ranges++;
+	spin_unlock(&fc->lock);
 	return 0;
 }
 
@@ -322,6 +326,10 @@ void fuse_removemapping(struct inode *inode)
 		if (dmap) {
 			fuse_dax_interval_tree_remove(dmap, &fi->dmap_tree);
 			fi->nr_dmaps--;
+			spin_lock(&fc->lock);
+			list_del_init(&dmap->busy_list);
+			fc->nr_busy_ranges--;
+			spin_unlock(&fc->lock);
 		}
 
 		if (!dmap)
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 3b17fb336256..e32b0059493b 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -113,6 +113,9 @@ struct fuse_dax_mapping {
 	__u64 end;
 	__u64 __subtree_last;
 
+	/* Will connect in fc->busy_ranges to keep track busy memory */
+	struct list_head busy_list;
+
        /** Position in DAX window */
        u64 window_offset;
 
@@ -856,6 +859,10 @@ struct fuse_conn {
 	/** DAX device, non-NULL if DAX is supported */
 	struct dax_device *dax_dev;
 
+	/* List of memory ranges which are busy */
+	unsigned long nr_busy_ranges;
+	struct list_head busy_ranges;
+
 	/*
 	 * DAX Window Free Ranges. TODO: This might not be best place to store
 	 * this free list
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 56310d10cd4c..234b9c0c80ab 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -622,6 +622,8 @@ static void fuse_free_dax_mem_ranges(struct list_head *mem_list)
 	/* Free All allocated elements */
 	list_for_each_entry_safe(range, temp, mem_list, list) {
 		list_del(&range->list);
+		if (!list_empty(&range->busy_list))
+			list_del(&range->busy_list);
 		kfree(range);
 	}
 }
@@ -666,6 +668,7 @@ static int fuse_dax_mem_range_init(struct fuse_conn *fc,
 		range->window_offset = i * FUSE_DAX_MEM_RANGE_SZ;
 		range->length = FUSE_DAX_MEM_RANGE_SZ;
 		list_add_tail(&range->list, &mem_ranges);
+		INIT_LIST_HEAD(&range->busy_list);
 		allocated_ranges++;
 	}
 
@@ -708,6 +711,7 @@ void fuse_conn_init(struct fuse_conn *fc, struct user_namespace *user_ns,
 	fc->dax_dev = dax_dev;
 	fc->user_ns = get_user_ns(user_ns);
 	INIT_LIST_HEAD(&fc->free_ranges);
+	INIT_LIST_HEAD(&fc->busy_ranges);
 }
 EXPORT_SYMBOL_GPL(fuse_conn_init);
 
-- 
2.13.6

