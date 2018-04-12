Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753049AbeDLLQa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 07:16:30 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:39768 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753281AbeDLLPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 07:15:22 -0400
X-Google-Smtp-Source: AIpwx48DMW7SKu3ka7LBXwAn5XSccfZ7zs+GShxh82BTMXqVldxkvXiNqH51Uu3HgtAcy/E6ssWl+w==
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
Subject: [PATCH v7 24/26] drivers: firmware: psci: Deal with CPU hotplug when using OSI mode
Date: Thu, 12 Apr 2018 13:14:29 +0200
Message-Id: <1523531671-27491-25-git-send-email-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To deal with CPU hotplug when OSI mode is used, the CPU device needs to be
detached from its PM domain (genpd) when putting it offline, otherwise the
CPU becomes considered as being in use from genpd and runtime PM point of
view. Obviously, then we also need to re-attach the CPU device when bring
the CPU back online, so let's do this.

Cc: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/firmware/psci/psci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
index 700e0e9..e649673 100644
--- a/drivers/firmware/psci/psci.c
+++ b/drivers/firmware/psci/psci.c
@@ -190,6 +190,10 @@ static int psci_cpu_off(u32 state)
 	int err;
 	u32 fn;
 
+	/* If running OSI mode, detach the CPU device from its PM domain. */
+	if (psci_osi_mode_enabled)
+		of_genpd_detach_cpu(smp_processor_id());
+
 	fn = psci_function_id[PSCI_FN_CPU_OFF];
 	err = invoke_psci_fn(fn, state, 0, 0);
 	return psci_to_linux_errno(err);
@@ -204,6 +208,10 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
 	err = invoke_psci_fn(fn, cpuid, entry_point, 0);
 	/* Clear the domain state to start fresh. */
 	psci_set_domain_state(0);
+
+	if (!err && psci_osi_mode_enabled)
+		of_genpd_attach_cpu(cpuid);
+
 	return psci_to_linux_errno(err);
 }
 
-- 
2.7.4
