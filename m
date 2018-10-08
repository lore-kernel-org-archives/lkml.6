Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D02FFC677D4
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:38:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD4C2089D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:38:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbtAiGz9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD4C2089D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729141AbeJIBvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:51:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:38064 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726427AbeJIBvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:51:18 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3C3C2064A;
        Mon,  8 Oct 2018 18:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539023894;
        bh=UEzYKWhh2/zoBJBpV0ybiNYzgVt8AAx/RtUZItprqAk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IbtAiGz9T78oLd960t9lNf1il3YlATMNL/65EUg3BIBT+jo88W90Wxm1Yc5O6hM5f
         Lmix2nedC6LOl5KhIlqq6TtuTv5EUhaj0t+oYVKKchnlNYa1IfT7Ox0GV0lhMXEEAG
         2n7Yf1z+cHWvNkASnCC0XrNz3ie+QTV1AwuDB+sk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 099/113] dm thin metadata: try to avoid ever aborting transactions
Date:   Mon,  8 Oct 2018 20:31:40 +0200
Message-Id: <20181008175536.690730890@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175530.864641368@linuxfoundation.org>
References: <20181008175530.864641368@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joe Thornber <ejt@redhat.com>

[ Upstream commit 3ab91828166895600efd9cdc3a0eb32001f7204a ]

Committing a transaction can consume some metadata of it's own, we now
reserve a small amount of metadata to cover this.  Free metadata
reported by the kernel will not include this reserve.

If any of the reserve has been used after a commit we enter a new
internal state PM_OUT_OF_METADATA_SPACE.  This is reported as
PM_READ_ONLY, so no userland changes are needed.  If the metadata
device is resized the pool will move back to PM_WRITE.

These changes mean we never need to abort and rollback a transaction due
to running out of metadata space.  This is particularly important
because there have been a handful of reports of data corruption against
DM thin-provisioning that can all be attributed to the thin-pool having
ran out of metadata space.

Signed-off-by: Joe Thornber <ejt@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-thin-metadata.c |   36 ++++++++++++++++++++
 drivers/md/dm-thin.c          |   73 +++++++++++++++++++++++++++++++++++++-----
 2 files changed, 100 insertions(+), 9 deletions(-)

--- a/drivers/md/dm-thin-metadata.c
+++ b/drivers/md/dm-thin-metadata.c
@@ -190,6 +190,12 @@ struct dm_pool_metadata {
 	sector_t data_block_size;
 
 	/*
+	 * We reserve a section of the metadata for commit overhead.
+	 * All reported space does *not* include this.
+	 */
+	dm_block_t metadata_reserve;
+
+	/*
 	 * Set if a transaction has to be aborted but the attempt to roll back
 	 * to the previous (good) transaction failed.  The only pool metadata
 	 * operation possible in this state is the closing of the device.
@@ -827,6 +833,22 @@ static int __commit_transaction(struct d
 	return dm_tm_commit(pmd->tm, sblock);
 }
 
+static void __set_metadata_reserve(struct dm_pool_metadata *pmd)
+{
+	int r;
+	dm_block_t total;
+	dm_block_t max_blocks = 4096; /* 16M */
+
+	r = dm_sm_get_nr_blocks(pmd->metadata_sm, &total);
+	if (r) {
+		DMERR("could not get size of metadata device");
+		pmd->metadata_reserve = max_blocks;
+	} else {
+		sector_div(total, 10);
+		pmd->metadata_reserve = min(max_blocks, total);
+	}
+}
+
 struct dm_pool_metadata *dm_pool_metadata_open(struct block_device *bdev,
 					       sector_t data_block_size,
 					       bool format_device)
@@ -860,6 +882,8 @@ struct dm_pool_metadata *dm_pool_metadat
 		return ERR_PTR(r);
 	}
 
+	__set_metadata_reserve(pmd);
+
 	return pmd;
 }
 
@@ -1763,6 +1787,13 @@ int dm_pool_get_free_metadata_block_coun
 	down_read(&pmd->root_lock);
 	if (!pmd->fail_io)
 		r = dm_sm_get_nr_free(pmd->metadata_sm, result);
+
+	if (!r) {
+		if (*result < pmd->metadata_reserve)
+			*result = 0;
+		else
+			*result -= pmd->metadata_reserve;
+	}
 	up_read(&pmd->root_lock);
 
 	return r;
