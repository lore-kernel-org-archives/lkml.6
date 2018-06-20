Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44C7C43140
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:25:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C99E20836
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 17:25:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="bReuTrLr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C99E20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933128AbeFTRZJ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 13:25:09 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:34242 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932674AbeFTRXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 13:23:11 -0400
Received: by mail-lf0-f67.google.com with SMTP id e13-v6so504381lfc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jun 2018 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7/fxm1AKVizOXQknbpAI2N51c69eELd8rPbu3jzZtbE=;
        b=bReuTrLrm8ygiBOgjl6MARfBuQGcn7wxebgSmffuWDknXNqjcktDDJC9JVeFhivxdT
         Bds9hIiSkFKakweH7n+2MtfsTaIh1XuQx5p1VN54QQ62CpGG7+XvUvZCEtXgZC/hAQeA
         ALy5UPbu5+NOfj5nA0dHa5W5XwE2Y1VXqAclY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7/fxm1AKVizOXQknbpAI2N51c69eELd8rPbu3jzZtbE=;
        b=kQOIqdvaPDIJO6xIKrCN8do5HjpEJ6DzReSxIojXKVSlg1topgyHeDRjTpYHNplZTW
         N1mhefUm1hJRlT+l6t+8cbf3f8NuwPbNsJ+3AK5awhHwz95Dnpkk5AETcUohQPhNYm9e
         b8+UyILAOgIHKM7ZCEDN+O6yQ1PRzjEIG4tqa8ZNv7h9tLBS0/c3UazKplrA6VfmmNag
         +qn2TYF3XuDHyV4tSZ/HZZFgcmM/LwvgjJcqZe1eumvUe9HGWKZPk9TF/Z0/Vy4ttswJ
         dmwBqOR1HlTeLFjGsku+kAKy7Y6W/hpmc90/soSlCALfkbC+4/Cq3UZ3wuALWAvfvZgk
         HLOw==
X-Gm-Message-State: APt69E3ZNU+olCCWEE4X4P/wQQTQbeJXQwFKquNkRhOOGbcF4AhT3KKi
        hE9hz6DTjpn07tvu5AOIBESKNw==
X-Google-Smtp-Source: ADUXVKIJo2YXgol7hsdEFgWgAY/YBNI7nk8q9PRx07agC9mkR5QY2YZjX/K7yb4J8x3kD2yJFJegrw==
X-Received: by 2002:a2e:5c89:: with SMTP id q131-v6mr8812218ljb.77.1529515389928;
        Wed, 20 Jun 2018 10:23:09 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id b2-v6sm514441lji.85.2018.06.20.10.23.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 20 Jun 2018 10:23:09 -0700 (PDT)
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
Subject: [PATCH v8 19/26] drivers: firmware: psci: Prepare to use OS initiated suspend mode
Date:   Wed, 20 Jun 2018 19:22:19 +0200
Message-Id: <20180620172226.15012-20-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620172226.15012-1-ulf.hansson@linaro.org>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable the OS initiated mode, the CPU topology needs to be described
using the hierarchical model in DT. When used, the idle state bits for the
CPU needs to be created by ORing the bits for CPU's selected idle state
with the bits for CPU's PM domain (CPU's cluster) idle state.

Let's prepare the PSCI driver to deal with this, via introducing a per CPU
variable called domain_state and by adding internal helpers to read/write
the value of variable.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci/psci.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index e8f4f8444ff1..40b2b8945018 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -87,8 +87,19 @@ static u32 psci_function_id[PSCI_FN_MAX];
 				(PSCI_1_0_EXT_POWER_STATE_ID_MASK | \
 				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
 
+static DEFINE_PER_CPU(u32, domain_state);
 static u32 psci_cpu_suspend_feature;
 
+static inline u32 psci_get_domain_state(void)
+{
+	return this_cpu_read(domain_state);
+}
+
+static inline void psci_set_domain_state(u32 state)
+{
+	this_cpu_write(domain_state, state);
+}
+
 static inline bool psci_has_ext_power_state(void)
 {
 	return psci_cpu_suspend_feature &
@@ -187,6 +198,8 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
 
 	fn = psci_function_id[PSCI_FN_CPU_ON];
 	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
+	/* Clear the domain state to start fresh. */
+	psci_set_domain_state(0);
 	return psci_to_linux_errno(err);
 }
 
@@ -408,15 +421,17 @@ int psci_cpu_init_idle(unsigned int cpu)
 static int psci_suspend_finisher(unsigned long index)
 {
 	u32 *state = __this_cpu_read(psci_power_state);
+	u32 composite_state = state[index - 1] | psci_get_domain_state();
 
-	return psci_ops.cpu_suspend(state[index - 1],
-				    __pa_symbol(cpu_resume));
+	return psci_ops.cpu_suspend(composite_state, __pa_symbol(cpu_resume));
 }
 
 int psci_cpu_suspend_enter(unsigned long index)
 {
 	int ret;
 	u32 *state = __this_cpu_read(psci_power_state);
+	u32 composite_state = state[index - 1] | psci_get_domain_state();
+
 	/*
 	 * idle state index 0 corresponds to wfi, should never be called
 	 * from the cpu_suspend operations
@@ -424,11 +439,14 @@ int psci_cpu_suspend_enter(unsigned long index)
 	if (WARN_ON_ONCE(!index))
 		return -EINVAL;
 
-	if (!psci_power_state_loses_context(state[index - 1]))
-		ret = psci_ops.cpu_suspend(state[index - 1], 0);
+	if (!psci_power_state_loses_context(composite_state))
+		ret = psci_ops.cpu_suspend(composite_state, 0);
 	else
 		ret = cpu_suspend(index, psci_suspend_finisher);
 
+	/* Clear the domain state to start fresh when back from idle. */
+	psci_set_domain_state(0);
+
 	return ret;
 }
 
-- 
2.17.1

