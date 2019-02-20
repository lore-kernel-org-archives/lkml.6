Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA75FC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:14:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD50205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 11:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="og5UyRnk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfBTLOt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 06:14:49 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:44034 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727750AbfBTLOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 06:14:47 -0500
Received: by mail-pf1-f194.google.com with SMTP id a3so1943096pff.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 03:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iaqe+2N11xxQ/51ku7yTu4pfL9uKnGF6QH2aPr+JL+8=;
        b=og5UyRnkhlV9llFi7vejwdCM0lQPQL7Xsrjhd48nSur5qfwOi3p+pko43dxXnVq7vF
         FTAlniLcJnNphS7aJcPwUpVKq73kaMe3ntLQGv4VFVjD/rexShoDI5t68xxccJ4eevq9
         IlFk+lrPkDJ14mHY4Mlp9r6CT3UH4Kk9GPuTxsssxcZ6bRSXfAmYR+D1r4p4LMOe/CPI
         Xq16GWuukpdraZwUH2Pj48Bz4paCfykdJ2hoMV8+SLmhl5yEp9DlBqiTNx2g38t6V9uQ
         gR11eDkkZvO+h3w1LQg4B1VXP1XvmfAh82XekCH4pv3lgIaO0aebYqhqStlU/llEYx/Z
         h2dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=iaqe+2N11xxQ/51ku7yTu4pfL9uKnGF6QH2aPr+JL+8=;
        b=nNsWaVVAUrWVohlVBlNnWHQEDth0Db36fy2e3GQQ+Duy57UoQLyUalUFBzx7ueLSXc
         A9goFctUSh+uKXGa95GliFuFCMg6WS1CpfB6+5TRgoLzDL5EptwauGoilfo8vNEiE+iE
         EkC66oblvIrNI3zRBR0GuuyOB02U+6J5xAXarMoG8+Mfkgt9SIzqjucg9hi7Kahsi/DS
         do4fcUREl6uNKZD9ZtJ6xI13kLIe/ftj2k18XsdaRdhA6ExGTgqNyW81GJ9WoE4iM89k
         DyX1yJkhJQYXoKAVWB9OsDQKGczvPvHs0qFszQz3Ovb0hlJqPQKerAwDBC+9XvJPGsQj
         e97g==
X-Gm-Message-State: AHQUAubzdykfmQoTe1HYuILsICivrJ8T/5ZKbSdoyLJf5YNbo87mquJa
        uptytgoE3IDk6+Ezmd4IfqS3+w==
X-Google-Smtp-Source: AHgI3Ia0uAPTGB87YBMXNU/vGH9cgBqTVaG+zZo0RBmwGiaEHSw4ccWKTerTkSqEx76adX7Y+Lw6cw==
X-Received: by 2002:a63:bf4c:: with SMTP id i12mr28881675pgo.382.1550661286342;
        Wed, 20 Feb 2019 03:14:46 -0800 (PST)
Received: from localhost ([122.172.102.63])
        by smtp.gmail.com with ESMTPSA id f14sm20767148pgv.23.2019.02.20.03.14.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Feb 2019 03:14:45 -0800 (PST)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rafael Wysocki <rjw@rjwysocki.net>, Ilia Lin <ilia.lin@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>, amit.kucheria@linaro.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: kyro: Reduce frame-size of qcom_cpufreq_kryo_probe()
Date:   Wed, 20 Feb 2019 16:44:34 +0530
Message-Id: <5919a74b74f466e803e07f70136517119dcd4560.1550661235.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.21.0.rc0.269.g1a574e7a288b
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the introduction of commit 846a415bf440 ("arm64: default NR_CPUS to
256"), we have started getting following compilation warning:

qcom-cpufreq-kryo.c:168:1: warning: the frame size of 2160 bytes is larger than 2048 bytes [-Wframe-larger-than=]

Fix that by dynamically allocating opp_tables and freeing it later.

Compile tested only.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-kryo.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-kryo.c b/drivers/cpufreq/qcom-cpufreq-kryo.c
index 1c8583cc06a2..6888cb6db2ef 100644
--- a/drivers/cpufreq/qcom-cpufreq-kryo.c
+++ b/drivers/cpufreq/qcom-cpufreq-kryo.c
@@ -75,7 +75,7 @@ static enum _msm8996_version qcom_cpufreq_kryo_get_msm_id(void)
 
 static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 {
-	struct opp_table *opp_tables[NR_CPUS] = {0};
+	struct opp_table **opp_tables;
 	enum _msm8996_version msm8996_version;
 	struct nvmem_cell *speedbin_nvmem;
 	struct device_node *np;
@@ -133,6 +133,10 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 	}
 	kfree(speedbin);
 
+	opp_tables = kcalloc(num_possible_cpus(), sizeof(*opp_tables), GFP_KERNEL);
+	if (!opp_tables)
+		return -ENOMEM;
+
 	for_each_possible_cpu(cpu) {
 		cpu_dev = get_cpu_device(cpu);
 		if (NULL == cpu_dev) {
@@ -149,6 +153,8 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 		}
 	}
 
+	kfree(opp_tables);
+
 	cpufreq_dt_pdev = platform_device_register_simple("cpufreq-dt", -1,
 							  NULL, 0);
 	if (!IS_ERR(cpufreq_dt_pdev))
@@ -163,6 +169,7 @@ static int qcom_cpufreq_kryo_probe(struct platform_device *pdev)
 			break;
 		dev_pm_opp_put_supported_hw(opp_tables[cpu]);
 	}
+	kfree(opp_tables);
 
 	return ret;
 }
-- 
2.21.0.rc0.269.g1a574e7a288b

