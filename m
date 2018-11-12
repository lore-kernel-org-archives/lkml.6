Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24217C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBDC3223D8
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 10:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1xsJXjt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBDC3223D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbeKLUp4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 15:45:56 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:42121 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729212AbeKLUpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 15:45:55 -0500
Received: by mail-pf1-f196.google.com with SMTP id u10-v6so4142103pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Nov 2018 02:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=WRUiqIUtLnq5Kt3BfAdxw6WClpYGJFwMdYAB6FisGEA=;
        b=h1xsJXjtr4KUX4hiAU3XjR0GvBQ+IQqpczfSDmxf4WmzGS3osEcUSguvicWvWXCOpz
         ApGW2bVX4eJeWM0ZQ6M0IVBl6jyucT3Lx0cEZIA815UrCpBAsIfAHdQWtW8+kKwQFxzx
         cHAeJAWFXMgR5VVfVuq/uazUpolpjm5ig2DQ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=WRUiqIUtLnq5Kt3BfAdxw6WClpYGJFwMdYAB6FisGEA=;
        b=K3Rbje46ap0kqMIaW7JdqLxp1Lna0He8goMqPKIoECx5PeDH1r+GeLnHWmqK4gGiwP
         bX0YWCgiuIRSfvyXuvK3VwQeMARAiTspAohTdWbcx+hOH7/6tTUxIqCFwmfumc9/9exV
         1R3wO6uqIJYHK58/umrxadZu/JkBZPjlbEV3RE1ZiIqOUzrvmYqpFT5kj2ecaAvvSaY0
         WyPVwofiV+qIjWemuGlJWUXAEEa7IPduYt2NNuK9n6B+Zi8F5TCfZppFlWiiK4lTMcKg
         qxNXOx7LONfvRblQGWESlotuXV9snO6HpT+GuZQMtvpLun+8PTCnjHRyxAKR1ocuhF4q
         yf1w==
X-Gm-Message-State: AGRZ1gKpRQifrvFmLEadvCDOTpnHcI2cfNxkv9FaRl4IdaVKojELTGfM
        M7TFxlpWeJj/czxNgbLhOMm2vw==
X-Google-Smtp-Source: AJdET5fi/0hkuSZLQv8DVN2iuIPkYkSADaMyZQJk/RZq8RPhUhPll42FhDRjETyssTZDEjmOZ+/b+w==
X-Received: by 2002:a63:eb0e:: with SMTP id t14mr378059pgh.445.1542019992697;
        Mon, 12 Nov 2018 02:53:12 -0800 (PST)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id 186-v6sm17545705pfe.39.2018.11.12.02.53.10
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 12 Nov 2018 02:53:12 -0800 (PST)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        yuanjiang.yu@unisoc.com, baolin.wang@linaro.org, broonie@kernel.org
Subject: [PATCH 3/4] power: supply: sc2731_charger: Avoid repeated charge/discharge
Date:   Mon, 12 Nov 2018 18:52:37 +0800
Message-Id: <2298d92a4156f331f9e317d6bc6eed0ff88677bb.1542019800.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
References: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
In-Reply-To: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
References: <5d096dec07f6808a70edcfaad6e8f77039f21a9b.1542019800.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add info->charging validation to avoid repeated charge or discharge
operation.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 drivers/power/supply/sc2731_charger.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/sc2731_charger.c b/drivers/power/supply/sc2731_charger.c
index a012d6c..49b3f0c 100644
--- a/drivers/power/supply/sc2731_charger.c
+++ b/drivers/power/supply/sc2731_charger.c
@@ -328,7 +328,7 @@ static void sc2731_charger_work(struct work_struct *data)
 
 	mutex_lock(&info->lock);
 
-	if (info->limit > 0) {
+	if (info->limit > 0 && !info->charging) {
 		/* set current limitation and start to charge */
 		ret = sc2731_charger_set_current_limit(info, info->limit);
 		if (ret)
@@ -343,7 +343,7 @@ static void sc2731_charger_work(struct work_struct *data)
 			goto out;
 
 		info->charging = true;
-	} else {
+	} else if (!info->limit && info->charging) {
 		/* Stop charging */
 		info->charging = false;
 		sc2731_charger_stop_charge(info);
-- 
1.7.9.5

