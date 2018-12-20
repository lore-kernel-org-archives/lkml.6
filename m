Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2443C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C12C521720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:17:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b9k/Hf8k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387524AbeLTORF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:17:05 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51981 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733182AbeLTORE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:17:04 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so2229751wmj.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 06:17:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=dl0vWZ2OmuLRkr6rXUIz7t6LbyxfogMj8WkEhaEhsA0=;
        b=b9k/Hf8kAni+gkKuoX2ym92n5HEjdT1XxxzZEnhXqz4HBR/UWmLNTNR65gknoyaiPS
         KQ7vdCJft5lHDbGZMc+hB1IcrMbr5rLQAhONL4CdHHRRF12Qfd0KfbnEFPOhHum+QSRf
         IXsUzEhArcfQkxTl9/q008nk/WHsIa0GS6ciY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dl0vWZ2OmuLRkr6rXUIz7t6LbyxfogMj8WkEhaEhsA0=;
        b=ki6tgWITZVhHHmtJC4h1tV6hSHI58dbxBG3SAj2qyVFYZqEhZ3sfaz0OMIqPdUNIwv
         +qQcf1ovqD2P2kSxIuNGDE7v1Ub19kANNpz0rWwCoagm1YtZA0tdqMfmLrkhSgEnLMF0
         IAj1EznbJ1qoDc1X0FU/saWN7N9WoqSuwcVpQ0rgSec00xAE7pUrwGFzlprGs2jLhtq0
         cAZXpd+n1lJu/QWzQkxNg89bbYduUslsoGoDjL3NJ4I2LewjgFgyTG0AkFBPNXH/VMjr
         zKhZtnu1yZHlHlrRhhQecgoJv2KGPxRjv12lLkIhm2raBB4yQSXPzg3cvMJ8oGQ/mpP4
         mvNw==
X-Gm-Message-State: AA+aEWaozV3F6F6fFGt3K8ls8uqELhcitHX+qyS2UIHGBul+93DHIS8h
        Amf+AnmXyBdr1+KsI76tnAZPmQ==
X-Google-Smtp-Source: AFSGD/UNrjs/0zRvq0PN+NwLus3oyFp12NHZqRJ3E0lyn8bH8ARB6+LrmxNY9dWK2HJNuuvGzxKNpw==
X-Received: by 2002:a1c:128b:: with SMTP id 133mr12239546wms.22.1545315421678;
        Thu, 20 Dec 2018 06:17:01 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:f9b3:37c1:b11a:64ce])
        by smtp.gmail.com with ESMTPSA id v132sm7855024wme.20.2018.12.20.06.17.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 06:17:00 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 2/3] drm/i915: Move on the new pm runtime interface
Date:   Thu, 20 Dec 2018 15:16:57 +0100
Message-Id: <1545315417-14483-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new pm runtime interface to get the accounted suspended time:
pm_runtime_accounted_time_get()

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/gpu/drm/i915/i915_pmu.c | 16 ++++++----------
 drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index d6c8f8f..3f76f60 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/irq.h>
+#include <linux/pm_runtime.h>
 #include "i915_pmu.h"
 #include "intel_ringbuffer.h"
 #include "i915_drv.h"
@@ -478,7 +479,6 @@ static u64 get_rc6(struct drm_i915_private *i915)
 		 * counter value.
 		 */
 		spin_lock_irqsave(&i915->pmu.lock, flags);
-		spin_lock(&kdev->power.lock);
 
 		/*
 		 * After the above branch intel_runtime_pm_get_if_in_use failed
@@ -491,16 +491,13 @@ static u64 get_rc6(struct drm_i915_private *i915)
 		 * suspended and if not we cannot do better than report the last
 		 * known RC6 value.
 		 */
-		if (kdev->power.runtime_status == RPM_SUSPENDED) {
-			if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
-				i915->pmu.suspended_jiffies_last =
-						  kdev->power.suspended_jiffies;
+		if (pm_runtime_status_suspended(kdev)) {
+			val = pm_runtime_suspended_time(kdev);
 
-			val = kdev->power.suspended_jiffies -
-			      i915->pmu.suspended_jiffies_last;
-			val += jiffies - kdev->power.accounting_timestamp;
+			if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
+				i915->pmu.suspended_time_last = val;
 
-			val = jiffies_to_nsecs(val);
+			val -= i915->pmu.suspended_time_last;
 			val += i915->pmu.sample[__I915_SAMPLE_RC6].cur;
 
 			i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = val;
@@ -510,7 +507,6 @@ static u64 get_rc6(struct drm_i915_private *i915)
 			val = i915->pmu.sample[__I915_SAMPLE_RC6].cur;
 		}
 
-		spin_unlock(&kdev->power.lock);
 		spin_unlock_irqrestore(&i915->pmu.lock, flags);
 	}
 
diff --git a/drivers/gpu/drm/i915/i915_pmu.h b/drivers/gpu/drm/i915/i915_pmu.h
index 7f164ca..3dc2a30 100644
--- a/drivers/gpu/drm/i915/i915_pmu.h
+++ b/drivers/gpu/drm/i915/i915_pmu.h
@@ -95,9 +95,9 @@ struct i915_pmu {
 	 */
 	struct i915_pmu_sample sample[__I915_NUM_PMU_SAMPLERS];
 	/**
-	 * @suspended_jiffies_last: Cached suspend time from PM core.
+	 * @suspended_time_last: Cached suspend time from PM core.
 	 */
-	unsigned long suspended_jiffies_last;
+	u64 suspended_time_last;
 	/**
 	 * @i915_attr: Memory block holding device attributes.
 	 */
-- 
2.7.4

