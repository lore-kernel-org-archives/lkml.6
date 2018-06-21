Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CBF7C43143
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:30:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ADEFD223E6
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 21:30:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mNMQR+8u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADEFD223E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934011AbeFUV3O (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 17:29:14 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:41748 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933933AbeFUV3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 17:29:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=wSZamsI5hfX+Sdt4UILe32NNcomypNMJ+9Y7hrsTfCM=; b=mNMQR+8uF5m73Aw++Vj1iGJK3
        Ra2PPK8MfMFAlskGA+EY6IhNdFa9RAqmsXQgg03JWmhLEROM1b9hewK3IilLJq/F28CPAG0VNYyHi
        b6wdoae/W+EAeHEeVik7YU88adrMwCvBC0khUgD2Sfi5AzXovF5Tnoo9wGuEfdjVm6Rq51Lj2dPTC
        hCTj0MNpE8T1cVBtgSRM/Rbf03nsnPRhgFW2/o8M6auPbFIiRfYfZoM8XPjrsYmAT87iCfQnPzxpK
        +phWUhJUF87Uvn4LKeZuLa8Jf1TRPQz+EyM9K6K91lmpT4FwbVps8JpIBNiNaiRll4dE0oOGhRz8L
        A9QeTLV7g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fW78d-0001az-U4; Thu, 21 Jun 2018 21:29:07 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH 06/26] fs: Convert namespace IDAs to new API
Date:   Thu, 21 Jun 2018 14:28:15 -0700
Message-Id: <20180621212835.5636-7-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180621212835.5636-1-willy@infradead.org>
References: <20180621212835.5636-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't need to keep track of the starting value; the IDA is efficient.

Signed-off-by: Matthew Wilcox <willy@infradead.org>
---
 fs/namespace.c | 50 ++++++++++++--------------------------------------
 1 file changed, 12 insertions(+), 38 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 8ddd14806799..bfd33eaab5aa 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -61,9 +61,6 @@ __setup("mphash_entries=", set_mphash_entries);
 static u64 event;
 static DEFINE_IDA(mnt_id_ida);
 static DEFINE_IDA(mnt_group_ida);
-static DEFINE_SPINLOCK(mnt_id_lock);
-static int mnt_id_start = 0;
-static int mnt_group_start = 1;
 
 static struct hlist_head *mount_hashtable __read_mostly;
 static struct hlist_head *mountpoint_hashtable __read_mostly;
@@ -101,50 +98,30 @@ static inline struct hlist_head *mp_hash(struct dentry *dentry)
 
 static int mnt_alloc_id(struct mount *mnt)
 {
-	int res;
+	int res = ida_alloc(&mnt_id_ida, GFP_KERNEL);
 
-retry:
-	ida_pre_get(&mnt_id_ida, GFP_KERNEL);
-	spin_lock(&mnt_id_lock);
-	res = ida_get_new_above(&mnt_id_ida, mnt_id_start, &mnt->mnt_id);
-	if (!res)
-		mnt_id_start = mnt->mnt_id + 1;
-	spin_unlock(&mnt_id_lock);
-	if (res == -EAGAIN)
-		goto retry;
-
-	return res;
+	if (res < 0)
+		return res;
+	mnt->mnt_id = res;
+	return 0;
 }
 
 static void mnt_free_id(struct mount *mnt)
 {
-	int id = mnt->mnt_id;
-	spin_lock(&mnt_id_lock);
-	ida_remove(&mnt_id_ida, id);
-	if (mnt_id_start > id)
-		mnt_id_start = id;
-	spin_unlock(&mnt_id_lock);
+	ida_free(&mnt_id_ida, mnt->mnt_id);
 }
 
 /*
  * Allocate a new peer group ID
- *
- * mnt_group_ida is protected by namespace_sem
  */
 static int mnt_alloc_group_id(struct mount *mnt)
 {
-	int res;
+	int res = ida_alloc_min(&mnt_group_ida, 1, GFP_KERNEL);
 
-	if (!ida_pre_get(&mnt_group_ida, GFP_KERNEL))
-		return -ENOMEM;
-
-	res = ida_get_new_above(&mnt_group_ida,
-				mnt_group_start,
-				&mnt->mnt_group_id);
-	if (!res)
-		mnt_group_start = mnt->mnt_group_id + 1;
-
-	return res;
+	if (res < 0)
+		return res;
+	mnt->mnt_group_id = res;
+	return 0;
 }
 
 /*
@@ -152,10 +129,7 @@ static int mnt_alloc_group_id(struct mount *mnt)
  */
 void mnt_release_group_id(struct mount *mnt)
 {
-	int id = mnt->mnt_group_id;
-	ida_remove(&mnt_group_ida, id);
-	if (mnt_group_start > id)
-		mnt_group_start = id;
+	ida_free(&mnt_group_ida, mnt->mnt_group_id);
 	mnt->mnt_group_id = 0;
 }
 
-- 
2.17.1

