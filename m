Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDFFEECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9A65720844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="uMwebZKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A65720844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731591AbeKIHmk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:34564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731566AbeKIHmj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:39 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7955F2086C;
        Thu,  8 Nov 2018 22:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714709;
        bh=uhn4Xilw7yywFC/T+cEWl+3Rx3A0RG7E1dAHJJvyJQM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uMwebZKNphkqcNPedZ+rtyHfD6MsnMKkHPehvSINQOID2v+Uz8xlnFjK/feCVXixe
         eLcaHJ4cZ4yt2ryJBCf+UUsqJPR4j/smupYVX5ZaN7FiouZwNLIOPSxjSPaL149h5Q
         krCMwmxPaFf8O87/P5Fhm2oBej4VDQCgIRFORMPY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Liu Bo <bo.li.liu@oracle.com>,
        David Sterba <dsterba@suse.com>, Chris Mason <clm@fb.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 071/171] Btrfs: clear EXTENT_DEFRAG bits in finish_ordered_io
Date:   Thu,  8 Nov 2018 13:50:41 -0800
Message-Id: <20181108215132.711131422@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



