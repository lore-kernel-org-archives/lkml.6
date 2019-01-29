Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5CAC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:53:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DFBD2086C
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 11:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548762827;
	bh=r66JSJ/5jvCyC8sRnxqQnTSvfRm/kPYiE/PwCg1gi/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=ISY7+tEf7UmL7QAs0cqK3U5VDuhLfAjG6tfObMpFWfMSG+0z4tnNy97dydSt3wDfz
	 Ch+X7+8EwWZ8nepCHpwRQivRjJDbOaRNkADwJRpU33AXPaGORoZZm/RroXqeTT0pgp
	 IOV7hl3I8qB/hgwEWImh+bFy/wGQJlxCp+88MQvA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731833AbfA2Lxq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 06:53:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:43254 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731066AbfA2Lvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 06:51:43 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97A452086C;
        Tue, 29 Jan 2019 11:51:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548762702;
        bh=r66JSJ/5jvCyC8sRnxqQnTSvfRm/kPYiE/PwCg1gi/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cwcVIp4rXgyZUHaZfRjhzjgs/rCRFSf/LBr4jZ0C4Rwa6z3jl1B+EIHcnao7brKoF
         MViT3OGo4guzlw+AtMAxglEQ53CQQSeeUhDRyXyjWaeY1xkWox4F0TUsOQoun0M6yj
         RqaKuO8szbBybyC3BoxqIJZRKZqUW/H8GKWsA7B0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, ryan.p.norwood@gmail.com,
        Joe Thornber <ejt@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>
Subject: [PATCH 4.9 29/44] dm thin: fix passdown_double_checking_shared_status()
Date:   Tue, 29 Jan 2019 12:36:24 +0100
Message-Id: <20190129113142.227792123@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190129113139.826927690@linuxfoundation.org>
References: <20190129113139.826927690@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1689,7 +1689,7 @@ int dm_thin_remove_range(struct dm_thin_
 	return r;
 }
 
-int dm_pool_block_is_used(struct dm_pool_metadata *pmd, dm_block_t b, bool *result)
+int dm_pool_block_is_shared(struct dm_pool_metadata *pmd, dm_block_t b, bool *result)
 {
 	int r;
 	uint32_t ref_count;
@@ -1697,7 +1697,7 @@ int dm_pool_block_is_used(struct dm_pool
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
@@ -1017,7 +1017,7 @@ static void passdown_double_checking_sha
 	 * passdown we have to check that these blocks are now unused.
 	 */
 	int r = 0;
-	bool used = true;
+	bool shared = true;
 	struct thin_c *tc = m->tc;
 	struct pool *pool = tc->pool;
 	dm_block_t b = m->data_block, e, end = m->data_block + m->virt_end - m->virt_begin;
@@ -1027,11 +1027,11 @@ static void passdown_double_checking_sha
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
 
@@ -1040,11 +1040,11 @@ static void passdown_double_checking_sha
 
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
 


