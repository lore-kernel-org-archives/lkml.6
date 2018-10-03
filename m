Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE82C64EBC
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0532921473
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 14:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="desWZW6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0532921473
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727528AbeJCV1i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 17:27:38 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:45796 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbeJCV1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 17:27:37 -0400
Received: by mail-lj1-f193.google.com with SMTP id j4-v6so1571566ljc.12
        for <linux-kernel@vger.kernel.org>; Wed, 03 Oct 2018 07:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=60U5bRPKDKJyHR17D5TYGPWZf08eZgljN5hkHwmsDUA=;
        b=desWZW6kZm9MoHxRhIgV19z7b6BH/QRJ2OPUabhMbRjAACBRrfdos4w49U1tyBVfGU
         btwLt77IkDaYsTQprkKZB1Jo6BKOJEBmqoiMiLWXNOB/lsM+gjDCj7a4GLIbRSb9OZ7Z
         h4CEgzpdwfkr4cOrcZUV5LUdctmd0wy/Ld3kM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=60U5bRPKDKJyHR17D5TYGPWZf08eZgljN5hkHwmsDUA=;
        b=QRk+VNQ4bG49Ic+z8sTDZdX4lkdp4U6RJyIkzouNS3XdpBfCtRMT7VO1+CsFwLvbzh
         iWVByoeX1f0j7vBjjqg+RXF3a8IQE7d+XPzCWF6wtRUhPIns+2sHQHZoMSpLsrd7QqxX
         OySfqhcrcl9gRnHdUq/spuV4y9KqCSxVSkK64glrzJ7BQQbsCjnNPtnSixLkBED7hcyk
         pbGfualzZtdJ2ER8I1O9RiiYENKWuHWKlIqINj3Pj0uU9SIdCp1cVu/GiutaRG36vaxj
         SGznVF+CAJCkuhgZZYBBt7byCMJ+05afqrYv2uw9wWAb5UIRzIigewbUZX9NoCAGrJ+E
         cdCA==
X-Gm-Message-State: ABuFfogU5G4JldaQWdw2I3GcOmKW2SoTG33yRoX9EiWWUrsneH4XQP98
        DexpSYaKcvaieFY/tlq9qeVEHQ==
X-Google-Smtp-Source: ACcGV62eYUZ0f1Bynmiavxa68k4auoEEG8yZecIQWETDoD832ixenFDZHZdEHJxZcAlphUS5fEAo0Q==
X-Received: by 2002:a2e:7f14:: with SMTP id a20-v6mr1338534ljd.148.1538577535185;
        Wed, 03 Oct 2018 07:38:55 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id 18-v6sm380867ljo.74.2018.10.03.07.38.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Oct 2018 07:38:54 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        linux-pm@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Kevin Hilman <khilman@kernel.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v9 09/11] drivers: firmware: psci: Split psci_dt_cpu_init_idle()
Date:   Wed,  3 Oct 2018 16:38:22 +0200
Message-Id: <20181003143824.13059-10-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003143824.13059-1-ulf.hansson@linaro.org>
References: <20181003143824.13059-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's split psci_dt_cpu_init_idle() function into two functions, as to
allow following changes to re-use some of the code.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci/psci.c | 42 ++++++++++++++++++++----------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index c80ec1d03274..9788bfc1cf8b 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -270,9 +270,26 @@ static int __init psci_features(u32 psci_func_id)
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
 static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
 {
-	int i, ret, count = 0;
+	int i, ret = 0, count = 0;
 	u32 *psci_states;
 	struct device_node *state_node;
 
@@ -291,29 +308,16 @@ static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
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

