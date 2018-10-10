Return-Path: <SRS0=PZ5q=MW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F9A5C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:15:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB712214DA
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Oct 2018 14:15:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB712214DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbeJJViL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Oct 2018 17:38:11 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:51734 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726492AbeJJViL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Oct 2018 17:38:11 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gAFH5-0007e8-1d; Wed, 10 Oct 2018 14:15:43 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ALSA: cs4236: fix return check from call to pnp_port_start
Date:   Wed, 10 Oct 2018 15:15:42 +0100
Message-Id: <20181010141542.16100-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the return from pnp_port_start is being checked for validity
by checking if it is greater or equal to zero, however, the return
is unsigned and hence this check is always true.  An 0 return from
pnp_port_start is actually an error, so fix the check by checking
for validity when it is non-zero.

Detected by CoverityScan, CID#1468334 ("Unsigned compared to 0")

Fixes: a9824c868a2c ("[ALSA] Add CS4232 PnP BIOS support")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/isa/cs423x/cs4236.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/isa/cs423x/cs4236.c b/sound/isa/cs423x/cs4236.c
index 70559e59d18f..2211c39d2c18 100644
--- a/sound/isa/cs423x/cs4236.c
+++ b/sound/isa/cs423x/cs4236.c
@@ -292,7 +292,7 @@ static int snd_cs423x_pnp_init_mpu(int dev, struct pnp_dev *pdev)
 		mpu_irq[dev] = SNDRV_AUTO_IRQ;
 	} else {
 		mpu_port[dev] = pnp_port_start(pdev, 0);
-		if (mpu_irq[dev] >= 0 &&
+		if (!mpu_irq[dev] &&
 		    pnp_irq_valid(pdev, 0) && pnp_irq(pdev, 0) >= 0) {
 			mpu_irq[dev] = pnp_irq(pdev, 0);
 		} else {
-- 
2.17.1

