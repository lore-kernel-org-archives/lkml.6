Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FDEC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 990D720675
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 12:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545999436;
	bh=xLo+A00IV1UQgq4LU/ithV4VkCjTMXLgRB4wVtrpfAg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EEUp5POc1aSzEWERKwBnFqxdC4rzOv/6gDKCGlZMqAV2K3YmMZOY5NfQZ3CKXCFyx
	 OacrSP6G6PfFGJjMcSRwXmnaswBzPP0qLkDpuzf6jJ/71AWrOvoUJisGPckHrNgO1V
	 okSFRLUVwuX9oayNB23izmp+JMsAbjTsckwydC60=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732887AbeL1MRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 07:17:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:36284 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732872AbeL1MRM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 07:17:12 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 77D6B2087F;
        Fri, 28 Dec 2018 12:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545999432;
        bh=xLo+A00IV1UQgq4LU/ithV4VkCjTMXLgRB4wVtrpfAg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HqwCU2p7IJ501VK8BNBeX4Vlo8yIPVIK8SrNzcbcdyHPTwPXO50U/ZurND3ljbAEP
         jnCU+cwYbcnUg4So9TtXhAlxdawZJJ6UEaUJ1z/qcWBJDMc54n1eBNdKQAl5siqrWV
         QlMk4v0gYu1m/bZhxIGPszkF3VvfxrxzI3S00S2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Omar Sandoval <osandov@fb.com>, Jens Axboe <axboe@kernel.dk>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 01/22] block: break discard submissions into the user defined size
Date:   Fri, 28 Dec 2018 12:52:38 +0100
Message-Id: <20181228113126.222869065@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181228113126.144310132@linuxfoundation.org>
References: <20181228113126.144310132@linuxfoundation.org>
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

[ Upstream commit af097f5d199e2aa3ab3ef777f0716e487b8f7b08 ]

Don't build discards bigger than what the user asked for, if the
user decided to limit the size by writing to 'discard_max_bytes'.

Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Omar Sandoval <osandov@fb.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-lib.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 46fe9248410d..d8b89c58af3d 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -63,10 +63,16 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		unsigned int req_sects;
 		sector_t end_sect, tmp;
 
-		/* Make sure bi_size doesn't overflow */
-		req_sects = min_t(sector_t, nr_sects, UINT_MAX >> 9);
+		/*
+		 * Issue in chunks of the user defined max discard setting,
+		 * ensuring that bi_size doesn't overflow
+		 */
+		req_sects = min_t(sector_t, nr_sects,
+					q->limits.max_discard_sectors);
+		if (req_sects > UINT_MAX >> 9)
+			req_sects = UINT_MAX >> 9;
 
-		/**
+		/*
 		 * If splitting a request, and the next starting sector would be
 		 * misaligned, stop the discard at the previous aligned sector.
 		 */
-- 
2.19.1



