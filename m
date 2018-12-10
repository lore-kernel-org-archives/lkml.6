Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780BFC04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:18:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49FBA2082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:18:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49FBA2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728979AbeLJRRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:17:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38438 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbeLJRNf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:35 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 716E1C049587;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 27A57600D7;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 9655F224270; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 36/52] fuse: Kick worker when free memory drops below 20% of total ranges
Date:   Mon, 10 Dec 2018 12:13:02 -0500
Message-Id: <20181210171318.16998-37-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kick worker to free up some memory when number of free ranges drops below
20% of total free ranges at the time of initialization.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c   | 11 ++++++++++-
 fs/fuse/fuse_i.h |  9 +++++++++
 fs/fuse/inode.c  |  1 +
 3 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 13db83d105ff..1f172d372eeb 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -186,6 +186,7 @@ static void fuse_link_write_file(struct file *file)
 
 static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
 {
+	unsigned long free_threshold;
 	struct fuse_dax_mapping *dmap = NULL;
 
 	spin_lock(&fc->lock);
@@ -193,7 +194,7 @@ static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
 	/* TODO: Add logic to try to free up memory if wait is allowed */
 	if (fc->nr_free_ranges <= 0) {
 		spin_unlock(&fc->lock);
-		return NULL;
+		goto out_kick;
 	}
 
 	WARN_ON(list_empty(&fc->free_ranges));
@@ -204,6 +205,14 @@ static struct fuse_dax_mapping *alloc_dax_mapping(struct fuse_conn *fc)
 	list_del_init(&dmap->list);
 	fc->nr_free_ranges--;
 	spin_unlock(&fc->lock);
+
+out_kick:
+	/* If number of free ranges are below threshold, start reclaim */
+	free_threshold = (fc->nr_ranges * FUSE_DAX_RECLAIM_THRESHOLD)/100;
+	if (free_threshold > 0 && fc->nr_free_ranges < free_threshold) {
+		pr_debug("fuse: Kicking dax memory reclaim worker. nr_free_ranges=0x%ld nr_total_ranges=%ld\n", fc->nr_free_ranges, fc->nr_ranges);
+		queue_delayed_work(system_long_wq, &fc->dax_free_work, 0);
+	}
 	return dmap;
 }
 
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index 383deaf0ecf1..bbefa7c11078 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -53,6 +53,13 @@
 /* Number of ranges reclaimer will try to free in one invocation */
 #define FUSE_DAX_RECLAIM_CHUNK		(10)
 
+/*
+ * Dax memory reclaim threshold in percetage of total ranges. When free
+ * number of free ranges drops below this threshold, reclaim can trigger
+ * Default is 20%
+ * */
+#define FUSE_DAX_RECLAIM_THRESHOLD	(20)
+
 /** List of active connections */
 extern struct list_head fuse_conn_list;
 
@@ -885,6 +892,8 @@ struct fuse_conn {
 	 */
 	unsigned long nr_free_ranges;
 	struct list_head free_ranges;
+
+	unsigned long nr_ranges;
 };
 
 static inline struct fuse_conn *get_fuse_conn_super(struct super_block *sb)
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 44f7bc44e319..d31acb97eede 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -675,6 +675,7 @@ static int fuse_dax_mem_range_init(struct fuse_conn *fc,
 
 	list_replace_init(&mem_ranges, &fc->free_ranges);
 	fc->nr_free_ranges = allocated_ranges;
+	fc->nr_ranges = allocated_ranges;
 	return 0;
 out_err:
 	/* Free All allocated elements */
-- 
2.13.6

