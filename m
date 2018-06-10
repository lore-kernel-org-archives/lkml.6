Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id 95pCJdNjHVtYTAAAmS7hNA
	; Sun, 10 Jun 2018 17:45:55 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 89C9A60791; Sun, 10 Jun 2018 17:45:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,FREEMAIL_FROM,
	MAILING_LIST_MULTI autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 24EDD606FA;
	Sun, 10 Jun 2018 17:45:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24EDD606FA
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753951AbeFJRpw (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Sun, 10 Jun 2018 13:45:52 -0400
Received: from out03.smtpout.orange.fr ([193.252.22.212]:34458 "EHLO
        out.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753922AbeFJRpv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jun 2018 13:45:51 -0400
Received: from localhost.localdomain ([77.136.39.130])
        by mwinf5d62 with ME
        id x5ld1x0052oVPad035lh1J; Sun, 10 Jun 2018 19:45:49 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Jun 2018 19:45:49 +0200
X-ME-IP: 77.136.39.130
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: thor.thayer@linux.intel.com, bp@alien8.de, mchehab@kernel.org
Cc: linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH V2] EDAC, altera: Fix an error handling path in 'altr_s10_sdram_probe()'
Date: Sun, 10 Jun 2018 19:45:32 +0200
Message-Id: <20180610174532.22071-1-christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.17.0
X-Antivirus: Avast (VPS 180610-2, 10/06/2018), Outbound message
X-Antivirus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

IF 'regmap_write()' fails, we should release some resources as done in all
the other error handling paths of the function.

Fixes: e9918d7fafae ("EDAC, altera: Handle SDRAM Uncorrectable Errors on Stratix10")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
v1 -> v2: Fix subject line
---
 drivers/edac/altera_edac.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index d0d5c4dbe097..5762c3c383f2 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -730,7 +730,8 @@ static int altr_s10_sdram_probe(struct platform_device *pdev)
 			 S10_DDR0_IRQ_MASK)) {
 		edac_printk(KERN_ERR, EDAC_MC,
 			    "Error clearing SDRAM ECC count\n");
-		return -ENODEV;
+		ret = -ENODEV;
+		goto err2;
 	}
 
 	if (regmap_update_bits(drvdata->mc_vbase, priv->ecc_irq_en_offset,
-- 
2.17.0
