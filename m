Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id vDIQBPERHltSVAAAmS7hNA
	; Mon, 11 Jun 2018 06:09:20 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 21EF960792; Mon, 11 Jun 2018 06:09:20 +0000 (UTC)
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="GTX1R5YC"
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=2.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 93312605A5;
	Mon, 11 Jun 2018 06:09:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 93312605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754061AbeFKGJR (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 20 others); Mon, 11 Jun 2018 02:09:17 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:33039 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753899AbeFKGJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jun 2018 02:09:14 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5B69DsI023908;
        Mon, 11 Jun 2018 01:09:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1528697353;
        bh=L6x7BXFfZq4J33aNcoyEGfU0AdUiYPQLJwyUwVVv/o8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GTX1R5YCq7WeXAcOwh024fg7yWE6qDIBkE2l3foKMpPRvpyHbNMlkh0fj1wWPA1Ko
         VO8N+OaTc8Y7FHQ8v9OXI2PyruNjheNvzLx1mu3DjxImmCISpD+lJHPXA9IqtMJVAG
         KDOvHSe4IET4cN4YdpkoRZxvKjZd02U5jvUkwnzo=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5B69DVr028780;
        Mon, 11 Jun 2018 01:09:13 -0500
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 11
 Jun 2018 01:09:13 -0500
Received: from dflp33.itg.ti.com (10.64.6.16) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 11 Jun 2018 01:09:13 -0500
Received: from a0132425.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dflp33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5B697IH016033;
        Mon, 11 Jun 2018 01:09:12 -0500
From: Vignesh R <vigneshr@ti.com>
To: Thierry Reding <thierry.reding@gmail.com>
CC: <linux-pwm@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Vignesh R <vigneshr@ti.com>
Subject: [PATCH 2/2] pwm: pwm-tiehrpwm: Fix disabling of output of PWMs
Date: Mon, 11 Jun 2018 11:39:56 +0530
Message-ID: <20180611060956.27999-3-vigneshr@ti.com>
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

pwm-tiehrpwm driver disables PWM output by putting it in low output
state via active AQCSFRC register in ehrpwm_pwm_disable(). But, the
AQCSFRC shadow register is not updated. Therefore, when shadow AQCSFRC
register is re-enabled in ehrpwm_pwm_enable() (say to enable second PWM
output), previous settings are lost as shadow register value is loaded
into active register. This results in things like PWMA getting enabled
automatically, when PWMB is enabled and vice versa. Fix this by
updating AQCSFRC shadow register as well during ehrpwm_pwm_disable().

Fixes: 19891b20e7c2 ("pwm: pwm-tiehrpwm: PWM driver support for EHRPWM")
Cc: stable@vger.kernel.org
Signed-off-by: Vignesh R <vigneshr@ti.com>
---
 drivers/pwm/pwm-tiehrpwm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pwm/pwm-tiehrpwm.c b/drivers/pwm/pwm-tiehrpwm.c
index 768176f54d5e..f7b8a86fa5c5 100644
--- a/drivers/pwm/pwm-tiehrpwm.c
+++ b/drivers/pwm/pwm-tiehrpwm.c
@@ -381,6 +381,8 @@ static void ehrpwm_pwm_disable(struct pwm_chip *chip, struct pwm_device *pwm)
 		aqcsfrc_mask = AQCSFRC_CSFA_MASK;
 	}
 
+	/* Update shadow register first before modifying active register */
+	ehrpwm_modify(pc->mmio_base, AQCSFRC, aqcsfrc_mask, aqcsfrc_val);
 	/*
 	 * Changes to immediate action on Action Qualifier. This puts
 	 * Action Qualifier control on PWM output from next TBCLK
-- 
2.17.1
