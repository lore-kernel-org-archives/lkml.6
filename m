Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E54DC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 28D5A2083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:28:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="aWFax21m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28D5A2083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932928AbeFTR2Z (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:28:25 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36805 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754458AbeFTRWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:22:46 -0400
Received: by mail-lf0-f68.google.com with SMTP id n24-v6so485751lfh.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=40LOjQ+YPGx6FLKxOB2XtXKEBIZOB0eV+AE7c0B9P1E=;
        b=aWFax21mb/OlcZ7istRxEXtPKUgExdCY0cZkrEYF2+Jr5f3yKt7cA4JqeDOe8p1AJY
         NNUJv+K8Al6QpPca5OFrRctUKi+y1W6JOcechSQQAEBT+F3kXon2QFO3P8WiL1gAl/Jp
         QxV1m/BbjaPYRQ1CJfXLnW72fnBPVUOcxglkk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=40LOjQ+YPGx6FLKxOB2XtXKEBIZOB0eV+AE7c0B9P1E=;
        b=anjnaZ8adOKPyT0jOOlQxvS885uM39VADXVQ+uy85SRkt1+nzKj2dUIjEj8ydHSnA/
         ba9wYIblgEbX06ch9kBO1Ia7yuHIauwZixIdM6HFI8J9u4vI8Q8FmG4R7SjvM+b6a0bi
         g5WLNn60G6h2pV7FM6HVkRJpgdmbXWCn0mR0xHvzxVDzQ95vde5Q05KMuZIX9/MKfvnX
         Sac0vVIZPvlD6K/dUgJJ5vjgcXtcaDhkobdVdpksgITz21NNXaRxntHl13yzQkcmWNJT
         rusLhEvEpbiHJbub4MHyr0wjpid3M7QRdKiBd5C5rXxiiezgoSasOQHTvpQFjD1Q3bmK
         p0qw==
X-Gm-Message-State: APt69E0Ajt3jAIApSMeyOZ3jckfSEKv/YBGx/U3qDd/0gyiNGP8XE2Wf
        UxfE+ySTuwfLwEFgSphzqWNJsw==
X-Google-Smtp-Source: ADUXVKIIJjPRC5qpFFEOx8+I/8Zau9QXY7+lIPwkDkUPtNuVr2VDIS66YI54o1YXlQncriceQEnUqg==
X-Received: by 2002:a2e:1d59:: with SMTP id d86-v6mr15375209ljd.104.1529515364476;
        Wed, 20 Jun 2018 10:22:44 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.22.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:22:43 -0700 (PDT)
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
Subject: [PATCH v8 05/26] PM / Domains: Add helper functions to attach/detach CPUs to/from genpd
Date:   Wed, 20 Jun 2018 19:22:05 +0200
Message-Id: <20180620172226.15012-6-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce two new genpd helper functions, of_genpd_attach|detach_cpu(),
which takes the CPU-number as an in-parameter.

To attach a CPU to a genpd, of_genpd_attach_cpu() starts by fetching the
struct device belonging to the CPU. Then it calls genpd_dev_pm_attach(),
which via DT tries to hook up the CPU device to its corresponding PM
domain. If it succeeds, of_genpd_attach_cpu() continues to prepare/enable
runtime PM of the device.

To detach a CPU from its PM domain, of_genpd_attach_cpu() reverse the
operations made from of_genpd_attach_cpu(). However, first it checks that
the CPU device has a valid PM domain pointer assigned, as to make sure it
belongs to genpd.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain.c | 69 +++++++++++++++++++++++++++++++++++++
 include/linux/pm_domain.h   |  9 +++++
 2 files changed, 78 insertions(+)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 6149ce0bfa7b..299fa2febbec 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2445,6 +2445,75 @@ struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(genpd_dev_pm_attach_by_id);
 
+/*
+ * of_genpd_attach_cpu() - Attach a CPU to its PM domain
+ * @cpu: The CPU to be attached.
+ *
+ * Parses the OF node of the CPU's device, to find a PM domain specifier. If
+ * such is found, attaches the CPU's device to the retrieved pm_domain ops and
+ * enables runtime PM for it. This to allow the CPU to be power managed through
+ * its PM domain.
+ *
+ * Returns zero when successfully attached the CPU's device to its PM domain,
+ * else a negative error code.
+ */
+int of_genpd_attach_cpu(int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+	int ret;
+
+	if (!dev) {
+		pr_warn("genpd: no dev for cpu%d\n", cpu);
+		return -ENODEV;
+	}
+
+	ret = genpd_dev_pm_attach(dev);
+	if (ret != 1) {
+		dev_warn(dev, "genpd: attach cpu failed %d\n", ret);
+		return ret < 0 ? ret : -ENODEV;
+	}
+
+	pm_runtime_irq_safe(dev);
+	pm_runtime_get_noresume(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	dev_info(dev, "genpd: attached cpu\n");
+	return 0;
+}
+EXPORT_SYMBOL(of_genpd_attach_cpu);
+
+/**
+ * of_genpd_detach_cpu() - Detach a CPU from its PM domain
+ * @cpu: The CPU to be detached.
+ *
+ * Detach the CPU's device from its corresponding PM domain. If detaching is
+ * completed successfully, disable runtime PM and restore the runtime PM usage
+ * count for the CPU's device.
+ */
+void of_genpd_detach_cpu(int cpu)
+{
+	struct device *dev = get_cpu_device(cpu);
+
+	if (!dev) {
+		pr_warn("genpd: no dev for cpu%d\n", cpu);
+		return;
+	}
+
+	/* Check that the device is attached to a genpd. */
+	if (!(dev->pm_domain && dev->pm_domain->detach == genpd_dev_pm_detach))
+		return;
+
+	genpd_dev_pm_detach(dev, true);
+
+	pm_runtime_disable(dev);
+	pm_runtime_put_noidle(dev);
+	pm_runtime_reinit(dev);
+
+	dev_info(dev, "genpd: detached cpu\n");
+}
+EXPORT_SYMBOL(of_genpd_detach_cpu);
+
 static const struct of_device_id idle_state_match[] = {
 	{ .compatible = "domain-idle-state", },
 	{ }
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 3f67ff0c1c69..2c09cf80b285 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -243,6 +243,8 @@ unsigned int of_genpd_opp_to_performance_state(struct device *dev,
 int genpd_dev_pm_attach(struct device *dev);
 struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 					 unsigned int index);
+int of_genpd_attach_cpu(int cpu);
+void of_genpd_detach_cpu(int cpu);
 #else /* !CONFIG_PM_GENERIC_DOMAINS_OF */
 static inline int of_genpd_add_provider_simple(struct device_node *np,
 					struct generic_pm_domain *genpd)
@@ -294,6 +296,13 @@ static inline struct device *genpd_dev_pm_attach_by_id(struct device *dev,
 	return NULL;
 }
 
+static inline int of_genpd_attach_cpu(int cpu)
+{
+	return -ENODEV;
+}
+
+static inline void of_genpd_detach_cpu(int cpu) {}
+
 static inline
 struct generic_pm_domain *of_genpd_remove_last(struct device_node *np)
 {
-- 
2.17.1

