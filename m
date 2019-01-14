Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44F37C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0DE2C206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 16:37:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YGUVocul"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbfANQhL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 11:37:11 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38748 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726732AbfANQhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 11:37:09 -0500
Received: by mail-wm1-f68.google.com with SMTP id m22so207256wml.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jan 2019 08:37:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=l9DFr+fvRp4XNuqC48f1qHOGOAXrzlsaBjEr2TKjUhQ=;
        b=YGUVoculVhQysuFRCsbNQIiuVYcvjY66Xe4LX7+xPF4IZ0rwm+fSRC1vVJOXzj2Uvb
         f+U8eciraYxPS23uQq3cV+ESE8UN/YkgMGzPPe2JLu+IVaU3VADFmzv8VnRv2LsO3G52
         JdjSynt3qW7rv7JphYeUlgzo3OwuufWD8DXdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=l9DFr+fvRp4XNuqC48f1qHOGOAXrzlsaBjEr2TKjUhQ=;
        b=k6lTC/RHTqkVbnS67KFTrOV7Dlt64528dmsUV7/fsERX8BuONVJN/VtfsGqtSOm1jU
         8UI1G6OjShwr+A5iCwqYGEFJsegP/+4iYdnhjJHSuRHtPU5BRlj7ypsEiTFgb0MCBj7v
         WZY65H0EcB3JbVB5Pu5jWCgQy4bLtVr2EBc+/Lz+9jMRPRZvgMsegAAqJ+aMUkoRUAKI
         EVmEMcojb3huJI8r0s+HFMR8t/tZAb1YUgggAX8+MO37Fw5FoAPnDtxGtDMZofJnXWvm
         rAvQdR1oJYy/DTY8Nxwqwsi/TuiiWJ5YL06bnswrQ/Qzw0Sq6Rgmwg6PuJfnfflnPRt9
         S++Q==
X-Gm-Message-State: AJcUukekC5Tw8CwqrBOxUeo+yZbpjR63CI0ajHUKxWdAsgLUHVo1qrWH
        wkgJ0Tydzhq6W3X1nJXWWWGtt9as1AI4iA==
X-Google-Smtp-Source: ALg8bN4Y9ioFVy8dEaarjhl4GkipP/ZCwRKGycgXeMtMxW5pnAtZ+oaYeaJD+QHvp59iNKq8X3kuGw==
X-Received: by 2002:a1c:400b:: with SMTP id n11mr12940185wma.85.1547483826284;
        Mon, 14 Jan 2019 08:37:06 -0800 (PST)
Received: from localhost ([49.248.190.171])
        by smtp.gmail.com with ESMTPSA id h16sm152392640wrb.62.2019.01.14.08.37.04
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 08:37:05 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        edubezval@gmail.com, swboyd@chromium.org, dianders@chromium.org,
        mka@chromium.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: [PATCH v1 03/10] cpufreq: Replace open-coded << with BIT()
Date:   Mon, 14 Jan 2019 22:04:55 +0530
Message-Id: <e1984eedda04ca44a44b4972708855702f5d91e4.1547481320.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
In-Reply-To: <cover.1547481320.git.amit.kucheria@linaro.org>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor clean-up to use BIT() and keep checkpatch happy. Clean up the
comment formatting while we're at it to make it easier to read.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
---
 include/linux/cpufreq.h | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 70ad02088825..ea303dfd5f05 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -351,14 +351,15 @@ struct cpufreq_driver {
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
@@ -366,14 +367,14 @@ struct cpufreq_driver {
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
@@ -382,19 +383,19 @@ struct cpufreq_driver {
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

