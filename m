Return-Path: <SRS0=RpQd=J3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F1DC5CFEB
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D93720875
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Jul 2018 14:21:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D93720875
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388537AbeGKO0Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 10:26:25 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:50776 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387949AbeGKO0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 10:26:25 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fdG04-0006at-N7; Wed, 11 Jul 2018 14:21:48 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Josef Bacik <jbacik@fb.com>
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][block-next] block: iolatency: fix comparison of unsigned int max_depth with a (u64)-1
Date:   Wed, 11 Jul 2018 15:21:48 +0100
Message-Id: <20180711142148.3949-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The comparison max_depth != (u64)-1 is always true as max_depth is a
unsigned int and so its upper 32 bits are 0. Fix this by using the
a comparison of (unsigned int)-1 to ensure like types are compared.
Note, if max_depth is changed to a wider type then this will need
fixing again.

Detected by CoverityScan, CID#1471763 ("Operands don't affect result")

Fixes: commit d70675121546 ("block: introduce blk-iolatency io controller")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 block/blk-iolatency.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-iolatency.c b/block/blk-iolatency.c
index 56ddb2c68752..9a6427372da0 100644
--- a/block/blk-iolatency.c
+++ b/block/blk-iolatency.c
@@ -434,7 +434,7 @@ static void iolatency_record_time(struct iolatency_grp *iolat,
 	 * We don't want to count issue_as_root bio's in the cgroups latency
 	 * statistics as it could skew the numbers downwards.
 	 */
-	if (unlikely(issue_as_root && iolat->rq_depth.max_depth != (u64)-1)) {
+	if (unlikely(issue_as_root && iolat->rq_depth.max_depth != (unsigned int)-1)) {
 		u64 sub = iolat->min_lat_nsec;
 		if (req_time < sub)
 			blkcg_add_delay(lat_to_blkg(iolat), now, sub - req_time);
@@ -816,7 +816,7 @@ static size_t iolatency_pd_stat(struct blkg_policy_data *pd, char *buf,
 	struct iolatency_grp *iolat = pd_to_lat(pd);
 	unsigned long long avg_lat = div64_u64(iolat->total_lat_avg, NSEC_PER_USEC);
 
-	if (iolat->rq_depth.max_depth == (u64)-1)
+	if (iolat->rq_depth.max_depth == (unsigned int)-1)
 		return scnprintf(buf, size, " depth=max avg_lat=%llu",
 				 avg_lat);
 
-- 
2.17.1

