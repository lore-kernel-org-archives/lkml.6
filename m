Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B51AC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBFE62087D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gPhFPLHS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBFE62087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732524AbeJICFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 22:05:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:55606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727260AbeJICFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 22:05:31 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E1012204FD;
        Mon,  8 Oct 2018 18:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024742;
        bh=XZVJLM9VgX6phpsg/WbZSV1fe2N3x5cpXKx4F0o/V2U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gPhFPLHSXjK4c7MfStsQydEyyesBfCV+gp/vSlsKMJ0cF9c5ou1spWhHzavG48hlt
         P+kMoxWQrIYb6atg6tshVGy2mMChqn9BHLEwn7qTXu9FYzl44i2eNIaulH1g779964
         HuEyP8t1ryTfNR+RPLzJxLdOER+VpPvxEOiJMhog=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Heinz Mauelshagen <heinzm@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.18 115/168] dm raid: fix RAID leg rebuild errors
Date:   Mon,  8 Oct 2018 20:31:35 +0200
Message-Id: <20181008175624.420459700@linuxfoundation.org>
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

[ Upstream commit 36a240a706d43383bbdd377522501ddd2e5771f6 ]

On fast devices such as NVMe, a flaw in rs_get_progress() results in
false target status output when userspace lvm2 requests leg rebuilds
(symptom of the failure is device health chars 'aaaaaaaa' instead of
expected 'aAaAAAAA' causing lvm2 to fail).

The correct sync action state definitions already exist in
decipher_sync_action() so fix rs_get_progress() to use it.

Change decipher_sync_action() to return an enum rather than a string for
the sync states and call it from rs_get_progress().  Introduce
sync_str() to translate from enum to the string that is needed by
raid_status().

Signed-off-by: Heinz Mauelshagen <heinzm@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/md/dm-raid.c |   80 +++++++++++++++++++++++++++++----------------------
 1 file changed, 46 insertions(+), 34 deletions(-)

--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3332,32 +3332,53 @@ static int raid_map(struct dm_target *ti
 	return DM_MAPIO_SUBMITTED;
 }
 
-/* Return string describing the current sync action of @mddev */
-static const char *decipher_sync_action(struct mddev *mddev, unsigned long recovery)
+/* Return sync state string for @state */
+enum sync_state { st_frozen, st_reshape, st_resync, st_check, st_repair, st_recover, st_idle };
+static const char *sync_str(enum sync_state state)
+{
+	/* Has to be in above sync_state order! */
+	static const char *sync_strs[] = {
+		"frozen",
+		"reshape",
+		"resync",
+		"check",
+		"repair",
+		"recover",
+		"idle"
+	};
+
+	return __within_range(state, 0, ARRAY_SIZE(sync_strs) - 1) ? sync_strs[state] : "undef";
+};
+
+/* Return enum sync_state for @mddev derived from @recovery flags */
+static const enum sync_state decipher_sync_action(struct mddev *mddev, unsigned long recovery)
 {
 	if (test_bit(MD_RECOVERY_FROZEN, &recovery))
-		return "frozen";
+		return st_frozen;
 
-	/* The MD sync thread can be done with io but still be running */
+	/* The MD sync thread can be done with io or be interrupted but still be running */
 	if (!test_bit(MD_RECOVERY_DONE, &recovery) &&
 	    (test_bit(MD_RECOVERY_RUNNING, &recovery) ||
 	     (!mddev->ro && test_bit(MD_RECOVERY_NEEDED, &recovery)))) {
 		if (test_bit(MD_RECOVERY_RESHAPE, &recovery))
-			return "reshape";
+			return st_reshape;
 
 		if (test_bit(MD_RECOVERY_SYNC, &recovery)) {
 			if (!test_bit(MD_RECOVERY_REQUESTED, &recovery))
-				return "resync";
-			else if (test_bit(MD_RECOVERY_CHECK, &recovery))
-				return "check";
-			return "repair";
+				return st_resync;
+			if (test_bit(MD_RECOVERY_CHECK, &recovery))
+				return st_check;
+			return st_repair;
 		}
 
 		if (test_bit(MD_RECOVERY_RECOVER, &recovery))
-			return "recover";
+			return st_recover;
+
+		if (mddev->reshape_position != MaxSector)
+			return st_reshape;
 	}
 
-	return "idle";
+	return st_idle;
 }
 
 /*
@@ -3391,6 +3412,7 @@ static sector_t rs_get_progress(struct r
 				sector_t resync_max_sectors)
 {
 	sector_t r;
+	enum sync_state state;
 	struct mddev *mddev = &rs->md;
 
 	clear_bit(RT_FLAG_RS_IN_SYNC, &rs->runtime_flags);
@@ -3401,20 +3423,14 @@ static sector_t rs_get_progress(struct r
 		set_bit(RT_FLAG_RS_IN_SYNC, &rs->runtime_flags);
 
 	} else {
-		if (!test_bit(__CTR_FLAG_NOSYNC, &rs->ctr_flags) &&
-		    !test_bit(MD_RECOVERY_INTR, &recovery) &&
-		    (test_bit(MD_RECOVERY_NEEDED, &recovery) ||
-		     test_bit(MD_RECOVERY_RESHAPE, &recovery) ||
-		     test_bit(MD_RECOVERY_RUNNING, &recovery)))
-			r = mddev->curr_resync_completed;
-		else
+		state = decipher_sync_action(mddev, recovery);
+
+		if (state == st_idle && !test_bit(MD_RECOVERY_INTR, &recovery))
 			r = mddev->recovery_cp;
+		else
+			r = mddev->curr_resync_completed;
 
-		if (r >= resync_max_sectors &&
-		    (!test_bit(MD_RECOVERY_REQUESTED, &recovery) ||
-		     (!test_bit(MD_RECOVERY_FROZEN, &recovery) &&
-		      !test_bit(MD_RECOVERY_NEEDED, &recovery) &&
-		      !test_bit(MD_RECOVERY_RUNNING, &recovery)))) {
+		if (state == st_idle && r >= resync_max_sectors) {
 			/*
 			 * Sync complete.
 			 */
