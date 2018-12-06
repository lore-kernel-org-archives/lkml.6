Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C70C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 25CBE20892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 14:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544107896;
	bh=AGHBTYNwGgwvORoPEv//wXLkzW2kOhHYlEwmWiCBSsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=S//qwyxi1gxOHHzGJOkQt/WzPg1RVkBeRLC4yQVhjvwcXsx0aC/XfS7BykM0fHggt
	 DYFOiXSfy20jL0ZL6sM9SkhHwOzKKCVLDXg6HlxOfAm+wVtSyZu0mG1IomzLq5Khec
	 QcGxD2Q2/KmteqLXTQNPHJnLVjiyvVfmFtmd0II8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25CBE20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731301AbeLFOqn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 09:46:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:51396 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731275AbeLFOqi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 09:46:38 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0B4C02146D;
        Thu,  6 Dec 2018 14:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544107597;
        bh=AGHBTYNwGgwvORoPEv//wXLkzW2kOhHYlEwmWiCBSsk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eXwoTnwPUFI6tVaVoHVyGEiu3mpqGrbsyELutz9HWFLxKbnPHuNnbgMCAYUDaHY6P
         oq+dcC7CXgsRM3Y8x3MvO+3yapijLyorURAyLEFR2wPXUCYHqk/4W9+8NTW+MGi1AN
         sMT67o8EuzKLL6kw8DGv5Q4F4mpGFppZEIKXX7t8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xu Wen <wen.xu@gatech.edu>,
        Qu Wenruo <wqu@suse.com>, Gu Jinxiang <gujx@cn.fujitsu.com>,
        David Sterba <dsterba@suse.com>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>
Subject: [PATCH 4.9 065/101] btrfs: validate type when reading a chunk
Date:   Thu,  6 Dec 2018 15:39:04 +0100
Message-Id: <20181206143015.414565735@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181206143011.174892052@linuxfoundation.org>
References: <20181206143011.174892052@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gu Jinxiang <gujx@cn.fujitsu.com>

commit 315409b0098fb2651d86553f0436b70502b29bb2 upstream.

Reported in https://bugzilla.kernel.org/show_bug.cgi?id=199839, with an
image that has an invalid chunk type but does not return an error.

Add chunk type check in btrfs_check_chunk_valid, to detect the wrong
type combinations.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199839
Reported-by: Xu Wen <wen.xu@gatech.edu>
Reviewed-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: Gu Jinxiang <gujx@cn.fujitsu.com>
Signed-off-by: David Sterba <dsterba@suse.com>
[bwh: Backported to 4.9: Use root->fs_info instead of fs_info]
Signed-off-by: Ben Hutchings <ben.hutchings@codethink.co.uk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/btrfs/volumes.c |   28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -6370,6 +6370,8 @@ static int btrfs_check_chunk_valid(struc
 	u16 num_stripes;
 	u16 sub_stripes;
 	u64 type;
+	u64 features;
+	bool mixed = false;
 
 	length = btrfs_chunk_length(leaf, chunk);
 	stripe_len = btrfs_chunk_stripe_len(leaf, chunk);
@@ -6410,6 +6412,32 @@ static int btrfs_check_chunk_valid(struc
 			  btrfs_chunk_type(leaf, chunk));
 		return -EIO;
 	}
+
+	if ((type & BTRFS_BLOCK_GROUP_TYPE_MASK) == 0) {
+		btrfs_err(root->fs_info, "missing chunk type flag: 0x%llx", type);
+		return -EIO;
+	}
+
+	if ((type & BTRFS_BLOCK_GROUP_SYSTEM) &&
+	    (type & (BTRFS_BLOCK_GROUP_METADATA | BTRFS_BLOCK_GROUP_DATA))) {
+		btrfs_err(root->fs_info,
+			"system chunk with data or metadata type: 0x%llx", type);
+		return -EIO;
+	}
+
+	features = btrfs_super_incompat_flags(root->fs_info->super_copy);
+	if (features & BTRFS_FEATURE_INCOMPAT_MIXED_GROUPS)
+		mixed = true;
+
+	if (!mixed) {
+		if ((type & BTRFS_BLOCK_GROUP_METADATA) &&
+		    (type & BTRFS_BLOCK_GROUP_DATA)) {
+			btrfs_err(root->fs_info,
+			"mixed chunk type in non-mixed mode: 0x%llx", type);
+			return -EIO;
+		}
+	}
+
 	if ((type & BTRFS_BLOCK_GROUP_RAID10 && sub_stripes != 2) ||
 	    (type & BTRFS_BLOCK_GROUP_RAID1 && num_stripes < 1) ||
 	    (type & BTRFS_BLOCK_GROUP_RAID5 && num_stripes < 2) ||


