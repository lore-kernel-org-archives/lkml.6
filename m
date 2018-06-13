Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id F04FCC5CFF1
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3859208B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:03:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3859208B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935249AbeFMBDX (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:03:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:64685 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935068AbeFMBBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:01:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 18:01:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,216,1526367600"; 
   d="scan'208";a="47283520"
Received: from voyager.sc.intel.com ([10.3.52.149])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2018 18:01:34 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Cc:     Andi Kleen <andi.kleen@intel.com>, Ashok Raj <ashok.raj@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Don Zickus <dzickus@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        Byungchul Park <byungchul.park@lge.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Christoffer Dall <cdall@linaro.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        iommu@lists.linux-foundation.org
Subject: [RFC PATCH 18/23] watchdog/hardlockup/hpet: Add the NMI watchdog operations
Date:   Tue, 12 Jun 2018 17:57:38 -0700
Message-Id: <1528851463-21140-19-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement the start, stop and disable operations of the HPET-based NMI
watchdog. Given that a single timer is used to monitor all the CPUs in
the system, it is necessary to define a cpumask that keeps track of the
CPUs that can be monitored. This cpumask is protected with a spin lock.

As individual CPUs are put online and offline, this cpumask is updated.
CPUs are unconditionally cleared from the mask when going offline. When
going online, the CPU is set in the mask only if is one of the CPUs allowed
to be monitored by the watchdog.

It is not necessary to implement a start function. The NMI watchdog will
be enabled when there is at least one CPU to monitor.

The disable function clears the CPU mask and disables the timer.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Babu Moger <babu.moger@oracle.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: Byungchul Park <byungchul.park@lge.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: Waiman Long <longman@redhat.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Christoffer Dall <cdall@linaro.org>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: David Rientjes <rientjes@google.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hpet.h |  2 +
 include/linux/nmi.h         |  1 +
 kernel/watchdog_hld_hpet.c  | 98 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 101 insertions(+)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 33309b7..6ace2d1 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -124,6 +124,8 @@ struct hpet_hld_data {
 	u32		irq;
 	u32		flags;
 	u64		ticks_per_second;
+	struct cpumask	monitored_mask;
+	spinlock_t	lock; /* serialized access to monitored_mask */
 };
 
 extern struct hpet_hld_data *hpet_hardlockup_detector_assign_timer(void);
diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index e608762..23e20d2 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -129,6 +129,7 @@ struct nmi_watchdog_ops {
 };
 
 extern struct nmi_watchdog_ops hardlockup_detector_perf_ops;
+extern struct nmi_watchdog_ops hardlockup_detector_hpet_ops;
 
 void watchdog_nmi_stop(void);
 void watchdog_nmi_start(void);
diff --git a/kernel/watchdog_hld_hpet.c b/kernel/watchdog_hld_hpet.c
index 3bedffa..857e051 100644
--- a/kernel/watchdog_hld_hpet.c
+++ b/kernel/watchdog_hld_hpet.c
@@ -345,6 +345,91 @@ static int setup_hpet_irq(struct hpet_hld_data *hdata)
 }
 
 /**
+ * hardlockup_detector_hpet_enable() - Enable the hardlockup detector
+ *
+ * The hardlockup detector is enabled for the CPU that executes the
+ * function. It is only enabled if such CPU is allowed to be monitored
+ * by the lockup detector.
+ *
+ * Returns:
+ *
+ * None
+ *
+ */
+static void hardlockup_detector_hpet_enable(void)
+{
+	struct cpumask *allowed = watchdog_get_allowed_cpumask();
+	unsigned int cpu = smp_processor_id();
+
+	if (!hld_data)
+		return;
+
+	if (!cpumask_test_cpu(cpu, allowed))
+		return;
+
+	spin_lock(&hld_data->lock);
+
+	cpumask_set_cpu(cpu, &hld_data->monitored_mask);
+
+	/*
+	 * If this is the first CPU to be monitored, set everything in motion:
+	 * move the interrupt to this CPU, kick and enable the timer.
+	 */
+	if (cpumask_weight(&hld_data->monitored_mask) == 1) {
+		if (irq_set_affinity(hld_data->irq, cpumask_of(cpu))) {
+			spin_unlock(&hld_data->lock);
+			pr_err("Unable to enable on CPU %d.!\n", cpu);
+			return;
+		}
+
+		kick_timer(hld_data);
+		enable(hld_data);
+	}
+
+	spin_unlock(&hld_data->lock);
+}
+
+/**
+ * hardlockup_detector_hpet_disable() - Disable the hardlockup detector
+ *
+ * The hardlockup detector is disabled for the CPU that executes the
+ * function.
+ *
+ * None
+ */
+static void hardlockup_detector_hpet_disable(void)
+{
+	if (!hld_data)
+		return;
+
+	spin_lock(&hld_data->lock);
+
+	cpumask_clear_cpu(smp_processor_id(), &hld_data->monitored_mask);
+
+	/* Only disable the timer if there are no more CPUs to monitor. */
+	if (!cpumask_weight(&hld_data->monitored_mask))
+		disable(hld_data);
+
+	spin_unlock(&hld_data->lock);
+}
+
+/**
+ * hardlockup_detector_hpet_stop() - Stop the NMI watchdog on all CPUs
+ *
+ * Returns:
+ *
+ * None
+ */
+static void hardlockup_detector_hpet_stop(void)
+{
+	disable(hld_data);
+
+	spin_lock(&hld_data->lock);
+	cpumask_clear(&hld_data->monitored_mask);
+	spin_unlock(&hld_data->lock);
+}
+
+/**
  * hardlockup_detector_hpet_init() - Initialize the hardlockup detector
  *
  * Only initialize and configure the detector if an HPET is available on the
@@ -383,5 +468,18 @@ static int __init hardlockup_detector_hpet_init(void)
 	 */
 	disable(hld_data);
 
+	spin_lock_init(&hld_data->lock);
+
+	spin_lock(&hld_data->lock);
+	cpumask_clear(&hld_data->monitored_mask);
+	spin_unlock(&hld_data->lock);
+
 	return 0;
 }
+
+struct nmi_watchdog_ops hardlockup_detector_hpet_ops = {
+	.init		= hardlockup_detector_hpet_init,
+	.enable		= hardlockup_detector_hpet_enable,
+	.disable	= hardlockup_detector_hpet_disable,
+	.stop		= hardlockup_detector_hpet_stop
+};
-- 
2.7.4

