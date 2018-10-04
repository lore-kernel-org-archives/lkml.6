Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 837F0C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:16:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 495DB21473
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 04:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="I/lWQzhr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495DB21473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbeJDLIE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 07:08:04 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:33919 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726813AbeJDLIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 07:08:04 -0400
Received: by mail-pl1-f196.google.com with SMTP id f18-v6so4484780plr.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 21:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qmKhPk9+e4QtLT1wSGU4V2sT6TEBWes/IdprVh2Q0io=;
        b=I/lWQzhr52XigUSMIbKX9KYqS94l1frlMSEWlqWA5e8XWYVzKQzlqWPff2nS/9fSWu
         dSoKVYSF4kQOfVueA9eI8+98chCNa6RyBd+t4uaCF4+fxoUoNaVg4vHMXuDfV7bYJymS
         J7fz8sti+e28HxD/J+QjjTp15B/DKPRPAXnuI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qmKhPk9+e4QtLT1wSGU4V2sT6TEBWes/IdprVh2Q0io=;
        b=GUsztpROklXRCbKLgAm47tDHp5Nt4H9ogwtmSVT+ok7FKU6S4H2L5Kjioy4SBe0LIS
         FpDxDutcD1TiY9716Z+G/T5uRm93uS1SQCa1jm26m5p87VyWNBow22R2iadvqq2OxPJf
         iwmuUPMZn3QrXXTDJdmrg9JGj0O/ymSLnzwHerw4Zt9Xo77OTUEHthJJXjtCQnjVnAlf
         g+j3UeLiMskjrRycQvtd8jy/2SLBZPIWIPx34e0LTTLLrO8u50D8WMt7/jWD491PnUYL
         jNhl0jwZbi2xT6EllG8HnCoGnZUygA2/CYegPcLrieQZxMTmQ1F/mhilFtJA2ao2mUgu
         OQ1Q==
X-Gm-Message-State: ABuFfogKDzhZR/V7i3W7WC6XsJLI78BLytzuOgiZAMt4VmvUGTKeFaOq
        pUdSi0E/7irti/ACtND/CyftVw==
X-Google-Smtp-Source: ACcGV61WCi5t8Fwx5jWHy+wjL2Rv7sLRP3xbYMeHuG4VvssoWLwFxSG+Bdnnz6vb/muq5+kh0GhXaw==
X-Received: by 2002:a17:902:bb88:: with SMTP id m8-v6mr4097054pls.120.1538626605578;
        Wed, 03 Oct 2018 21:16:45 -0700 (PDT)
Received: from localhost ([122.172.76.11])
        by smtp.gmail.com with ESMTPSA id 25-v6sm8577065pfm.36.2018.10.03.21.16.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 21:16:45 -0700 (PDT)
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rafael Wysocki <rjw@rjwysocki.net>, niklas.cassel@linaro.org,
        d-gerlach@ti.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] OPP: Improve error handling in dev_pm_opp_of_cpumask_add_table()
Date:   Thu,  4 Oct 2018 09:46:20 +0530
Message-Id: <50b6b87c8484da8bb5dcce00f84ec80aee8fc2bd.1538625101.git.viresh.kumar@linaro.org>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a2c
In-Reply-To: <cover.1538625101.git.viresh.kumar@linaro.org>
References: <cover.1538625101.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error handling wasn't appropriate in
dev_pm_opp_of_cpumask_add_table(). For example it returns 0 on success
and also for the case where cpumask is empty or cpu_device wasn't found
for any of the CPUs.

It should really return error on such cases, so that the callers can be
aware of the outcome.

Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/opp/of.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index a71ff3acca0f..67a384c8ead2 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -614,16 +614,18 @@ EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_remove_table);
 int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask)
 {
 	struct device *cpu_dev;
-	int cpu, ret = 0;
+	int cpu, ret;
 
-	WARN_ON(cpumask_empty(cpumask));
+	if (WARN_ON(cpumask_empty(cpumask)))
+		return -ENODEV;
 
 	for_each_cpu(cpu, cpumask) {
 		cpu_dev = get_cpu_device(cpu);
 		if (!cpu_dev) {
 			pr_err("%s: failed to get cpu%d device\n", __func__,
 			       cpu);
-			continue;
+			ret = -ENODEV;
+			goto remove_table;
 		}
 
 		ret = dev_pm_opp_of_add_table(cpu_dev);
@@ -635,12 +637,16 @@ int dev_pm_opp_of_cpumask_add_table(const struct cpumask *cpumask)
 			pr_debug("%s: couldn't find opp table for cpu:%d, %d\n",
 				 __func__, cpu, ret);
 
-			/* Free all other OPPs */
-			_dev_pm_opp_cpumask_remove_table(cpumask, cpu);
-			break;
+			goto remove_table;
 		}
 	}
 
+	return 0;
+
+remove_table:
+	/* Free all other OPPs */
+	_dev_pm_opp_cpumask_remove_table(cpumask, cpu);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dev_pm_opp_of_cpumask_add_table);
-- 
2.18.0.rc1.242.g61856ae69a2c

