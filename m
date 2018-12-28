Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88392C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D57720675
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:21:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999713;
	bh=bJdqvnntYfA/zPUOoTZ0Rrgy8zbN+XxR/YewiHqlVtw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=mxm09DxvjJ3/M6UZygpY9J6yVnjKYy6c5k+LN0Q+gxHeMZBZjlGhn/or/b5kOG1uW
	 IcSEhwSRy5WPpZO97opXKMI70YtAenLpO10mmAqZOXZyfNS2c3oJ9Go/niIUvQ+vOE
	 rA5GSwUgL4DbVVUNJIl3d4WjslCTKy2bE+WKAZFY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732529AbeL1MPt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:15:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:34792 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732506AbeL1MPp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:15:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47ADF2087F;
        Fri, 28 Dec 2018 12:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999344;
        bh=bJdqvnntYfA/zPUOoTZ0Rrgy8zbN+XxR/YewiHqlVtw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TvF+5bTopDSl/8TCm9c69X4O4mMnziMTMKJTBvxHzx3dE+475hllNLZXWtg1KiXFD
         gD+7jUNxwQ6GarztRRPere+XfPS0KoiE6gnr7MCxQ7G5YIuzuP3HCBNOOKPi7RzVFy
         +DdgLeT1LBFwtaEz1XvVs9qOylv3XLlLjxuiZ/yo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 02/36] block: fix infinite loop if the device loses discard capability
Date:   Fri, 28 Dec 2018 12:52:18 +0100
Message-Id: <20181228113126.684445611@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.526729877@linuxfoundation.org>
References: <20181228113126.526729877@linuxfoundation.org>
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

[ Upstream commit b88aef36b87c9787a4db724923ec4f57dfd513f3 ]

If __blkdev_issue_discard is in progress and a device mapper device is
reloaded with a table that doesn't support discard,
q->limits.max_discard_sectors is set to zero. This results in infinite
loop in __blkdev_issue_discard.

This patch checks if max_discard_sectors is zero and aborts with
-EOPNOTSUPP.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Tested-by: Zdenek Kabelac <mpatocka@redhat.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-lib.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 53a45663e688..0bdc77888dc5 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -65,6 +65,8 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		 */
 		req_sects = min_t(sector_t, nr_sects,
 					q->limits.max_discard_sectors);
+		if (!req_sects)
+			goto fail;
 		if (req_sects > UINT_MAX >> 9)
 			req_sects = UINT_MAX >> 9;
 
@@ -102,6 +104,14 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 
 	*biop = bio;
 	return 0;
+
+fail:
+	if (bio) {
+		submit_bio_wait(bio);
+		bio_put(bio);
+	}
+	*biop = NULL;
+	return -EOPNOTSUPP;
 }
 EXPORT_SYMBOL(__blkdev_issue_discard);
 
-- 
2.19.1



