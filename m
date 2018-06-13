Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 2ECB4C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D7ACA208BA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 01:01:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7ACA208BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935182AbeFMBB5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 21:01:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:64691 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935076AbeFMBBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 21:01:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Jun 2018 18:01:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,216,1526367600"; 
   d="scan'208";a="47283527"
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
Subject: [RFC PATCH 20/23] watchdog/hardlockup/hpet: Rotate interrupt among all monitored CPUs
Date:   Tue, 12 Jun 2018 17:57:40 -0700
Message-Id: <1528851463-21140-21-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1528851463-21140-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to detect hardlockups in all the monitored CPUs, move the
interrupt to the next monitored CPU when handling the NMI interrupt; wrap
around when reaching the highest CPU in the mask. This rotation is achieved
by setting the affinity mask to only contain the next CPU to monitor.

In order to prevent our interrupt to be reassigned to another CPU, flag
it as IRQF_NONBALANCING.

The cpumask monitored_mask keeps track of the CPUs that the watchdog
should monitor. This structure is updated when the NMI watchdog is
enabled or disabled in a specific CPU. As this mask can change
concurrently as CPUs are put online or offline and the watchdog is
disabled or enabled, a lock is required to protect the monitored_mask.

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
 kernel/watchdog_hld_hpet.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/watchdog_hld_hpet.c b/kernel/watchdog_hld_hpet.c
index 857e051..c40acfd 100644
--- a/kernel/watchdog_hld_hpet.c
+++ b/kernel/watchdog_hld_hpet.c
@@ -10,6 +10,7 @@
 #include <linux/nmi.h>
 #include <linux/hpet.h>
 #include <asm/hpet.h>
+#include <asm/cpumask.h>
 #include <asm/irq_remapping.h>
 
 #undef pr_fmt
@@ -199,8 +200,8 @@ static irqreturn_t hardlockup_detector_irq_handler(int irq, void *data)
  * @regs:	Register values as seen when the NMI was asserted
  *
  * When an NMI is issued, look for hardlockups. If the timer is not periodic,
- * kick it. The interrupt is always handled when if delivered via the
- * Front-Side Bus.
+ * kick it. Move the interrupt to the next monitored CPU. The interrupt is
+ * always handled when if delivered via the Front-Side Bus.
  *
  * Returns:
  *
@@ -211,7 +212,7 @@ static int hardlockup_detector_nmi_handler(unsigned int val,
 					   struct pt_regs *regs)
 {
 	struct hpet_hld_data *hdata = hld_data;
-	unsigned int use_fsb;
+	unsigned int use_fsb, cpu;
 
 	/*
 	 * If FSB delivery mode is used, the timer interrupt is programmed as
@@ -222,8 +223,27 @@ static int hardlockup_detector_nmi_handler(unsigned int val,
 	if (!use_fsb && !is_hpet_wdt_interrupt(hdata))
 		return NMI_DONE;
 
+	/* There are no CPUs to monitor. */
+	if (!cpumask_weight(&hdata->monitored_mask))
+		return NMI_HANDLED;
+
 	inspect_for_hardlockups(regs);
 
+	/*
+	 * Target a new CPU. Keep trying until we find a monitored CPU. CPUs
+	 * are addded and removed to this mask at cpu_up() and cpu_down(),
+	 * respectively. Thus, the interrupt should be able to be moved to
+	 * the next monitored CPU.
+	 */
+	spin_lock(&hld_data->lock);
+	for_each_cpu_wrap(cpu, &hdata->monitored_mask, smp_processor_id() + 1) {
+		if (!irq_set_affinity(hld_data->irq, cpumask_of(cpu)))
+			break;
+		pr_err("Could not assign interrupt to CPU %d. Trying with next present CPU.\n",
+		       cpu);
+	}
+	spin_unlock(&hld_data->lock);
+
 	if (!(hdata->flags & HPET_DEV_PERI_CAP))
 		kick_timer(hdata);
 
@@ -336,7 +356,7 @@ static int setup_hpet_irq(struct hpet_hld_data *hdata)
 	 * Request an interrupt to activate the irq in all the needed domains.
 	 */
 	ret = request_irq(hwirq, hardlockup_detector_irq_handler,
-			  IRQF_TIMER | IRQF_DELIVER_AS_NMI,
+			  IRQF_TIMER | IRQF_DELIVER_AS_NMI | IRQF_NOBALANCING,
 			  "hpet_hld", hdata);
 	if (ret)
 		unregister_nmi_handler(NMI_LOCAL, "hpet_hld");
-- 
2.7.4

