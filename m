Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 253BEC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:22:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C750120836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="A9fuIxNS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C750120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932232AbeFTRWz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:22:55 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41706 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754527AbeFTRWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:22:51 -0400
Received: by mail-lf0-f67.google.com with SMTP id d24-v6so462342lfa.8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=vnYluIpcEHC+tsAsU0zpoMH7H2eRLG9C8FtOsJ0eLNk=;
        b=A9fuIxNS3uBRahtGY3yF8BJX+KBopB0YlNuVvX9MTh+xt1z7j1iKkK9AELwlTF7KCl
         Rd/7Y/OeF6eDwgvDCt+aqtfnX8WxW1mYntnkQ3QBpQP5Z2bR6+dLVx+eNEIMg8natOdz
         MdlfGI3j2PSCpKmKUQiReapNtTpQ9lJlo6Q9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=vnYluIpcEHC+tsAsU0zpoMH7H2eRLG9C8FtOsJ0eLNk=;
        b=kRbGQgzvJ+6hOKXMyynAd4YrZTywoL5w4DP3Oyilcfxirb3Vn1OvPUxnCyQjujrt4K
         2qCzTq4U2oq7M6di7+yWNDdhp03PHCtsM82PUWyGSn8qu4tDbhdBeXCHCQKQunnIzIXg
         2arR945kBI+AE/YkASInsfXEdf3NuX/XuF02gsGnEp8uekAhCjsk1vVWErlJdiHJOv0j
         uo9vgjubJz6TPHRR1ovKtssaIpQyVDfAHtdUD1MDSoNuUbhTn9ZGGGNlRNVi3rQPjJcb
         +VfprzEVHOiEknhfjo0m0IGbUWAM7OTuSIRTk9J/ddNPl2YilGcvVNnaCDHHG1q0Hz1f
         uFSA==
X-Gm-Message-State: APt69E1OWV2rjTQX9bnL6Chk1+V+IMxdgvq5NJdZG+7GkspJmpBbZoj3
        MXsp1qw4Weqk08kOQMkP2YlrFw==
X-Google-Smtp-Source: ADUXVKK84Q1LGQnNiTjybKUAInQtHrhH0fvzJOM/HZa6SCmBbdy9GJRiOUal7GTkipBNB47dsvQi5g==
X-Received: by 2002:a2e:1092:: with SMTP id 18-v6mr15640303ljq.115.1529515369568;
        Wed, 20 Jun 2018 10:22:49 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:22:48 -0700 (PDT)
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
Subject: [PATCH v8 08/26] PM / Domains: Extend genpd CPU governor to cope with QoS constraints
Date:   Wed, 20 Jun 2018 19:22:08 +0200
Message-Id: <20180620172226.15012-9-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU devices and other regular devices may share the same PM domain and may
also be hierarchically related via subdomains. In either case, all devices
including CPUs, may be attached to a PM domain managed by genpd, that has
an idle state with an enter/exit latency.

Let's take these latencies into account in the state selection process by
genpd's governor for CPUs. This means the governor, pm_domain_cpu_gov,
becomes extended to satisfy both a state's residency and a potential dev PM
QoS constraint.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/base/power/domain_governor.c | 15 +++++++++++----
 include/linux/pm_domain.h            |  1 +
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
index 1aad55719537..03d4e9454ce9 100644
--- a/drivers/base/power/domain_governor.c
+++ b/drivers/base/power/domain_governor.c
@@ -214,8 +214,10 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 	struct generic_pm_domain *genpd = pd_to_genpd(pd);
 	struct gpd_link *link;
 
-	if (!genpd->max_off_time_changed)
+	if (!genpd->max_off_time_changed) {
+		genpd->state_idx = genpd->cached_power_down_state_idx;
 		return genpd->cached_power_down_ok;
+	}
 
 	/*
 	 * We have to invalidate the cached results for the masters, so
@@ -240,6 +242,7 @@ static bool default_power_down_ok(struct dev_pm_domain *pd)
 		genpd->state_idx--;
 	}
 
+	genpd->cached_power_down_state_idx = genpd->state_idx;
 	return genpd->cached_power_down_ok;
 }
 
@@ -255,6 +258,10 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	s64 idle_duration_ns;
 	int cpu, i;
 
+	/* Validate dev PM QoS constraints. */
+	if (!default_power_down_ok(pd))
+		return false;
+
 	if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
 		return true;
 
@@ -276,9 +283,9 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
 	/*
 	 * Find the deepest idle state that has its residency value satisfied
 	 * and by also taking into account the power off latency for the state.
-	 * Start at the deepest supported state.
+	 * Start at the state picked by the dev PM QoS constraint validation.
 	 */
-	i = genpd->state_count - 1;
+	i = genpd->state_idx;
 	do {
 		if (!genpd->states[i].residency_ns)
 			break;
@@ -312,6 +319,6 @@ struct dev_power_governor pm_domain_always_on_gov = {
 };
 
 struct dev_power_governor pm_domain_cpu_gov = {
-	.suspend_ok = NULL,
+	.suspend_ok = default_suspend_ok,
 	.power_down_ok = cpu_power_down_ok,
 };
diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
index 97901c833108..dbc69721cad8 100644
--- a/include/linux/pm_domain.h
+++ b/include/linux/pm_domain.h
@@ -81,6 +81,7 @@ struct generic_pm_domain {
 	s64 max_off_time_ns;	/* Maximum allowed "suspended" time. */
 	bool max_off_time_changed;
 	bool cached_power_down_ok;
+	bool cached_power_down_state_idx;
 	int (*attach_dev)(struct generic_pm_domain *domain,
 			  struct device *dev);
 	void (*detach_dev)(struct generic_pm_domain *domain,
-- 
2.17.1

