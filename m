Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id wJrPLEuDHlteEwAAmS7hNA
	; Mon, 11 Jun 2018 14:13:00 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 7B54060850; Mon, 11 Jun 2018 14:13:00 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jFggEjEK"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	MAILING_LIST_MULTI,T_DKIM_INVALID autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id EAA6960351;
	Mon, 11 Jun 2018 14:12:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EAA6960351
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933917AbeFKOLh (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:11:37 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:46568 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933625AbeFKOHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:07:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=ujfYxZIIK99WfZRI1IdMsLLKISMVlB52o41m2OWnoI8=; b=jFggEjEKsiE60Ti2L72G3uyKP
        hHWplrkGm5THJgbvekX2XemUx1GMPanxUVs7+xMyCG25tCDRz1bmBDRgY2nX1jj6FYD+jSbufkK1P
        1F9x/SWvTIwTlMgOtT5pGGiILTP3CXI403Ns7h6VokvSxu2lkAw1fy+s0Rs/iVGuSw7l890KWzKIx
        R7NXCaOZ8wjAS2Jan/JDe2a+ja99sJTmeLq6ysSHpzbRIY9cUUzVHZ2tZrayme51JnnXYTXz79ZW2
        7YHOFtJu1nUCHDWgtjJoSsQW4zfDsTOxU8mAWPX6/ZI7XWzkX/rMASel2j427KcAXPPZaqX/HfGYi
        ChZu++RRg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fSNTS-00050G-J3; Mon, 11 Jun 2018 14:07:10 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: Matthew Wilcox <mawilcox@microsoft.com>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@redhat.com>,
        Lukas Czerner <lczerner@redhat.com>,
        Ross Zwisler <ross.zwisler@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ryusuke Konishi <konishi.ryusuke@lab.ntt.co.jp>,
        linux-nilfs@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
        Chao Yu <yuchao0@huawei.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: [PATCH v13 62/72] dax: Hash on XArray instead of mapping
Date: Mon, 11 Jun 2018 07:06:29 -0700
Message-Id: <20180611140639.17215-63-willy@infradead.org>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <20180611140639.17215-1-willy@infradead.org>
References: <20180611140639.17215-1-willy@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox <mawilcox@microsoft.com>

Since the XArray is embedded in the struct address_space, its address
contains exactly as much entropy as the address of the mapping.  This
patch is purely preparatory for later patches which will simplify the
wait/wake interfaces.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 fs/dax.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 97e8931541f1..7d0712c45da5 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -116,7 +116,7 @@ static int dax_is_empty_entry(void *entry)
  * DAX page cache entry locking
  */
 struct exceptional_entry_key {
-	struct address_space *mapping;
+	struct xarray *xa;
 	pgoff_t entry_start;
 };
 
@@ -125,7 +125,7 @@ struct wait_exceptional_entry_queue {
 	struct exceptional_entry_key key;
 };
 
-static wait_queue_head_t *dax_entry_waitqueue(struct address_space *mapping,
+static wait_queue_head_t *dax_entry_waitqueue(struct xarray *xa,
 		pgoff_t index, void *entry, struct exceptional_entry_key *key)
 {
 	unsigned long hash;
@@ -138,21 +138,21 @@ static wait_queue_head_t *dax_entry_waitqueue(struct address_space *mapping,
 	if (dax_is_pmd_entry(entry))
 		index &= ~PG_PMD_COLOUR;
 
-	key->mapping = mapping;
+	key->xa = xa;
 	key->entry_start = index;
 
-	hash = hash_long((unsigned long)mapping ^ index, DAX_WAIT_TABLE_BITS);
+	hash = hash_long((unsigned long)xa ^ index, DAX_WAIT_TABLE_BITS);
 	return wait_table + hash;
 }
 
-static int wake_exceptional_entry_func(wait_queue_entry_t *wait, unsigned int mode,
-				       int sync, void *keyp)
+static int wake_exceptional_entry_func(wait_queue_entry_t *wait,
+		unsigned int mode, int sync, void *keyp)
 {
 	struct exceptional_entry_key *key = keyp;
 	struct wait_exceptional_entry_queue *ewait =
 		container_of(wait, struct wait_exceptional_entry_queue, wait);
 
-	if (key->mapping != ewait->key.mapping ||
+	if (key->xa != ewait->key.xa ||
 	    key->entry_start != ewait->key.entry_start)
 		return 0;
 	return autoremove_wake_function(wait, mode, sync, NULL);
@@ -163,13 +163,13 @@ static int wake_exceptional_entry_func(wait_queue_entry_t *wait, unsigned int mo
  * The important information it's conveying is whether the entry at
  * this index used to be a PMD entry.
  */
-static void dax_wake_mapping_entry_waiter(struct address_space *mapping,
+static void dax_wake_mapping_entry_waiter(struct xarray *xa,
 		pgoff_t index, void *entry, bool wake_all)
 {
 	struct exceptional_entry_key key;
 	wait_queue_head_t *wq;
 
-	wq = dax_entry_waitqueue(mapping, index, entry, &key);
+	wq = dax_entry_waitqueue(xa, index, entry, &key);
 
 	/*
 	 * Checking for locked entry and prepare_to_wait_exclusive() happens
@@ -246,7 +246,8 @@ static void *get_unlocked_mapping_entry(struct address_space *mapping,
 			return entry;
 		}
 
-		wq = dax_entry_waitqueue(mapping, index, entry, &ewait.key);
+		wq = dax_entry_waitqueue(&mapping->i_pages, index, entry,
+				&ewait.key);
 		prepare_to_wait_exclusive(wq, &ewait.wait,
 					  TASK_UNINTERRUPTIBLE);
 		xa_unlock_irq(&mapping->i_pages);
@@ -270,7 +271,7 @@ static void dax_unlock_mapping_entry(struct address_space *mapping,
 	}
 	unlock_slot(mapping, slot);
 	xa_unlock_irq(&mapping->i_pages);
-	dax_wake_mapping_entry_waiter(mapping, index, entry, false);
+	dax_wake_mapping_entry_waiter(&mapping->i_pages, index, entry, false);
 }
 
 static void put_locked_mapping_entry(struct address_space *mapping,
@@ -290,7 +291,7 @@ static void put_unlocked_mapping_entry(struct address_space *mapping,
 		return;
 
 	/* We have to wake up next waiter for the page cache entry lock */
-	dax_wake_mapping_entry_waiter(mapping, index, entry, false);
+	dax_wake_mapping_entry_waiter(&mapping->i_pages, index, entry, false);
 }
 
 static unsigned long dax_entry_size(void *entry)
@@ -481,8 +482,8 @@ static void *grab_mapping_entry(struct address_space *mapping, pgoff_t index,
 			dax_disassociate_entry(entry, mapping, false);
 			radix_tree_delete(&mapping->i_pages, index);
 			mapping->nrexceptional--;
-			dax_wake_mapping_entry_waiter(mapping, index, entry,
-					true);
+			dax_wake_mapping_entry_waiter(&mapping->i_pages,
+					index, entry, true);
 		}
 
 		entry = dax_make_locked(0, size_flag | DAX_EMPTY);
-- 
2.17.1
