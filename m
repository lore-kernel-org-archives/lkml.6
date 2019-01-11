Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 803F1C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:43:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C1B1218D3
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 19:43:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JoF+RxuW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388859AbfAKTnC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 14:43:02 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36800 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732097AbfAKTnC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 14:43:02 -0500
Received: by mail-lj1-f195.google.com with SMTP id g11-v6so13965279ljk.3;
        Fri, 11 Jan 2019 11:42:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZRVS57tv9I9ffMetpNGaYITV4nVk628qDxZw36pJwY=;
        b=JoF+RxuWc2U9ZqruqdjMEi3EjCHt0bgwXRIwuZppsWf8QH8qSge61SMBsSilfSj6Tg
         pw4ZUIBNDO0tUwDtPKfgMFMBK3XFn5y6Qhgg03Iv0VNDuh+hLNhYUWZNGbf93yeK+5UM
         ZrxVROqyBcFhWrMElADODgOAENuuFx7t/ep+ZIddLBvvZHeBERqmkejK0mmu5JPXntBN
         Fcssi9buJrfJm0RUg/J5vDecw9WzoxkI7N/uh73NzFpO2vuo5F++6j2aH60pdxGSesrf
         Wv1wq15hteaG+z4NtC/OGLH9byfsjaNSasr3UprXgwDP5DxlpSAOpW86ViMmBBk9e+uq
         KZ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=WZRVS57tv9I9ffMetpNGaYITV4nVk628qDxZw36pJwY=;
        b=eMza6BbSYqvmm9gDH++Ts5ymhQBdz44uCRDq5e0ul6Tlp040LTJUPnZsOCYJ1L7CWe
         Paqi4sOIh/36/l+Twv04vyq0L5vGpQ9KpTvuEB3MA2EqIHKzERyiyLNsdyPITdY8DMC3
         hSc38F+ociy3yVJrZKSNaDDZr66J2HZJpnUBZRf5Mo0tvBcWLHcXI37Ni88gGVkNamsl
         5raONeTkT2g5NN+Oc34603DBnWzFoKX7qfwjJ4cU+pFlFeti83TxInNfXvuhz4Guqa6U
         C4YrhgjQJdG+8gxHTmQXL8Zh028ygKuJMi5i5dx1Vci5SumQaNxSuIN4Q1bJ/KI48ZRF
         gKIQ==
X-Gm-Message-State: AJcUukeiXMwHApz8Er5R7woI5zp2UKiGbgWElmqr7xV/tqK9jEpAlL55
        BoKfge9QZmTiP03Rd0EGiaA=
X-Google-Smtp-Source: ALg8bN5G1D/gYawrOZ1LXdLsVI9Ryj4UGQP1xBGAR8D5E9SYUt9eLCKuZEmQortAT8+vnWDeCbTIgw==
X-Received: by 2002:a2e:e02:: with SMTP id 2-v6mr6808353ljo.10.1547235778733;
        Fri, 11 Jan 2019 11:42:58 -0800 (PST)
Received: from localhost.localdomain ([2a02:a315:5445:5300:1c33:9053:5344:9f1f])
        by smtp.googlemail.com with ESMTPSA id h3sm14602964lfj.25.2019.01.11.11.42.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 11 Jan 2019 11:42:57 -0800 (PST)
From:   =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
To:     kgene@kernel.org
Cc:     krzk@kernel.org, viresh.kumar@linaro.org, rjw@rjwysocki.net,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Pawe=C5=82=20Chmiel?= <pawel.mikolaj.chmiel@gmail.com>
Subject: [PATCH v3] cpufreq: s5pv210: Defer probe if getting regulators fail
Date:   Fri, 11 Jan 2019 20:42:44 +0100
Message-Id: <20190111194244.2439-1-pawel.mikolaj.chmiel@gmail.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is possibility, that when probing driver, regulators are not yet
initialized. In this case we should return EPROBE_DEFER and wait till
they're initialized, since they're required currently for cpufreq driver
to work. Also move regulator initialization code at beginning of probe,
so we can defer as fast as posibble.

Signed-off-by: Paweł Chmiel <pawel.mikolaj.chmiel@gmail.com>
---
Changes from v2:
  - Handle all error paths in probe

Changes from v1:
  - Fix compilation error
  - Reorganize code so it's smaller
