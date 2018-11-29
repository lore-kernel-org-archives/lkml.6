Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EE8C04EBA
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 92E7E21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="gc/mEof6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E7E21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730977AbeK3Exn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:53:43 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:37784 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730941AbeK3Exl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:53:41 -0500
Received: by mail-lf1-f68.google.com with SMTP id p17so2118983lfh.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZnU2zg5+wIbWo5O0mmqI6742JstHQYNw0KGOcLMkauw=;
        b=gc/mEof6FAHJILmhbUnZDwxeH3clqii9e4boH+PzYfTjHTpHvntzwcHeA4X/TZUQCO
         nEaYBT3n60JTTzq82pT8Jx8y3Ni2mBBoG8mGM8FR0XlTfs3oYJZ8Icwa0KV7QnJ8zC0z
         1x2yIJkBRlAHnoX+Xfz8x50/nIvF5nR+udY6k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZnU2zg5+wIbWo5O0mmqI6742JstHQYNw0KGOcLMkauw=;
        b=tGbqWAdj8KX6pvtSZeXs6G5tZyCqM1L5rjYwewrBXNdFtU0sAQCOk6rNu+IfYzboKT
         UxZku38US1VwGVLUBmqQEqQR9rtotDsB3aPGF2omJgr1bZuDbpGsy8TFvfhs5lqg6lIm
         e2NmFEjILWgnUq2aJ9I8fLrlKwL4J7Ss/dU3uCDijmFLq7E+kIye8voBae5mV4tAZ0mN
         GwPyZYaplh3Npwa0t46S5ole24IaYoK+4mk18Mxgoyw+2MwjaA6/AJj2drzzVi0Qcy0C
         FCqF9XdBIVVv7pefF+0Psahttx8JBuLw2SxAPpsBhSeHDrbhuxabSAxSLhu0Ddh4Kpfk
         LJGg==
X-Gm-Message-State: AA+aEWZ59zkXJGptTwL9Sqv96nr9CvEtdSoxCuBEXVy5QiyXarLD20Ls
        q/RPsNe9+hZ5lBGdttW6A9nXog==
X-Google-Smtp-Source: AFSGD/UfhHk4UsCzPn/eAc1UCLzaQXf6ETh/uaMawQcc+6G7rBPGahcf/FhFDVQ7YPe4Sfkg3pEBVQ==
X-Received: by 2002:a19:a84e:: with SMTP id r75mr1697958lfe.45.1543513649619;
        Thu, 29 Nov 2018 09:47:29 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:29 -0800 (PST)
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
Subject: [PATCH v10 12/27] drivers: firmware: psci: Simplify state node parsing
Date:   Thu, 29 Nov 2018 18:46:45 +0100
Message-Id: <20181129174700.16585-13-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of iterating through all the state nodes in DT, to find out how
many states that needs to be allocated, let's use the number already known
by the cpuidle driver. In this way we can drop the iteration altogether.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- New patch.

---
 drivers/firmware/psci/psci.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index d50b46a0528f..cbfc936d251c 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -290,26 +290,20 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
 static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 			struct device_node *cpu_node, int cpu)
 {
-	int i, ret = 0, count = 0;
+	int i, ret = 0, num_state_nodes = drv->state_count - 1;
 	u32 *psci_states;
 	struct device_node *state_node;
 
-	/* Count idle states */
-	while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
-					      count))) {
-		count++;
-		of_node_put(state_node);
-	}
-
-	if (!count)
-		return -ENODEV;
-
-	psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
+	psci_states = kcalloc(num_state_nodes, sizeof(*psci_states),
+			GFP_KERNEL);
 	if (!psci_states)
 		return -ENOMEM;
 
-	for (i = 0; i < count; i++) {
+	for (i = 0; i < num_state_nodes; i++) {
 		state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
+		if (!state_node)
+			break;
+
 		ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
 		of_node_put(state_node);
 
@@ -319,6 +313,11 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
 		pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
 	}
 
+	if (i != num_state_nodes) {
+		ret = -ENODEV;
+		goto free_mem;
+	}
+
 	/* Idle states parsed correctly, initialize per-cpu pointer */
 	per_cpu(psci_power_state, cpu) = psci_states;
 	return 0;
-- 
2.17.1

