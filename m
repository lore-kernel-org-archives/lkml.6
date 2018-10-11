Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C183C677FC
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1874E2087A
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:39:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="QmXUndeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1874E2087A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbeJKXHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:07:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:36926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726721AbeJKXHT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:07:19 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 20791213A2;
        Thu, 11 Oct 2018 15:39:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272375;
        bh=LVCT4B663VPXQAZCTG1nCV3DzIN/zUqdLHm4NMGIvnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QmXUndeMT8Zd4KYCx2pCPHs4PNxlDi15XboKXwDQga1ZAizez5M+/6y+q3auAqNbc
         W/Cv25FOeIbyTTM0/EFyQsxthfNtPPreFt8ngHtTyON/StSur5ODo5+wd433Zjbmp5
         Z+iWSQ584+yD+UDBfs+lo7c1UeqrtcxhcksgAElA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Joe Thornber <ejt@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 3.18 087/120] dm thin metadata: try to avoid ever aborting transactions
Date:   Thu, 11 Oct 2018 17:34:28 +0200
Message-Id: <20181011152553.413513241@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
@@ -191,6 +191,12 @@ struct dm_pool_metadata {
 	bool read_only:1;
 
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
@@ -824,6 +830,22 @@ static int __commit_transaction(struct d
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
@@ -858,6 +880,8 @@ struct dm_pool_metadata *dm_pool_metadat
 		return ERR_PTR(r);
 	}
 
+	__set_metadata_reserve(pmd);
+
 	return pmd;
 }
 
@@ -1625,6 +1649,13 @@ int dm_pool_get_free_metadata_block_coun
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
@@ -1746,8 +1777,11 @@ int dm_pool_resize_metadata_dev(struct d
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
@@ -140,7 +140,13 @@ struct dm_thin_new_mapping;
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
 
@@ -994,7 +1000,35 @@ static void set_pool_mode(struct pool *p
 
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
@@ -1020,14 +1054,16 @@ static int commit(struct pool *pool)
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
@@ -1093,6 +1129,19 @@ static int alloc_data_block(struct thin_
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
 
@@ -1124,6 +1173,7 @@ static int should_error_unserviceable_bi
 	case PM_OUT_OF_DATA_SPACE:
 		return pool->pf.error_if_no_space ? -ENOSPC : 0;
 
+	case PM_OUT_OF_METADATA_SPACE:
 	case PM_READ_ONLY:
 	case PM_FAIL:
 		return -EIO;
@@ -1823,8 +1873,9 @@ static void set_pool_mode(struct pool *p
 		error_retry_list(pool);
 		break;
 
+	case PM_OUT_OF_METADATA_SPACE:
 	case PM_READ_ONLY:
-		if (old_mode != new_mode)
+		if (!is_read_only_pool_mode(old_mode))
 			notify_of_pool_mode_change(pool, "read-only");
 		dm_pool_metadata_read_only(pool->pmd);
 		pool->process_bio = process_bio_read_only;
@@ -2727,6 +2778,10 @@ static int maybe_resize_metadata_dev(str
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
@@ -2974,7 +3029,7 @@ static int pool_message(struct dm_target
 	struct pool_c *pt = ti->private;
 	struct pool *pool = pt->pool;
 
-	if (get_pool_mode(pool) >= PM_READ_ONLY) {
+	if (get_pool_mode(pool) >= PM_OUT_OF_METADATA_SPACE) {
 		DMERR("%s: unable to service pool target messages in READ_ONLY or FAIL mode",
 		      dm_device_name(pool->pool_md));
 		return -EINVAL;
@@ -3047,6 +3102,7 @@ static void pool_status(struct dm_target
 	dm_block_t nr_blocks_data;
 	dm_block_t nr_blocks_metadata;
 	dm_block_t held_root;
+	enum pool_mode mode;
 	char buf[BDEVNAME_SIZE];
 	char buf2[BDEVNAME_SIZE];
 	struct pool_c *pt = ti->private;
@@ -3117,9 +3173,10 @@ static void pool_status(struct dm_target
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


