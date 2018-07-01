Return-Path: <SRS0=zLEl=JR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A639C6778C
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEC3D250AD
	for <linux-kernel@archiver.kernel.org>; Sun,  1 Jul 2018 16:16:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEC3D250AD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933596AbeGAQQo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 1 Jul 2018 12:16:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60818 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932692AbeGAQQh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jul 2018 12:16:37 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 151A4ACD;
        Sun,  1 Jul 2018 16:16:36 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 007/105] Revert "Btrfs: fix scrub to repair raid6 corruption"
Date:   Sun,  1 Jul 2018 18:01:17 +0200
Message-Id: <20180701153150.036177743@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701153149.382300170@linuxfoundation.org>
References: <20180701153149.382300170@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sasha Levin <Alexander.Levin@microsoft.com>

This reverts commit 95b286daf7ba784191023ad110122703eb2ebabc.

This commit used an incorrect log message.

Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/raid56.c  |   18 ++++--------------
 fs/btrfs/volumes.c |    9 +--------
 2 files changed, 5 insertions(+), 22 deletions(-)

--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2160,21 +2160,11 @@ int raid56_parity_recover(struct btrfs_r
 	}
 
 	/*
-	 * Loop retry:
-	 * for 'mirror == 2', reconstruct from all other stripes.
-	 * for 'mirror_num > 2', select a stripe to fail on every retry.
+	 * reconstruct from the q stripe if they are
+	 * asking for mirror 3
 	 */
-	if (mirror_num > 2) {
-		/*
-		 * 'mirror == 3' is to fail the p stripe and
-		 * reconstruct from the q stripe.  'mirror > 3' is to
-		 * fail a data stripe and reconstruct from p+q stripe.
-		 */
-		rbio->failb = rbio->real_stripes - (mirror_num - 1);
-		ASSERT(rbio->failb > 0);
-		if (rbio->failb <= rbio->faila)
-			rbio->failb--;
-	}
+	if (mirror_num == 3)
+		rbio->failb = rbio->real_stripes - 2;
 
 	ret = lock_stripe_add(rbio);
 
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5056,14 +5056,7 @@ int btrfs_num_copies(struct btrfs_fs_inf
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)
 		ret = 2;
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
-		/*
-		 * There could be two corrupted data stripes, we need
-		 * to loop retry in order to rebuild the correct data.
-		 *
-		 * Fail a stripe at a time on every retry except the
-		 * stripe under reconstruction.
-		 */
-		ret = map->num_stripes;
+		ret = 3;
 	else
 		ret = 1;
 	free_extent_map(em);


