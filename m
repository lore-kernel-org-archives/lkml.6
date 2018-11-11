Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF2AAC43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A204D206BA
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 22:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAaPVXtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A204D206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404129AbeKLInv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 03:43:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54742 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403989AbeKLIW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:22:59 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D10BD2241E;
        Sun, 11 Nov 2018 22:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975581;
        bh=I51LqlYD3f5g2OQ2cYpJwJ54Jkxb+oFr/rAP9WTnQ+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EAaPVXtQsaftXWpL+Hg3RpsQS/DOSdii/xsBB8zzWfKJY7bRyI/1AbD3NMmjiORFS
         zowkw5659IkDRzReaTlDpKu5uBz+Sfpf3eoJiDSzInhovi0wKtf8sTrmbJXpAZWu8/
         82up9vIZnAS5vXBYDAyWDs3BDXJ8ydwni3Oghkbs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 174/222] dm zoned: fix metadata block ref counting
Date:   Sun, 11 Nov 2018 14:24:31 -0800
Message-Id: <20181111221702.706202404@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221647.665769131@linuxfoundation.org>
References: <20181111221647.665769131@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Damien Le Moal <damien.lemoal@wdc.com>

commit 33c2865f8d011a2ca9f67124ddab9dc89382e9f1 upstream.

Since the ref field of struct dmz_mblock is always used with the
spinlock of struct dmz_metadata locked, there is no need to use an
atomic_t type. Change the type of the ref field to an unsigne
integer.

Fixes: 3b1a94c88b79 ("dm zoned: drive-managed zoned block device target")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-zoned-metadata.c |   20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

--- a/drivers/md/dm-zoned-metadata.c
+++ b/drivers/md/dm-zoned-metadata.c
@@ -99,7 +99,7 @@ struct dmz_mblock {
 	struct rb_node		node;
 	struct list_head	link;
 	sector_t		no;
-	atomic_t		ref;
+	unsigned int		ref;
 	unsigned long		state;
 	struct page		*page;
 	void			*data;
@@ -296,7 +296,7 @@ static struct dmz_mblock *dmz_alloc_mblo
 
 	RB_CLEAR_NODE(&mblk->node);
 	INIT_LIST_HEAD(&mblk->link);
-	atomic_set(&mblk->ref, 0);
+	mblk->ref = 0;
 	mblk->state = 0;
 	mblk->no = mblk_no;
 	mblk->data = page_address(mblk->page);
@@ -397,7 +397,7 @@ static struct dmz_mblock *dmz_fetch_mblo
 		return NULL;
 
 	spin_lock(&zmd->mblk_lock);
-	atomic_inc(&mblk->ref);
+	mblk->ref++;
 	set_bit(DMZ_META_READING, &mblk->state);
 	dmz_insert_mblock(zmd, mblk);
 	spin_unlock(&zmd->mblk_lock);
@@ -484,7 +484,8 @@ static void dmz_release_mblock(struct dm
 
 	spin_lock(&zmd->mblk_lock);
 
-	if (atomic_dec_and_test(&mblk->ref)) {
+	mblk->ref--;
+	if (mblk->ref == 0) {
 		if (test_bit(DMZ_META_ERROR, &mblk->state)) {
 			rb_erase(&mblk->node, &zmd->mblk_rbtree);
 			dmz_free_mblock(zmd, mblk);
@@ -511,7 +512,8 @@ static struct dmz_mblock *dmz_get_mblock
 	mblk = dmz_lookup_mblock(zmd, mblk_no);
 	if (mblk) {
 		/* Cache hit: remove block from LRU list */
-		if (atomic_inc_return(&mblk->ref) == 1 &&
+		mblk->ref++;
+		if (mblk->ref == 1 &&
 		    !test_bit(DMZ_META_DIRTY, &mblk->state))
 			list_del_init(&mblk->link);
 	}
@@ -753,7 +755,7 @@ int dmz_flush_metadata(struct dmz_metada
 
 		spin_lock(&zmd->mblk_lock);
 		clear_bit(DMZ_META_DIRTY, &mblk->state);
-		if (atomic_read(&mblk->ref) == 0)
+		if (mblk->ref == 0)
 			list_add_tail(&mblk->link, &zmd->mblk_lru_list);
 		spin_unlock(&zmd->mblk_lock);
 	}
@@ -2308,7 +2310,7 @@ static void dmz_cleanup_metadata(struct
 		mblk = list_first_entry(&zmd->mblk_dirty_list,
 					struct dmz_mblock, link);
 		dmz_dev_warn(zmd->dev, "mblock %llu still in dirty list (ref %u)",
-			     (u64)mblk->no, atomic_read(&mblk->ref));
+			     (u64)mblk->no, mblk->ref);
 		list_del_init(&mblk->link);
 		rb_erase(&mblk->node, &zmd->mblk_rbtree);
 		dmz_free_mblock(zmd, mblk);
@@ -2326,8 +2328,8 @@ static void dmz_cleanup_metadata(struct
 	root = &zmd->mblk_rbtree;
 	rbtree_postorder_for_each_entry_safe(mblk, next, root, node) {
 		dmz_dev_warn(zmd->dev, "mblock %llu ref %u still in rbtree",
-			     (u64)mblk->no, atomic_read(&mblk->ref));
-		atomic_set(&mblk->ref, 0);
+			     (u64)mblk->no, mblk->ref);
+		mblk->ref = 0;
 		dmz_free_mblock(zmd, mblk);
 	}
 


