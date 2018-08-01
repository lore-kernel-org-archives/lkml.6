Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C666C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A09B208A5
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 13:06:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A09B208A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389340AbeHAOvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 10:51:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41393 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388930AbeHAOvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 10:51:55 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fkqpP-0006DB-7s; Wed, 01 Aug 2018 13:06:11 +0000
From:   Colin King <colin.king@canonical.com>
To:     Daniel Scheller <d.scheller.oss@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][media-next] media: ddbridge/sx8: remove redundant check of iq_mode == 2
Date:   Wed,  1 Aug 2018 14:06:10 +0100
Message-Id: <20180801130610.19643-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The check for irq_mode == 2 occurs is always false and hence flags
is always zero.  This is because the check occurs in a path where
irq_mode is >= 3. Clean up the code by removing the check and irq_mode
and just pass 0.

Detected by CoverityScan, CID#1472214 ("Logically dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/media/pci/ddbridge/ddbridge-sx8.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/media/pci/ddbridge/ddbridge-sx8.c b/drivers/media/pci/ddbridge/ddbridge-sx8.c
index 4418604258d1..c1c69d47f8c9 100644
--- a/drivers/media/pci/ddbridge/ddbridge-sx8.c
+++ b/drivers/media/pci/ddbridge/ddbridge-sx8.c
@@ -398,9 +398,7 @@ static int set_parameters(struct dvb_frontend *fe)
 		}
 		stat = start(fe, 3, mask, ts_config);
 	} else {
-		u32 flags = (iq_mode == 2) ? 1 : 0;
-
-		stat = start_iq(fe, flags, 4, ts_config);
+		stat = start_iq(fe, 0, 4, ts_config);
 	}
 	if (!stat) {
 		state->started = 1;
-- 
2.17.1

