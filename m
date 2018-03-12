Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751835AbeCLPba (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:31:30 -0400
Received: from mout.web.de ([212.227.15.14]:38733 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751431AbeCLPb1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:31:27 -0400
To: linux-edac@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Thor Thayer <thor.thayer@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] altera_edac: Use common error handling code in
 altr_sdram_probe()
Message-ID: <f2f6b789-f262-f6cc-743f-244d4870c70e@users.sourceforge.net>
Date: Mon, 12 Mar 2018 16:31:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:chS9q9mea6n4VG6zq35KlzIzg9REc2lgCSAWBu2rjACPwkOJMeM
 lsQkuT5TEANCcXT852kqNRWa+kz1aA71mpy/rKPSgzbRCjTnvhlSZ/6KklViiTzr2eWo/9F
 Q/X/eVQP4BpJym752kgjW/0dMjHK5ybupxmQK6cKCkULvVA/hZf50b68H9T5MCWc+iH2hSV
 r00JySHJUrkWGMXsLQjtg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:/T1+hqHyAgI=:bN04WveGis4dc+ukZqhrwp
 EzkooE8k3YiVJjpWDTaOwoobT/Wkk+1f7YwcCi2llJ7+QRjYNTKCpNEMyb0Cy5UBrYRK5ASTh
 bhZohyZbElryozu64SJkF9X2EbLsVeRDCnZeF2sSld3v3t+TFpghzg37rKmeiZOreOvA3zGWz
 tZmncYrCWMqejeA0U/6tg1grM6hjAldTnfFIoVar/Qx5hUdH4YKQQle0ko+SOwF9uM+KZieXB
 pPx5XjZu+NlRGPDeaFCNmQM3qAdE3PgKp9t57lznkb6Vcyz69t2Knl6UUtQNiw6f3xCh/gyxK
 jdat3KOrZXLr2P1YxR1NsIw4E9wkJFXRe9f/tnuvg4Qumk//R3JxMXaZd7TPWE87/dwOqU/6m
 Plcpqrc/0GxhP4uTxYTAWz6nuCGuinvAnf8yqZEwuF2eSMJpYAz9lBXp8481xNttYLxHjs4iG
 WzYbFyS8qG+/v3YVFLMcJZFvOElskyYiKj4qC2o+/4PHiD+IyKYtRVzuNPCT47Qmt6LjTxYG+
 QjN5weUsBLekHtSrcZDFxnHU/UMPSqwPRA/ZTb68XvULgVFBB5X3evpw0qG1PDvl3LFn6WboP
 jab/pHrFAJmUv5zVfsZUp6er0NkQ9ApZT/tmYLcX789MktGbzlm1trhaP5txGTSOOKtNGdmsq
 3AuiA2busSCvLPoFga/IFYNEr2RS9Po5ayMDomdPiVHwZCl00yS6uMJ2f8YEitNvulgo8uPKD
 1nD8Zwt4qIaO6AxcoLEvGiiXJQbe03UUmPfxju+zu+Iq1LiQgJe8NjFCiNEvxxlYJnJJUxyYt
 ai0VMUEY9WNlkUTkUrbJt5hhFx0+qbsi83oQra8+4NLEKfkIdE=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 12 Mar 2018 16:23:53 +0100

Add a jump target so that a specific error code is assigned to the
local variable "res" at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/edac/altera_edac.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 11d6419788c2..d5c15b27d520 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -419,8 +419,7 @@ static int altr_sdram_probe(struct platform_device *pdev)
 		if (res < 0) {
 			edac_mc_printk(mci, KERN_ERR,
 				       "Unable to request irq %d\n", irq2);
-			res = -ENODEV;
-			goto err2;
+			goto e_nodev;
 		}
 
 		res = a10_unmask_irq(pdev, A10_DDR0_IRQ_MASK);
@@ -435,8 +434,7 @@ static int altr_sdram_probe(struct platform_device *pdev)
 	if (res < 0) {
 		edac_mc_printk(mci, KERN_ERR,
 			       "Unable to request irq %d\n", irq);
-		res = -ENODEV;
-		goto err2;
+		goto e_nodev;
 	}
 
 	/* Infrastructure ready - enable the IRQ */
@@ -444,8 +442,7 @@ static int altr_sdram_probe(struct platform_device *pdev)
 			       priv->ecc_irq_en_mask, priv->ecc_irq_en_mask)) {
 		edac_mc_printk(mci, KERN_ERR,
 			       "Error enabling SDRAM ECC IRQ\n");
-		res = -ENODEV;
-		goto err2;
+		goto e_nodev;
 	}
 
 	altr_sdr_mc_create_debugfs_nodes(mci);
@@ -454,6 +451,8 @@ static int altr_sdram_probe(struct platform_device *pdev)
 
 	return 0;
 
+e_nodev:
+	res = -ENODEV;
 err2:
 	edac_mc_del_mc(&pdev->dev);
 err:
-- 
2.16.2
