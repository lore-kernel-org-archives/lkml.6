Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752420AbeCNREW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 13:04:22 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:42585 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751997AbeCNQ7T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 12:59:19 -0400
X-Google-Smtp-Source: AG47ELvHaaFCQFX++JU99VZySuZCgsiDWNbqHWg72ELY9+wH/mnR8n7FKfxSv8PphX6a4l1vWZIFDQ==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        linux-pm@vger.kernel.org
Cc: Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>,
        Lina Iyer <lina.iyer@linaro.org>, Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 09/25] kernel/cpu_pm: Manage runtime PM in the idle path for CPUs
Date: Wed, 14 Mar 2018 17:58:19 +0100
Message-Id: <1521046715-30683-10-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
References: <1521046715-30683-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
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
index 67b02e1..71317ff 100644
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
 
+	if (!ret && dev)
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
+	if (dev)
+		pm_runtime_get_sync(dev);
+
 	return cpu_pm_notify(CPU_PM_EXIT, -1, NULL);
 }
 EXPORT_SYMBOL_GPL(cpu_pm_exit);
-- 
2.7.4
