Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 194BEC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:28:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0BD020836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:28:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="e/XMLeMl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BD020836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754595AbeFTR2n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:28:43 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:39653 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754433AbeFTRWo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:22:44 -0400
Received: by mail-lf0-f65.google.com with SMTP id t2-v6so470501lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q3sBFx4bDLVEE6Yvpy9kVMF3vWlpgdg6YBSbLYqXsME=;
        b=e/XMLeMlRx28jbEDB7QNTC7AZ+tIR885ZpI7S+nl9KRtbtMETY2CF2Pv+JFE1mweSe
         1awjv5ZZJLYqTVddil3Hr7LCV3KHUgjjmPN5NSdSkzFsMaTzvaOXTGE/J9DXGl/0DfgP
         4FBSc+VNLZq8otJedKQjH/MWqJZUvu5tbL0v8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q3sBFx4bDLVEE6Yvpy9kVMF3vWlpgdg6YBSbLYqXsME=;
        b=RJIgtP/PXI8v2dgXQH+tk+ayPrN5uIyhcox6wtDm9RHbUd/RqoY4D+3UPP6UwejUwH
         hH2mKnmGgOeYlLWMHh3w50MAAQhHaI1lGlRRm88dckz7fK2u+FqV1yvSHdMrrxeyBkwK
         YOEI88+qij+wVILppNs6gjN8xWmuHpwo/RKVM0ZbLuDwYpnl83ePr/UcTmGFtqGoRURS
         0tkxYg96BdnV52nv/J7y6VWVbEAvyG6TLFuUde7UDpphceXyUj+SZKga4fhOYRdXZy+F
         zyvmffo4NKn732+L/Qy954q+dXGAU7Cno8slAQVg787lCS2Zmxq/Nr9JaEXFBL6GErTs
         oi6w==
X-Gm-Message-State: APt69E138HNBeRyxsI25UpR+lAtyaEhZFDvc/i/dQmvMq3zBi3VeIvNX
        ojhAYssvMFsfm7qIqhJgecPRBQ==
X-Google-Smtp-Source: ADUXVKIp3AXtOaz03IpCwOZ9IQJrq2qZ7IYsLAa/KRT98qnsBHyHNXYzDx/1n/77pq4H37AKTRzMdA==
X-Received: by 2002:a19:6550:: with SMTP id c16-v6mr14358137lfj.31.1529515362666;
        Wed, 20 Jun 2018 10:22:42 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:22:41 -0700 (PDT)
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
Subject: [PATCH v8 04/26] PM / Domains: Add support for CPU devices to genpd
Date:   Wed, 20 Jun 2018 19:22:04 +0200
Message-Id: <20180620172226.15012-5-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable a device belonging to a CPU to be attached to a PM domain managed
by genpd, let's do a few changes to genpd as to make it convenient to
manage the specifics around CPUs.

First, as to be able to quickly find out what CPUs that are attached to a
genpd, which typically becomes useful from a genpd governor as following
changes is about to show, let's add a cpumask 'cpus' to the struct
generic_pm_domain.

At the point when a device that belongs to a CPU, is attached/detached to
its corresponding PM domain via genpd_add_device(), let's update the
cpumask in genpd->cpus. Moreover, propagate the update of the cpumask to
the master domains, which makes the genpd->cpus to contain a cpumask that
hierarchically reflect all CPUs for a genpd, including CPUs attached to
subdomains.

Second, to unconditionally manage CPUs and the cpumask in genpd->cpus, is
unnecessary for cases when only non-CPU devices are parts of a genpd.
Let's avoid this by adding a new configuration bit, GENPD_FLAG_CPU_DOMAIN.
Clients must set the bit before they call pm_genpd_init(), as to instruct
genpd that it shall deal with CPUs and thus manage the cpumask in
genpd->cpus.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 69 ++++++++++++++++++++++++++++++++++++-
 include/linux/pm_domain.h   |  3 ++
 2 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 21d298e1820b..6149ce0bfa7b 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -20,6 +20,7 @@
 #include <linux/sched.h>
 #include <linux/suspend.h>
 #include <linux/export.h>
+#include <linux/cpu.h>
 
 #include "power.h"
 
