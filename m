Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50BE6C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12BA8223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:53:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="fXAOav+m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12BA8223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729207AbeKLUpx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:45:53 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:43332 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeKLUpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:45:53 -0500
Received: by mail-pl1-f193.google.com with SMTP id g59-v6so4171058plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 02:53:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=HOXqfssWr+GA/FOx7jvb56dSFIWUhT4eEupIEdpFDGI=;
        b=fXAOav+mraP+N9dy7FR2kkWZYlok0XTd5+E2fxqdoMQvs77zlJ9gRC6qQ9jeo7Q5U2
         7MuqGCZ5JB3AIGJBYk5UBxA7OZv3rKkogdtwNc3kHUzZyAzFcIMxFjtdbC8kteEw9NBI
         yKpfd7rWYpxyaacoVwpPdteKIPC1RHXcFPB6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=HOXqfssWr+GA/FOx7jvb56dSFIWUhT4eEupIEdpFDGI=;
        b=SM8o/LJrm35PBAKgzKAIpqvxEUMImloRI+8nHK/VZZKAMoYzFbOEtB6GEFHW4ph2dc
         29pe8sPOh0hj+hkKoYkOTcbv9+Ezo3SYdZOqtffeCm2bHaYRIRAx2uwVnMsiTqorRvAJ
         DRtc5kIsnkDLjSb/dv5fyvoTTzbyuxOzJu7pJhusggpLaNk3Cmj9wSmkUiLZTA/vwBuL
         tG/Hzywj7Vj1l6BM7BQGsLvQzHQ20efTD1CVHRH+rKPy8StsZfkMLPRmi1dziYicF5ft
         6irNqmNDkZCmuITEQRloxgpIxFGf/vaFnONHf+vLmkbWrOOS9IlnHSjcEiIaQc+CT6Yr
         RRhQ==
X-Gm-Message-State: AGRZ1gKn99urYwl/yEZW8L00R2HE6iHEuc488pyuH8AhSwRUEMC2ngni
        Em/NZ4RT1fIb+7M/sUqvA1mOUZv9lD8mFl7g
X-Google-Smtp-Source: AJdET5dLTa5+Mx7PHRpgLQqOLJdRyHOhk6Zws1uTzN0sgcEU8pBmO+WVn69Ev5EIf3pgktk0Bkt1Cg==
X-Received: by 2002:a17:902:622:: with SMTP id 31-v6mr459108plg.310.1542019990064;
        Mon, 12 Nov 2018 02:53:10 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 186-v6sm17545705pfe.39.2018.11.12.02.53.07
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 02:53:09 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org
Subject: [PATCH 2/4] power: supply: sc2731_charger: Add charger status detection
Date:   Mon, 12 Nov 2018 18:52:36 +0800
Message-Id: <7fa4e3191a6be72b5a90d0ee73b70457a699f9bd.1542019800.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
References: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
In-Reply-To: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
References: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB charger status can be notified before the charger driver registers
the USB phy notifier, so we should check the charger status in probe() in
case we missed the USB charger notification.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc2731_charger.c |   20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index 393ba98..a012d6c 100644
--- a/drivers/power/supply/sc2731_charger.c
+++ b/drivers/power/supply/sc2731_charger.c
@@ -432,6 +432,24 @@ static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
 	return ret;
 }
 
+static void sc2731_charger_detect_status(struct sc2731_charger_info *info)
+{
+	unsigned int min, max;
+
+	/*
+	 * If the USB charger status has been USB_CHARGER_PRESENT before
+	 * registering the notifier, we should start to charge with getting
+	 * the charge current.
+	 */
+	if (info->usb_phy->chg_state != USB_CHARGER_PRESENT)
+		return;
+
+	usb_phy_get_charger_current(info->usb_phy, &min, &max);
+	info->limit = min;
+
+	schedule_work(&info->work);
+}
+
 static int sc2731_charger_probe(struct platform_device *pdev)
 {
 	struct device_node *np = pdev->dev.of_node;
@@ -486,6 +504,8 @@ static int sc2731_charger_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	sc2731_charger_detect_status(info);
+
 	return 0;
 }
 
-- 
1.7.9.5

