Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6F84ECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:33:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9909206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:33:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9909206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388729AbeGTNVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:21:41 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:41262 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731623AbeGTNVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:21:40 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8DBABBBD;
        Fri, 20 Jul 2018 12:31:39 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Prashanth Prakash <pprakash@codeaurora.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Subject: [PATCH 4.14 05/92] cpufreq / CPPC: Set platform specific transition_delay_us
Date:   Fri, 20 Jul 2018 14:13:09 +0200
Message-Id: <20180720121417.508186050@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121417.206337808@linuxfoundation.org>
References: <20180720121417.206337808@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prashanth Prakash <pprakash@codeaurora.org>

commit d4f3388afd488ed15368fa7413b8bd6d1f98bb1d upstream.

Add support to specify platform specific transition_delay_us instead
of using the transition delay derived from PCC.

With commit 3d41386d556d (cpufreq: CPPC: Use transition_delay_us
depending transition_latency) we are setting transition_delay_us
directly and not applying the LATENCY_MULTIPLIER. Because of that,
on Qualcomm Centriq we can end up with a very high rate of frequency
change requests when using the schedutil governor (default
rate_limit_us=10 compared to an earlier value of 10000).

The PCC subspace describes the rate at which the platform can accept
commands on the CPPC's PCC channel. This includes read and write
command on the PCC channel that can be used for reasons other than
frequency transitions. Moreover the same PCC subspace can be used by
multiple freq domains and deriving transition_delay_us from it as we
do now can be sub-optimal.

Moreover if a platform does not use PCC for desired_perf register then
there is no way to compute the transition latency or the delay_us.

CPPC does not have a standard defined mechanism to get the transition
rate or the latency at the moment.

Given the above limitations, it is simpler to have a platform specific
transition_delay_us and rely on PCC derived value only if a platform
specific value is not available.

Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
Cc: 4.14+ <stable@vger.kernel.org> # 4.14+
Fixes: 3d41386d556d (cpufreq: CPPC: Use transition_delay_us depending transition_latency)
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/cpufreq/cppc_cpufreq.c |   46 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -126,6 +126,49 @@ static void cppc_cpufreq_stop_cpu(struct
 				cpu->perf_caps.lowest_perf, cpu_num, ret);
 }
 
+/*
+ * The PCC subspace describes the rate at which platform can accept commands
+ * on the shared PCC channel (including READs which do not count towards freq
+ * trasition requests), so ideally we need to use the PCC values as a fallback
+ * if we don't have a platform specific transition_delay_us
+ */
+#ifdef CONFIG_ARM64
+#include <asm/cputype.h>
+
+static unsigned int cppc_cpufreq_get_transition_delay_us(int cpu)
+{
+	unsigned long implementor = read_cpuid_implementor();
+	unsigned long part_num = read_cpuid_part_number();
+	unsigned int delay_us = 0;
+
+	switch (implementor) {
+	case ARM_CPU_IMP_QCOM:
+		switch (part_num) {
+		case QCOM_CPU_PART_FALKOR_V1:
+		case QCOM_CPU_PART_FALKOR:
+			delay_us = 10000;
+			break;
+		default:
+			delay_us = cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+			break;
+		}
+		break;
+	default:
+		delay_us = cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+		break;
+	}
+
+	return delay_us;
+}
+
+#else
+
+static unsigned int cppc_cpufreq_get_transition_delay_us(int cpu)
+{
+	return cppc_get_transition_latency(cpu) / NSEC_PER_USEC;
+}
+#endif
+
 static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
 	struct cppc_cpudata *cpu;
@@ -163,8 +206,7 @@ static int cppc_cpufreq_cpu_init(struct
 	policy->cpuinfo.max_freq = cppc_dmi_max_khz;
 
 	policy->cpuinfo.transition_latency = cppc_get_transition_latency(cpu_num);
-	policy->transition_delay_us = cppc_get_transition_latency(cpu_num) /
-		NSEC_PER_USEC;
+	policy->transition_delay_us = cppc_cpufreq_get_transition_delay_us(cpu_num);
 	policy->shared_type = cpu->shared_type;
 
 	if (policy->shared_type == CPUFREQ_SHARED_TYPE_ANY) {


