Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id KJSoJNSLHls8ZAAAmS7hNA
	; Mon, 11 Jun 2018 14:49:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 846F3607A4; Mon, 11 Jun 2018 14:49:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 97ACA6074D;
	Mon, 11 Jun 2018 14:49:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97ACA6074D
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=linutronix.de
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932439AbeFKOtR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 19 others); Mon, 11 Jun 2018 10:49:17 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:37342 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751952AbeFKOtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 10:49:16 -0400
Received: from bigeasy by Galois.linutronix.de with local (Exim 4.80)
        (envelope-from <bigeasy@linutronix.de>)
        id 1fSO8A-0006Au-2F; Mon, 11 Jun 2018 16:49:14 +0200
Date: Mon, 11 Jun 2018 16:49:14 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, linux-ntfs-dev@lists.sourceforge.net,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Anton Altaparmakov <anton@tuxera.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH REPOST] ntfs: don't disable interrupts during kmap_atomic()
Message-ID: <20180611144913.gln5mklhqcrfsoom@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: NeoMutt/20180512
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ntfs_end_buffer_async_read() disables interrupts around kmap_atomic(). This is
a leftover from the old kmap_atomic() implementation which relied on fixed
mapping slots, so the caller had to make sure that the same slot could not be
reused from an interrupting context.

kmap_atomic() was changed to dynamic slots long ago and commit 1ec9c5ddc17a
("include/linux/highmem.h: remove the second argument of k[un]map_atomic()")
removed the slot assignements, but the callers were not checked for now
redundant interrupt disabling.

Remove the conditional interrupt disable.

Cc: Anton Altaparmakov <anton@tuxera.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
Repost from 
  https://lkml.kernel.org/r/20180504144222.5443-1-bigeasy@linutronix.de

 fs/ntfs/aops.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ntfs/aops.c b/fs/ntfs/aops.c
index 3a2e509c77c5..01c770979921 100644
--- a/fs/ntfs/aops.c
+++ b/fs/ntfs/aops.c
@@ -93,13 +93,11 @@ static void ntfs_end_buffer_async_read(struct buffer_head *bh, int uptodate)
 			ofs = 0;
 			if (file_ofs < init_size)
 				ofs = init_size - file_ofs;
-			local_irq_save(flags);
 			kaddr = kmap_atomic(page);
 			memset(kaddr + bh_offset(bh) + ofs, 0,
 					bh->b_size - ofs);
 			flush_dcache_page(page);
 			kunmap_atomic(kaddr);
-			local_irq_restore(flags);
 		}
 	} else {
 		clear_buffer_uptodate(bh);
@@ -146,13 +144,11 @@ static void ntfs_end_buffer_async_read(struct buffer_head *bh, int uptodate)
 		recs = PAGE_SIZE / rec_size;
 		/* Should have been verified before we got here... */
 		BUG_ON(!recs);
-		local_irq_save(flags);
 		kaddr = kmap_atomic(page);
 		for (i = 0; i < recs; i++)
 			post_read_mst_fixup((NTFS_RECORD*)(kaddr +
 					i * rec_size), rec_size);
 		kunmap_atomic(kaddr);
-		local_irq_restore(flags);
 		flush_dcache_page(page);
 		if (likely(page_uptodate && !PageError(page)))
 			SetPageUptodate(page);
-- 
2.17.1
