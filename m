Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB93C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:22:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4EA6520659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:22:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jmgzWA3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726833AbfANKV6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:21:58 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:40961 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726595AbfANKV4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:21:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id x10so22112125wrs.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:21:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=cNYNQ5KauWNer74TDBHyi3aVg7qesm9a6f/suNN7BOE=;
        b=jmgzWA3DtEZ+pp9ewQZONx3Svz0g4mDEuJnlXIKx1f05yBEZeouIq0rjNWQS/7qvCV
         ErmFWPp/V40JeP3IvUQIiYvuCzpgj1jmU5olayPUhLnyeYsXCfYmdQvEJx6asF7tzlLH
         FFyQKblrYrHS5q4KrQQ80EFEA0pDUo9DJxUdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=cNYNQ5KauWNer74TDBHyi3aVg7qesm9a6f/suNN7BOE=;
        b=gbCiBIPQyS3aazfXgj+Lv1cPWCfLSZ1QIN6WM7f/yMnilEQ9KAVnH2LS8OhiB3zGXZ
         EiWWIm4NuN1k0xmB0XDaJjXWkxoBkib7cg/eNKqtOcgpmZbIVaFDujDQj2k3tMEktdlC
         PBSi6aZbDfmsdCQ70T6cJo3ZY/FfYVZng78AENkGBaOhTqs6hg8hWGeL13d3DHCgT8d0
         nuDGhCK5MgPdaDRWVajn3ZIAHImnT2Y8rc9dB3Op1e7H9vXdfhTNyJEwBdVox64uWbXN
         EGsRdwJAlBwtiTS4Tu2kcQzuJY1B+0pYqlu/NNzddKmDCz/ZRxt/njcbc8VEl0ClGQ4j
         dtUg==
X-Gm-Message-State: AJcUukdMK8LTMmBA00qWmg1ibmRp5j22TsuV3eiMFmiDU0o/7/nX9hmi
        9zVGmJIN9rjjHwNXFmOitQT2D2AqsfE=
X-Google-Smtp-Source: ALg8bN6N4nPyi7ryYyTPveVcVLN2AW+0ZijVlkHW606l7wjb8pm8Fe6xBBuOd8LoiM6pkSnmBQKXrA==
X-Received: by 2002:adf:8421:: with SMTP id 30mr24392096wrf.153.1547461314750;
        Mon, 14 Jan 2019 02:21:54 -0800 (PST)
Received: from localhost ([49.248.81.155])
        by smtp.gmail.com with ESMTPSA id y185sm17801534wmg.34.2019.01.14.02.21.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 02:21:54 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY DRIVERS)
Subject: [PATCH v2 6/9] cpufreq: qcom-hw: Register as a cpufreq cooling device
Date:   Mon, 14 Jan 2019 15:51:08 +0530
Message-Id: <b5e5698973c156f16af825ee92b8c94af224e634.1547458732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the CPUFREQ_AUTO_REGISTER_COOLING_DEV flag to allow the cpufreq core
to auto-register the driver as a cooling device.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 drivers/cpufreq/qcom-cpufreq-hw.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/qcom-cpufreq-hw.c b/drivers/cpufreq/qcom-cpufreq-hw.c
index 649dddd72749..47c7cea22da1 100644
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

