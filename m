Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EC6CC43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D0E21873
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 14:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="YpMcJy+o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726802AbeLROzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 09:55:40 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43990 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726766AbeLROzh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 09:55:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id r10so16188876wrs.10
        for <linux-kernel@vger.kernel.org>; Tue, 18 Dec 2018 06:55:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gUwbwmeADuEc2X4Ia538ZUBklszWDge9MdrlOIVIBqg=;
        b=YpMcJy+oov1I6Sv6Xa3HOejixQCR0FjNZ6zfWc7eRx7Y7qeUibf3JeP+h6MhGzGrUe
         gxnsBy8U9VN0BFhJl9S4R1nHxIaRNBeHqmfqPnMwQLbqsYcxUkS9Cmb+F/fLq36EjRCF
         nrmRCqAMrzG9W9zj8uClaRVMDh9YpyCl6MHSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gUwbwmeADuEc2X4Ia538ZUBklszWDge9MdrlOIVIBqg=;
        b=WMFVDgxey8QKEW1kernhmDuk2suputArHKRqbiouDeygQm/AELQtu5OrnmlbzL7i7b
         VrHKYjgR2yK9V26qB4AeNPw6SGF/tsIub0dyfGQrav7SwZ1Xvw4UxYAM0V4ziB5WNlOs
         rXfbsTMIBuMKO8nYrtRuqRiNc3Yrkm7j7AZrgFz17rmUZZwSpvPK7l+kJMXPWYtrSQxr
         zbahxC5IIczPaoxzA6ystB5OyJg/qinCClpIjhT+ElX7T4zs7vMHRNsx4A/0oVaaLc7I
         kPjyhd3AclEUqR7doTSdVMoytzPZyabsTIAvXaCgOJXiIrQAcp6bhlp9loCY5GvTuVvr
         +awQ==
X-Gm-Message-State: AA+aEWanmM/bUCuboWZI9b2RotpzvgoC+ijJq0BlfITJrS0kh7Be7Jep
        2xeRRq2rs/WYcL6jLEh1O6Sh9Q==
X-Google-Smtp-Source: AFSGD/WZQGWsKj/Gbytpr1ecq3jG7tmwvUGu9Ikth/x7a2ETWtGAKMIDgocTgFvg/+Zs0XG5zV5MNQ==
X-Received: by 2002:a5d:4a0c:: with SMTP id m12mr14781326wrq.38.1545144935389;
        Tue, 18 Dec 2018 06:55:35 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:85e9:25c5:6cbd:73e9])
        by smtp.gmail.com with ESMTPSA id n20sm1579956wmi.11.2018.12.18.06.55.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Dec 2018 06:55:34 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, thara.gopinath@linaro.org,
        jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
        rodrigo.vivi@intel.com, airlied@linux.ie,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc:     ulf.hansson@linaro.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 3/3] PM/runtime:Replace jiffies based accounting with ktime based accounting
Date:   Tue, 18 Dec 2018 15:55:23 +0100
Message-Id: <1545144923-31546-4-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
References: <1545144923-31546-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thara Gopinath <thara.gopinath@linaro.org>

This patch replaces jiffies based accounting for runtime_active_time
and runtime_suspended_time with ktime base accounting. This makes the
runtime debug counters inline with genpd and other pm subsytems which
uses ktime based accounting.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
[move from ktime to raw nsec]
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 10 +++++-----
 drivers/base/power/sysfs.c   | 11 ++++++++---
 include/linux/pm.h           |  6 +++---
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 6461469..5c18e28 100644
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
@@ -1517,7 +1517,7 @@ void pm_runtime_init(struct device *dev)
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
 	dev->power.deferred_resume = false;
-	dev->power.accounting_timestamp = jiffies;
+	dev->power.accounting_timestamp = ktime_to_ns(ktime_get());
 	INIT_WORK(&dev->power.work, pm_runtime_work);
 
 	dev->power.timer_expires = 0;
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

