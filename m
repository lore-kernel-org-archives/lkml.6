Return-Path: <SRS0=RZO6=PX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB377C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 889C120859
	for <linux-kernel@archiver.kernel.org>; Tue, 15 Jan 2019 16:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547570230;
	bh=qTudNXb/T7dxqFrFTur+ikwV6ooNIsPHEzKdInnSJzI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=F8UXvx2N/iWZk6BtRgqajjerAWPiLoX/3dZd+mgl7AEsFOcnKAGlTlpUNcg/c0mwL
	 WGHgPaw3rcG/lQ/PGd/j0ZvWUWX5zjgfvNRw53pjyR6fP3T0f88HGUJ7Pwfj+0r2Uv
	 JKYDSY7FIAguNILB6U8xygXlRVkvPtykec2y4g0g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbfAOQhJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 11:37:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:52462 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731728AbfAOQhH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 11:37:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FBA820873;
        Tue, 15 Jan 2019 16:37:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547570226;
        bh=qTudNXb/T7dxqFrFTur+ikwV6ooNIsPHEzKdInnSJzI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Prws2DxVb7CLbB5CoJhn5gnoYwM8FSGf3zCHwmRLNx3TN89R7h/H3rg8qZuV2ug3w
         rTTCFGf+QWjuSqJ71RcFAgJW9EOb4JKZUJ03Aj9UE/LSRd1Vb7pTceVRvcx9PKpUDs
         2L097NWdNTeaTxZbaq4IdpoL5ngEe33DTJxxyaBo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Vegard Nossum <vegard.nossum@oracle.com>,
        Qu Wenruo <quwenruo@cn.fujitsu.com>, Chris Mason <clm@fb.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.4 03/51] btrfs: Enhance chunk validation check
Date:   Tue, 15 Jan 2019 17:34:59 +0100
Message-Id: <20190115154847.411592180@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190115154846.928796000@linuxfoundation.org>
References: <20190115154846.928796000@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qu Wenruo <quwenruo@cn.fujitsu.com>

commit f04b772bfc17f502703794f4d100d12155c1a1a9 upstream.

Enhance chunk validation:
1) Num_stripes
   We already have such check but it's only in super block sys chunk
   array.
   Now check all on-disk chunks.

2) Chunk logical
   It should be aligned to sector size.
   This behavior should be *DOUBLE CHECKED* for 64K sector size like
   PPC64 or AArch64.
   Maybe we can found some hidden bugs.

3) Chunk length
   Same as chunk logical, should be aligned to sector size.

4) Stripe length
   It should be power of 2.

5) Chunk type
   Any bit out of TYPE_MAS | PROFILE_MASK is invalid.

With all these much restrict rules, several fuzzed image reported in
mail list should no longer cause kernel panic.

Reported-by: Vegard Nossum <vegard.nossum@oracle.com>
Signed-off-by: Qu Wenruo <quwenruo@cn.fujitsu.com>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |   33 ++++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6217,6 +6217,7 @@ static int read_one_chunk(struct btrfs_r
 	struct extent_map *em;
 	u64 logical;
 	u64 length;
+	u64 stripe_len;
 	u64 devid;
 	u8 uuid[BTRFS_UUID_SIZE];
 	int num_stripes;
@@ -6225,6 +6226,37 @@ static int read_one_chunk(struct btrfs_r
 
 	logical = key->offset;
 	length = btrfs_chunk_length(leaf, chunk);
+	stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
+	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
+	/* Validation check */
+	if (!num_stripes) {
+		btrfs_err(root->fs_info, "invalid chunk num_stripes: %u",
+			  num_stripes);
+		return -EIO;
+	}
+	if (!IS_ALIGNED(logical, root->sectorsize)) {
+		btrfs_err(root->fs_info,
+			  "invalid chunk logical %llu", logical);
+		return -EIO;
+	}
+	if (!length || !IS_ALIGNED(length, root->sectorsize)) {
+		btrfs_err(root->fs_info,
+			"invalid chunk length %llu", length);
+		return -EIO;
+	}
+	if (!is_power_of_2(stripe_len)) {
+		btrfs_err(root->fs_info, "invalid chunk stripe length: %llu",
+			  stripe_len);
+		return -EIO;
+	}
+	if (~(BTRFS_BLOCK_GROUP_TYPE_MASK | BTRFS_BLOCK_GROUP_PROFILE_MASK) &
+	    btrfs_chunk_type(leaf, chunk)) {
+		btrfs_err(root->fs_info, "unrecognized chunk type: %llu",
+			  ~(BTRFS_BLOCK_GROUP_TYPE_MASK |
+			    BTRFS_BLOCK_GROUP_PROFILE_MASK) &
+			  btrfs_chunk_type(leaf, chunk));
+		return -EIO;
+	}
 
 	read_lock(&map_tree->map_tree.lock);
 	em = lookup_extent_mapping(&map_tree->map_tree, logical, 1);
@@ -6241,7 +6273,6 @@ static int read_one_chunk(struct btrfs_r
 	em = alloc_extent_map();
 	if (!em)
 		return -ENOMEM;
-	num_stripes = btrfs_chunk_num_stripes(leaf, chunk);
 	map = kmalloc(map_lookup_size(num_stripes), GFP_NOFS);
 	if (!map) {
 		free_extent_map(em);


