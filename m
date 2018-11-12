Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7794CC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34730223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jYcr/3u0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34730223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729040AbeKLUpu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:45:50 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:33217 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbeKLUpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:45:50 -0500
Received: by mail-pl1-f193.google.com with SMTP id w22-v6so4191882plk.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 02:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=qSBEaLMQTxoif/rlC/sHjfIRGMZsmwAJJs2wQVE+B5U=;
        b=jYcr/3u07sWgDbtZaVIrHOPZfwRdtlpfIZM2SabGLo+mGy7P+dEEfHMDmySwtUP/UZ
         jpcPrA/+nb1fFWwA1fn0PepmONaa+iPuplJivD/hWDOSRDphPkH8iMDS7sWLMCPkokR0
         hHUHxrfWsiKTsKrXMdRpUcIogFNcso6MJ6tY4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qSBEaLMQTxoif/rlC/sHjfIRGMZsmwAJJs2wQVE+B5U=;
        b=WuefElabv68lsAYAnHoLGmocWwhTxEw0iw8h4rUUmo0TCkyQ3c+zYY+A0DLWaFivKD
         mZDoUpu+tmIDxEsIH7vPl/7v6Ty3UOA/YAyQxumwzNVW24tNhuRqioY45UCYbBQC/wMU
         jnKLHMUFHJGIdFTdlUI5Z8Y5m2vcnTD9eZLNX+vciDdzUitYVb+Npu6RAFVaOuLjtSjs
         hkmEvv9lpw8V5+XlIjKZJGQqfaHHGuDbBdrDc4swXE/ZeSVmE0uDKbhtWUUI6+FBiO0c
         De22qFH9yAaiFGUnEgCGOfgWU5Q4p3PdC1oDZ87lw2105hjBgumt0SlOlIk34laCH2Vw
         7uzw==
X-Gm-Message-State: AGRZ1gK7YfZt9XI90ceLRhewsRPWaYXotROpcI5621Lw4RFzMuJ6wBYX
        SVzp6imIC4s50nkAm2vxeUcYLw==
X-Google-Smtp-Source: AJdET5dXGrxqHznxKj+Ur9lD39xH3tO6eMJUOYpQotI0eBtdGZbm378+O9zGlFYSzYa0gagpVuKUTA==
X-Received: by 2002:a17:902:1122:: with SMTP id d31-v6mr439172pla.259.1542019987406;
        Mon, 12 Nov 2018 02:53:07 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 186-v6sm17545705pfe.39.2018.11.12.02.53.04
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 02:53:06 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org
Subject: [PATCH 1/4] power: supply: sc2731_charger: Add one work to charge/discharge
Date:   Mon, 12 Nov 2018 18:52:35 +0800
Message-Id: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the USB notifier context is atomic, we can not start or stop charging
in atomic context. Thus this patch adds one work to help to charge or
discharge.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc2731_charger.c |   30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index 525a820..393ba98 100644
--- a/drivers/power/supply/sc2731_charger.c
+++ b/drivers/power/supply/sc2731_charger.c
@@ -57,9 +57,11 @@ struct sc2731_charger_info {
 	struct usb_phy *usb_phy;
 	struct notifier_block usb_notify;
 	struct power_supply *psy_usb;
+	struct work_struct work;
 	struct mutex lock;
 	bool charging;
 	u32 base;
+	u32 limit;
 };
 
 static void sc2731_charger_stop_charge(struct sc2731_charger_info *info)
@@ -318,22 +320,21 @@ static int sc2731_charger_property_is_writeable(struct power_supply *psy,
 	.property_is_writeable	= sc2731_charger_property_is_writeable,
 };
 
-static int sc2731_charger_usb_change(struct notifier_block *nb,
-				     unsigned long limit, void *data)
+static void sc2731_charger_work(struct work_struct *data)
 {
 	struct sc2731_charger_info *info =
-		container_of(nb, struct sc2731_charger_info, usb_notify);
-	int ret = 0;
+		container_of(data, struct sc2731_charger_info, work);
+	int ret;
 
 	mutex_lock(&info->lock);
 
-	if (limit > 0) {
+	if (info->limit > 0) {
 		/* set current limitation and start to charge */
-		ret = sc2731_charger_set_current_limit(info, limit);
+		ret = sc2731_charger_set_current_limit(info, info->limit);
 		if (ret)
 			goto out;
 
-		ret = sc2731_charger_set_current(info, limit);
+		ret = sc2731_charger_set_current(info, info->limit);
 		if (ret)
 			goto out;
 
@@ -350,7 +351,19 @@ static int sc2731_charger_usb_change(struct notifier_block *nb,
 
 out:
 	mutex_unlock(&info->lock);
-	return ret;
+}
+
+static int sc2731_charger_usb_change(struct notifier_block *nb,
+				     unsigned long limit, void *data)
+{
+	struct sc2731_charger_info *info =
+		container_of(nb, struct sc2731_charger_info, usb_notify);
+
+	info->limit = limit;
+
+	schedule_work(&info->work);
+
+	return NOTIFY_OK;
 }
 
 static int sc2731_charger_hw_init(struct sc2731_charger_info *info)
@@ -432,6 +445,7 @@ static int sc2731_charger_probe(struct platform_device *pdev)
 
 	mutex_init(&info->lock);
 	info->dev = &pdev->dev;
+	INIT_WORK(&info->work, sc2731_charger_work);
 
 	info->regmap = dev_get_regmap(pdev->dev.parent, NULL);
 	if (!info->regmap) {
-- 
1.7.9.5

