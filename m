Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737B0C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B82C2082D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:52:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mRiCQPw4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B82C2082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731010AbeKCEA5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 3 Nov 2018 00:00:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:56770 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726081AbeKCEA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Nov 2018 00:00:56 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D5DC32082D;
        Fri,  2 Nov 2018 18:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184761;
        bh=52XBrDA5q9JBMriJ6bOdQSNBojrzFhMig42cc4D0zv8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mRiCQPw4+kIGal2WreNLNDUETOod8bchwHSX5/ihhadYUfnsGJw3KPQ76SRFF+fqU
         yR6R5s3afWM96ZM2teOW4gfgaeqnWdEhNbpzFcDSqPTR6u8LE8o9eL12pt4CZZNpuy
         qGs+b0CtwoUotcvnNV6wCIaDxBcMq5A6AGHVdEVk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Misono Tomohiro <misono.tomohiro@jp.fujitsu.com>,
        Qu Wenruo <wqu@suse.com>, David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 089/143] btrfs: quota: Set rescan progress to (u64)-1 if we hit last leaf
Date:   Fri,  2 Nov 2018 19:34:34 +0100
Message-Id: <20181102182904.944139657@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182857.064326086@linuxfoundation.org>
References: <20181102182857.064326086@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -2603,8 +2603,10 @@ out:
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



