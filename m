Return-Path: <SRS0=alsP=NS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A43C0044C
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:41:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 057B520827
	for <linux-kernel@archiver.kernel.org>; Wed,  7 Nov 2018 13:41:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 057B520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fi.rohmeurope.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727462AbeKGXMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 7 Nov 2018 18:12:02 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43093 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbeKGXMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Nov 2018 18:12:02 -0500
Received: by mail-lf1-f68.google.com with SMTP id u18so11470777lff.10
        for <linux-kernel@vger.kernel.org>; Wed, 07 Nov 2018 05:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hUw/f3pfAWGmgfsftKGiw4xWCDUlJ7/A3a2ZWIb2gf4=;
        b=krJ6uk3Py7dntmGFBwnSrBs7brrgZ8UXbEKRuL2gKC57poESOu95cYxMYegt3oRooF
         qn4sbjqspcXufyctbZx9S1eR16nIEeacLhl62Gfjm986+YjvzB1BNbYXZIa7YiY/Pyt7
         1yrTXDBT7IZ4EbZmKCKgTZVjvx0ozklkIXh0ZVSLJNwbf39ocHEL5AyQnKaVgjXO+bDU
         wKE7RXm1kNQtySH6pT2/1d29s33OlxDkFCsZ50wNmhpQ+Szoln3AjhJ0yl8zNjpYiZvf
         cBIqQWHa/zst61ZW3JROsXABTtETSNnQ/wXuNAOjox4bKNVmdMgxdDgFa2qcBVhFngkB
         gtQA==
X-Gm-Message-State: AGRZ1gJPEP3b3CgYFukZJZy/mWo+ySeGd8K/5+9uyUAJ1d8UAwuEyONL
        5VwacX/TerpVzRQJLm2GnlY=
X-Google-Smtp-Source: AJdET5c/ScgRVXcZ+q9N2UCIlXKUKJ1zys4fZ/OSLdnhOpTrS6pQFfAPG8imxPRGWVcVUyg8Hqt5Eg==
X-Received: by 2002:a19:9904:: with SMTP id b4mr143476lfe.95.1541598095317;
        Wed, 07 Nov 2018 05:41:35 -0800 (PST)
Received: from localhost.localdomain ([213.255.186.46])
        by smtp.gmail.com with ESMTPSA id c5-v6sm120753lja.62.2018.11.07.05.41.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 07 Nov 2018 05:41:34 -0800 (PST)
Date:   Wed, 7 Nov 2018 15:41:26 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, mazziesaccount@gmail.com
Cc:     linux-kernel@vger.kernel.org, heikki.haikola@fi.rohmeurope.com,
        mikko.mutanen@fi.rohmeurope.com
Subject: [PATCH] regulator: bd718x7: Change next state after poweroff to ready
Message-ID: <20181107134126.GA4030@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BD71837 and BD71847 have a HW functionality which leave power
rails OFF after powerof state:
- if they have been controlled by SW.
- if state transition from poweroff is done to SNVS

BD71837 can after reset transition from power-off to SNVS or
READY state depending on reset reason. By default only wathcdog
reset changes state from poweroff to ready. Change PMIC
configuration to always transition to READY in order to avoid
crucial power rails being OFF after reset.

If SNVS is required the crucial power rails should not be
controlled by SW - eg corresponding regulator control register
should have SEL bit kept zero. Currently the driver assumes all
regulators to be controlled by SW so it sets all SEL bits to 1.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/bd718x7-regulator.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index 3a47e0372e77..63669f9038cc 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1053,6 +1053,29 @@ static int bd718xx_probe(struct platform_device *pdev)
 			BD718XX_REG_REGLOCK);
 	}
 
+	/* At poweroff transition PMIC HW disables EN bit for regulators but
+	 * leaves SEL bit untouched. So if state transition from POWEROFF
+	 * is done to SNVS - then all power rails controlled by SW (having
+	 * SEL bit set) stay disabled as EN is cleared. This may result boot
+	 * failure if any crucial systems are powered by these rails.
+	 *
+	 * Change the next stage from poweroff to be READY instead of SNVS
+	 * for all reset types because OTP loading at READY will clear SEL
+	 * bit allowing HW defaults for power rails to be used
+	 */
+	err = regmap_update_bits(mfd->regmap, BD718XX_REG_TRANS_COND1,
+				 BD718XX_ON_REQ_POWEROFF_MASK |
+				 BD718XX_SWRESET_POWEROFF_MASK |
+				 BD718XX_WDOG_POWEROFF_MASK |
+				 BD718XX_KEY_L_POWEROFF_MASK,
+				 BD718XX_POWOFF_TO_RDY);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to change reset target\n");
+		goto err;
+	} else {
+		dev_dbg(&pdev->dev, "Changed all resets from SVNS to READY\n");
+	}
+
 	for (i = 0; i < pmic_regulators[mfd->chip_type].r_amount; i++) {
 
 		const struct regulator_desc *desc;
-- 
2.14.3


