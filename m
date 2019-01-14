Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0BEBC43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A29E420659
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 10:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="OcGf/FTB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfANKVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 05:21:52 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55370 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726803AbfANKVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 05:21:51 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so8221654wmc.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 02:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=VetZdY4CkpnIoseIMJiUu8n+JdK4ZfAqKf1jE2X0vFM=;
        b=OcGf/FTBqUMQkD9F05ac/NUQru8v7tpBP4vbtbbKVS/UChYWbb5hB7GTgeHar/vGlK
         2c0g4PbEeuAcy+Y4+qKsBNp0HKDprBkO3MZkttoz7tfjSaTipbAZmuxRKe3zIsTw+goQ
         Nohy8SbKuperex8IV74nfYPaOA0hNbrOMjj/I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=VetZdY4CkpnIoseIMJiUu8n+JdK4ZfAqKf1jE2X0vFM=;
        b=eCzU+oQEbZNUAh041Yc9JJLLAblxdKX5dWsvXswRYSwzo/EzmGxonq8XJvt5MFK8Il
         VkjFn0ZGpH8EYC0/lKNykj6ob90/obgBSPacJ6skupoYDf3/LA1MGVfkVv8n4StRwR6+
         OB5lwtN6RaCgdNrp58L+MTKkq7bR7WwDvG9XeNaZlFf67plHhCx8XgeddixbPfgdxy5X
         aHCS6hOEAB9+rozepqA4eSkC6veBajVMWQ8vNu+xUBzHZ/RSt5bMAGmMT46TcMaqBTpI
         ZVby/Lxz0xdDVJRytgiy7bIhVEXsJupXBWShqruBg+zgr54kDKMh8xTOAzOcpyisBCcc
         oh8g==
X-Gm-Message-State: AJcUukcwMuFu1He77aKq+II22DYyuNMKxaOWq7BcBknH/oeBU+AfRpZz
        SNHio3qZLrLyfFvDCkYKSFYimpRbwa4=
X-Google-Smtp-Source: ALg8bN62n6bBdmLwVMyLNefLVcgESRJXuDGGrQCadTVvrEezHFv4ngWEmOvwkDONq0ke/HZWQ/BtBg==
X-Received: by 2002:a1c:c60e:: with SMTP id w14mr11816664wmf.18.1547461308945;
        Mon, 14 Jan 2019 02:21:48 -0800 (PST)
Received: from localhost ([49.248.81.155])
        by smtp.gmail.com with ESMTPSA id v6sm54612203wro.57.2019.01.14.02.21.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 02:21:48 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, bjorn.andersson@linaro.org,
        viresh.kumar@linaro.org, edubezval@gmail.com,
        andy.gross@linaro.org, tdas@codeaurora.org, swboyd@chromium.org,
        dianders@chromium.org, mka@chromium.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org (open list:CPU FREQUENCY DRIVERS)
Subject: [PATCH v2 5/9] cpufreq: Replace open-coded << with BIT()
Date:   Mon, 14 Jan 2019 15:51:07 +0530
Message-Id: <59ce8ef9777ab0ae3636d8d10110a7f331456ba6.1547458732.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547458732.git.amit.kucheria@linaro.org>
References: <cover.1547458732.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor clean-up to use BIT() and keep checkpatch happy. Clean-up the
comment formatting to while we're at it to make it easier to read.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 include/linux/cpufreq.h | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 0c51d5ce7350..c87989c97834 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -349,14 +349,15 @@ struct cpufreq_driver {
 };
 
 /* flags */
-#define CPUFREQ_STICKY		(1 << 0)	/* driver isn't removed even if
-						   all ->init() calls failed */
-#define CPUFREQ_CONST_LOOPS	(1 << 1)	/* loops_per_jiffy or other
-						   kernel "constants" aren't
-						   affected by frequency
-						   transitions */
-#define CPUFREQ_PM_NO_WARN	(1 << 2)	/* don't warn on suspend/resume
-						   speed mismatches */
+
+/* driver isn't removed even if all ->init() calls failed */
+#define CPUFREQ_STICKY				BIT(0)
+
+/* loops_per_jiffy or other kernel "constants" aren't affected by frequency transitions */
+#define CPUFREQ_CONST_LOOPS			BIT(1)
+
+/* don't warn on suspend/resume speed mismatches */
+#define CPUFREQ_PM_NO_WARN			BIT(2)
 
 /*
  * This should be set by platforms having multiple clock-domains, i.e.
@@ -364,14 +365,14 @@ struct cpufreq_driver {
  * be created in cpu/cpu<num>/cpufreq/ directory and so they can use the same
  * governor with different tunables for different clusters.
  */
-#define CPUFREQ_HAVE_GOVERNOR_PER_POLICY (1 << 3)
+#define CPUFREQ_HAVE_GOVERNOR_PER_POLICY	BIT(3)
 
 /*
  * Driver will do POSTCHANGE notifications from outside of their ->target()
  * routine and so must set cpufreq_driver->flags with this flag, so that core
  * can handle them specially.
  */
-#define CPUFREQ_ASYNC_NOTIFICATION  (1 << 4)
+#define CPUFREQ_ASYNC_NOTIFICATION		BIT(4)
 
 /*
  * Set by drivers which want cpufreq core to check if CPU is running at a
@@ -380,19 +381,19 @@ struct cpufreq_driver {
  * from the table. And if that fails, we will stop further boot process by
  * issuing a BUG_ON().
  */
-#define CPUFREQ_NEED_INITIAL_FREQ_CHECK	(1 << 5)
+#define CPUFREQ_NEED_INITIAL_FREQ_CHECK	BIT(5)
 
 /*
  * Set by drivers to disallow use of governors with "dynamic_switching" flag
  * set.
  */
-#define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING (1 << 6)
+#define CPUFREQ_NO_AUTO_DYNAMIC_SWITCHING	BIT(6)
 
 /*
  * Set by drivers that want the core to automatically register the cpufreq
  * driver as a thermal cooling device
  */
-#define CPUFREQ_AUTO_REGISTER_COOLING_DEV (1 << 7)
+#define CPUFREQ_AUTO_REGISTER_COOLING_DEV	BIT(7)
 
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
-- 
2.17.1