@@ -3422,24 +3438,20 @@ static sector_t rs_get_progress(struct r
 			if (test_bit(MD_RECOVERY_RECOVER, &recovery))
 				set_bit(RT_FLAG_RS_IN_SYNC, &rs->runtime_flags);
 
-		} else if (test_bit(MD_RECOVERY_RECOVER, &recovery)) {
+		} else if (state == st_recover)
 			/*
 			 * In case we are recovering, the array is not in sync
 			 * and health chars should show the recovering legs.
 			 */
 			;
-
-		} else if (test_bit(MD_RECOVERY_SYNC, &recovery) &&
-			   !test_bit(MD_RECOVERY_REQUESTED, &recovery)) {
+		else if (state == st_resync)
 			/*
 			 * If "resync" is occurring, the raid set
 			 * is or may be out of sync hence the health
 			 * characters shall be 'a'.
 			 */
 			set_bit(RT_FLAG_RS_RESYNCING, &rs->runtime_flags);
-
-		} else if (test_bit(MD_RECOVERY_RESHAPE, &recovery) &&
-			   !test_bit(MD_RECOVERY_REQUESTED, &recovery)) {
+		else if (state == st_reshape)
 			/*
 			 * If "reshape" is occurring, the raid set
 			 * is or may be out of sync hence the health
@@ -3447,7 +3459,7 @@ static sector_t rs_get_progress(struct r
 			 */
 			set_bit(RT_FLAG_RS_RESYNCING, &rs->runtime_flags);
 
-		} else if (test_bit(MD_RECOVERY_REQUESTED, &recovery)) {
+		else if (state == st_check || state == st_repair)
 			/*
 			 * If "check" or "repair" is occurring, the raid set has
 			 * undergone an initial sync and the health characters
@@ -3455,12 +3467,12 @@ static sector_t rs_get_progress(struct r
 			 */
 			set_bit(RT_FLAG_RS_IN_SYNC, &rs->runtime_flags);
 
-		} else {
+		else {
 			struct md_rdev *rdev;
 
 			/*
 			 * We are idle and recovery is needed, prevent 'A' chars race
-			 * caused by components still set to in-sync by constrcuctor.
+			 * caused by components still set to in-sync by constructor.
 			 */
 			if (test_bit(MD_RECOVERY_NEEDED, &recovery))
 				set_bit(RT_FLAG_RS_RESYNCING, &rs->runtime_flags);
@@ -3524,7 +3536,7 @@ static void raid_status(struct dm_target
 		progress = rs_get_progress(rs, recovery, resync_max_sectors);
 		resync_mismatches = (mddev->last_sync_action && !strcasecmp(mddev->last_sync_action, "check")) ?
 				    atomic64_read(&mddev->resync_mismatches) : 0;
-		sync_action = decipher_sync_action(&rs->md, recovery);
+		sync_action = sync_str(decipher_sync_action(&rs->md, recovery));
 
 		/* HM FIXME: do we want another state char for raid0? It shows 'D'/'A'/'-' now */
 		for (i = 0; i < rs->raid_disks; i++)


