Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EEA7C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E732082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 17:13:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E732082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbeLJRNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 12:13:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45114 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbeLJRNg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 12:13:36 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2ED6C2D7E8;
        Mon, 10 Dec 2018 17:13:36 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.234])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DBAC46012B;
        Mon, 10 Dec 2018 17:13:35 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id D358222427F; Mon, 10 Dec 2018 12:13:30 -0500 (EST)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, sweil@redhat.com, swhiteho@redhat.com
Subject: [PATCH 51/52] fuse: shared version cleanups
Date:   Mon, 10 Dec 2018 12:13:17 -0500
Message-Id: <20181210171318.16998-52-vgoyal@redhat.com>
In-Reply-To: <20181210171318.16998-1-vgoyal@redhat.com>
References: <20181210171318.16998-1-vgoyal@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Mon, 10 Dec 2018 17:13:36 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miklos Szeredi <mszeredi@redhat.com>

Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
---
 fs/fuse/dir.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 3aa214f9a28e..f9a91e782cf0 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -253,29 +253,36 @@ static bool fuse_dentry_version_mismatch(struct dentry *dentry)
 	return fuse_version_mismatch(inode, READ_ONCE(fude->version));
 }
 
-static void fuse_set_version_ptr(struct inode *inode,
-			      struct fuse_entryver_out *outver)
+static s64 *fuse_version_ptr(struct inode *inode,
+			     struct fuse_entryver_out *outver)
 {
 	struct fuse_conn *fc = get_fuse_conn(inode);
-	struct fuse_inode *fi = get_fuse_inode(inode);
 
-	if (!fc->version_table || !outver->version_index) {
-		fi->version_ptr = NULL;
-		return;
-	}
+	if (!fc->version_table || !outver->version_index)
+		return NULL;
+
 	if (outver->version_index >= fc->version_table_size) {
 		pr_warn_ratelimited("version index too large (%llu >= %llu)\n",
 				    outver->version_index,
 				    fc->version_table_size);
-		fi->version_ptr = NULL;
-		return;
+		return NULL;
 	}
 
-	fi->version_ptr = fc->version_table + outver->version_index;
+	return fc->version_table + outver->version_index;
+}
 
-	pr_info("fuse: version_ptr = %p\n", fi->version_ptr);
-	pr_info("fuse: version = %lli\n", fi->attr_version);
-	pr_info("fuse: current_version: %lli\n", *fi->version_ptr);
+static void fuse_set_version_ptr(struct inode *inode,
+			      struct fuse_entryver_out *outver)
+{
+	struct fuse_inode *fi = get_fuse_inode(inode);
+
+	fi->version_ptr = fuse_version_ptr(inode, outver);
+
+	if (fi->version_ptr) {
+		pr_info("fuse: version_ptr = %p\n", fi->version_ptr);
+		pr_info("fuse: version = %lli\n", fi->attr_version);
+		pr_info("fuse: current_version: %lli\n", *fi->version_ptr);
+	}
 }
 
 /*
@@ -335,13 +342,16 @@ static int fuse_dentry_revalidate(struct dentry *entry, unsigned int flags)
 		if (!ret && !outarg.nodeid)
 			ret = -ENOENT;
 		if (!ret) {
+			s64 *new_version_ptr = fuse_version_ptr(inode, &outver);
+
 			fi = get_fuse_inode(inode);
 			if (outarg.nodeid != get_node_id(inode)) {
 				fuse_queue_forget(fc, forget, outarg.nodeid, 1);
 				goto invalid;
 			}
-			if (fi->version_ptr != fc->version_table + outver.version_index)
-				pr_warn("fuse_dentry_revalidate: version_ptr changed (%p -> %p)\n", fi->version_ptr, fc->version_table + outver.version_index);
+			if (fi->version_ptr != new_version_ptr) {
+				pr_warn("fuse_dentry_revalidate: version_ptr changed (%p -> %p)\n", fi->version_ptr, new_version_ptr);
+			}
 
 			spin_lock(&fc->lock);
 			fi->nlookup++;
-- 
2.13.6

