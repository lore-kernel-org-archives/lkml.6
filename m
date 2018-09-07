Return-Path: <SRS0=+2vW=LV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A447BC433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:27:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF252083D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Sep 2018 17:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="myKKd6I6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF252083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeIGWJf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Sep 2018 18:09:35 -0400
Received: from m12-15.163.com ([220.181.12.15]:59576 "EHLO m12-15.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725963AbeIGWJe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Sep 2018 18:09:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=wskbfu9PoVt18paWqN
        jzNRbWi9VPmOfU2FcnPWqS3ko=; b=myKKd6I6P2x6VsF8+csl5uDFJBSFHJW1GV
        uxd3hw/aTv4o3RomcrwwFUMdq0NTuWBrYKuKgnpvZvDOq77in++mRdvjMJn/qL0Q
        XMc2mK+LYiozGDTD9hf6HfCBEix8Jy5eJQX6sc7sJG7FUmB+u98m60OuAKG/x2MN
        EqHpqX+sY=
Received: from localhost (unknown [183.156.140.9])
        by smtp11 (Coremail) with SMTP id D8CowAAHYMsDtZJbkGTKGQ--.3266S5;
        Sat, 08 Sep 2018 01:27:33 +0800 (CST)
From:   jun qian <hangdianqj@163.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        jun qian <hangdianqj@163.com>
Subject: [PATCH] block: umem: replace spin_lock_bh with spin_lock in tasklet callback
Date:   Fri,  7 Sep 2018 10:27:20 -0700
Message-Id: <20180907172720.48621-1-hangdianqj@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: D8CowAAHYMsDtZJbkGTKGQ--.3266S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xr43KryDAF1fCr1fCr1kuFg_yoWfCwcEvr
        yrWF9IgrWqkwn0kr1Yv3ZxZryqka1jgFn5KFy2qa43J3srZas3Gw1vqrW3ZryDuFyxC3sx
        u342q347ur1xKjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU81SoJUUUUU==
X-Originating-IP: [183.156.140.9]
X-CM-SenderInfo: pkdqwvpldq1yi6rwjhhfrp/1tbiRAW6R1SIX1xGYQAAsE
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As you are already in a tasklet, it is unnecessary to call spin_lock_bh.

Signed-off-by: jun qian <hangdianqj@163.com>
---
 drivers/block/umem.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/umem.c b/drivers/block/umem.c
index 5c7fb8cc4149..9094ca60949c 100644
--- a/drivers/block/umem.c
+++ b/drivers/block/umem.c
@@ -421,7 +421,7 @@ static void process_page(unsigned long data)
 	struct cardinfo *card = (struct cardinfo *)data;
 	unsigned int dma_status = card->dma_status;
 
-	spin_lock_bh(&card->lock);
+	spin_lock(&card->lock);
 	if (card->Active < 0)
 		goto out_unlock;
 	page = &card->mm_pages[card->Active];
@@ -496,7 +496,7 @@ static void process_page(unsigned long data)
 		mm_start_io(card);
 	}
  out_unlock:
-	spin_unlock_bh(&card->lock);
+	spin_unlock(&card->lock);
 
 	while (return_bio) {
 		struct bio *bio = return_bio;
-- 
2.17.1



