Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEFE3C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E32121720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 14:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="HWOftnI1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbeLTOQg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 09:16:36 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33288 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731305AbeLTOQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 09:16:33 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so1946185wrr.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 06:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8H/YiHauv71s0EVIedV1buJib0rVCedGsQtekdc1nA8=;
        b=HWOftnI1mbulWmgJlFO7aGeHWxAy4tAgurVqR4AzNFAaWCbHc62oW2cosYjrIZIb4X
         uSSwhJ6YoAZ6twfHq/T6FVcFdNl4nGla9mEkByn18fj9z315qL9GxtZ0kknoFjZcHJxh
         K3rj9v1SYuakV97U6Ri6wqz5ZqOd6EQWh2vbU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8H/YiHauv71s0EVIedV1buJib0rVCedGsQtekdc1nA8=;
        b=D3+eUDGS2FqtnbRL9YV+3qtCmgCXMiXVaKo/c/Vgzx8t7vGgzNrfb9kVR6+SC0DH0O
         PuRQKomR+ieAXbZNyI5A3njfJWzKkHE3xApDIbZhi5X7smTfgkZlOUDwJE3g9Tw8hEZq
         KuxZmh/OaWB4qdYpFWxSVeBq+m90py1YwEt4hPFG9roJBYNDoBrLmK/B7IPUhdEefLNs
         rfnhhA8WUtMpSuAYkDzGYOtebmxj3lJiPQJtc7BzHQJjrJUtU9eP98FurMy4jQISWOeJ
         coHXluZjbZKpU68ueVqSt+ExsVzg4jLOIXZqJ4snpBrjWgIhKe5IOrwf2Q5AnTcq+DYo
         WtwQ==
X-Gm-Message-State: AA+aEWbYnC0AI3hCCs8UNZ4zpZJ5aekIlwk8gmV0nhesWpXl9DUEAxzS
        /u5+7KPnzSOj2qArBQAS1P/BWg==
X-Google-Smtp-Source: AFSGD/V4TD2tOUeyfiPk/ZY5x1XnKKv3F8PgpZ/bjzw1x2UBkOVGRgM38l2dEU2qFclUyFk8ChWvQw==
X-Received: by 2002:adf:db01:: with SMTP id s1mr22055723wri.214.1545315391844;
        Thu, 20 Dec 2018 06:16:31 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:f9b3:37c1:b11a:64ce])
        by smtp.gmail.com with ESMTPSA id 127sm2313218wmm.45.2018.12.20.06.16.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Dec 2018 06:16:30 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v4 1/3] PM/runtime: Add a new interface to get accounted time
Date:   Thu, 20 Dec 2018 15:16:23 +0100
Message-Id: <1545315385-14384-2-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545315385-14384-1-git-send-email-vincent.guittot@linaro.org>
References: <1545315385-14384-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers (like i915/drm) needs to get the accounted suspended time.
pm_runtime_suspended_time() will return the suspended accounted time
in ns unit.

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

