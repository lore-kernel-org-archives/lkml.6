Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 880A4C282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:26:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9BA2083B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 16:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aVSLiJos"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731510AbfBDQ0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 11:26:07 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35114 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730735AbfBDQ0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 11:26:02 -0500
Received: by mail-wm1-f66.google.com with SMTP id t200so566774wmt.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Feb 2019 08:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=9lKepzvlFqSdyTmpHqFOS3txG3e1Qlnve7EeoiMfLO0=;
        b=aVSLiJosF7nsn2YlMbkWjfe/sQt+HQvDzUEKw4RhgQWgOVm70k9HPSiS5kbBVP/nE1
         uxICapIcLqWzWM7keOzeU4tTM3C0LF+hWtIqKxl8GXPDB84dVtX59Ewhs+KjNoSXstgm
         a7axZ2Vk2Aky3bhhwgyM5lpXXxhrlCVDzQPX4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=9lKepzvlFqSdyTmpHqFOS3txG3e1Qlnve7EeoiMfLO0=;
        b=m2QdDiCEhN8KXf6xqnfnU/07DhtQK0QPr+7Fg/ZUluVenBqgnXbVep8Kh4MRX+gHw7
         Lkf6EHkJo91mDdAwUx2APUcshLac8bx48IcQ34atYAb5w51PMUjBBuFiuguBm9wuqcey
         GL5+YeP8BeUvJfKF2I8+ZvA+KD7wtL4qR6fXpIjhar19FPmzR5XgiBw7MszN39b9dHk/
         vtdK2W8eBlqWtvCaOhu/nVIodzrM/KBVsUwYG77kiape/ccK1y6onRze6du+Ji01azPh
         KUorsqKVLgvVScUsKQCgafh+dQGIy5m+kWraUGHCrD+cvvPYMCnWt312m0IaarJnRZ50
         2WeA==
X-Gm-Message-State: AHQUAuYerl3o3XHX+sqx6pIbdI9nkTuUrmfYSZK9tU9d49IgvJiH0joZ
        ScoEuuRnV6BH9Dm+krgkF3xFug==
X-Google-Smtp-Source: AHgI3IZ7M0ze84wTX8DLxUv882QQUfhGHmbTLyFg1PCjFq7A45aNiEqTtsmhl2YBtsRd3HsDJdr2vw==
X-Received: by 2002:a1c:b456:: with SMTP id d83mr127459wmf.115.1549297559980;
        Mon, 04 Feb 2019 08:25:59 -0800 (PST)
Received: from localhost.localdomain ([2a01:e0a:f:6020:70b6:b9c6:89e2:36a])
        by smtp.gmail.com with ESMTPSA id a4sm1251992wrt.37.2019.02.04.08.25.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 04 Feb 2019 08:25:59 -0800 (PST)
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, ulf.hansson@linaro.org, biju.das@bp.renesas.com
Cc:     linux-arm-kernel@lists.infradead.org, geert@linux-m68k.org,
        thara.gopinath@linaro.org, linux-renesas-soc@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH 2/2] PM-runtime: update time accounting only when enabled
Date:   Mon,  4 Feb 2019 17:25:53 +0100
Message-Id: <1549297553-17647-3-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
References: <1549297553-17647-1-git-send-email-vincent.guittot@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update accounting_timestamp field only when PM runtime is enable
and don't forget to account the last state before disabling it.

Suggested-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 drivers/base/power/runtime.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
index 50740da..ed62cca 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -66,11 +66,14 @@ static int rpm_suspend(struct device *dev, int rpmflags);
  */
 void update_pm_runtime_accounting(struct device *dev)
 {
-	u64 now = ktime_get_mono_fast_ns();
-	u64 last = dev->power.accounting_timestamp;
-	u64 delta;
+	u64 now, last, delta;
 
-	dev->power.accounting_timestamp = now;
+	if (dev->power.disable_depth > 0)
+		return;
+
+	last = dev->power.accounting_timestamp;
+
+	dev->power.accounting_timestamp = now = ktime_get_mono_fast_ns();
 
 	/*
 	 * Because ktime_get_mono_fast_ns() is not monotonic during
@@ -82,9 +85,6 @@ void update_pm_runtime_accounting(struct device *dev)
 
 	delta = now - last;
 
-	if (dev->power.disable_depth > 0)
-		return;
-
 	if (dev->power.runtime_status == RPM_SUSPENDED)
 		dev->power.suspended_time += delta;
 	else
@@ -1298,6 +1298,9 @@ void __pm_runtime_disable(struct device *dev, bool check_resume)
 		pm_runtime_put_noidle(dev);
 	}
 
+	/* Update time accounting before disabling pm runtime */
+	update_pm_runtime_accounting(dev);
+
 	if (!dev->power.disable_depth++)
 		__pm_runtime_barrier(dev);
 
@@ -1521,7 +1524,6 @@ void pm_runtime_init(struct device *dev)
 	dev->power.request_pending = false;
 	dev->power.request = RPM_REQ_NONE;
 	dev->power.deferred_resume = false;
-	dev->power.accounting_timestamp = 0;
 	INIT_WORK(&dev->power.work, pm_runtime_work);
 
 	dev->power.timer_expires = 0;
-- 
2.7.4

