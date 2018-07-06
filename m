Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324B4C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:49:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D474A2400F
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 08:49:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D474A2400F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753362AbeGFItj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 04:49:39 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:45330 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751185AbeGFIti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 04:49:38 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id 7Lpc1y00c3XaVaC01LpcQl; Fri, 06 Jul 2018 10:49:36 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fbMQq-0004w1-Mn; Fri, 06 Jul 2018 10:49:36 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fbMQq-0007uR-Kd; Fri, 06 Jul 2018 10:49:36 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3] block: Add default switch case to blk_pm_allow_request() to kill warning
Date:   Fri,  6 Jul 2018 10:49:35 +0200
Message-Id: <20180706084935.30359-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With gcc 4.9.0 and 7.3.0:

    block/blk-core.c: In function 'blk_pm_allow_request':
    block/blk-core.c:2747:2: warning: enumeration value 'RPM_ACTIVE' not handled in switch [-Wswitch]
      switch (rq->q->rpm_status) {
      ^

Convert the return statement below the switch() block into a default
case to fix this.

Fixes: e4f36b249b4d4e75 ("block: fix peeking requests during PM")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v3:
  - Update line number,
  - Add gcc 7.3.0,

v2:
  - Add Reviewed-by,
  - Update line number.
---
 block/blk-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f84a9b7b6f5aa167..40e495073bdeec32 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2750,9 +2750,9 @@ static bool blk_pm_allow_request(struct request *rq)
 		return rq->rq_flags & RQF_PM;
 	case RPM_SUSPENDED:
 		return false;
+	default:
+		return true;
 	}
-
-	return true;
 }
 #else
 static bool blk_pm_allow_request(struct request *rq)
-- 
2.17.1

