Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD4A5C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C3A5206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B4M5RU4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbfANQfz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:35:55 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51789 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbfANQfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:35:55 -0500
Received: by mail-wm1-f65.google.com with SMTP id b11so223817wmj.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:35:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=B3U4dJNDxXU77aqEF/bd0F2FU2BzXMK0qQTt7fghjFA=;
        b=B4M5RU4V6n94aCrZUAH4F+wWJFxlWEjftqPmqqs9uGUOVv7uhSwYIroen676tDJlF5
         hkQX2V22SJAdhYFTVYGk4RrPtxQGztGimctR6XBW5mrHdmQq0U/kYn+0S82kNAwq1FcA
         d9EtaVmC32Cva3n6CAu1Q77AuJ4mCqKHe7K0E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=B3U4dJNDxXU77aqEF/bd0F2FU2BzXMK0qQTt7fghjFA=;
        b=ZtE5bFIaZfo2zzAu3kcV73UtBTHzAl/4UujX9NAYS4b8hvd/fo96sMsPI0l5Jk2zqO
         9sMmZ4qP35FGYffM48lKfE36dJlDAfkFR1qbjdVcVX4jNkke4CP5YstIbFK/1GUG4tCK
         ufPxun3iLqnbmCD7CzyVlReZqL6OtslaFKhWwixontnttZsE7sV3ER/eSaaSCRr+jCSJ
         xlZtuW3roA7oruHhGHG+BOvV/AzZUVxrjBg+ZTHvKQya5JtYpTD21gpFALHFpvIm+5BU
         cESKDjKfq6i9FDRSDItCNqyChbQvLuzGPpJTmzgzaBa/RdLSgHFS6l9S1VLv2YfH31vY
         vImg==
X-Gm-Message-State: AJcUukdCJdr1n0c3IK4o5QqEVMQiimS42s0AIganv22GqFH6hxR95+N+
        mIlO7HUMnK0C30Mi9YEFE9chFmVBZA/P6Q==
X-Google-Smtp-Source: ALg8bN4rDGwQQv8KQifEL+FznWmJAiaEI37HHW4e/z4i2VxC6/pkJxcOM/RmTh6Q65h8E6/HJozGAg==
X-Received: by 2002:a1c:aa0f:: with SMTP id t15mr12308049wme.108.1547483753190;
        Mon, 14 Jan 2019 08:35:53 -0800 (PST)
Received: from localhost ([49.248.190.171])
        by smtp.gmail.com with ESMTPSA id w12sm65168974wrr.23.2019.01.14.08.35.51
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:35:52 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 01/10] cpufreq: Add thermal_cooling_device pointer to struct cpufreq_policy
Date:   Mon, 14 Jan 2019 22:04:53 +0530
Message-Id: <168294311714f269b1050bcbf5d3324eae0808f2.1547481320.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several cpufreq drivers register themselves as thermal cooling devices.
Adding a pointer to struct cpufreq_policy removes the need for them to
store this pointer in a private data structure.

We can then auto-register the cpufreq driver as a thermal cooling device
from cpufreq core code.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 include/linux/cpufreq.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c86d6d8bdfed..7d0cf54125fa 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -95,6 +95,11 @@ struct cpufreq_policy {
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
 
+#ifdef CONFIG_CPU_THERMAL
+	/* Pointer to the cooling device if used for thermal mitigation */
+	struct thermal_cooling_device *cooldev;
+#endif
+
 	struct list_head        policy_list;
 	struct kobject		kobj;
 	struct completion	kobj_unregister;
-- 
2.17.1