---
 drivers/cpufreq/s5pv210-cpufreq.c | 68 ++++++++++++++++++++++---------
 1 file changed, 49 insertions(+), 19 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index f51697f1e0b3..627b132e3e61 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -584,7 +584,7 @@ static struct notifier_block s5pv210_cpufreq_reboot_notifier = {
 static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 {
 	struct device_node *np;
-	int id;
+	int id, result = 0;
 
 	/*
 	 * HACK: This is a temporary workaround to get access to clock
@@ -594,18 +594,40 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 	 * this whole driver as soon as S5PV210 gets migrated to use
 	 * cpufreq-dt driver.
 	 */
+	arm_regulator = regulator_get(NULL, "vddarm");
+	if (IS_ERR(arm_regulator)) {
+		if (PTR_ERR(arm_regulator) == -EPROBE_DEFER)
+			pr_debug("vddarm regulator not ready, defer\n");
+		else
+			pr_err("failed to get regulator vddarm\n");
+		result = PTR_ERR(arm_regulator);
+		goto err_arm_regulator;
+	}
+
+	int_regulator = regulator_get(NULL, "vddint");
+	if (IS_ERR(int_regulator)) {
+		if (PTR_ERR(int_regulator) == -EPROBE_DEFER)
+			pr_debug("vddint regulator not ready, defer\n");
+		else
+			pr_err("failed to get regulator vddint\n");
+		result = PTR_ERR(int_regulator);
+		goto err_int_regulator;
+	}
+
 	np = of_find_compatible_node(NULL, NULL, "samsung,s5pv210-clock");
 	if (!np) {
 		pr_err("%s: failed to find clock controller DT node\n",
 			__func__);
-		return -ENODEV;
+		result = -ENODEV;
+		goto err_clock;
 	}
 
 	clk_base = of_iomap(np, 0);
 	of_node_put(np);
 	if (!clk_base) {
 		pr_err("%s: failed to map clock registers\n", __func__);
-		return -EFAULT;
+		result = -EFAULT;
+		goto err_clock;
 	}
 
 	for_each_compatible_node(np, NULL, "samsung,s5pv210-dmc") {
@@ -614,7 +636,8 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 			pr_err("%s: failed to get alias of dmc node '%pOFn'\n",
 				__func__, np);
 			of_node_put(np);
-			return id;
+			result = id;
+			goto err_clk_base;
 		}
 
 		dmc_base[id] = of_iomap(np, 0);
@@ -622,33 +645,40 @@ static int s5pv210_cpufreq_probe(struct platform_device *pdev)
 			pr_err("%s: failed to map dmc%d registers\n",
 				__func__, id);
 			of_node_put(np);
-			return -EFAULT;
+			result = -EFAULT;
+			goto err_dmc;
 		}
 	}
 
 	for (id = 0; id < ARRAY_SIZE(dmc_base); ++id) {
 		if (!dmc_base[id]) {
 			pr_err("%s: failed to find dmc%d node\n", __func__, id);
-			return -ENODEV;
+			result = -ENODEV;
+			goto err_dmc;
 		}
 	}
 
-	arm_regulator = regulator_get(NULL, "vddarm");
-	if (IS_ERR(arm_regulator)) {
-		pr_err("failed to get regulator vddarm\n");
-		return PTR_ERR(arm_regulator);
-	}
-
-	int_regulator = regulator_get(NULL, "vddint");
-	if (IS_ERR(int_regulator)) {
-		pr_err("failed to get regulator vddint\n");
-		regulator_put(arm_regulator);
-		return PTR_ERR(int_regulator);
-	}
-
 	register_reboot_notifier(&s5pv210_cpufreq_reboot_notifier);
 
 	return cpufreq_register_driver(&s5pv210_driver);
+
+err_dmc:
+	for (id = 0; id < ARRAY_SIZE(dmc_base); ++id)
+		if (dmc_base[id])
+			iounmap(dmc_base[id]);
+
+err_clk_base:
+	iounmap(clk_base);
+
+err_clock:
+	regulator_put(int_regulator);
+
+err_int_regulator:
+	regulator_put(arm_regulator);
+
+err_arm_regulator:
+
+	return result;
 }
 
 static struct platform_driver s5pv210_cpufreq_platdrv = {
-- 
2.17.1