@@ -126,6 +127,7 @@ static const struct genpd_lock_ops genpd_spin_ops = {
 #define genpd_is_irq_safe(genpd)	(genpd->flags & GENPD_FLAG_IRQ_SAFE)
 #define genpd_is_always_on(genpd)	(genpd->flags & GENPD_FLAG_ALWAYS_ON)
 #define genpd_is_active_wakeup(genpd)	(genpd->flags & GENPD_FLAG_ACTIVE_WAKEUP)
+#define genpd_is_cpu_domain(genpd)	(genpd->flags & GENPD_FLAG_CPU_DOMAIN)
 
 static inline bool irq_safe_dev_in_no_sleep_domain(struct device *dev,
 		const struct generic_pm_domain *genpd)
@@ -1377,6 +1379,62 @@ static void genpd_free_dev_data(struct device *dev,
 	dev_pm_put_subsys_data(dev);
 }
 
+static void __genpd_update_cpumask(struct generic_pm_domain *genpd,
+				   int cpu, bool set, unsigned int depth)
+{
+	struct gpd_link *link;
+
+	if (!genpd_is_cpu_domain(genpd))
+		return;
+
+	list_for_each_entry(link, &genpd->slave_links, slave_node) {
+		struct generic_pm_domain *master = link->master;
+
+		genpd_lock_nested(master, depth + 1);
+		__genpd_update_cpumask(master, cpu, set, depth + 1);
+		genpd_unlock(master);
+	}
+
+	if (set)
+		cpumask_set_cpu(cpu, genpd->cpus);
+	else
+		cpumask_clear_cpu(cpu, genpd->cpus);
+}
+
+static void genpd_update_cpumask(struct generic_pm_domain *genpd,
+				 struct device *dev, bool set)
+{
+	bool is_cpu = false;
+	int cpu;
+
+	if (!genpd_is_cpu_domain(genpd))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		if (get_cpu_device(cpu) == dev) {
+			is_cpu = true;
+			break;
+		}
+	}
+
+	if (!is_cpu)
+		return;
+
+	__genpd_update_cpumask(genpd, cpu, set, 0);
+}
+
+static void genpd_set_cpumask(struct generic_pm_domain *genpd,
+			      struct device *dev)
+{
+	genpd_update_cpumask(genpd, dev, true);
+}
+
+static void genpd_clear_cpumask(struct generic_pm_domain *genpd,
+				struct device *dev)
+{
+	genpd_update_cpumask(genpd, dev, false);
+}
+
 static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 			    struct gpd_timing_data *td)
 {
@@ -1398,6 +1456,8 @@ static int genpd_add_device(struct generic_pm_domain *genpd, struct device *dev,
 	if (ret)
 		goto out;
 
+	genpd_set_cpumask(genpd, dev);
+
 	dev_pm_domain_set(dev, &genpd->domain);
 
 	genpd->device_count++;
@@ -1459,6 +1519,7 @@ static int genpd_remove_device(struct generic_pm_domain *genpd,
 	if (genpd->detach_dev)
 		genpd->detach_dev(genpd, dev);
 
+	genpd_clear_cpumask(genpd, dev);
 	dev_pm_domain_set(dev, NULL);
 
 	list_del_init(&pdd->list_node);
@@ -1686,11 +1747,16 @@ int pm_genpd_init(struct generic_pm_domain *genpd,
 	if (genpd_is_always_on(genpd) && !genpd_status_on(genpd))
 		return -EINVAL;
 
+	if (!zalloc_cpumask_var(&genpd->cpus, GFP_KERNEL))
+		return -ENOMEM;
+
 	/* Use only one "off" state if there were no states declared */
 	if (genpd->state_count == 0) {
 		ret = genpd_set_default_power_state(genpd);
-		if (ret)
+		if (ret) {
+			free_cpumask_var(genpd->cpus);
 			return ret;
+		}
 	} else if (!gov) {
 		pr_warn("%s : no governor for states\n", genpd->name);
 	}
@@ -1736,6 +1802,7 @@ static int genpd_remove(struct generic_pm_domain *genpd)
 	list_del(&genpd->gpd_list_node);
 	genpd_unlock(genpd);
 	cancel_work_sync(&genpd->power_off_work);
+	free_cpumask_var(genpd->cpus);
 	kfree(genpd->free);
 	pr_debug("%s: removed %s\n", __func__, genpd->name);
 
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 27fca748344a..3f67ff0c1c69 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -16,12 +16,14 @@
 #include <linux/of.h>
 #include <linux/notifier.h>
 #include <linux/spinlock.h>
+#include <linux/cpumask.h>
 
 /* Defines used for the flags field in the struct generic_pm_domain */
 #define GENPD_FLAG_PM_CLK	 (1U << 0) /* PM domain uses PM clk */
 #define GENPD_FLAG_IRQ_SAFE	 (1U << 1) /* PM domain operates in atomic */
 #define GENPD_FLAG_ALWAYS_ON	 (1U << 2) /* PM domain is always powered on */
 #define GENPD_FLAG_ACTIVE_WAKEUP (1U << 3) /* Keep devices active if wakeup */
+#define GENPD_FLAG_CPU_DOMAIN	 (1U << 4) /* PM domain manages CPUs */
 
 enum gpd_status {
 	GPD_STATE_ACTIVE = 0,	/* PM domain is active */
@@ -68,6 +70,7 @@ struct generic_pm_domain {
 	unsigned int suspended_count;	/* System suspend device counter */
 	unsigned int prepared_count;	/* Suspend counter of prepared devices */
 	unsigned int performance_state;	/* Aggregated max performance state */
+	cpumask_var_t cpus;		/* A cpumask of the attached CPUs */
 	int (*power_off)(struct generic_pm_domain *domain);
 	int (*power_on)(struct generic_pm_domain *domain);
 	unsigned int (*opp_to_performance_state)(struct generic_pm_domain *genpd,
-- 
2.17.1

