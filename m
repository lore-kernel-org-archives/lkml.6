Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABB8C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F4D920883
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:15:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uTb/lnwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F4D920883
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728946AbeJYWsW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:48:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:56978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728919AbeJYWsV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:48:21 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 644D720869;
        Thu, 25 Oct 2018 14:15:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476925;
        bh=qb+k2B17M/VyiZNG6zG0rKK5nS8iq4aeY9XLtwMul3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uTb/lnwdc/BdqzLz4rJZfFWUDLhqeUeB7x+QGLJRLlI99L5G2UzsrwrwLESK/3Ymi
         MITeTzxN01VgYzsnQ5u9DYTYx1WUhfzLgOEsuSKpZ+XW2J7Gwvhy0Jw1ye4ZVLd8/G
         6UaJbQoxPl1Etm3SNp1hoe86lUpO6lztye0mN17o=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Liu Bo <bo.li.liu@oracle.com>, David Sterba <dsterba@suse.com>,
        Chris Mason <clm@fb.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 41/98] Btrfs: clear EXTENT_DEFRAG bits in finish_ordered_io
Date:   Thu, 25 Oct 2018 10:13:26 -0400
Message-Id: <20181025141423.213774-41-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Liu Bo <bo.li.liu@oracle.com>

[ Upstream commit 452e62b71fbbefe2646fad3a968371a026936c6d ]

Before this, we use 'filled' mode here, ie. if all range has been
filled with EXTENT_DEFRAG bits, get to clear it, but if the defrag
range joins the adjacent delalloc range, then we'll have EXTENT_DEFRAG
bits in extent_state until releasing this inode's pages, and that
prevents extent_data from being freed.

This clears the bit if any was found within the ordered extent.

Signed-off-by: Liu Bo <bo.li.liu@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Chris Mason <clm@fb.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index bd036557c6bc..5ebdb58079e1 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -2966,7 +2966,7 @@ static int btrfs_finish_ordered_io(struct btrfs_ordered_extent *ordered_extent)
 
 	ret = test_range_bit(io_tree, ordered_extent->file_offset,
 			ordered_extent->file_offset + ordered_extent->len - 1,
-			EXTENT_DEFRAG, 1, cached_state);
+			EXTENT_DEFRAG, 0, cached_state);
 	if (ret) {
 		u64 last_snapshot = btrfs_root_last_snapshot(&root->root_item);
 		if (0 && last_snapshot >= BTRFS_I(inode)->generation)
-- 
2.17.1

