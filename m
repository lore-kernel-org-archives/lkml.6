Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D76C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10B5120659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZfPUQzxz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfANKVn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:21:43 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44650 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726765AbfANKVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:21:39 -0500
Received: by mail-wr1-f66.google.com with SMTP id z5so22121302wrt.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=EJX+dwJGPWWCAq/U7Rxqn4mqzkt0rkUgh6ol6e18W2g=;
        b=ZfPUQzxziYUzsb8yM368ueLuq8ISb7GvH6YdC9XIQEtutmz5I41/tI3dFA5e2RwFc7
         GYkI7+V9hD0yfBKSpI6lHiq4ZPxwtBDFQ8TDBBXW9ENe9G1yDPZ5uLMzW3jDWSP2sK6Z
         uP0Djba+mAuFnqCUqls4txjXp6QmOcpCWPogk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=EJX+dwJGPWWCAq/U7Rxqn4mqzkt0rkUgh6ol6e18W2g=;
        b=hf+/niGx6BCBFnHQzbzHnssYO9QW4Q4x+p7hd2FxVBHnRhWZVemFT+/vva2FT77IDJ
         nsm7i+f20dzE5t3p/x+vvLhgwswSEIPO5kea9i9QeS0gP4E0EzT9zHL4IWKdIyJeoUbb
         xThMN897/3Iy2KAacFJG8upvRHusXiroPNvisPvYkVR8jENlcXkp7bndTKon33kBPHO9
         mrm5H0OofLgeX1sjjL6ZCbmX/MCsGu0LHVPwAvuXJwMA8Z6gIu082imwzVj79kJeH1OT
         /WiLEUH/wUxbdazlWqI8ywXyLsIOuNbEAFjLskYb/X3L884TLVg6KvzCuQucyfzr/gyn
         rWeQ==
X-Gm-Message-State: AJcUukfyYP9sDZrf61tRVvHyNKB8YMECnb3G9/PlgJnDdPh7eYSfSiN2
        0bXg5dIvl38aIgbe8wUn4+ziaEPSCrY=
X-Google-Smtp-Source: ALg8bN5muGx9Q25Onqti2STyxOsGR+BffokPLDhaTgWX1gTbVMyO9l37Hg5dRFAFqdVb0tLNjo/sFw==
X-Received: by 2002:adf:de91:: with SMTP id w17mr25144412wrl.320.1547461297218;
        Mon, 14 Jan 2019 02:21:37 -0800 (PST)
Received: from localhost ([49.248.81.155])
        by smtp.gmail.com with ESMTPSA id a1sm63729951wrw.76.2019.01.14.02.21.35
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 02:21:36 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY DRIVERS)
Subject: [PATCH v2 3/9] drivers: cpufreq: Add thermal_cooling_device pointer to struct cpufreq_policy
Date:   Mon, 14 Jan 2019 15:51:05 +0530
Message-Id: <bbc4cccbe2931de5f7e07b70a4873624424ac930.1547458732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several cpufreq drivers register themselves as thermal cooling devices.
Adding a pointer to struct cpufreq_policy removes the need for them to
store this pointer in a private data structure.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 include/linux/cpufreq.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c86d6d8bdfed..9fbc1d996967 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -95,6 +95,9 @@ struct cpufreq_policy {
 	struct cpufreq_frequency_table	*freq_table;
 	enum cpufreq_table_sorting freq_table_sorted;
 
+	/* Pointer to the cooling device if used for thermal mitigation */
+	struct thermal_cooling_device *cooldev;
+
 	struct list_head        policy_list;
 	struct kobject		kobj;
 	struct completion	kobj_unregister;
-- 
2.17.1

