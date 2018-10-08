Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38FE4C65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB7C2087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:50:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xao6VgZp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFB7C2087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732188AbeJICDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:03:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:53508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729987AbeJICDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:03:54 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 219E6214C5;
        Mon,  8 Oct 2018 18:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024646;
        bh=dlWjQA1R4GC5HmTnsSrqcR16un9M789p0ddl7Y3cMbA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xao6VgZpWuOtcL/pKuM58EXUloZj+Y+LCD02vMBGyBYW+czRkIbjvPrFpYVEtt6MU
         YzV8IFe3SBS0L/wh4RGuWq6PnJBCrG1Wv122QGlXvDn1f50gr8NlECKnykF5bfJ0V+
         rLAUqdigYTvs6sg/TMy7e4N6YcDJitz5WDAEwpK0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 107/168] dm raid: fix reshape race on small devices
Date:   Mon,  8 Oct 2018 20:31:27 +0200
Message-Id: <20181008175624.118391622@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175620.043587728@linuxfoundation.org>
References: <20181008175620.043587728@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heinz Mauelshagen <heinzm@redhat.com>

[ Upstream commit 38b0bd0cda07d34ad6f145fce675ead74739c44e ]

Loading a new mapping table, the dm-raid target's constructor
retrieves the volatile reshaping state from the raid superblocks.

When the new table is activated in a following resume, the actual
reshape position is retrieved.  The reshape driven by the previous
mapping can already have finished on small and/or fast devices thus
updating raid superblocks about the new raid layout.

This causes the actual array state (e.g. stripe size reshape finished)
to be inconsistent with the one in the new mapping, causing hangs with
left behind devices.

This race does not occur with usual raid device sizes but with small
ones (e.g. those created by the lvm2 test suite).

Fix by no longer transferring stale/inconsistent raid_set state during
preresume.

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-raid.c |   48 +-----------------------------------------------
 1 file changed, 1 insertion(+), 47 deletions(-)

--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -29,9 +29,6 @@
  */
 #define	MIN_RAID456_JOURNAL_SPACE (4*2048)
 
-/* Global list of all raid sets */
-static LIST_HEAD(raid_sets);
-
 static bool devices_handle_discard_safely = false;
 
 /*
@@ -227,7 +224,6 @@ struct rs_layout {
 
 struct raid_set {
 	struct dm_target *ti;
-	struct list_head list;
 
 	uint32_t stripe_cache_entries;
 	unsigned long ctr_flags;
@@ -273,19 +269,6 @@ static void rs_config_restore(struct rai
 	mddev->new_chunk_sectors = l->new_chunk_sectors;
 }
 
-/* Find any raid_set in active slot for @rs on global list */
-static struct raid_set *rs_find_active(struct raid_set *rs)
-{
-	struct raid_set *r;
-	struct mapped_device *md = dm_table_get_md(rs->ti->table);
-
-	list_for_each_entry(r, &raid_sets, list)
-		if (r != rs && dm_table_get_md(r->ti->table) == md)
-			return r;
-
-	return NULL;
-}
-
 /* raid10 algorithms (i.e. formats) */
 #define	ALGORITHM_RAID10_DEFAULT	0
 #define	ALGORITHM_RAID10_NEAR		1
@@ -764,7 +747,6 @@ static struct raid_set *raid_set_alloc(s
 
 	mddev_init(&rs->md);
 
-	INIT_LIST_HEAD(&rs->list);
 	rs->raid_disks = raid_devs;
 	rs->delta_disks = 0;
 
@@ -782,9 +764,6 @@ static struct raid_set *raid_set_alloc(s
 	for (i = 0; i < raid_devs; i++)
 		md_rdev_init(&rs->dev[i].rdev);
 
-	/* Add @rs to global list. */
-	list_add(&rs->list, &raid_sets);
-
 	/*
 	 * Remaining items to be initialized by further RAID params:
 	 *  rs->md.persistent
@@ -797,7 +776,7 @@ static struct raid_set *raid_set_alloc(s
 	return rs;
 }
 
-/* Free all @rs allocations and remove it from global list. */
+/* Free all @rs allocations */
 static void raid_set_free(struct raid_set *rs)
 {
 	int i;
@@ -815,8 +794,6 @@ static void raid_set_free(struct raid_se
 			dm_put_device(rs->ti, rs->dev[i].data_dev);
 	}
 
-	list_del(&rs->list);
-
 	kfree(rs);
 }
 
@@ -3947,29 +3924,6 @@ static int raid_preresume(struct dm_targ
 	if (test_and_set_bit(RT_FLAG_RS_PRERESUMED, &rs->runtime_flags))
 		return 0;
 
-	if (!test_bit(__CTR_FLAG_REBUILD, &rs->ctr_flags)) {
-		struct raid_set *rs_active = rs_find_active(rs);
-
-		if (rs_active) {
-			/*
-			 * In case no rebuilds have been requested
-			 * and an active table slot exists, copy
-			 * current resynchonization completed and
-			 * reshape position pointers across from
-			 * suspended raid set in the active slot.
-			 *
-			 * This resumes the new mapping at current
-			 * offsets to continue recover/reshape without
-			 * necessarily redoing a raid set partially or
-			 * causing data corruption in case of a reshape.
-			 */
-			if (rs_active->md.curr_resync_completed != MaxSector)
-				mddev->curr_resync_completed = rs_active->md.curr_resync_completed;
-			if (rs_active->md.reshape_position != MaxSector)
-				mddev->reshape_position = rs_active->md.reshape_position;
-		}
-	}
-
 	/*
 	 * The superblocks need to be updated on disk if the
 	 * array is new or new devices got added (thus zeroed


