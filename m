Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 57445C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0271120660
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:04:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0271120660
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935311AbeFMBEP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:04:15 -0400
Received: from mga14.intel.com ([192.55.52.115]:64685 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935054AbeFMBBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:01:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 18:01:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,216,1526367600"; 
   d="scan'208";a="47283493"
Received: from voyager.sc.intel.com ([10.3.52.149])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2018 18:01:33 -0700
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
        Don Zickus <dzickus@redhat.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Weisbecker <frederic@kernel.org>,
        Babu Moger <babu.moger@oracle.com>,
        "David S. Miller" <davem@davemloft.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Colin Ian King <colin.king@canonical.com>,
        "Luis R. Rodriguez" <mcgrof@kernel.org>,
        iommu@lists.linux-foundation.org
Subject: [RFC PATCH 12/23] kernel/watchdog: Introduce a struct for NMI watchdog operations
Date:   Tue, 12 Jun 2018 17:57:32 -0700
Message-Id: <1528851463-21140-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of exposing individual functions for the operations of the NMI
watchdog, define a common interface that can be used across multiple
implementations.

The struct nmi_watchdog_ops is defined for such operations. These initial
definitions include the enable, disable, start, stop, and cleanup
operations.

Only a single NMI watchdog can be used in the system. The operations of
this NMI watchdog are accessed via the new variable nmi_wd_ops. This
variable is set to point the operations of the first NMI watchdog that
initializes successfully. Even though at this moment, the only available
NMI watchdog is the perf-based hardlockup detector. More implementations
can be added in the future.

While introducing this new struct for the NMI watchdog operations, convert
the perf-based NMI watchdog to use these operations.

The functions hardlockup_detector_perf_restart() and
hardlockup_detector_perf_stop() are special. They are not regular watchdog
operations; they are used to work around hardware bugs. Thus, they are not
used for the start and stop operations. Furthermore, the perf-based NMI
watchdog does not need to implement such operations. They are intended to
globally start and stop the NMI watchdog; the perf-based NMI
watchdog is implemented on a per-CPU basis.

Currently, when perf-based hardlockup detector is not selected at build
time, a dummy hardlockup_detector_perf_init() is used. The return value
of this function depends on CONFIG_HAVE_NMI_WATCHDOG. This behavior is
conserved by defining using the set of NMI watchdog operations structure
hardlockup_detector_noop. These dummy operations are used when no hard-
lockup detector is used or fails to initialize.

Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Jacob Pan <jacob.jun.pan@intel.com>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Babu Moger <babu.moger@oracle.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Colin Ian King <colin.king@canonical.com>
Cc: "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Cc: sparclinux@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: iommu@lists.linux-foundation.org
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 include/linux/nmi.h   | 39 +++++++++++++++++++++++++++----------
 kernel/watchdog.c     | 54 +++++++++++++++++++++++++++++++++++++++++++++------
 kernel/watchdog_hld.c | 16 +++++++++++----
 3 files changed, 89 insertions(+), 20 deletions(-)

diff --git a/include/linux/nmi.h b/include/linux/nmi.h
index b8d868d..d3f5d55f 100644
--- a/include/linux/nmi.h
+++ b/include/linux/nmi.h
@@ -92,24 +92,43 @@ static inline void hardlockup_detector_disable(void) {}
 extern void arch_touch_nmi_watchdog(void);
 extern void hardlockup_detector_perf_stop(void);
 extern void hardlockup_detector_perf_restart(void);
-extern void hardlockup_detector_perf_disable(void);
-extern void hardlockup_detector_perf_enable(void);
-extern void hardlockup_detector_perf_cleanup(void);
-extern int hardlockup_detector_perf_init(void);
 #else
 static inline void hardlockup_detector_perf_stop(void) { }
 static inline void hardlockup_detector_perf_restart(void) { }
-static inline void hardlockup_detector_perf_disable(void) { }
-static inline void hardlockup_detector_perf_enable(void) { }
-static inline void hardlockup_detector_perf_cleanup(void) { }
 # if !defined(CONFIG_HAVE_NMI_WATCHDOG)
-static inline int hardlockup_detector_perf_init(void) { return -ENODEV; }
 static inline void arch_touch_nmi_watchdog(void) {}
-# else
-static inline int hardlockup_detector_perf_init(void) { return 0; }
 # endif
 #endif
 
+/**
+ * struct nmi_watchdog_ops - Operations performed by NMI watchdogs
+ * @init:		Initialize and configure the hardware resources of the
+ *			NMI watchdog.
+ * @enable:		Enable (i.e., monitor for hardlockups) the NMI watchdog
+ *			in the CPU in which the function is executed.
+ * @disable:		Disable (i.e., do not monitor for hardlockups) the NMI
+ *			in the CPU in which the function is executed.
+ * @start:		Start the the NMI watchdog in all CPUs. Used after the
+ *			parameters of the watchdog are updated. Optional if
+ *			such updates does not impact operation the NMI watchdog.
+ * @stop:		Stop the the NMI watchdog in all CPUs. Used before the
+ *			parameters of the watchdog are updated. Optional if
+ *			such updates does not impact the NMI watchdog.
+ * @cleanup:		Cleanup unneeded data structures of the NMI watchdog.
+ *			Used after updating the parameters of the watchdog.
+ *			Optional no cleanup is needed.
+ */
+struct nmi_watchdog_ops {
+	int	(*init)(void);
+	void	(*enable)(void);
+	void	(*disable)(void);
+	void	(*start)(void);
+	void	(*stop)(void);
+	void	(*cleanup)(void);
+};
+
+extern struct nmi_watchdog_ops hardlockup_detector_perf_ops;
+
 void watchdog_nmi_stop(void);
 void watchdog_nmi_start(void);
 int watchdog_nmi_probe(void);
diff --git a/kernel/watchdog.c b/kernel/watchdog.c
index 576d180..5057376 100644
--- a/kernel/watchdog.c
+++ b/kernel/watchdog.c
@@ -48,6 +48,8 @@ int __read_mostly soft_watchdog_user_enabled = 1;
 int __read_mostly watchdog_thresh = 10;
 int __read_mostly nmi_watchdog_available;
 
+static struct nmi_watchdog_ops *nmi_wd_ops;
+
 struct cpumask watchdog_allowed_mask __read_mostly;
 
 struct cpumask watchdog_cpumask __read_mostly;
@@ -99,6 +101,23 @@ __setup("hardlockup_all_cpu_backtrace=", hardlockup_all_cpu_backtrace_setup);
 #endif /* CONFIG_HARDLOCKUP_DETECTOR */
 
 /*
+ * Define a non-existent hard lockup detector. It will be used only if
+ * no actual hardlockup detector was selected at built time.
+ */
+static inline int noop_hardlockup_detector_init(void)
+{
+	/* If arch has an NMI watchdog, pretend to initialize it. */
+	if (IS_ENABLED(CONFIG_HAVE_NMI_WATCHDOG))
+		return 0;
+	else
+		return -ENODEV;
+}
+
+static struct nmi_watchdog_ops hardlockup_detector_noop = {
+	.init = noop_hardlockup_detector_init,
+};
+
+/*
  * These functions can be overridden if an architecture implements its
  * own hardlockup detector.
  *
@@ -108,19 +127,33 @@ __setup("hardlockup_all_cpu_backtrace=", hardlockup_all_cpu_backtrace_setup);
  */
 int __weak watchdog_nmi_enable(unsigned int cpu)
 {
-	hardlockup_detector_perf_enable();
+	if (nmi_wd_ops && nmi_wd_ops->enable)
+		nmi_wd_ops->enable();
+
 	return 0;
 }
 
 void __weak watchdog_nmi_disable(unsigned int cpu)
 {
-	hardlockup_detector_perf_disable();
+	if (nmi_wd_ops && nmi_wd_ops->disable)
+		nmi_wd_ops->disable();
 }
 
 /* Return 0, if a NMI watchdog is available. Error code otherwise */
 int __weak __init watchdog_nmi_probe(void)
 {
-	return hardlockup_detector_perf_init();
+	int ret = -ENODEV;
+
+	if (IS_ENABLED(CONFIG_HARDLOCKUP_DETECTOR_PERF))
+		ret = hardlockup_detector_perf_ops.init();
+
+	if (!ret) {
+		nmi_wd_ops = &hardlockup_detector_perf_ops;
+		return ret;
+	}
+
+	nmi_wd_ops = &hardlockup_detector_noop;
+	return nmi_wd_ops->init();
 }
 
 /**
@@ -131,7 +164,11 @@ int __weak __init watchdog_nmi_probe(void)
  * update_variables();
  * watchdog_nmi_start();
  */
-void __weak watchdog_nmi_stop(void) { }
+void __weak watchdog_nmi_stop(void)
+{
+	if (nmi_wd_ops && nmi_wd_ops->stop)
+		nmi_wd_ops->stop();
+}
 
 /**
  * watchdog_nmi_start - Start the watchdog after reconfiguration
@@ -144,7 +181,11 @@ void __weak watchdog_nmi_stop(void) { }
  * - watchdog_thresh
  * - watchdog_cpumask
  */
-void __weak watchdog_nmi_start(void) { }
+void __weak watchdog_nmi_start(void)
+{
+	if (nmi_wd_ops && nmi_wd_ops->start)
+		nmi_wd_ops->start();
+}
 
 /**
  * lockup_detector_update_enable - Update the sysctl enable bit
@@ -627,7 +668,8 @@ static inline void lockup_detector_setup(void)
 static void __lockup_detector_cleanup(void)
 {
 	lockdep_assert_held(&watchdog_mutex);
-	hardlockup_detector_perf_cleanup();
+	if (nmi_wd_ops && nmi_wd_ops->cleanup)
+		nmi_wd_ops->cleanup();
 }
 
 /**
diff --git a/kernel/watchdog_hld.c b/kernel/watchdog_hld.c
index e449a23..036cb0a 100644
--- a/kernel/watchdog_hld.c
+++ b/kernel/watchdog_hld.c
@@ -186,7 +186,7 @@ static int hardlockup_detector_event_create(void)
 /**
  * hardlockup_detector_perf_enable - Enable the local event
  */
-void hardlockup_detector_perf_enable(void)
+static void hardlockup_detector_perf_enable(void)
 {
 	if (hardlockup_detector_event_create())
 		return;
@@ -201,7 +201,7 @@ void hardlockup_detector_perf_enable(void)
 /**
  * hardlockup_detector_perf_disable - Disable the local event
  */
-void hardlockup_detector_perf_disable(void)
+static void hardlockup_detector_perf_disable(void)
 {
 	struct perf_event *event = this_cpu_read(watchdog_ev);
 
@@ -219,7 +219,7 @@ void hardlockup_detector_perf_disable(void)
  *
  * Called from lockup_detector_cleanup(). Serialized by the caller.
  */
-void hardlockup_detector_perf_cleanup(void)
+static void hardlockup_detector_perf_cleanup(void)
 {
 	int cpu;
 
@@ -281,7 +281,7 @@ void __init hardlockup_detector_perf_restart(void)
 /**
  * hardlockup_detector_perf_init - Probe whether NMI event is available at all
  */
-int __init hardlockup_detector_perf_init(void)
+static int __init hardlockup_detector_perf_init(void)
 {
 	int ret = hardlockup_detector_event_create();
 
@@ -291,5 +291,13 @@ int __init hardlockup_detector_perf_init(void)
 		perf_event_release_kernel(this_cpu_read(watchdog_ev));
 		this_cpu_write(watchdog_ev, NULL);
 	}
+
 	return ret;
 }
+
+struct nmi_watchdog_ops hardlockup_detector_perf_ops = {
+	.init		= hardlockup_detector_perf_init,
+	.enable		= hardlockup_detector_perf_enable,
+	.disable	= hardlockup_detector_perf_disable,
+	.cleanup	= hardlockup_detector_perf_cleanup,
+};
-- 
2.7.4

