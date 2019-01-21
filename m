Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D44C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34C2320861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 08:48:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="ijcBVtI5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfAUIsI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 03:48:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35658 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729360AbfAUIsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 03:48:07 -0500
Received: by mail-wm1-f67.google.com with SMTP id t200so9939143wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jan 2019 00:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=oNAEuic8TN2JCwvO+MVhFf5QRjvhdSap6qMFsy8Im+g=;
        b=ijcBVtI5Mvbtoi8VWwc4u26mjMgDm6dGdbKnvtNRDG6qhgGzQSl0t27azpCpUaAohE
         OTKWzMf0O61ZH5W0KBaNyTrQCKGg9DGs3jss9xS01ZvrHf8szU+EDzpgPZYfUBckUXWl
         U2dxKZByRW3NomQHXHLGg2fj/zie1/wNLWENY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=oNAEuic8TN2JCwvO+MVhFf5QRjvhdSap6qMFsy8Im+g=;
        b=euKNfYCdXNaY5O+/lYYA577tK7BtJDFq4uATh6Zf0/CIbl63o5pN6IP0mqHwJ4a9oU
         2u1IlcKJxX5wQ2d9onl74Qwi94ujT/4WIkkt+mIJEucPfvTumMHiyjf6OU5osrJWmAkK
         /bx7teLL/Ey7K7aSpdSMAmYmVFkuC4qly+GPn5OLSuirxKazKLYhEG60Py2a0b6NA4sO
         b1Wo8JVs8qkzSp8KXXNG7T+qvQOUXke3Sf8P6Aew2R4ttyR9brhIO4rrn59OlhFg65O8
         GU7HWfxpxdPuHp9kte5avlvheUK8kFnFWp0aD8pxrGn2EMoN66raXiqNRb1oXtU71hRF
         g47g==
X-Gm-Message-State: AJcUukfTPDAQihLH12uVDgQDeVu/IrOjzXMlG9cEkJut5AWjPTkbFjdp
        gJpngzOnQ44a0IKMtoLdSQWf6RVaLLU=
X-Google-Smtp-Source: ALg8bN5SQhDA44ig/6S6drHt3wH2vTVbxwD4KXdqiQLwIZKDo9XI10lnB4hKpIBl6/MC4LZgmDIrpQ==
X-Received: by 2002:a1c:2501:: with SMTP id l1mr24878582wml.102.1548060485508;
        Mon, 21 Jan 2019 00:48:05 -0800 (PST)
Received: from localhost ([114.143.52.189])
        by smtp.gmail.com with ESMTPSA id d16sm73763366wru.52.2019.01.21.00.48.02
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Jan 2019 00:48:04 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-msm@vger.kernel.org, viresh.kumar@linaro.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: [PATCH] cpufreq: Replace open-coded << with BIT()
Date:   Mon, 21 Jan 2019 14:17:37 +0530
Message-Id: <2501c48872e5fa9c26f06216c19955d70b263a85.1548060067.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Minor clean-up to use BIT() and keep checkpatch happy. Clean up the
comment formatting while we're at it to make it easier to read.

Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 include/linux/cpufreq.h | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index c86d6d8bdfed..bd7fbd6a4478 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -346,14 +346,15 @@ struct cpufreq_driver {
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
@@ -361,14 +362,14 @@ struct cpufreq_driver {
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
@@ -377,13 +378,13 @@ struct cpufreq_driver {
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
 
 int cpufreq_register_driver(struct cpufreq_driver *driver_data);
 int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
-- 
2.17.1

