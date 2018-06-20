Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110F9C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:27:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD38220836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="UKWyS3hT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD38220836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754555AbeFTR1m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:27:42 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33747 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754501AbeFTRWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:22:52 -0400
Received: by mail-lf0-f67.google.com with SMTP id y20-v6so500910lfy.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w/YAA8BgJgXeuAB4Wu8EHA4s3RfgYKqr95WAIEacqUs=;
        b=UKWyS3hTToKxrXbPMXXRta1HjAcVNo2/elOmaTz2VWM9HaXeuoPJUWIzqmC4xJmUT6
         F8wFz06W1B92R+249KsTGoHBm3XzhB7povwc3EAj6QJn91acb1MKY89vzo4r02bw64rY
         umdxH5INr3n8kHjJT5+oq7XPYhk7Du3FT4qek=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w/YAA8BgJgXeuAB4Wu8EHA4s3RfgYKqr95WAIEacqUs=;
        b=q+i+mkDSrx7YAFw2+iGNdqwXM3h5AxchLh7gdqYzvXjbhc9nu+IaQsZEyAL6miw7r/
         P3qXzQ7mIH34U695gPamkg1jza6I/AUYkXx/q6KELNjtq5nuL4r4bq9f/Ma01Vwu9WZn
         pI9yrsc9wbwmzjcWMDFccXOf44KUjXE1GfSfA62wRWNu6ksgDxAX6bNizzUfZlyHuQo6
         3tWqA0IqSBK9jIGSy4TFB/vaaUd77Yi97mmo2lfcufiz1B1ROd7b6zJJ3qwUlzleDnH1
         qe+kmRcRkhEXF3zBv7t/UqTkKEAfusK6oW0s6sjvk8ws0xXxTcz2hAOnG9vWyR3nnyfz
         r0yg==
X-Gm-Message-State: APt69E0bmhN+IPyfuH4Ow/Fg5yep0Y8pj5d1qQn2eejJDIrpk3MJNg7T
        UCS5sgpQ/wG57N2exx1NtShJ1w==
X-Google-Smtp-Source: ADUXVKKpZbnKqi0oKUPGq7T1+MiBtHrteMTDgrbFxl9QBtjQc36fvDAlSgdwGwy5+rWMXBOZHXzUUQ==
X-Received: by 2002:a2e:594d:: with SMTP id n74-v6mr15420669ljb.128.1529515371181;
        Wed, 20 Jun 2018 10:22:51 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.22.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:22:50 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
Cc:     Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v8 09/26] kernel/cpu_pm: Manage runtime PM in the idle path for CPUs
Date:   Wed, 20 Jun 2018 19:22:09 +0200
Message-Id: <20180620172226.15012-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To allow CPUs being power managed by PM domains, let's deploy support for
runtime PM for the CPU's corresponding struct device.

More precisely, at the point when the CPU is about to enter an idle state,
decrease the runtime PM usage count for its corresponding struct device,
via calling pm_runtime_put_sync_suspend(). Then, at the point when the CPU
resumes from idle, let's increase the runtime PM usage count, via calling
pm_runtime_get_sync().

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 kernel/cpu_pm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 67b02e138a47..492d4a83dca0 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -16,9 +16,11 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/cpu.h>
 #include <linux/cpu_pm.h>
 #include <linux/module.h>
 #include <linux/notifier.h>
+#include <linux/pm_runtime.h>
 #include <linux/spinlock.h>
 #include <linux/syscore_ops.h>
 
@@ -91,6 +93,7 @@ int cpu_pm_enter(void)
 {
 	int nr_calls;
 	int ret = 0;
+	struct device *dev = get_cpu_device(smp_processor_id());
 
 	ret = cpu_pm_notify(CPU_PM_ENTER, -1, &nr_calls);
 	if (ret)
@@ -100,6 +103,9 @@ int cpu_pm_enter(void)
 		 */
 		cpu_pm_notify(CPU_PM_ENTER_FAILED, nr_calls - 1, NULL);
 
+	if (!ret && dev && dev->pm_domain)
+		pm_runtime_put_sync_suspend(dev);
+
 	return ret;
 }
 EXPORT_SYMBOL_GPL(cpu_pm_enter);
@@ -118,6 +124,11 @@ EXPORT_SYMBOL_GPL(cpu_pm_enter);
  */
 int cpu_pm_exit(void)
 {
+	struct device *dev = get_cpu_device(smp_processor_id());
+
+	if (dev && dev->pm_domain)
+		pm_runtime_get_sync(dev);
+
 	return cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_exit);
-- 
2.17.1

