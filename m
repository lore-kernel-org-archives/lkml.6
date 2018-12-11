Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962D6C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:18:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D82020851
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545096;
	bh=nXIb51wCD0PLvnkwLgQjjxK/EeCGuYyikHc2EmuWBmE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h/RspMmPpuCFqZiAZkzYG2dJtcwl+tloAZFFRQmSHnBdqg//GO3bqYlHUK8Hghc8X
	 gNcVUu1OnSk9Jxr2uCi+t800TvUW1A0qfiXXt+04+q91DIU4VNDs+lZscGbfHvQ3+A
	 6a50IdS2kOEvXHWKs6m/y882RQaj6hnLUxZ5wKdk=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D82020851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbeLKQSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:18:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:35066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728371AbeLKPqj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:46:39 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AF53320870;
        Tue, 11 Dec 2018 15:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543199;
        bh=nXIb51wCD0PLvnkwLgQjjxK/EeCGuYyikHc2EmuWBmE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cRoQvwQLXaOsMIAJEhjBSaRuBLMxwRQMZnAgJvg9PlryhIFq/F9N2/4/Todg3H8vF
         kxZ6xYw3KmAMvQU9zMiCyWOKHMcCOiS5Qiyc+7nYpPqhf9SqCISMu8vJ09LMEAern7
         cI1iB367L8qad1HkCoDxTKRAtGrF4AZc42JzoOrI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 17/91] btrfs: release metadata before running delayed refs
Date:   Tue, 11 Dec 2018 16:40:36 +0100
Message-Id: <20181211151607.261293742@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
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

We want to release the unused reservation we have since it refills the
delayed refs reserve, which will make everything go smoother when
running the delayed refs if we're short on our reservation.

CC: stable@vger.kernel.org # 4.4+
Reviewed-by: Omar Sandoval <osandov@fb.com>
Reviewed-by: Liu Bo <bo.liu@linux.alibaba.com>
Reviewed-by: Nikolay Borisov <nborisov@suse.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/transaction.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/transaction.c b/fs/btrfs/transaction.c
index be8eae80ff65..098016338f98 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1821,6 +1821,9 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
+	btrfs_trans_release_metadata(trans, root);
+	trans->block_rsv = NULL;
+
 	/* make a pass through all the delayed refs we have so far
 	 * any runnings procs may add more while we are here
 	 */
@@ -1830,9 +1833,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans,
 		return ret;
 	}
 
-	btrfs_trans_release_metadata(trans, root);
-	trans->block_rsv = NULL;
-
 	cur_trans = trans->transaction;
 
 	/*
-- 
2.17.1



