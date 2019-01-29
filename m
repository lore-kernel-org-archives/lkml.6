Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B42CC169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4FAF20882
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762630;
	bh=JlRDsUpk+Cb0RXytDJDC6ZtzMaho9AzwOBC8LZkaaIE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XZ55ty2aentPcKVNGAGvL9LYumuKwiyezqjmVNgToJdfChNfcHune2y/ypqmPFmHt
	 YrK5D/QmNrpuNpos2kCV6LyUIhXP77dV/SealV7DPxjx34EbHyezkIMVK/esnP1vjM
	 xKimhQg/PqtSPq2eF4jlrn8qLeMHANCyLP1HwiFs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731420AbfA2Lu2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:50:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:41754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731657AbfA2LuZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:50:25 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AD0E820989;
        Tue, 29 Jan 2019 11:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762624;
        bh=JlRDsUpk+Cb0RXytDJDC6ZtzMaho9AzwOBC8LZkaaIE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gn52I8g8ADkhPnG62+ae3JwwfLLVzoQb2U3C0/8GrmgXx+oT4AjKuNMmOb0tABHn9
         /vLkPjdtRwv0SCnbqMym0dKJhrlQD3nE55+Bq48QiwbDx0BHa0zFqXhqcKZm2tgBy0
         BQEcJo/fJVoe7jKmlgbVX0tw+Hclpgi8YBh4lVyk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ryan.p.norwood@gmail.com,
        Joe Thornber <ejt@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.14 39/68] dm thin: fix passdown_double_checking_shared_status()
Date:   Tue, 29 Jan 2019 12:36:01 +0100
Message-Id: <20190129113134.962319589@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113131.751891514@linuxfoundation.org>
References: <20190129113131.751891514@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Thornber <ejt@redhat.com>

commit d445bd9cec1a850c2100fcf53684c13b3fd934f2 upstream.

Commit 00a0ea33b495 ("dm thin: do not queue freed thin mapping for next
stage processing") changed process_prepared_discard_passdown_pt1() to
increment all the blocks being discarded until after the passdown had
completed to avoid them being prematurely reused.

IO issued to a thin device that breaks sharing with a snapshot, followed
by a discard issued to snapshot(s) that previously shared the block(s),
results in passdown_double_checking_shared_status() being called to
iterate through the blocks double checking their reference count is zero
and issuing the passdown if so.  So a side effect of commit 00a0ea33b495
is passdown_double_checking_shared_status() was broken.

Fix this by checking if the block reference count is greater than 1.
Also, rename dm_pool_block_is_used() to dm_pool_block_is_shared().

Fixes: 00a0ea33b495 ("dm thin: do not queue freed thin mapping for next stage processing")
Cc: stable@vger.kernel.org # 4.9+
Reported-by: ryan.p.norwood@gmail.com
Signed-off-by: Joe Thornber <ejt@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/md/dm-thin-metadata.c |    4 ++--
 drivers/md/dm-thin-metadata.h |    2 +-
 drivers/md/dm-thin.c          |   10 +++++-----
 3 files changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -1687,7 +1687,7 @@ int dm_thin_remove_range(struct dm_thin_
 	return r;
 }
 
-int dm_pool_block_is_used(struct dm_pool_metadata *pmd, dm_block_t b, bool *result)
+int dm_pool_block_is_shared(struct dm_pool_metadata *pmd, dm_block_t b, bool *result)
 {
 	int r;
 	uint32_t ref_count;
@@ -1695,7 +1695,7 @@ int dm_pool_block_is_used(struct dm_pool
 	down_read(&pmd->root_lock);
 	r = dm_sm_get_count(pmd->data_sm, b, &ref_count);
 	if (!r)
-		*result = (ref_count != 0);
+		*result = (ref_count > 1);
 	up_read(&pmd->root_lock);
 
 	return r;
--- a/drivers/md/dm-thin-metadata.h
+++ b/drivers/md/dm-thin-metadata.h
@@ -195,7 +195,7 @@ int dm_pool_get_metadata_dev_size(struct
 
 int dm_pool_get_data_dev_size(struct dm_pool_metadata *pmd, dm_block_t *result);
 
-int dm_pool_block_is_used(struct dm_pool_metadata *pmd, dm_block_t b, bool *result);
+int dm_pool_block_is_shared(struct dm_pool_metadata *pmd, dm_block_t b, bool *result);
 
 int dm_pool_inc_data_range(struct dm_pool_metadata *pmd, dm_block_t b, dm_block_t e);
 int dm_pool_dec_data_range(struct dm_pool_metadata *pmd, dm_block_t b, dm_block_t e);
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -1042,7 +1042,7 @@ static void passdown_double_checking_sha
 	 * passdown we have to check that these blocks are now unused.
 	 */
 	int r = 0;
-	bool used = true;
+	bool shared = true;
 	struct thin_c *tc = m->tc;
 	struct pool *pool = tc->pool;
 	dm_block_t b = m->data_block, e, end = m->data_block + m->virt_end - m->virt_begin;
@@ -1052,11 +1052,11 @@ static void passdown_double_checking_sha
 	while (b != end) {
 		/* find start of unmapped run */
 		for (; b < end; b++) {
-			r = dm_pool_block_is_used(pool->pmd, b, &used);
+			r = dm_pool_block_is_shared(pool->pmd, b, &shared);
 			if (r)
 				goto out;
 
-			if (!used)
+			if (!shared)
 				break;
 		}
 
@@ -1065,11 +1065,11 @@ static void passdown_double_checking_sha
 
 		/* find end of run */
 		for (e = b + 1; e != end; e++) {
-			r = dm_pool_block_is_used(pool->pmd, e, &used);
+			r = dm_pool_block_is_shared(pool->pmd, e, &shared);
 			if (r)
 				goto out;
 
-			if (used)
+			if (shared)
 				break;
 		}
 


