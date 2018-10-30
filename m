Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAEDFC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CC9B2075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 02:40:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CC9B2075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amzn.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbeJ3LcK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 07:32:10 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:33803 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726692AbeJ3LcD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 07:32:03 -0400
X-IronPort-AV: E=Sophos;i="5.54,442,1534809600"; 
   d="scan'208";a="639170512"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1d-f273de60.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 30 Oct 2018 02:40:27 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-f273de60.us-east-1.amazon.com (8.14.7/8.14.7) with ESMTP id w9U2ePiT102751
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Tue, 30 Oct 2018 02:40:25 GMT
Received: from EX13D12UEA001.ant.amazon.com (10.43.61.99) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Oct 2018 02:40:25 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D12UEA001.ant.amazon.com (10.43.61.99) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 30 Oct 2018 02:40:25 +0000
Received: from localhost (172.23.204.141) by mail-relay.amazon.com
 (10.43.61.243) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Tue, 30 Oct 2018 02:40:24 +0000
From:   Balbir Singh <sblbir@amzn.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Balbir Singh" <sblbir@amzn.com>
Subject: [PATCH] Add cmd_flags to print_req_error
Date:   Tue, 30 Oct 2018 02:40:15 +0000
Message-ID: <20181030024015.1092-1-sblbir@amzn.com>
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

Signed-off-by: Balbir Singh <sblbir@amzn.com>
Reviewed-by: Eduardo Valentin <eduval@amazon.com>
---

Testing: Compile tested at my end

Changelog
  - convert %llx to %x and remove casting to unsigned long long

 block/blk-core.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index cdfabc5646da..0fd6104bb0d2 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -256,10 +256,11 @@ static void print_req_error(struct request *req, blk_status_t status)
 	if (WARN_ON_ONCE(idx >= ARRAY_SIZE(blk_errors)))
 		return;
 
-	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu\n",
-			   __func__, blk_errors[idx].name, req->rq_disk ?
-			   req->rq_disk->disk_name : "?",
-			   (unsigned long long)blk_rq_pos(req));
+	printk_ratelimited(KERN_ERR "%s: %s error, dev %s, sector %llu flags %x\n",
+				__func__, blk_errors[idx].name,
+				req->rq_disk ?  req->rq_disk->disk_name : "?",
+				(unsigned long long)blk_rq_pos(req),
+				req->cmd_flags);
 }
 
 static void req_bio_endio(struct request *rq, struct bio *bio,
-- 
2.16.2

