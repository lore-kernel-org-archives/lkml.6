Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B95C4321E
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:12:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16C1E2075B
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 21:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C1E2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727669AbeIHBzW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 21:55:22 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:39876 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726002AbeIHBzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 21:55:21 -0400
Received: from localhost (ip-213-127-74-90.ip.prioritytelecom.net [213.127.74.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 21930FBE;
        Fri,  7 Sep 2018 21:12:33 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mikulas Patocka <mpatocka@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 4.18 013/145] block: fix infinite loop if the device loses discard capability
Date:   Fri,  7 Sep 2018 23:07:59 +0200
Message-Id: <20180907210904.663692213@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180907210903.617721278@linuxfoundation.org>
References: <20180907210903.617721278@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mikulas Patocka <mpatocka@redhat.com>

commit b88aef36b87c9787a4db724923ec4f57dfd513f3 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 block/blk-lib.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -68,6 +68,8 @@ int __blkdev_issue_discard(struct block_
 		 */
 		req_sects = min_t(sector_t, nr_sects,
 					q->limits.max_discard_sectors);
+		if (!req_sects)
+			goto fail;
 		if (req_sects > UINT_MAX >> 9)
 			req_sects = UINT_MAX >> 9;
 
@@ -105,6 +107,14 @@ int __blkdev_issue_discard(struct block_
 
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
 


