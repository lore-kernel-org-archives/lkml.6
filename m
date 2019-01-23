Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23FB3C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:50:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D93AC20870
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 07:50:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYGSQgOg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727057AbfAWHu3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 02:50:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40775 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfAWHuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 02:50:23 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so1186607wrt.7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 23:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6Uzfk3h9kJFsyoYLbkQfF/tuQMo4t3cWJwQxIwIcjck=;
        b=gYGSQgOgDb8NH7SMn/o6ov8ebwNQuRJGmIp7u6RfAwfYziW3ojqTYpYB5wkLSjeZup
         Y1AVm0w7xvHLOzMPVHfRXu/DeBg/p/dsPv+5R6UmXFFe2KaWonCWOEkMBjrA9Q2nYY5X
         l/1Adjon//t7gLiga9xzdDfsYYaybIR9BPcgA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6Uzfk3h9kJFsyoYLbkQfF/tuQMo4t3cWJwQxIwIcjck=;
        b=podAjuBAHIqm3S7Tn2ZQ97I1RNGkzvVUNkzc1Np25sUvGm9Tq+3mCgxNKMUHX9M5hb
         d1jakgc9n53LGfDszFCh+/fAtwmzxvuSChcJ9znax27kKia8hhbBCjE+AGF8occEmMGK
         5iq2IKzexMZpLauJAwfhPCCtECRYZedIIdC0u9bNZawiRAXzILns82fu7sCDbFUxxXUP
         5ZjyZN0B4ojAkuEGVr2kqpe+dRAU3LQHuHN+Jc6DSmE/bn2DdxAmm/nCY1nJ0HA/Vm5l
         F9L6hHU3V3twcsL6fsmEpAkbxKYOiV/7oURAYK1tSRy3ZrBqb69dMqh5lvYL/wrNh7B1
         DqoA==
X-Gm-Message-State: AJcUukdiSbWp1gy6UAGnMOUjikNRFr60ChDe/TDqVoiR2ZxtRuAYUgun
        9VWxfG6Jf7ZouDsotGELCh9S7A==
X-Google-Smtp-Source: ALg8bN7Kd3EMuPn3o0RslF2EiwwGm3O/TrZQ/x9EBYWs9l5VwHkxRegpWdV91TUgpm2FhT+Vmo2TJw==
X-Received: by 2002:a5d:480d:: with SMTP id l13mr1470005wrq.175.1548229821253;
        Tue, 22 Jan 2019 23:50:21 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:5ca6:2921:648b:56b6])
        by smtp.gmail.com with ESMTPSA id i186sm70138787wmd.19.2019.01.22.23.50.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Jan 2019 23:50:20 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org, linux@roeck-us.net
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v7 2/2] PM-runtime: Replace jiffies based accounting with ktime-based accounting
Date:   Wed, 23 Jan 2019 08:50:14 +0100
Message-Id: <1548229814-24913-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548229814-24913-1-git-send-email-vincent.guittot@linaro.org>
References: <1548229814-24913-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thara Gopinath <thara.gopinath@linaro.org>

This patch replaces jiffies based accounting for runtime_active_time
and runtime_suspended_time with ktime-based accounting. This makes the
runtime debug counters inline with genpd and other PM subsytems which
use ktime-based accounting.

Timekeeping is initialized before driver_init(). It's only at that time
that PM runtime can be enabled.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
[switch from ktime to raw nsec]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 17 +++++++++--------
 drivers/base/power/sysfs.c   | 11 ++++++++---
 include/linux/pm.h           |  6 +++---
 3 files changed, 20 insertions(+), 14 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index eccd37f1..e9dae6d7 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -66,8 +66,8 @@ static int rpm_suspend(struct device *dev, int rpmflags);
  */
 void update_pm_runtime_accounting(struct device *dev)
 {
-	unsigned long now = jiffies;
-	unsigned long delta;
+	u64 now = ktime_to_ns(ktime_get());
+	u64 delta;
 
 	delta = now - dev->power.accounting_timestamp;
 
@@ -77,9 +77,9 @@ void update_pm_runtime_accounting(struct device *dev)
 		return;
 
 	if (dev->power.runtime_status == RPM_SUSPENDED)
-		dev->power.suspended_jiffies += delta;
+		dev->power.suspended_time += delta;
 	else
-		dev->power.active_jiffies += delta;
+		dev->power.active_time += delta;
 }
 
 static void __update_runtime_status(struct device *dev, enum rpm_status status)
@@ -90,16 +90,17 @@ static void __update_runtime_status(struct device *dev, enum rpm_status status)
 
 u64 pm_runtime_suspended_time(struct device *dev)
 {
-	unsigned long flags, time;
+	u64 time;
+	unsigned long flags;
 
 	spin_lock_irqsave(&dev->power.lock, flags);
 
 	update_pm_runtime_accounting(dev);
-	time = dev->power.suspended_jiffies;
+	time = dev->power.suspended_time;
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
 
-	return jiffies_to_nsecs(time);
+	return time;
 }
 EXPORT_SYMBOL_GPL(pm_runtime_suspended_time);
 
@@ -1311,7 +1312,7 @@ void pm_runtime_enable(struct device *dev)
 
 		/* About to enable runtime pm, set accounting_timestamp to now */
 		if (!dev->power.disable_depth)
-			dev->power.accounting_timestamp = jiffies;
+			dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
 	} else {
 		dev_warn(dev, "Unbalanced %s!\n", __func__);
 	}
diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
index d713738..96c8a22 100644
--- a/drivers/base/power/sysfs.c
+++ b/drivers/base/power/sysfs.c
@@ -125,9 +125,12 @@ static ssize_t runtime_active_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int ret;
+	u64 tmp;
 	spin_lock_irq(&dev->power.lock);
 	update_pm_runtime_accounting(dev);
-	ret = sprintf(buf, "%i\n", jiffies_to_msecs(dev->power.active_jiffies));
+	tmp = dev->power.active_time;
+	do_div(tmp, NSEC_PER_MSEC);
+	ret = sprintf(buf, "%llu\n", tmp);
 	spin_unlock_irq(&dev->power.lock);
 	return ret;
 }
@@ -138,10 +141,12 @@ static ssize_t runtime_suspended_time_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	int ret;
+	u64 tmp;
 	spin_lock_irq(&dev->power.lock);
 	update_pm_runtime_accounting(dev);
-	ret = sprintf(buf, "%i\n",
-		jiffies_to_msecs(dev->power.suspended_jiffies));
+	tmp = dev->power.suspended_time;
+	do_div(tmp, NSEC_PER_MSEC);
+	ret = sprintf(buf, "%llu\n", tmp);
 	spin_unlock_irq(&dev->power.lock);
 	return ret;
 }
diff --git a/include/linux/pm.h b/include/linux/pm.h
index 0bd9de1..3d2cbf9 100644
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -633,9 +633,9 @@ struct dev_pm_info {
 	int			runtime_error;
 	int			autosuspend_delay;
 	u64			last_busy;
-	unsigned long		active_jiffies;
-	unsigned long		suspended_jiffies;
-	unsigned long		accounting_timestamp;
+	u64			active_time;
+	u64			suspended_time;
+	u64			accounting_timestamp;
 #endif
 	struct pm_subsys_data	*subsys_data;  /* Owned by the subsystem. */
 	void (*set_latency_tolerance)(struct device *, s32);
-- 
2.7.4

