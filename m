Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751833AbeFBRpq (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 13:45:46 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:44510 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbeFBRpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 13:45:45 -0400
X-Google-Smtp-Source: ADUXVKJUe6JBmPWGq4ungX6LNZSriqJK2MRHWzwISxyDEyKVRPkmb3ylmr4sHpMydLcInHz9WKVNOQ==
From: Kent Overstreet <kent.overstreet@gmail.com>
To: axboe@kernel.dk, dm-devel@redhat.com, linux-kernel@vger.kernel.org,
        snitzer@redhat.com
Cc: Kent Overstreet <kent.overstreet@gmail.com>
Subject: [PATCH] dm-crypt: fix warning in shutdown path
Date: Sat,  2 Jun 2018 13:45:04 -0400
Message-Id: <20180602174504.1847-1-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The counter for the number of allocated pages includes pages in the
mempool's reserve, so checking that the number of allocated pages is 0
needs to happen after we exit the mempool.

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
---
 drivers/md/dm-crypt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/md/dm-crypt.c b/drivers/md/dm-crypt.c
index eaf6b279ac..9a000aa955 100644
--- a/drivers/md/dm-crypt.c
+++ b/drivers/md/dm-crypt.c
@@ -2221,14 +2221,14 @@ static void crypt_dtr(struct dm_target *ti)
 
 	bioset_exit(&cc->bs);
 
-	if (mempool_initialized(&cc->page_pool))
-		WARN_ON(percpu_counter_sum(&cc->n_allocated_pages) != 0);
-	percpu_counter_destroy(&cc->n_allocated_pages);
-
 	mempool_exit(&cc->page_pool);
 	mempool_exit(&cc->req_pool);
 	mempool_exit(&cc->tag_pool);
 
+	if (cc->n_allocated_pages.counters)
+		WARN_ON(percpu_counter_sum(&cc->n_allocated_pages) != 0);
+	percpu_counter_destroy(&cc->n_allocated_pages);
+
 	if (cc->iv_gen_ops && cc->iv_gen_ops->dtr)
 		cc->iv_gen_ops->dtr(cc);
 
-- 
2.17.1
