Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB36BC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:55:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8B1F21850
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:55:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="b+0NUBHB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbeLROzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:55:37 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55541 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbeLROze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:55:34 -0500
Received: by mail-wm1-f65.google.com with SMTP id y139so2929115wmc.5
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 06:55:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s74m+Lr1EiptSBHBVzfFna+tA9cO0B3xmfsEojfvWLo=;
        b=b+0NUBHBg7fsbJjDW4sdaIepSE86T/4spu7357R8/qFfySNIgASF5b6eLW5lmMQm3v
         YmZ2jznvjymXqzbRYRtmhQoSfiSifaPzMmJuQNhtu3m2R1eOCqyO48suzvqPBIhI9KKS
         mpUIueTZZqBYJRk6NTdGJxqNowtffxhr/JIEQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s74m+Lr1EiptSBHBVzfFna+tA9cO0B3xmfsEojfvWLo=;
        b=VXYvlUCU/5Df97FM7Y3s9kqZ85nlzbdNbdYVbTafIApZmFlAUepkRxKTAYAUD+W31g
         2xAEqToBF2GjZ87KSdp+b1xiqQZsDBRMt+jMT0dlMIJD+eRpMzPXYTN24uIiXRCLh9js
         jdsOYpe8TF+FF/GINyzY5DalUCLUSna0YPo9O0wCp/VXFaAvjh76yRJN792qjNtvgVro
         tMD8uFubvFnDVljGv+9W0++3sixTEZx1MLdk/NfKUbpMQGzZV+irIL9jM+eI3xD8jAmO
         3pfnulu3RLl3m8Klcvl3mayCqay29djG3pUzPxkqADzjg5xp7pZcG+J+iTuDFiaEuoFl
         aNqQ==
X-Gm-Message-State: AA+aEWaY1dovBpjJd4+Qk2yBF1WMayI7b3fRQ+AZKJwuI1P59ce86cXd
        882emfvtNOLoI/XuIZ9gODxQRg==
X-Google-Smtp-Source: AFSGD/VbG5obJ6y3EElJe4H6iuiUTdFIAn/CLiMO7pbQolzgSzQ8bfP8WyIBcO42MityIVQc2Ogmkw==
X-Received: by 2002:a1c:ab87:: with SMTP id u129mr3536429wme.104.1545144932374;
        Tue, 18 Dec 2018 06:55:32 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:85e9:25c5:6cbd:73e9])
        by smtp.gmail.com with ESMTPSA id n20sm1579956wmi.11.2018.12.18.06.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Dec 2018 06:55:31 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [RFC v3 1/3] PM/runtime: Add a new interface to get accounted time
Date:   Tue, 18 Dec 2018 15:55:21 +0100
Message-Id: <1545144923-31546-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
References: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers (like i915/drm) need to get the accounted suspended time.
pm_runtime_accounted_time_get() will return the suspended or active
accounted time until now.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 26 ++++++++++++++++++++++++++
 include/linux/pm_runtime.h   |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 7062469..6461469 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -88,6 +88,32 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
 	dev->power.runtime_status = status;
 }
 
+u64 pm_runtime_accounted_time_get(struct device *dev, enum rpm_status status, bool update)
+{
+	u64 now = ktime_to_ns(ktime_get());
+	u64 delta = 0, time = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+
+	if (dev->power.disable_depth > 0)
+		goto unlock;
+
+	/* Add ongoing state  if requested */
+	if (update && dev->power.runtime_status == status)
+		delta = now - dev->power.accounting_timestamp;
+
+	if (status == RPM_SUSPENDED)
+		time = dev->power.suspended_time + delta;
+	else
+		time = dev->power.active_time + delta;
+
+unlock:
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	return time;
+}
+
 /**
  * pm_runtime_deactivate_timer - Deactivate given device's suspend timer.
  * @dev: Device to handle.
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 54af4ee..86f21f9 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -113,6 +113,8 @@ static inline bool pm_runtime_is_irq_safe(struct device *dev)
 	return dev->power.irq_safe;
 }
 
+extern u64 pm_runtime_accounted_time_get(struct device *dev, enum rpm_status status, bool update);
+
 #else /* !CONFIG_PM */
 
 static inline bool queue_pm_work(struct work_struct *work) { return false; }
-- 
2.7.4

