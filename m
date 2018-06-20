Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD53C43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:23:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66C6C20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:23:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lr1SCMsT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66C6C20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932931AbeFTRXV (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:23:21 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:41757 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932827AbeFTRXS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:23:18 -0400
Received: by mail-lf0-f65.google.com with SMTP id d24-v6so464367lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=iMx6h1L2HIsE81Qqf9KTc/HGuq09dzGoe43tExUeSqA=;
        b=Lr1SCMsT8ul9gy3ZiZNlhP2+8AuWwFud0Q1JuVsoxiCkAjBT3/MVx41++wpXHYtrzt
         pIJuCC7YYAu1tt6OvJvaQR5TtdEdmaXw5ancZ1EQj+e15c59a9rvW635+5u8WDX4HYej
         oTmXppj0RJifVpThU5DPigCvFbvwigZjpnYxo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=iMx6h1L2HIsE81Qqf9KTc/HGuq09dzGoe43tExUeSqA=;
        b=RoX9XK/UaOA200M8P+JXUus7vsW0/Q5HO+yisoWINcO8b5ETj9nteThv4k2Z+pfz/u
         DZa18hiG+y0ce2AuEn0gdJrjhys5oIX+0/rmeQ1Xtjq5WQ4yGrXicmsMDP1KgRdjeCis
         MM1HoazEoy/EKe0qelzEeLem1rD/RHLDD3eIFTyr18nY1OWYJ1GPyLi7hZcWM3XF72sf
         rwYMFuEJFXqRC66i/54muDkYEf+uZdkCrhFG50zYJRjQVMzth7m5N02LFnWD7oTZcdHV
         Vx3dNDdPvbgUDpUz4EaiOo3BUWu2fF9RXbdz4J2mLRDU4NNJH2/kooa2S+y7Y9WvCfPM
         2vSQ==
X-Gm-Message-State: APt69E25KvPVD7Q7venqGrAVTBmRYY6tTLscrxR8gpoZYSfUpS73diIR
        w/Ofeq69soeUq4yNBj5zINerbw==
X-Google-Smtp-Source: ADUXVKJN7qF1bO1BibAbpbCkbJJtFe10TW1BGESo34tVrvg1dCk+dsk7W0EoG6BuIGK2G2S49aEd3g==
X-Received: by 2002:a2e:1d59:: with SMTP id d86-v6mr15376470ljd.104.1529515397265;
        Wed, 20 Jun 2018 10:23:17 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.23.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:23:16 -0700 (PDT)
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
Subject: [PATCH v8 23/26] drivers: firmware: psci: Try to attach CPU devices to their PM domains
Date:   Wed, 20 Jun 2018 19:22:23 +0200
Message-Id: <20180620172226.15012-24-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the OS initiated CPU suspend mode have been enabled, the PM domain
topology for CPUs have earlier been created by PSCI. Let's use this
information in psci_dt_cpu_init_idle() as a condition for when it makes
sense to try to attach the CPU to its corresponding PM domain, via calling
of_genpd_attach_cpu().

If the CPU is attached successfully to its PM domain, idle management is
now fully prepared to be controlled through runtime PM for the CPU.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci/psci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 80c286d83369..700e0e995871 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -20,6 +20,7 @@
 #include <linux/linkage.h>
 #include <linux/of.h>
 #include <linux/pm.h>
+#include <linux/pm_domain.h>
 #include <linux/printk.h>
 #include <linux/psci.h>
 #include <linux/reboot.h>
@@ -91,6 +92,7 @@ static u32 psci_function_id[PSCI_FN_MAX];
 
 static DEFINE_PER_CPU(u32, domain_state);
 static u32 psci_cpu_suspend_feature;
+static bool psci_osi_mode_enabled;
 
 u32 psci_get_domain_state(void)
 {
@@ -339,6 +341,14 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
+
+	/* If running OSI mode, attach the CPU device to its PM domain. */
+	if (psci_osi_mode_enabled) {
+		ret = of_genpd_attach_cpu(cpu);
+		if (ret)
+			goto free_mem;
+	}
+
 	return 0;
 
 free_mem:
@@ -753,6 +763,7 @@ int __init psci_dt_topology_init(void)
 		goto out;
 	}
 
+	psci_osi_mode_enabled = true;
 	pr_info("OSI mode enabled.\n");
 out:
 	of_node_put(np);
-- 
2.17.1

