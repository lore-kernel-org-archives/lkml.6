Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6EAC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:24:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E700B20870
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 14:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bXcLrQbe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728812AbfAVOYl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 09:24:41 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33499 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728365AbfAVOYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 09:24:38 -0500
Received: by mail-wr1-f67.google.com with SMTP id c14so27622950wrr.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Jan 2019 06:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=icRDkcXzioH9ylzj5h9mEPp6hJmlM4XW9bm5lCr6fE4=;
        b=bXcLrQbemsaH8z1LwgrunyyYuupal+AFxADKh14R6FPQr47McexPFnhHEgomACyUjp
         UDJqmCvjET5MPN3mLwxyFxF1oar39NtCY4rtJQgpX9mFr6m4tzYX/aBmjhvDGVvXaPCL
         2ro2nfJlHM2qlszBTo8MI5JXpXYxCGt1NtQkA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=icRDkcXzioH9ylzj5h9mEPp6hJmlM4XW9bm5lCr6fE4=;
        b=Wh7mD6m1qLqrtHfqH5KS6Q7VfGootuLoPSh5NCGP2SkVVadhBO8fDKEmWNiEkYI63x
         KBH6q9/MEKugJXF9Njf29EaK9arFLy/QH4LBpMvXyd2/trtd2aByt+CZVJAbecdMJEbP
         dRqxfHG2iJACgPVXZ3mKyyjnnr5m7qZJl1L5UuMtQ6ZEN+M0JZFUOEFdfy+Z6isnlXGH
         h3O8xp/NIykLTKiE2u+hy4/t/MSpUcqt3D5XNhnVAgRPLkkBBEh7z93GNzMpfJB0TO/g
         PQ0c/52MLKkgF0gwVAx7VBIw1scESSzkZ39NI8ZNSaA/DEafA8dg/nKgaIJKKYddFyD6
         6u5A==
X-Gm-Message-State: AJcUukfZC8KCrSePGJoXTGNWTGMrCCcevYAnVnAG4BwNzNIBeJv4uirQ
        WRLDXvTDPCCEJsAGC6f3tIQAxQ==
X-Google-Smtp-Source: ALg8bN4jwbyPxEbRHdX+k/bNQEkGqyIW0EORqCMMYQfIb0UpZlXj1xlua7eaPO6XQ6Gex+xop6Y/uQ==
X-Received: by 2002:a5d:6450:: with SMTP id d16mr33154547wrw.64.1548167075610;
        Tue, 22 Jan 2019 06:24:35 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:609f:7896:d361:50c6])
        by smtp.gmail.com with ESMTPSA id l19sm52620119wme.21.2019.01.22.06.24.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 22 Jan 2019 06:24:34 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org, linux@roeck-us.net
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/2] PM-runtime: Replace jiffies based accounting with ktime-based accounting
Date:   Tue, 22 Jan 2019 15:24:30 +0100
Message-Id: <1548167070-421-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org>
References: <1548167070-421-1-git-send-email-vincent.guittot@linaro.org>
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
index 7df1d05..e49b3a8 100644
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
 
@@ -1308,7 +1309,7 @@ void pm_runtime_enable(struct device *dev)
 
 	/* About to enable runtime pm, set accounting_timestamp to now */
 	if (dev->power.disable_depth == 1)
-		dev->power.accounting_timestamp = jiffies;
+		dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
 
 	if (dev->power.disable_depth > 0)
 		dev->power.disable_depth--;
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

