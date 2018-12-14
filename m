Return-Path: <SRS0=kF4g=OX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CE1FC43387
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:22:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8475E20643
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="QAn73MFm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730187AbeLNOWk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Dec 2018 09:22:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42403 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730106AbeLNOWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Dec 2018 09:22:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id q18so5603114wrx.9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Dec 2018 06:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B6KKzqZhmrvKOYN6ED9mcoMzLhzOfCHFL8+e2184smI=;
        b=QAn73MFmuHG4n98+SxXjRKozG3XQEUTCGn4Gx1561auPX0rE8IJuZY6oS91pvwm7ty
         s61NzVuF/ZDdW5aIwoWpD5Xcqkb7OYmo9j8YkoG8D9ffz9bH+u2QkoLHvkXwPxfthg5b
         QmSx5GDwPYHtOIjIWOuPA6WA0BHjScKkuY8OM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=B6KKzqZhmrvKOYN6ED9mcoMzLhzOfCHFL8+e2184smI=;
        b=Tr5jgheqapJHIvMlyrLOKzHslgdIYfbfgrA2XgJ3A970xVta38n9RztSrEba4aibIl
         SUh3hpe9vPkq7CItlesfVlmWdz13fQcasw6yYuTKiX6B8zzz4ddYu6Fs0k2Cz6LtctCO
         C/75kESLMuzVEvyeimoy4COoYn6EJw0qQ2ds3eGoFOvdpLMeOlYb9QYi1491Rw0ru2DW
         kBTuaranVGs3zI7gLKcDmDhJolTc+ZSaLufC6RRvk2VqcazNXPeyCr3k5a4KFyp7CFsZ
         rfIy4BYOXLPir8Rfkxz//aHyioG28ZOIldD7gnBN2GMPpJAybBK4waI/Me3XGj5GhjVX
         3D1w==
X-Gm-Message-State: AA+aEWb5TtHJpDUt1RqSZqsZTV4oaBgcZVSK53FgSava72NSke30jPON
        dIQ6BzEs6ybEvbwCEQ/hwOJ/mg==
X-Google-Smtp-Source: AFSGD/UqxrZoOHYqy0eFlkd+RGzUaYthK6wcqifIVgODMwqns32SoTW73Iv4mc8UNO8gSdQ9dPJ+eA==
X-Received: by 2002:adf:f785:: with SMTP id q5mr2982881wrp.9.1544797354960;
        Fri, 14 Dec 2018 06:22:34 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ed2e:a6ad:f6ef:ff8e])
        by smtp.gmail.com with ESMTPSA id m4sm25793829wmi.3.2018.12.14.06.22.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 14 Dec 2018 06:22:34 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2 3/3] drm/i915: Move to new PM core fields
Date:   Fri, 14 Dec 2018 15:22:27 +0100
Message-Id: <1544797347-20601-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org>
References: <1544797347-20601-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With jiffies been replaced by raw ns in PM core accounting, 915 driver is
updated to use this new time infrastructure.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/gpu/drm/i915/i915_pmu.c | 12 ++++++------
 drivers/gpu/drm/i915/i915_pmu.h |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/i915/i915_pmu.c b/drivers/gpu/drm/i915/i915_pmu.c
index d6c8f8f..cf6437d 100644
--- a/drivers/gpu/drm/i915/i915_pmu.c
+++ b/drivers/gpu/drm/i915/i915_pmu.c
@@ -493,14 +493,14 @@ static u64 get_rc6(struct drm_i915_private *i915)
 		 */
 		if (kdev->power.runtime_status == RPM_SUSPENDED) {
 			if (!i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur)
-				i915->pmu.suspended_jiffies_last =
-						  kdev->power.suspended_jiffies;
+				i915->pmu.suspended_time_last =
+					kdev->power.suspended_time;
 
-			val = kdev->power.suspended_jiffies -
-			      i915->pmu.suspended_jiffies_last;
-			val += jiffies - kdev->power.accounting_timestamp;
+			val = kdev->power.suspended_time -
+				i915->pmu.suspended_time_last;
+			val += ktime_to_ns(ktime_get()) -
+				kdev->power.accounting_timestamp;
 
-			val = jiffies_to_nsecs(val);
 			val += i915->pmu.sample[__I915_SAMPLE_RC6].cur;
 
 			i915->pmu.sample[__I915_SAMPLE_RC6_ESTIMATED].cur = val;
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

