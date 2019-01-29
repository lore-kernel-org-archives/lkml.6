Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55EDDC282C7
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23B5420989
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 04:57:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YguGZwjm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727499AbfA2E51 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 23:57:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43059 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbfA2E51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 23:57:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id r10so20479709wrs.10
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jan 2019 20:57:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=f/AzGAh3ZudvUYw4T0qqJvy1cHtwmw9luwK7hINpsNI=;
        b=YguGZwjmRGHbzKSRsmz+oxth3OP8Qd3nJF/HVLk4nVKRcrKFEYdezDxHQMpUfXuRa9
         j9iZqlDxOSeG6nID3/KRGoDONxmOAulOC7XdDc0nlmWQUB8g30riWyYGhMjgHjDRYcQH
         NoMGNYgpLT8U7A2rgTIqs8aQQH/OIKQJrl2WU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=f/AzGAh3ZudvUYw4T0qqJvy1cHtwmw9luwK7hINpsNI=;
        b=CG9mP+Rez6c9sIY1HCuZyIjwgEJR2dIKEcNKNsMaWMmLIHWBcLnJffyLnpczAXAU7A
         Wy/MBcu8EW8q5X2nbDlIF9lmenev/B/kzbt4HqFIFPZvFoJTbPocV3xqpmje3AaBYJsc
         Fh7S0gsFDx4ROyB1e6u9EAk2THCQ0E+S1qaJm/x8ZRJx4OgbVNz1w49IUfcZV8Fbg7Ly
         TB+6M3aFZLaxwjFs8LjOxq/MjDc23v0Aw06DMKjrQOxg0DAoSzqOnhq+tCnt0Tz9AYIF
         MtLFMJjDLYFD8ibJ0gK1jGWWq8Tuia96nHvxbDCL3B36GLkXh5G4cpEKFSAHZvN99jQG
         HDZA==
X-Gm-Message-State: AJcUuke0gCYVcB5I1B+ulqQmV/5nreVdWvm2jLziHesuoZdBP6r2Gy3+
        oFcQvJnBtD/2PstmPWK1vds1Due0Jkk=
X-Google-Smtp-Source: ALg8bN5wlaXkuFK4qoVruAWbC29h4rKYONSibqQ7MKpTzcS6icf3XQkoUs/NLxtQGs3eeBkTlpTtOw==
X-Received: by 2002:adf:9d08:: with SMTP id k8mr25652098wre.203.1548737845146;
        Mon, 28 Jan 2019 20:57:25 -0800 (PST)
Received: from localhost ([49.248.171.30])
        by smtp.gmail.com with ESMTPSA id i13sm96485915wrw.32.2019.01.28.20.57.23
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Jan 2019 20:57:24 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Taniya Das <tdas@codeaurora.org>, linux-pm@vger.kernel.org
Subject: [PATCH v5 3/9] cpufreq: qcom-hw: Register as a cpufreq cooling device
Date:   Tue, 29 Jan 2019 10:25:09 +0530
Message-Id: <ca0320e94c8b7f27f8f490b71c3342c902eaeacf.1548737236.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548737236.git.amit.kucheria@linaro.org>
References: <cover.1548737236.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CPUFREQ_IS_COOLING_DEV flag to allow the cpufreq core to
auto-register the driver as a cooling device.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d83939a1b3d4..c88b51304d89 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -231,7 +231,8 @@ static struct freq_attr *qcom_cpufreq_hw_attr[] = {
 
 static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
+			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+			  CPUFREQ_IS_COOLING_DEV,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= qcom_cpufreq_hw_target_index,
 	.get		= qcom_cpufreq_hw_get,
-- 
2.17.1

