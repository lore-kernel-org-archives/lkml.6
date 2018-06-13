Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 4BC7AC433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:01:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3BFC208C4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:01:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3BFC208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935165AbeFMBBv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:01:51 -0400
Received: from mga14.intel.com ([192.55.52.115]:64685 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935085AbeFMBBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:01:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 18:01:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,216,1526367600"; 
   d="scan'208";a="47283530"
Received: from voyager.sc.intel.com ([10.3.52.149])
  by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2018 18:01:35 -0700
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
Subject: [RFC PATCH 21/23] watchdog/hardlockup/hpet: Adjust timer expiration on the number of monitored CPUs
Date:   Tue, 12 Jun 2018 17:57:41 -0700
Message-Id: <1528851463-21140-22-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each CPU should be monitored for hardlockups every watchdog_thresh seconds.
Since all the CPUs in the system are monitored by the same timer and the
timer interrupt is rotated among the monitored CPUs, the timer must expire
every watchdog_thresh/N seconds; where N is the number of monitored CPUs.

A new member is added to struct hpet_wdt_data to determine the per-CPU
ticks per second. This quantity is used to program the comparator of the
timer.

The ticks-per-CPU quantity is updated every time when the number of
monitored CPUs changes: when the watchdog is enabled or disabled for
a specific CPU.

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
 arch/x86/include/asm/hpet.h |  1 +
 kernel/watchdog_hld_hpet.c  | 41 ++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 6ace2d1..e67818d 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -124,6 +124,7 @@ struct hpet_hld_data {
 	u32		irq;
 	u32		flags;
 	u64		ticks_per_second;
+	u64		ticks_per_cpu;
 	struct cpumask	monitored_mask;
 	spinlock_t	lock; /* serialized access to monitored_mask */
 };
diff --git a/kernel/watchdog_hld_hpet.c b/kernel/watchdog_hld_hpet.c
index c40acfd..ebb820d 100644
--- a/kernel/watchdog_hld_hpet.c
+++ b/kernel/watchdog_hld_hpet.c
@@ -65,11 +65,21 @@ static void kick_timer(struct hpet_hld_data *hdata)
 	 * are able to update the comparator before the counter reaches such new
 	 * value.
 	 *
+	 * The timer must monitor each CPU every watch_thresh seconds. Hence the
+	 * timer expiration must be:
+	 *
+	 *    watch_thresh/N
+	 *
+	 * where N is the number of monitored CPUs.
+	 *
+	 * in order to monitor all the online CPUs. ticks_per_cpu gives the
+	 * number of ticks needed to meet the condition above.
+	 *
 	 * Let it wrap around if needed.
 	 */
 	count = get_count();
 
-	new_compare = count + watchdog_thresh * hdata->ticks_per_second;
+	new_compare = count + watchdog_thresh * hdata->ticks_per_cpu;
 
 	set_comparator(hdata, new_compare);
 }
@@ -160,6 +170,33 @@ static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
 }
 
 /**
+ * update_ticks_per_cpu() - Update the number of HPET ticks per CPU
+ * @hdata:	struct with the timer's the ticks-per-second and CPU mask
+ *
+ * From the overall ticks-per-second of the timer, compute the number of ticks
+ * after which the timer should expire to monitor each CPU every watch_thresh
+ * seconds. The ticks-per-cpu quantity is computed using the number of CPUs that
+ * the watchdog currently monitors.
+ *
+ * Returns:
+ *
+ * None
+ *
+ */
+static void update_ticks_per_cpu(struct hpet_hld_data *hdata)
+{
+	unsigned int num_cpus = cpumask_weight(&hdata->monitored_mask);
+	unsigned long long temp = hdata->ticks_per_second;
+
+	/* Only update if there are monitored CPUs. */
+	if (!num_cpus)
+		return;
+
+	do_div(temp, num_cpus);
+	hdata->ticks_per_cpu = temp;
+}
+
+/**
  * hardlockup_detector_irq_handler() - Interrupt handler
  * @irq:	Interrupt number
  * @data:	Data associated with the interrupt
@@ -390,6 +427,7 @@ static void hardlockup_detector_hpet_enable(void)
 	spin_lock(&hld_data->lock);
 
 	cpumask_set_cpu(cpu, &hld_data->monitored_mask);
+	update_ticks_per_cpu(hld_data);
 
 	/*
 	 * If this is the first CPU to be monitored, set everything in motion:
@@ -425,6 +463,7 @@ static void hardlockup_detector_hpet_disable(void)
 	spin_lock(&hld_data->lock);
 
 	cpumask_clear_cpu(smp_processor_id(), &hld_data->monitored_mask);
+	update_ticks_per_cpu(hld_data);
 
 	/* Only disable the timer if there are no more CPUs to monitor. */
 	if (!cpumask_weight(&hld_data->monitored_mask))
-- 
2.7.4

