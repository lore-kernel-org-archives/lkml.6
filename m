Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84637C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:49:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4970D250DC
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:49:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4970D250DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934080AbeFXPti (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:49:38 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:33334 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932073AbeFXPtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:49:36 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EE27C2C;
        Sun, 24 Jun 2018 15:49:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 13/39] Btrfs: make raid6 rebuild retry more
Date:   Sun, 24 Jun 2018 23:24:00 +0800
Message-Id: <20180624152353.535229696@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624152352.038950449@linuxfoundation.org>
References: <20180624152352.038950449@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Liu Bo <bo.li.liu@oracle.com>

[ Upstream commit 8810f7517a3bc4ca2d41d022446d3f5fd6b77c09 ]

There is a scenario that can end up with rebuild process failing to
return good content, i.e.
suppose that all disks can be read without problems and if the content
that was read out doesn't match its checksum, currently for raid6
btrfs at most retries twice,

- the 1st retry is to rebuild with all other stripes, it'll eventually
  be a raid5 xor rebuild,
- if the 1st fails, the 2nd retry will deliberately fail parity p so
  that it will do raid6 style rebuild,

however, the chances are that another non-parity stripe content also
has something corrupted, so that the above retries are not able to
return correct content, and users will think of this as data loss.
More seriouly, if the loss happens on some important internal btree
roots, it could refuse to mount.

This extends btrfs to do more retries and each retry fails only one
stripe.  Since raid6 can tolerate 2 disk failures, if there is one
more failure besides the failure on which we're recovering, this can
always work.

The worst case is to retry as many times as the number of raid6 disks,
but given the fact that such a scenario is really rare in practice,
it's still acceptable.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/raid56.c  |   18 ++++++++++++++----
 fs/btrfs/volumes.c |    9 ++++++++-
 2 files changed, 22 insertions(+), 5 deletions(-)

--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@ -2161,11 +2161,21 @@ int raid56_parity_recover(struct btrfs_r
 	}
 
 	/*
-	 * reconstruct from the q stripe if they are
-	 * asking for mirror 3
+	 * Loop retry:
+	 * for 'mirror == 2', reconstruct from all other stripes.
+	 * for 'mirror_num > 2', select a stripe to fail on every retry.
 	 */
-	if (mirror_num == 3)
-		rbio->failb = rbio->real_stripes - 2;
+	if (mirror_num > 2) {
+		/*
+		 * 'mirror == 3' is to fail the p stripe and
+		 * reconstruct from the q stripe.  'mirror > 3' is to
+		 * fail a data stripe and reconstruct from p+q stripe.
+		 */
+		rbio->failb = rbio->real_stripes - (mirror_num - 1);
+		ASSERT(rbio->failb > 0);
+		if (rbio->failb <= rbio->faila)
+			rbio->failb--;
+	}
 
 	ret = lock_stripe_add(rbio);
 
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -5186,7 +5186,14 @@ int btrfs_num_copies(struct btrfs_fs_inf
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID5)
 		ret = 2;
 	else if (map->type & BTRFS_BLOCK_GROUP_RAID6)
-		ret = 3;
+		/*
+		 * There could be two corrupted data stripes, we need
+		 * to loop retry in order to rebuild the correct data.
+		 *
+		 * Fail a stripe at a time on every retry except the
+		 * stripe under reconstruction.
+		 */
+		ret = map->num_stripes;
 	else
 		ret = 1;
 	free_extent_map(em);


