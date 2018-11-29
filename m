Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A80C43610
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4F0EA21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kQS7vsEO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4F0EA21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730937AbeK3Exk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:53:40 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42613 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730870AbeK3Exi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:53:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id l15-v6so2520302lja.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C0VjsI0UfpBTK8w+W8XunAgB9zCJk33hNRRNGzP35VQ=;
        b=kQS7vsEOYPpXGlZNXuLMFtfkofiQuooHy+fccXroI9o/TGMZsJLjCqyJCmBDcW+Pfm
         SSZXA94pqanu/v4Q8btPoMk0uRoASTgNiYRzQx/qxsxxc91rzycdnQXVJ/jkbznAH+qz
         ETf/KoqgfbjIQG0Nb/a4vedWuXg17lj8fgw/s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C0VjsI0UfpBTK8w+W8XunAgB9zCJk33hNRRNGzP35VQ=;
        b=RmJsr8WuG7QbGgd2vlW+CpeRWD/i5VYhnj2goffOlwuThFzuYoui67JDqNbwB1RzPe
         +mSbFrooD+GDRB1cpuHMAcp/L9kidww+XNizIKmujCd8/4vQcPuNiusuHPaNLTQLQ+UW
         RbeyH8mGbHPteQawnwtCw1VkToiPBEgQxbchwGHxyXJWuR0MrD/p1qO5HYbG/fNiXriM
         mIW9dboO1q7/vnXJ5NFWfa043lYcumVdA6DlgnDtPIIxaCH1nexPW+ODk0YrO3+sgOne
         yvD5f5+1ltMLZ+AGnwEpzMZ2WNbq7FjvolZOVOBsuVVpH1SRwbSoiFqSyKo8lBNNR4mj
         TCUQ==
X-Gm-Message-State: AA+aEWY0Zr0uUM+yL5+q1lPGKIH2fvQCmj1TyTCKlrpjQLpigMielP5m
        m365KKpB7PI33JEzsM6xUCijnw==
X-Google-Smtp-Source: AFSGD/UXa2P2II/wtioQeASL+BRwTSaq76NVJ+o2O/6qKa9KM8ADvkUD6yNQjs/D3EcYdG3tnACO/Q==
X-Received: by 2002:a2e:9a56:: with SMTP id k22-v6mr1711941ljj.17.1543513647571;
        Thu, 29 Nov 2018 09:47:27 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:26 -0800 (PST)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v10 11/27] drivers: firmware: psci: Split psci_dt_cpu_init_idle()
Date:   Thu, 29 Nov 2018 18:46:44 +0100
Message-Id: <20181129174700.16585-12-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's split the psci_dt_cpu_init_idle() function into two functions, as to
allow following changes to re-use some of the code.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- None.

---
 drivers/firmware/psci/psci.c | 42 ++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 878c4dcf0118..d50b46a0528f 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -270,10 +270,27 @@ static int __init psci_features(u32 psci_func_id)
 #ifdef CONFIG_CPU_IDLE
 static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
 
+static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
+{
+	int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
+
+	if (err) {
+		pr_warn("%pOF missing arm,psci-suspend-param property\n", np);
+		return err;
+	}
+
+	if (!psci_power_state_is_valid(*state)) {
+		pr_warn("Invalid PSCI power state %#x\n", *state);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 			struct device_node *cpu_node, int cpu)
 {
-	int i, ret, count = 0;
+	int i, ret = 0, count = 0;
 	u32 *psci_states;
 	struct device_node *state_node;
 
@@ -292,29 +309,16 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		return -ENOMEM;
 
 	for (i = 0; i < count; i++) {
-		u32 state;
-
 		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
+		of_node_put(state_node);
 
-		ret = of_property_read_u32(state_node,
-					   "arm,psci-suspend-param",
-					   &state);
-		if (ret) {
-			pr_warn(" * %pOF missing arm,psci-suspend-param property\n",
-				state_node);
-			of_node_put(state_node);
+		if (ret)
 			goto free_mem;
-		}
 
-		of_node_put(state_node);
-		pr_debug("psci-power-state %#x index %d\n", state, i);
-		if (!psci_power_state_is_valid(state)) {
-			pr_warn("Invalid PSCI power state %#x\n", state);
-			ret = -EINVAL;
-			goto free_mem;
-		}
-		psci_states[i] = state;
+		pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
 	}
+
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
 	return 0;
-- 
2.17.1

