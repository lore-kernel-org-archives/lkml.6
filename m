Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id m57qKfgQHltUTwAAmS7hNA
	; Mon, 11 Jun 2018 06:09:32 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id D856F60792; Mon, 11 Jun 2018 06:09:31 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="m5YFEOkv"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 56E74601D2;
	Mon, 11 Jun 2018 06:09:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 56E74601D2
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932324AbeFKGJQ (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:09:16 -0400
Received: from fllnx210.ext.ti.com ([198.47.19.17]:20782 "EHLO
        fllnx210.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754035AbeFKGJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:09:12 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by fllnx210.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5B69BA8022618;
        Mon, 11 Jun 2018 01:09:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528697351;
        bh=r0CSrsiBsJTw33Cuqm0n9WwlFPaZFEPktqKO9NTaIKg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=m5YFEOkvQblOhwq+KpKkaaQa1EAUOcS8Me8pe6JY69oDJ06ZAhr7dunIcUzw9Z7Cf
         RoKrVrZ7Cn6BK2jSNRBa9LjV0qudMcJg5sUPyrneCX0MizecCMKgkpHIEI3td9W2VZ
         NIxoGN/7pwGE/IVIxESvMoHkB0w2TLSXejD1azN4=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5B69BI2016343;
        Mon, 11 Jun 2018 01:09:11 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 11
 Jun 2018 01:09:11 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 11 Jun 2018 01:09:11 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5B697IG016033;
        Mon, 11 Jun 2018 01:09:10 -0500
From: Vignesh R <vigneshr@ti.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 1/2] pwm: pwm-tiehrpwm: Don't use emulation mode bits to control PWM output
Date: Mon, 11 Jun 2018 11:39:55 +0530
Message-ID: <20180611060956.27999-2-vigneshr@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180611060956.27999-1-vigneshr@ti.com>
References: <20180611060956.27999-1-vigneshr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As per AM335x TRM SPRUH73P "15.2.2.11 ePWM Behavior During Emulation",
TBCTL[15:14] only have effect during emulation suspend events (IOW,
to stop PWM when debugging using a debugger). These bits have no effect
on PWM output during normal running of system. Hence, remove code
accessing these bits as they have no role in enabling/disabling PWMs.

Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
Cc: stable@vger.kernel.org
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 4c22cb395040..768176f54d5e 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -33,10 +33,6 @@
 #define TBCTL			0x00
 #define TBPRD			0x0A
 
-#define TBCTL_RUN_MASK		(BIT(15) | BIT(14))
-#define TBCTL_STOP_NEXT		0
-#define TBCTL_STOP_ON_CYCLE	BIT(14)
-#define TBCTL_FREE_RUN		(BIT(15) | BIT(14))
 #define TBCTL_PRDLD_MASK	BIT(3)
 #define TBCTL_PRDLD_SHDW	0
 #define TBCTL_PRDLD_IMDT	BIT(3)
@@ -360,7 +356,7 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 	/* Channels polarity can be configured from action qualifier module */
 	configure_polarity(pc, pwm->hwpwm);
 
-	/* Enable TBCLK before enabling PWM device */
+	/* Enable TBCLK */
 	ret = clk_enable(pc->tbclk);
 	if (ret) {
 		dev_err(chip->dev, "Failed to enable TBCLK for %s: %d\n",
@@ -368,9 +364,6 @@ static int ehrpwm_pwm_enable(struct pwm_chip *chip, struct pwm_device *pwm)
 		return ret;
 	}
 
-	/* Enable time counter for free_run */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_RUN_MASK, TBCTL_FREE_RUN);
-
 	return 0;
 }
 
@@ -400,9 +393,6 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 	/* Disabling TBCLK on PWM disable */
 	clk_disable(pc->tbclk);
 
-	/* Stop Time base counter */
-	ehrpwm_modify(pc->mmio_base, TBCTL, TBCTL_RUN_MASK, TBCTL_STOP_NEXT);
-
 	/* Disable clock on PWM disable */
 	pm_runtime_put_sync(chip->dev);
 }
-- 
2.17.1
