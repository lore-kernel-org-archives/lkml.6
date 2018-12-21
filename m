Return-Path: <SRS0=OLKc=O6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E652C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:34:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0687218FD
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Dec 2018 10:34:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="GAu74PYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389776AbeLUKeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Dec 2018 05:34:10 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36223 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389752AbeLUKeG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Dec 2018 05:34:06 -0500
Received: by mail-wr1-f67.google.com with SMTP id u4so4696510wrp.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Dec 2018 02:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ep7ki1gNWA79DVfUoUUmYu7v+nAqJfeGtUHFVJPz20Y=;
        b=GAu74PYLxL+6Wick3OFJyKDb6jXq0x9p1nEHjZ89VkLqLt/h4NnaIKBpLkulbyVGl3
         p+9hX8vOzUoAi5UV70k4Hl46Mv7aoAPMJHLb0HehV0gUAJ+qqTJPFIeTv9HLWUmIRv63
         3ZR+8RewAJEgcwFWwDaKD+xh66Bkbyl8jC7v4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ep7ki1gNWA79DVfUoUUmYu7v+nAqJfeGtUHFVJPz20Y=;
        b=jIN8GgxbvDlmk0iGpqCdbPLqYymsj5uSWmrAx3JSLYZgzNUyZJpmxPo/8Q/w4+BOss
         sG8OvCf3e99bI5261TWiu4Le6l9CkMg3qt2ll4ryEw42+9VtpFjaaoD12nsaJyg9XD0M
         5HrKmtLQ1nTG8DOhTfKEVgioD37KvDmeIWVUqOWSo7w45YnLd1suP5+yCL+ffydugRlP
         9V9dFWI6TIuhDabZIUFbL4iKtDNT0vg5clXDeDo2TvTKw0h66WeEPrSc78IYzf/wlBM7
         BC3GmUMcN1C+xjj/cqlN+XN/y3Kuczr06jRsYjrVl8gju5KHA5kmfVtwwbvaXBBlzTm+
         9VUw==
X-Gm-Message-State: AJcUukfb7zEgEBLZjt0iO/4oFdJx073V1AhYG1u0uVSJJc63n0O2nClu
        MyFCJ2C3RcKD4zWBtffL0/WJ0Q==
X-Google-Smtp-Source: ALg8bN4wjkJW3YmjRm7yuLqlqUPIK2Y/fHiGy1wakXSLaRrbSjXoVQZEO/6eTCscAFtVLPpsgClsmg==
X-Received: by 2002:a5d:528e:: with SMTP id c14mr1974240wrv.236.1545388444380;
        Fri, 21 Dec 2018 02:34:04 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:ac05:2372:f02d:b03f])
        by smtp.gmail.com with ESMTPSA id h10sm10573685wmf.44.2018.12.21.02.34.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Dec 2018 02:34:03 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v5 1/3] PM/runtime: Add a new interface to get accounted time
Date:   Fri, 21 Dec 2018 11:33:54 +0100
Message-Id: <1545388436-7489-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
References: <1545388436-7489-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers (like i915/drm) needs to get the accounted suspended time.
pm_runtime_suspended_time() will return the suspended accounted time
in ns unit.

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 16 ++++++++++++++++
 include/linux/pm_runtime.h   |  2 ++
 2 files changed, 18 insertions(+)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index beb85c3..e695544 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -86,6 +86,22 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
 	dev->power.runtime_status = status;
 }
 
+u64 pm_runtime_suspended_time(struct device *dev)
+{
+	unsigned long flags, time;
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+
+	update_pm_runtime_accounting(dev);
+
+	time = dev->power.suspended_jiffies;
+
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	return jiffies_to_nsecs(time);
+}
+EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
+
 /**
  * pm_runtime_deactivate_timer - Deactivate given device's suspend timer.
  * @dev: Device to handle.
diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index f0fc470..d479707 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -113,6 +113,8 @@ static inline bool pm_runtime_is_irq_safe(struct device *dev)
 	return dev->power.irq_safe;
 }
 
+extern u64 pm_runtime_suspended_time(struct device *dev);
+
 #else /* !CONFIG_PM */
 
 static inline bool queue_pm_work(struct work_struct *work) { return false; }
-- 
2.7.4

