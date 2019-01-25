Return-Path: <SRS0=KJEp=QB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 906E1C282C0
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:03:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E7022184B
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Jan 2019 07:03:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="EwLhTb+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbfAYHDM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Jan 2019 02:03:12 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45240 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728174AbfAYHDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jan 2019 02:03:10 -0500
Received: by mail-yw1-f65.google.com with SMTP id d190so3500426ywd.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jan 2019 23:03:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=zLqXF7SYoovkgBMNm7MtzJSzeE0VgZYQlKefNmrl8Go=;
        b=EwLhTb+1nwC8TLvJKx01JbTutq1255mupbqFFVXEEgh1OnGkfiBmHs6hz107JGe/P2
         x6PnUPmI7FFNWIC7oQ8STOnRyd82VZiyDGq40BYlDzxM6UvP568DlE0NyuAJEnpRYOxN
         /MmudNV7UWET34KAU8JQ6M+t28sGKGm0Nrl6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=zLqXF7SYoovkgBMNm7MtzJSzeE0VgZYQlKefNmrl8Go=;
        b=RNXlDYELdDKpZ6eI3E1SEm7AJfnWq+RIvOEOz8s4lnZwYjAIe3ZJiYAtX59a89tJ0W
         SR4pTSqboqfvQFdWiuFCFpDBIROuxtIZCVrlTVaiLSkHe2PjEpRjW5Jz0gxl9Q0rBdCE
         UR24a92xUHzcSf1eelZDLXhQ4Ukz3/EDt/2XSaa8yEa1rkz7d2v96br/cwjnBGaz2RbE
         OEHWWQzYg5sm2/7hZktU+NOnL9Fba66yaVvLeQ4Js0VIldmhtbkq1IcyEEPr/h6OwGka
         sDwB5v42IYzooA59FmoSbsYl1a+1e9kwc5hRuAWBNZdFXTAhAVD+zsdV62qOIetjGIaP
         J+QQ==
X-Gm-Message-State: AJcUukf4sP8ERsD6od8SpxulY7NaNMjC+nJ0IrnA/05H6SJCBuJ4cZKZ
        JJ4Q7lHtYfpz/Qk/2aQmZuA6tYoX1kM=
X-Google-Smtp-Source: ALg8bN7fZcOKGWD7Oqrsv7af18g87g4M5leshTDktRjZ9VS1QDzgqusDcfjdtqHe7CRdVq30vsZL/g==
X-Received: by 2002:a81:4511:: with SMTP id s17mr9655402ywa.430.1548399789522;
        Thu, 24 Jan 2019 23:03:09 -0800 (PST)
Received: from localhost ([49.248.181.51])
        by smtp.gmail.com with ESMTPSA id i2sm12390826ywc.59.2019.01.24.23.03.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 24 Jan 2019 23:03:09 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK)
Subject: [PATCHv3 3/9] cpufreq: qcom-hw: Register as a cpufreq cooling device
Date:   Fri, 25 Jan 2019 12:32:23 +0530
Message-Id: <03a5f33f0667b58eca3c65a7ce1c25a4e5cd00df.1548398851.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1548398851.git.amit.kucheria@linaro.org>
References: <cover.1548398851.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1548398851.git.amit.kucheria@linaro.org>
References: <cover.1548398851.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow the cpufreq core
to auto-register the driver as a cooling device.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
Tested-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index d83939a1b3d4..ed32849a3d40 100644
--- a/drivers/cpufreq/qcom-cpufreq-hw.c
+++ b/drivers/cpufreq/qcom-cpufreq-hw.c
@@ -231,7 +231,8 @@ static struct freq_attr *qcom_cpufreq_hw_attr[] = {
 
 static struct cpufreq_driver cpufreq_qcom_hw_driver = {
 	.flags		= CPUFREQ_STICKY | CPUFREQ_NEED_INITIAL_FREQ_CHECK |
-			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY,
+			  CPUFREQ_HAVE_GOVERNOR_PER_POLICY |
+			  CPUFREQ_AUTO_REGISTER_COOLING_DEV,
 	.verify		= cpufreq_generic_frequency_table_verify,
 	.target_index	= qcom_cpufreq_hw_target_index,
 	.get		= qcom_cpufreq_hw_get,
-- 
2.17.1

