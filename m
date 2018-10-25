Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0048C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 97C372085A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwt6NUwU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97C372085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbeJYWou (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:44:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:53804 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728299AbeJYWoq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:44:46 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0A822084A;
        Thu, 25 Oct 2018 14:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476710;
        bh=any9d/ZlmM1theEkMiICGcDkwKEKdz3y9VhByluyreI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iwt6NUwUPJ42QDvsEJ8mh3aKuz+cZpBRST8srUm0X//Bqj+R6K7AP3FV1qJZ9v5LZ
         zroT71K4WNGnNpuZfydM82WlPzbs42z9UD0VGeWT28sAGC2ip1zBmb4OtcRRQaQ568
         YMEjtfjVQ5YUeHxTPucMI8HmTgaJUGBeFnQZg9hY=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 40/46] btrfs: quota: Set rescan progress to (u64)-1 if we hit last leaf
Date:   Thu, 25 Oct 2018 10:10:47 -0400
Message-Id: <20181025141053.213330-40-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141053.213330-1-sashal@kernel.org>
References: <20181025141053.213330-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 6f7de19ed3d4d3526ca5eca428009f97cf969c2f ]

Commit ff3d27a048d9 ("btrfs: qgroup: Finish rescan when hit the last leaf
of extent tree") added a new exit for rescan finish.

However after finishing quota rescan, we set
fs_info->qgroup_rescan_progress to (u64)-1 before we exit through the
original exit path.
While we missed that assignment of (u64)-1 in the new exit path.

The end result is, the quota status item doesn't have the same value.
(-1 vs the last bytenr + 1)
Although it doesn't affect quota accounting, it's still better to keep
the original behavior.

Reported-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Fixes: ff3d27a048d9 ("btrfs: qgroup: Finish rescan when hit the last leaf of extent tree")
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/qgroup.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/btrfs/qgroup.c b/fs/btrfs/qgroup.c
index 473ad5985aa3..47dec283628d 100644
--- a/fs/btrfs/qgroup.c
+++ b/fs/btrfs/qgroup.c
@@ -2603,8 +2603,10 @@ qgroup_rescan_leaf(struct btrfs_fs_info *fs_info, struct btrfs_path *path,
 	}
 	btrfs_put_tree_mod_seq(fs_info, &tree_mod_seq_elem);
 
-	if (done && !ret)
+	if (done && !ret) {
 		ret = 1;
+		fs_info->qgroup_rescan_progress.objectid = (u64)-1;
+	}
 	return ret;
 }
 
-- 
2.17.1

