Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F783C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 206342082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:17:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 206342082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbeLJRRN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:17:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50522 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbeLJRNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A53CB30DDBD1;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67FDD6015E;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id A2DF1224274; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 40/52] fuse: Do not block on inode lock while freeing memory range
Date:   Mon, 10 Dec 2018 12:13:06 -0500
Message-Id: <20181210171318.16998-41-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Once we select a memory range to free, we currently block on inode
lock. Do not block and use trylock instead. And move on to next memory
range if trylock fails.

Reason being that in next few patches I want to enabling waiting for
memmory ranges to become free in fuse_iomap_begin(). So insted of
returning -EBUSY, a process will wait for a memory range to become
free.

We don't want to end up in a situation where process is sleeping in
iomap_begin() with inode lock held and worker is trying to free
memory from same inode, resulting in deadlock.

To avoid deadlock, use trylock instead.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/file.c | 36 ++++++++++++++++++++++++++++--------
 1 file changed, 28 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index d86f6e5c4daf..dbe3410a94d7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3891,7 +3891,12 @@ int fuse_dax_free_one_mapping(struct fuse_conn *fc, struct inode *inode,
 	int ret;
 	struct fuse_inode *fi = get_fuse_inode(inode);
 
-	inode_lock(inode);
+	/*
+	 * If process is blocked waiting for memory while holding inode
+	 * lock, we will deadlock. So continue to free next range.
+	 */
+	if (!inode_trylock(inode))
+		return -EAGAIN;
 	down_write(&fi->i_mmap_sem);
 	down_write(&fi->i_dmap_sem);
 	ret = fuse_dax_free_one_mapping_locked(fc, inode, dmap_start);
@@ -3903,19 +3908,22 @@ int fuse_dax_free_one_mapping(struct fuse_conn *fc, struct inode *inode,
 
 int fuse_dax_free_memory(struct fuse_conn *fc, unsigned long nr_to_free)
 {
-	struct fuse_dax_mapping *dmap, *pos;
-	int ret, i;
+	struct fuse_dax_mapping *dmap, *pos, *temp;
+	int ret, nr_freed = 0;
 	u64 dmap_start = 0, window_offset = 0;
 	struct inode *inode = NULL;
 
 	/* Pick first busy range and free it for now*/
-	for (i = 0; i < nr_to_free; i++) {
+	while(1) {
+		if (nr_freed >= nr_to_free)
+			break;
+
 		dmap = NULL;
 		spin_lock(&fc->lock);
 
-		list_for_each_entry(pos, &fc->busy_ranges, busy_list) {
-			dmap = pos;
-			inode = igrab(dmap->inode);
+		list_for_each_entry_safe(pos, temp, &fc->busy_ranges,
+						busy_list) {
+			inode = igrab(pos->inode);
 			/*
 			 * This inode is going away. That will free
 			 * up all the ranges anyway, continue to
@@ -3923,6 +3931,13 @@ int fuse_dax_free_memory(struct fuse_conn *fc, unsigned long nr_to_free)
 			 */
 			if (!inode)
 				continue;
+			/*
+			 * Take this element off list and add it tail. If
+			 * inode lock can't be obtained, this will help with
+			 * selecting new element
+			 */
+			dmap = pos;
+			list_move_tail(&dmap->busy_list, &fc->busy_ranges);
 			dmap_start = dmap->start;
 			window_offset = dmap->window_offset;
 			break;
@@ -3933,11 +3948,16 @@ int fuse_dax_free_memory(struct fuse_conn *fc, unsigned long nr_to_free)
 
 		ret = fuse_dax_free_one_mapping(fc, inode, dmap_start);
 		iput(inode);
-		if (ret) {
+		if (ret && ret != -EAGAIN) {
 			printk("%s(window_offset=0x%llx) failed. err=%d\n",
 				__func__, window_offset, ret);
 			return ret;
 		}
+
+		/* Could not get inode lock. Try next element */
+		if (ret == -EAGAIN)
+			continue;
+		nr_freed++;
 	}
 	return 0;
 }
-- 
2.13.6

