Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A976C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:39:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E850420864
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 08:39:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E850420864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030486AbeFRIio (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 04:38:44 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:37170 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S968228AbeFRIij (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 04:38:39 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 78A9FC49;
        Mon, 18 Jun 2018 08:38:38 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sasha Levin <alexander.levin@microsoft.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.14 186/189] Revert "Btrfs: fix scrub to repair raid6 corruption"
Date:   Mon, 18 Jun 2018 10:14:42 +0200
Message-Id: <20180618081216.693015697@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618081209.254234434@linuxfoundation.org>
References: <20180618081209.254234434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sasha Levin <Alexander.Levin@microsoft.com>

This reverts commit d91bb7c6988bd6450284c762b33f2e1ea3fe7c97.

This commit used an incorrect log message.

Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Reported-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/raid56.c  |   18 ++++--------------
 fs/btrfs/volumes.c |    9 +--------
 2 files changed, 5 insertions(+), 22 deletions(-)

--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2172,21 +2172,11 @@ int raid56_parity_recover(struct btrfs_f
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
@@ -5110,14 +5110,7 @@ int btrfs_num_copies(struct btrfs_fs_inf
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


