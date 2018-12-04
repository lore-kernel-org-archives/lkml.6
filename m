Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D2E9C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5F752146D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 11:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EQLqfN4V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5F752146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbeLDLGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 06:06:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:55404 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbeLDLGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 06:06:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EDDD214ED;
        Tue,  4 Dec 2018 11:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543921605;
        bh=mH1kEwx9P8tBj7d7stfwsqHw5gUlaGpPU51Ia0A99aQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EQLqfN4VAA/rhFuXBRQXA79CFKi74B4KYRX9qfsJ1twMrVGqflONgU8yciDyQ8w0X
         26S30pCoedF6hMe8i1Ddfh3aUED2J534KrUNDkeL3FDtySY0ZbXmkWjnRMf684C8qU
         tyyh+XbX5ZORP3kJGEVDoGYEGIwL9pG14wzckf3Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Omar Sandoval <osandov@fb.com>,
        Liu Bo <bo.liu@linux.alibaba.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 135/146] btrfs: release metadata before running delayed refs
Date:   Tue,  4 Dec 2018 11:50:21 +0100
Message-Id: <20181204103732.257702147@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181204103726.750894136@linuxfoundation.org>
References: <20181204103726.750894136@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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
index f74005ca8f08..73c1fbca0c35 100644
--- a/fs/btrfs/transaction.c
+++ b/fs/btrfs/transaction.c
@@ -1955,6 +1955,9 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		return ret;
 	}
 
+	btrfs_trans_release_metadata(trans, fs_info);
+	trans->block_rsv = NULL;
+
 	/* make a pass through all the delayed refs we have so far
 	 * any runnings procs may add more while we are here
 	 */
@@ -1964,9 +1967,6 @@ int btrfs_commit_transaction(struct btrfs_trans_handle *trans)
 		return ret;
 	}
 
-	btrfs_trans_release_metadata(trans, fs_info);
-	trans->block_rsv = NULL;
-
 	cur_trans = trans->transaction;
 
 	/*
-- 
2.17.1



