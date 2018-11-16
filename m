Return-Path: <SRS0=A7nN=N3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0DC6C43441
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:02:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8890F2089D
	for <linux-kernel@archiver.kernel.org>; Fri, 16 Nov 2018 11:02:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="NfmqTkyk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8890F2089D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389508AbeKPVNv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 16 Nov 2018 16:13:51 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40302 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389430AbeKPVNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Nov 2018 16:13:51 -0500
Received: by mail-pf1-f196.google.com with SMTP id x2-v6so11245552pfm.7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Nov 2018 03:02:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=OmVH3UHc4jVpPVW6soMiO6W7+f+gJlHLBPjlEn0mL64=;
        b=NfmqTkykV8or7LF9itF66A4SSLCnZfQEBwB4ANhk+9QwBLM1R3UTvEyGIVssNXEiwF
         rMbP5tIk6X5TBQUGSvMoK6V2jpqCYLBsN1WH4AdSX/CZYHouqb7u6W0fP+XE5GLS2f0J
         J9IW6hEzw3HYASHr9ANbXLLpjiJEtDXY+CROo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=OmVH3UHc4jVpPVW6soMiO6W7+f+gJlHLBPjlEn0mL64=;
        b=uUqdX/AeQBAxDtqAhARMTEIbznCxNx4MTRjoatoE388OSYxlDCdezyX3orKX7QFBDE
         K5qH8oPkdptMsWxMZgohV2Rek0lyx2E2wNv/Ru+A+FmsCu5mWZKK5ymkn6fBFMXgY+YK
         FrD3Q4NWIMRSo2OpC29nktgAGlvPnpNDNIO1q3FOQD2l9xPgWXPGSxUYdPtFTZUeqEGU
         nfkmh7KQOesAPofjekZwELUlgKrA+d+QhjOwGkyn4nBvekZs5pidf8jyUyMmKamP56qC
         elKwt4QWK3Jng5dVa5e/Wdy/u5rWCK/ZdxZch7tkDCwbETTB7qc8jNNSH+NLbdVr9RXs
         nZ4A==
X-Gm-Message-State: AGRZ1gIWc3hwDIOJ4zGqIgnDJtW1Dijeq2ck3BGFyfVmGIiOloNua1sm
        PfGUwh5iYX1d747Kjabd7y9jTg==
X-Google-Smtp-Source: AJdET5fG7zURzFKKNVWK5RJ2B1oFaNmkCVlIjC5h17TPXlSAYBnRDUKMMrM369hw6Gub2PYvw9/Y9w==
X-Received: by 2002:a62:ae12:: with SMTP id q18mr3320720pff.126.1542366119771;
        Fri, 16 Nov 2018 03:01:59 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 202sm21268106pfy.87.2018.11.16.03.01.55
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 16 Nov 2018 03:01:59 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org, robh+dt@kernel.org, mark.rutland@arm.com
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, yuanjiang.yu@unisoc.com,
        baolin.wang@linaro.org, broonie@kernel.org,
        linus.walleij@linaro.org
Subject: [PATCH 2/6] power: supply: charger-manager: Fix some misspelled words
Date:   Fri, 16 Nov 2018 19:01:09 +0800
Message-Id: <24406bab7e6b694c8eeb621c450ea7b039beb1d8.1542362262.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
In-Reply-To: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
References: <4ea9eaf85d780afb190cb45da2df8ff5fd86d449.1542362262.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some misspelled words.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/charger-manager.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index a1b420a..bd6c450 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -363,7 +363,7 @@ static int try_charger_enable(struct charger_manager *cm, bool enable)
 	int err = 0, i;
 	struct charger_desc *desc = cm->desc;
 
-	/* Ignore if it's redundent command */
+	/* Ignore if it's redundant command */
 	if (enable == cm->charger_enabled)
 		return 0;
 
@@ -1799,7 +1799,7 @@ static int charger_manager_probe(struct platform_device *pdev)
 
 	/*
 	 * Charger-manager is capable of waking up the systme from sleep
-	 * when event is happend through cm_notify_event()
+	 * when event is happened through cm_notify_event()
 	 */
 	device_init_wakeup(&pdev->dev, true);
 	device_set_wakeup_capable(&pdev->dev, false);
@@ -2019,7 +2019,7 @@ static void __exit charger_manager_cleanup(void)
  * cm_notify_event - charger driver notify Charger Manager of charger event
  * @psy: pointer to instance of charger's power_supply
  * @type: type of charger event
- * @msg: optional message passed to uevent_notify fuction
+ * @msg: optional message passed to uevent_notify function
  */
 void cm_notify_event(struct power_supply *psy, enum cm_event_types type,
 		     char *msg)
-- 
1.7.9.5

