Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB9DC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:34:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FCB9218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:34:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="MIDo50OU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389815AbeLUKeL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:34:11 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:32869 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389727AbeLUKeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:34:07 -0500
Received: by mail-wr1-f68.google.com with SMTP id c14so4708381wrr.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vhYWlU36PKEBPCWfg+y/jovhINShmKXiUFstQKgZjEM=;
        b=MIDo50OUD6EVgxLArZ7ef4EB8Ao67bD0d2dLb9z9AhHaovP48bbnR4JIC/ORMmFuH/
         RwHpphTGoOeZIX5rqtzH8UesZ/lVyXzxveT78VNx7urODpWwcVM9IOmry7c/xizCZKNg
         rQViwv3I+inpsqq9xmGU0wMiLpcmrYSj6U7EM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vhYWlU36PKEBPCWfg+y/jovhINShmKXiUFstQKgZjEM=;
        b=biuQC2gBYRh7fPJ7kKNWayOT5rQcBhKZYiBNn37EVDSq4ovU9Ef2l2QTXXpG1eKzxJ
         d+ifIkdanbGR8t1nf16WNAMDlTpF34TYg4A1WyL/z4VxL2y5qJ35NhDXQI0JZPUl+YkS
         8IHaJ4s+FPf7iqtdvQKQ3zlp7CErdKRBKn/PMuQsas/VP/GKr9LCajQL2264pDS5XjMZ
         Q2PaVSqE5kC6So6BGbcI4ia+FEIIN10FaZv7/cjuwNbqRuv/gGEQeXG8fx5ZMM7mJGys
         kxu/qB7owtjLSpTj8Xw6/+zsyaYcR8siHftqxgR7rYcQ++GKhFw8cBccwcLj2muCBx+e
         hMPw==
X-Gm-Message-State: AJcUukfGY9Xip/jprBAw8xjp/iuSTnfxwvYjW44DHebGMJymE1aExHcn
        9tRJJSxCMWHLoUC/PxLUL9EKDg==
X-Google-Smtp-Source: ALg8bN4rkuE9s4ovYN0PMaQ4hUXlMXfh/Z75T+PscgGWnGvSru5l7X8CPIksEEVTtl3LNVBIWgchsw==
X-Received: by 2002:adf:ee46:: with SMTP id w6mr2034596wro.261.1545388445505;
        Fri, 21 Dec 2018 02:34:05 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ac05:2372:f02d:b03f])
        by smtp.gmail.com with ESMTPSA id h10sm10573685wmf.44.2018.12.21.02.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Dec 2018 02:34:04 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 2/3] drm/i915: Move on the new pm runtime interface
Date:   Fri, 21 Dec 2018 11:33:55 +0100
Message-Id: <1545388436-7489-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the new pm runtime interface to get the accounted suspended time:
pm_runtime_suspended_time().
This new interface helps to simplify and cleanup the code that computes
__I915_SAMPLE_RC6_ESTIMATED and to remove direct access to internals of
PM runtime.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
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

