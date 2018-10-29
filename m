Return-Path: <SRS0=Xm/m=NJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D542C2BC61
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 00:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D10FF2082D
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Oct 2018 00:58:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rmHX/vN3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D10FF2082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726102AbeJ2Joo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Oct 2018 05:44:44 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:51756 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbeJ2Joo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Oct 2018 05:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1540774704; x=1572310704;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=dwtwKmwFXM5O3E/PIhsvpPhvx2frXCKIHEq+6NBc88Y=;
  b=rmHX/vN3nLul+BTfJgACz5o57u0AK76Wq0QFjiPoPvXYl9w1OhSytpWC
   Ky+uqzAaU/hLmgcrtY62H5F286Ii7Z+CgrRKlCQQEEGfsRQQLIWZruYk9
   8+TOMYTDbeq8Clo0se46qPnsBuaNtmA2QO1e0pZ7j/ZOegNhSE1QzfcU8
   M=;
X-IronPort-AV: E=Sophos;i="5.54,438,1534809600"; 
   d="scan'208";a="761685552"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-7c3c5f85.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Oct 2018 00:58:22 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-2a-7c3c5f85.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w9T0wLaS077538
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Mon, 29 Oct 2018 00:58:22 GMT
Received: from EX13D01UWA003.ant.amazon.com (10.43.160.107) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 29 Oct 2018 00:58:21 +0000
Received: from EX13MTAUEE001.ant.amazon.com (10.43.62.200) by
 EX13d01UWA003.ant.amazon.com (10.43.160.107) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 29 Oct 2018 00:58:21 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.62.226) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Mon, 29 Oct 2018 00:58:20 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Balbir Singh" <sblbir@amazon.com>
Subject: [PATCH] Add cmd_flags to print_req_error
Date:   Mon, 29 Oct 2018 00:57:32 +0000
Message-ID: <20181029005732.21040-1-sblbir@amazon.com>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I ran into a bug where after hibernation due to incompatible
backends, the block driver returned BLK_STS_NOTSUPP, with the
current message it's hard to find out what the command flags
were. Adding req->cmd_flags help make the problem easier to
diagnose.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
---

The patch has been just compile tested only.

 block/blk-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cdfabc5646da..28b8f93835a7 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -256,10 +256,11 @@ static void print_req_error(struct request *req, blk_status_t status)
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
 		return;
 
-	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu\n",
-			   __func__, blk_errors[idx].name, req->rq_disk ?
-			   req->rq_disk->disk_name : "?",
-			   (unsigned long long)blk_rq_pos(req));
+	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %llx\n",
+				__func__, blk_errors[idx].name,
+				req->rq_disk ?  req->rq_disk->disk_name : "?",
+				(unsigned long long)blk_rq_pos(req),
+				(unsigned long long)req->cmd_flags);
 }
 
 static void req_bio_endio(struct request *rq, struct bio *bio,
-- 
2.16.2

