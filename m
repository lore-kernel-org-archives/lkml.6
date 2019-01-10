Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C4AC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CC0EF214DA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 11:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbfAJLF6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 06:05:58 -0500
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:60350 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726925AbfAJLF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 06:05:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C894BEBD;
        Thu, 10 Jan 2019 03:05:56 -0800 (PST)
Received: from queper01-lin.cambridge.arm.com (queper01-lin.cambridge.arm.com [10.1.195.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4C1A3F694;
        Thu, 10 Jan 2019 03:05:54 -0800 (PST)
From:   Quentin Perret <quentin.perret@arm.com>
To:     corbet@lwn.net, peterz@infradead.org, rjw@rjwysocki.net
Cc:     mingo@redhat.com, morten.rasmussen@arm.com, qais.yousef@arm.com,
        patrick.bellasi@arm.com, dietmar.eggemann@arm.com,
        linux-doc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quentin.perret@arm.com
Subject: [PATCH 1/2] PM / EM: Document the Energy Model framework
Date:   Thu, 10 Jan 2019 11:05:45 +0000
Message-Id: <20190110110546.8101-2-quentin.perret@arm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190110110546.8101-1-quentin.perret@arm.com>
References: <20190110110546.8101-1-quentin.perret@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a documentation file summarizing the key design points and
APIs of the newly introduced Energy Model framework.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 Documentation/power/energy-model.txt | 144 +++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 Documentation/power/energy-model.txt

diff --git a/Documentation/power/energy-model.txt b/Documentation/power/energy-model.txt
new file mode 100644
index 000000000000..a2b0ae4c76bd
--- /dev/null
+++ b/Documentation/power/energy-model.txt
@@ -0,0 +1,144 @@
+                           ====================
+                           Energy Model of CPUs
+                           ====================
+
+1. Overview
+-----------
+
+The Energy Model (EM) framework serves as an interface between drivers knowing
+the power consumed by CPUs at various performance levels, and the kernel
+subsystems willing to use that information to make energy-aware decisions.
+
+The source of the information about the power consumed by CPUs can vary greatly
+from one platform to another. These power costs can be estimated using
+devicetree data in some cases. In others, the firmware will know better.
+Alternatively, userspace might be best positioned. And so on. In order to avoid
+each and every client subsystem to re-implement support for each and every
+possible source of information on its own, the EM framework intervenes as an
+abstraction layer which standardizes the format of power cost tables in the
+kernel, hence enabling to avoid redundant work.
+
+The figure below depicts an example of drivers (Arm-specific here, but the
+approach is applicable to any architecture) providing power costs to the EM
+framework, and interested clients reading the data from it.
+
+       +---------------+  +-----------------+  +---------------+
+       | Thermal (IPA) |  | Scheduler (EAS) |  |     Other     |
+       +---------------+  +-----------------+  +---------------+
+               |                   | em_pd_energy()    |
+               |                   | em_cpu_get()      |
+               +---------+         |         +---------+
+                         |         |         |
+                         v         v         v
+                        +---------------------+
+                        |    Energy Model     |
+                        |     Framework       |
+                        +---------------------+
+                           ^       ^       ^
+                           |       |       | em_register_perf_domain()
+                +----------+       |       +---------+
+                |                  |                 |
+        +---------------+  +---------------+  +--------------+
+        |  cpufreq-dt   |  |   arm_scmi    |  |    Other     |
+        +---------------+  +---------------+  +--------------+
+                ^                  ^                 ^
+                |                  |                 |
+        +--------------+   +---------------+  +--------------+
+        | Device Tree  |   |   Firmware    |  |      ?       |
+        +--------------+   +---------------+  +--------------+
+
+The EM framework manages power cost tables per 'performance domain' in the
+system. A performance domain is a group of CPUs whose performance is scaled
+together. Performance domains generally have a 1-to-1 mapping with CPUFreq
+policies. All CPUs in a performance domain are required to have the same
+micro-architecture. CPUs in different performance domains can have different
+micro-architectures.
+
+
+2. Core APIs
+------------
+
+  2.1 Config options
+
+CONFIG_ENERGY_MODEL must be enabled to use the EM framework.
+
+
+  2.2 Registration of performance domains
+
+Drivers are expected to register performance domains into the EM framework by
+calling the following API:
+
+  int em_register_perf_domain(cpumask_t *span, unsigned int nr_states,
+			      struct em_data_callback *cb);
+
+Drivers must specify the CPUs of the performance domains using the cpumask
+argument, and provide a callback function returning <frequency, power> tuples
+for each capacity state. The callback function provided by the driver is free
+to fetch data from any relevant location (DT, firmware, ...), and by any mean
+deemed necessary. See Section 3. for an example of driver implementing this
+callback, and kernel/power/energy_model.c for further documentation on this
+API.
+
+
+  2.3 Accessing performance domains
+
+Subsystems interested in the energy model of a CPU can retrieve it using the
+em_cpu_get() API. The energy model tables are allocated once upon creation of
+the performance domains, and kept in memory untouched.
+
+The energy consumed by a performance domain can be estimated using the
+em_pd_energy() API. The estimation is performed assuming that the schedutil
+CPUfreq governor is in use.
+
+More details about the above APIs can be found in include/linux/energy_model.h.
+
+
+3. Example driver
+-----------------
+
+This section provides a simple example of a CPUFreq driver registering a
+performance domain in the Energy Model framework using the (fake) 'foo'
+protocol. The driver implements an est_power() function to be provided to the
+EM framework.
+
+ -> drivers/cpufreq/foo_cpufreq.c
+
+01	static int est_power(unsigned long *mW, unsigned long *KHz, int cpu)
+02	{
+03		long freq, power;
+04
+05		/* Use the 'foo' protocol to ceil the frequency */
+06		freq = foo_get_freq_ceil(cpu, *KHz);
+07		if (freq < 0);
+08			return freq;
+09
+10		/* Estimate the power cost for the CPU at the relevant freq. */
+11		power = foo_estimate_power(cpu, freq);
+12		if (power < 0);
+13			return power;
+14
+15		/* Return the values to the EM framework */
+16		*mW = power;
+17		*KHz = freq;
+18
+19		return 0;
+20	}
+21
+22	static int foo_cpufreq_init(struct cpufreq_policy *policy)
+23	{
+24		struct em_data_callback em_cb = EM_DATA_CB(est_power);
+25		int nr_opp, ret;
+26
+27		/* Do the actual CPUFreq init work ... */
+28		ret = do_foo_cpufreq_init(policy);
+29		if (ret)
+30			return ret;
+31
+32		/* Find the number of OPPs for this policy */
+33		nr_opp = foo_get_nr_opp(policy);
+34
+35		/* And register the new performance domain */
+36		em_register_perf_domain(policy->cpus, nr_opp, &em_cb);
+37
+38	        return 0;
+39	}
-- 
2.20.1

