Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBBAFC6778C
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:05:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B13923FCF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 12:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B13923FCF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932780AbeGFMFB (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 08:05:01 -0400
Received: from bran.ispras.ru ([83.149.199.196]:31614 "EHLO smtp.ispras.ru"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753672AbeGFMFA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 08:05:00 -0400
Received: from myklebust.intra.ispras.ru (unknown [10.10.2.207])
        by smtp.ispras.ru (Postfix) with ESMTP id 41BD2203C3;
        Fri,  6 Jul 2018 15:04:55 +0300 (MSK)
From:   Anton Vasilyev <vasilyev@ispras.ru>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc:     Anton Vasilyev <vasilyev@ispras.ru>,
        Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, ldv-project@linuxtesting.org
Subject: [PATCH] video: goldfishfb: fix memory leak on driver remove
Date:   Fri,  6 Jul 2018 15:04:22 +0300
Message-Id: <20180706120422.14628-1-vasilyev@ispras.ru>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

goldfish_fb_probe() allocates memory for fb, but goldfish_fb_remove() does
not have deallocation of fb, which leads to memory leak on probe/remove.

The patch adds deallocation into goldfish_fb_remove().

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
---
 drivers/video/fbdev/goldfishfb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/goldfishfb.c b/drivers/video/fbdev/goldfishfb.c
index 3b70044773b6..9fe7edf725c6 100644
--- a/drivers/video/fbdev/goldfishfb.c
+++ b/drivers/video/fbdev/goldfishfb.c
@@ -301,6 +301,7 @@ static int goldfish_fb_remove(struct platform_device *pdev)
 	dma_free_coherent(&pdev->dev, framesize, (void *)fb->fb.screen_base,
 						fb->fb.fix.smem_start);
 	iounmap(fb->reg_base);
+	kfree(fb);
 	return 0;
 }
 
-- 
2.18.0

