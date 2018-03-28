Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752572AbeC1HrG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 03:47:06 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:41489 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752159AbeC1HrF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 03:47:05 -0400
X-Google-Smtp-Source: AIpwx4+1xxUhCHWDmHtbEU6mh096polU2MiutzVy/adtFLiQDgurhJFqS83y1xKyS35TvZp5tb7PIg==
From: Vincent Guittot <vincent.guittot@linaro.org>
To: catalin.marinas@arm.com, will.deacon@arm.com,
        linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, peterz@infradead.org,
        dietmar.eggemann@arm.com, Morten.Rasmussen@arm.com,
        chris.redpath@arm.com, Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH] sched: support dynamiQ cluster
Date: Wed, 28 Mar 2018 09:46:55 +0200
Message-Id: <1522223215-23524-1-git-send-email-vincent.guittot@linaro.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Arm DynamiQ system can integrate cores with different micro architecture
or max OPP under the same DSU so we can have cores with different compute
capacity at the LLC (which was not the case with legacy big/LITTLE
architecture). Such configuration is similar in some way to ITMT on intel
platform which allows some cores to be boosted to higher turbo frequency
than others and which uses SD_ASYM_PACKING feature to ensures that CPUs with
highest capacity, will always be used in priortiy in order to provide
maximum throughput.

Add arch_asym_cpu_priority() for arm64 as this function is used to
differentiate CPUs in the scheduler. The CPU's capacity is used to order
CPUs in the same DSU.

Create sched domain topolgy level for arm64 so we can set SD_ASYM_PACKING
at MC level.

Some tests have been done on a hikey960 platform (quad cortex-A53,
quad cortex-A73). For the test purpose, the CPUs topology of the hikey960
has been modified so the 8 heterogeneous cores are described as being part
of the same cluster and sharing resources (MC level) like with a DynamiQ DSU.

Results below show the time in seconds to run sysbench --test=cpu with an
increasing number of threads. The sysbench test run 32 times

             without patch     with patch    diff
1 threads    11.04(+/- 30%)    8.86(+/- 0%)  -19%
2 threads     5.59(+/- 14%)    4.43(+/- 0%)  -20%
3 threads     3.80(+/- 13%)    2.95(+/- 0%)  -22%
4 threads     3.10(+/- 12%)    2.22(+/- 0%)  -28%
5 threads     2.47(+/-  5%)    1.95(+/- 0%)  -21%
6 threads     2.09(+/-  0%)    1.73(+/- 0%)  -17%
7 threads     1.64(+/-  0%)    1.56(+/- 0%)  - 7%
8 threads     1.42(+/-  0%)    1.42(+/- 0%)    0%

Results show a better and stable results across iteration with the patch
compared to mainline because we are always using big cores in priority whereas
with mainline, the scheduler randomly choose a big or a little cores when
there are more cores than number of threads.
With 1 thread, the test duration varies in the range [8.85 .. 15.86] for
mainline whereas it stays in the range [8.85..8.87] with the patch

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

---

The SD_ASYM_PACKING flag is disabled by default and I'm preparing another patch
to enable this dynamically at boot time by detecting the system topology.

 arch/arm64/kernel/topology.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 2186853..cb6705e5 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -296,6 +296,33 @@ static void __init reset_cpu_topology(void)
 	}
 }
 
+#ifdef CONFIG_SCHED_MC
+unsigned int __read_mostly arm64_sched_asym_enabled;
+
+int arch_asym_cpu_priority(int cpu)
+{
+	return topology_get_cpu_scale(NULL, cpu);
+}
+
+static inline int arm64_sched_dynamiq(void)
+{
+	return arm64_sched_asym_enabled ? SD_ASYM_PACKING : 0;
+}
+
+static int arm64_core_flags(void)
+{
+	return cpu_core_flags() | arm64_sched_dynamiq();
+}
+#endif
+
+static struct sched_domain_topology_level arm64_topology[] = {
+#ifdef CONFIG_SCHED_MC
+	{ cpu_coregroup_mask, arm64_core_flags, SD_INIT_NAME(MC) },
+#endif
+	{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
+	{ NULL, },
+};
+
 void __init init_cpu_topology(void)
 {
 	reset_cpu_topology();
@@ -306,4 +333,7 @@ void __init init_cpu_topology(void)
 	 */
 	if (of_have_populated_dt() && parse_dt_topology())
 		reset_cpu_topology();
+
+	/* Set scheduler topology descriptor */
+	set_sched_topology(arm64_topology);
 }
-- 
2.7.4