@@ -1875,8 +1906,11 @@ int dm_pool_resize_metadata_dev(struct d
 	int r = -EINVAL;
 
 	down_write(&pmd->root_lock);
-	if (!pmd->fail_io)
+	if (!pmd->fail_io) {
 		r = __resize_space_map(pmd->metadata_sm, new_count);
+		if (!r)
+			__set_metadata_reserve(pmd);
+	}
 	up_write(&pmd->root_lock);
 
 	return r;
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -200,7 +200,13 @@ struct dm_thin_new_mapping;
 enum pool_mode {
 	PM_WRITE,		/* metadata may be changed */
 	PM_OUT_OF_DATA_SPACE,	/* metadata may be changed, though data may not be allocated */
+
+	/*
+	 * Like READ_ONLY, except may switch back to WRITE on metadata resize. Reported as READ_ONLY.
+	 */
+	PM_OUT_OF_METADATA_SPACE,
 	PM_READ_ONLY,		/* metadata may not be changed */
+
 	PM_FAIL,		/* all I/O fails */
 };
 
@@ -1301,7 +1307,35 @@ static void set_pool_mode(struct pool *p
 
 static void requeue_bios(struct pool *pool);
 
-static void check_for_space(struct pool *pool)
+static bool is_read_only_pool_mode(enum pool_mode mode)
+{
+	return (mode == PM_OUT_OF_METADATA_SPACE || mode == PM_READ_ONLY);
+}
+
+static bool is_read_only(struct pool *pool)
+{
+	return is_read_only_pool_mode(get_pool_mode(pool));
+}
+
+static void check_for_metadata_space(struct pool *pool)
+{
+	int r;
+	const char *ooms_reason = NULL;
+	dm_block_t nr_free;
+
+	r = dm_pool_get_free_metadata_block_count(pool->pmd, &nr_free);
+	if (r)
+		ooms_reason = "Could not get free metadata blocks";
+	else if (!nr_free)
+		ooms_reason = "No free metadata blocks";
+
+	if (ooms_reason && !is_read_only(pool)) {
+		DMERR("%s", ooms_reason);
+		set_pool_mode(pool, PM_OUT_OF_METADATA_SPACE);
+	}
+}
+
+static void check_for_data_space(struct pool *pool)
 {
 	int r;
 	dm_block_t nr_free;
@@ -1327,14 +1361,16 @@ static int commit(struct pool *pool)
 {
 	int r;
 
-	if (get_pool_mode(pool) >= PM_READ_ONLY)
+	if (get_pool_mode(pool) >= PM_OUT_OF_METADATA_SPACE)
 		return -EINVAL;
 
 	r = dm_pool_commit_metadata(pool->pmd);
 	if (r)
 		metadata_operation_failed(pool, "dm_pool_commit_metadata", r);
-	else
-		check_for_space(pool);
+	else {
+		check_for_metadata_space(pool);
+		check_for_data_space(pool);
+	}
 
 	return r;
 }
@@ -1400,6 +1436,19 @@ static int alloc_data_block(struct thin_
 		return r;
 	}
 
+	r = dm_pool_get_free_metadata_block_count(pool->pmd, &free_blocks);
+	if (r) {
+		metadata_operation_failed(pool, "dm_pool_get_free_metadata_block_count", r);
+		return r;
+	}
+
+	if (!free_blocks) {
+		/* Let's commit before we use up the metadata reserve. */
+		r = commit(pool);
+		if (r)
+			return r;
+	}
+
 	return 0;
 }
 
@@ -1431,6 +1480,7 @@ static int should_error_unserviceable_bi
 	case PM_OUT_OF_DATA_SPACE:
 		return pool->pf.error_if_no_space ? -ENOSPC : 0;
 
+	case PM_OUT_OF_METADATA_SPACE:
 	case PM_READ_ONLY:
 	case PM_FAIL:
 		return -EIO;
@@ -2401,8 +2451,9 @@ static void set_pool_mode(struct pool *p
 		error_retry_list(pool);
 		break;
 
+	case PM_OUT_OF_METADATA_SPACE:
 	case PM_READ_ONLY:
-		if (old_mode != new_mode)
+		if (!is_read_only_pool_mode(old_mode))
 			notify_of_pool_mode_change(pool, "read-only");
 		dm_pool_metadata_read_only(pool->pmd);
 		pool->process_bio = process_bio_read_only;
@@ -3333,6 +3384,10 @@ static int maybe_resize_metadata_dev(str
 		DMINFO("%s: growing the metadata device from %llu to %llu blocks",
 		       dm_device_name(pool->pool_md),
 		       sb_metadata_dev_size, metadata_dev_size);
+
+		if (get_pool_mode(pool) == PM_OUT_OF_METADATA_SPACE)
+			set_pool_mode(pool, PM_WRITE);
+
 		r = dm_pool_resize_metadata_dev(pool->pmd, metadata_dev_size);
 		if (r) {
 			metadata_operation_failed(pool, "dm_pool_resize_metadata_dev", r);
@@ -3636,7 +3691,7 @@ static int pool_message(struct dm_target
 	struct pool_c *pt = ti->private;
 	struct pool *pool = pt->pool;
 
-	if (get_pool_mode(pool) >= PM_READ_ONLY) {
+	if (get_pool_mode(pool) >= PM_OUT_OF_METADATA_SPACE) {
 		DMERR("%s: unable to service pool target messages in READ_ONLY or FAIL mode",
 		      dm_device_name(pool->pool_md));
 		return -EOPNOTSUPP;
@@ -3710,6 +3765,7 @@ static void pool_status(struct dm_target
 	dm_block_t nr_blocks_data;
 	dm_block_t nr_blocks_metadata;
 	dm_block_t held_root;
+	enum pool_mode mode;
 	char buf[BDEVNAME_SIZE];
 	char buf2[BDEVNAME_SIZE];
 	struct pool_c *pt = ti->private;
@@ -3780,9 +3836,10 @@ static void pool_status(struct dm_target
 		else
 			DMEMIT("- ");
 
-		if (pool->pf.mode == PM_OUT_OF_DATA_SPACE)
+		mode = get_pool_mode(pool);
+		if (mode == PM_OUT_OF_DATA_SPACE)
 			DMEMIT("out_of_data_space ");
-		else if (pool->pf.mode == PM_READ_ONLY)
+		else if (is_read_only_pool_mode(mode))
 			DMEMIT("ro ");
 		else
 			DMEMIT("rw ");


