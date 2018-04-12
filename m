Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753164AbeDLLRL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 07:17:11 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:44302 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752621AbeDLLPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 07:15:13 -0400
X-Google-Smtp-Source: AIpwx49a8s23MUX5vh6XozH+RnJhKfmqz1q6V2EcaUj79apwzrfUBotIEY1uyL6zbmdGN3PviPm8hA==
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-pm@vger.kernel.org
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
Subject: [PATCH v7 19/26] drivers: firmware: psci: Prepare to use OS initiated suspend mode
Date: Thu, 12 Apr 2018 13:14:24 +0200
Message-Id: <1523531671-27491-20-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
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
index e8f4f84..40b2b89 100644
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
2.7.4
