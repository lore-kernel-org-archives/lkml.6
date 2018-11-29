Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A0AEC4161B
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1539D214C1
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="B/5EWbX/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1539D214C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731031AbeK3Ext (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 23:53:49 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:41310 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730999AbeK3Exs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 23:53:48 -0500
Received: by mail-lj1-f195.google.com with SMTP id z80-v6so2520955ljb.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Nov 2018 09:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PgU1c1CxxtqSBW5JefCvIK+xCW7iLG8npYRcb1HuKE4=;
        b=B/5EWbX/4pIf3Oc3G2zdHEoTEbgIGKaLe3sWcikr1JnH0hv2gk3BnxwQr4TUdob0pS
         GBHcOVwcErj08YkbJF+3nI8Qeiz3paCDoblCXvk3zQCosYDQzVJJ3Zu2ag+TMhbtAuwy
         JVyxj/mbnkShjM0JtEpEnU0awLd8+vHoqWDi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PgU1c1CxxtqSBW5JefCvIK+xCW7iLG8npYRcb1HuKE4=;
        b=hyMFMyYMmcsZwah+Ip/5rAE6onG3sZKyOs5jwTov2HS6+GBXkz+/2q7U1i5Pb6Zuwr
         TSRzHI16861XZWLOmmMOVKCZJuRGczZFfaA+gDEN9VpvW1IMPky3dryNnV0Z/qVXwgMr
         KHpqbovACXDMBXWVCbkIookY+qYn3mVzuHd7Zwl05ATz0XnQ6EZ3tqZQIzuQt0KQXVhG
         FUn2miaMS1zwokAP28z70/BVSe93Jr2JnB2WenXOJJ5syq8XbdohghdFgEEC4jaECDIK
         /FP17U1ohhxfKoMpTCwBCwIE+KRhsp1x/AqUZTJq+Rha7iFSYXSZGQML92/gL8K4V2rt
         CV5Q==
X-Gm-Message-State: AA+aEWaGrm5PzkJqXtC8blOQU71TpGnlPJFd/OHv0SYOppFRAp7cYg6b
        1FIg83MqXFAdGZ9f1aYv9sVjPA==
X-Google-Smtp-Source: AFSGD/WczsUHri23WmBiaft8WE6DWc6NG5zksmRIXHH/fM1XFB8rrAvVA/6TldZECosGbxyL5A6+UQ==
X-Received: by 2002:a2e:85d3:: with SMTP id h19-v6mr1678736ljj.82.1543513656433;
        Thu, 29 Nov 2018 09:47:36 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Nov 2018 09:47:35 -0800 (PST)
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
Subject: [PATCH v10 16/27] drivers: firmware: psci: Prepare to use OS initiated suspend mode
Date:   Thu, 29 Nov 2018 18:46:49 +0100
Message-Id: <20181129174700.16585-17-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To enable the OS initiated mode, the CPU topology needs to be described
using the hierarchical model in DT. When used, the idle state bits for the
CPU are created by ORing the bits for PM domain's idle state.

Let's prepare the PSCI driver to deal with this, via introducing a per CPU
variable called domain_state and by adding internal helpers to read/write
the value of the variable.

Cc: Lina Iyer <ilina@codeaurora.org>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---

Changes in v10:
	- Use __this_cpu_read|write() rather than this_cpu_read|write().

---
 drivers/firmware/psci/psci.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 4f0cbc95e41b..8dbcdecc2ae4 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -87,8 +87,19 @@ static u32 psci_function_id[PSCI_FN_MAX];
 				(PSCI_1_0_EXT_POWER_STATE_ID_MASK | \
 				PSCI_1_0_EXT_POWER_STATE_TYPE_MASK)
 
+static DEFINE_PER_CPU(u32, domain_state);
 static u32 psci_cpu_suspend_feature;
 
+static inline u32 psci_get_domain_state(void)
+{
+	return __this_cpu_read(domain_state);
+}
+
+static inline void psci_set_domain_state(u32 state)
+{
+	__this_cpu_write(domain_state, state);
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
 
@@ -409,15 +422,17 @@ int psci_cpu_init_idle(struct cpuidle_driver *drv, unsigned int cpu)
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
@@ -425,11 +440,14 @@ int psci_cpu_suspend_enter(unsigned long index)
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

