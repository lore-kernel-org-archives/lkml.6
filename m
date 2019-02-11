Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE042C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:01:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78C2D218D8
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 16:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549900897;
	bh=KhA8XNN+0BZPSKKdkvs3lalVmwa4Yw8yhba1jyNHsAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=r99suO91/viXM4Ljnis68Yd2ela4pDMk+Re1gIFN5I/KBGUzNLhdNErodPNyaZhq+
	 Fjkbw2GAM5X/3dpIwzXl7iDrzbt2RFR9hisgPXu6iH3WsIWY319SJNQxZrlNe3I5UB
	 I782fU3LDnbdqyo4PdvD6v1HajrtsHjDpzWQUYzU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfBKQBf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 11:01:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:37674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730225AbfBKObB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:31:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B080820675;
        Mon, 11 Feb 2019 14:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895461;
        bh=KhA8XNN+0BZPSKKdkvs3lalVmwa4Yw8yhba1jyNHsAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OAIAfuiRgS+TH31sd5svIRdeXvg4LTKS02+xWVouNrnL/Hqe4XQefdPve9Je//HZf
         LBHsiLd131SfBYs/D8y2uGVrNzYq6jADgPRKDTmQTKGFCSHUF1/cD10SPBnOIA8tn2
         PCZMTVtY5L1UsGTtjqoPKvC9rtGinkxDPCSt5DlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 181/352] btrfs: reada: reorder dev-replace locks before radix tree preload
Date:   Mon, 11 Feb 2019 15:16:48 +0100
Message-Id: <20190211141858.608391723@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit ceb21a8db48559fd0809e03c4df9eb37743d9170 ]

The device-replace read lock is going to use rw semaphore in followup
commits. The semaphore might sleep which is not possible in the radix
tree preload section. The lock nesting is now:

* device replace
  * radix tree preload
    * readahead spinlock

Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/reada.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/btrfs/reada.c b/fs/btrfs/reada.c
index dec14b739b10..6f81f3e88b6d 100644
--- a/fs/btrfs/reada.c
+++ b/fs/btrfs/reada.c
@@ -376,26 +376,28 @@ static struct reada_extent *reada_find_extent(struct btrfs_fs_info *fs_info,
 		goto error;
 	}
 
+	/* Insert extent in reada tree + all per-device trees, all or nothing */
+	btrfs_dev_replace_read_lock(&fs_info->dev_replace);
 	ret = radix_tree_preload(GFP_KERNEL);
-	if (ret)
+	if (ret) {
+		btrfs_dev_replace_read_unlock(&fs_info->dev_replace);
 		goto error;
+	}
 
-	/* insert extent in reada_tree + all per-device trees, all or nothing */
-	btrfs_dev_replace_read_lock(&fs_info->dev_replace);
 	spin_lock(&fs_info->reada_lock);
 	ret = radix_tree_insert(&fs_info->reada_tree, index, re);
 	if (ret == -EEXIST) {
 		re_exist = radix_tree_lookup(&fs_info->reada_tree, index);
 		re_exist->refcnt++;
 		spin_unlock(&fs_info->reada_lock);
-		btrfs_dev_replace_read_unlock(&fs_info->dev_replace);
 		radix_tree_preload_end();
+		btrfs_dev_replace_read_unlock(&fs_info->dev_replace);
 		goto error;
 	}
 	if (ret) {
 		spin_unlock(&fs_info->reada_lock);
-		btrfs_dev_replace_read_unlock(&fs_info->dev_replace);
 		radix_tree_preload_end();
+		btrfs_dev_replace_read_unlock(&fs_info->dev_replace);
 		goto error;
 	}
 	radix_tree_preload_end();
-- 
2.19.1



