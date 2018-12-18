Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81731C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BEA1218A5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcmFxoVW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbeLROzm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:55:42 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50429 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726664AbeLROzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:55:37 -0500
Received: by mail-wm1-f66.google.com with SMTP id n190so2978280wmd.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 06:55:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NjMh1hlHnaU/XWOpjKkttorbhNkixdC3H52jnc/A7+E=;
        b=jcmFxoVWCkT1rXUrzn8599cUiFQ6td+R2XheLYPnKmboKxVYTulP1VrUyIhoVGpTuU
         38dBbP/4Nb72UBugkBCjG5xnnXFEbH7e8e5/f7HszVOPAbXk2zGR5w/En6qACAOVDx4g
         6eUl9U8DHRiqGurcYUGHKJsTPd+JAASXBqZMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NjMh1hlHnaU/XWOpjKkttorbhNkixdC3H52jnc/A7+E=;
        b=oYseG8+oDTMFV3lcQdKCSsdlhJhMNJzI9xLu6KEgqRulmAh1R95qfIif3cCtK7A3PN
         HagEFdI7JnHPoG6u7qEURnznWjlR92Q/j90XoeSsMVTQCCfDkowT0v0PFn5GkJthGCsU
         w3E5PTd6ZA5cq6FHTxx2hMVVJfx7Xt6p+D0zCz+tGYXLMGPq4/uU9P0svj/AFOtx2buZ
         VF+csDp8O4C3U5m4dA4GCGKa1+bo/DrHA4LOG/7rmGObueMf+HrwnW9yG9Sk7jzlGIp9
         6hr4s7jHED3CRLkhPvVRgRUCj8zWejHWIj75qauTdLYMJU09aiRgbM7lNG07h6xs1xhH
         FV/Q==
X-Gm-Message-State: AA+aEWYvYH/19c5qbPYV6bZUXdAssXUMFihvETL11c80S8rLt9K7467y
        8I3TV8q0omJdN74RUk9BK6zVhw==
X-Google-Smtp-Source: AFSGD/WNpwn5+jNvUuKx5vDfrF+erj92+2KCxrVEekLfnOrXoUH0xGsG5gZvUsTIIYqQXIeMh1T1UA==
X-Received: by 2002:a1c:c008:: with SMTP id q8mr3208517wmf.99.1545144934224;
        Tue, 18 Dec 2018 06:55:34 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:85e9:25c5:6cbd:73e9])
        by smtp.gmail.com with ESMTPSA id n20sm1579956wmi.11.2018.12.18.06.55.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Dec 2018 06:55:33 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RFC 2/3] drm/i915: Move on the new pm runtime interface
Date:   Tue, 18 Dec 2018 15:55:22 +0100
Message-Id: <1545144923-31546-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
References: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new pm runtime interface to get the accounted suspended time:
pm_runtime_accounted_time_get()

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/gpu/drm/i915/i915_pmu.c | 18 ++++++++----------
 drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index d6c8f8f..ebc49ea 100644
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
@@ -491,16 +491,15 @@ static u64 get_rc6(struct drm_i915_private *i915)
 		 * suspended and if not we cannot do better than report the last
 		 * known RC6 value.
 		 */
-		if (kdev->power.runtime_status == RPM_SUSPENDED) {
+		val = pm_runtime_accounted_time_get(kdev, RPM_SUSPENDED, true);
+		if (pm_runtime_status_suspended(kdev)) {
 			if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
-				i915->pmu.suspended_jiffies_last =
-						  kdev->power.suspended_jiffies;
+				i915->pmu.suspended_time_last =
+					pm_runtime_accounted_time_get(kdev,
+								      RPM_SUSPENDED,
+								      false);
 
-			val = kdev->power.suspended_jiffies -
-			      i915->pmu.suspended_jiffies_last;
-			val += jiffies - kdev->power.accounting_timestamp;
-
-			val = jiffies_to_nsecs(val);
+			val -= i915->pmu.suspended_time_last;
 			val += i915->pmu.sample[__I915_SAMPLE_RC6].cur;
 
 			i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = val;
@@ -510,7 +509,6 @@ static u64 get_rc6(struct drm_i915_private *i915)
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

