Return-Path: <SRS0=HyMZ=RC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52B8EC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:06:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24F39217F5
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Feb 2019 16:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730113AbfB0QGB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Feb 2019 11:06:01 -0500
Received: from mga02.intel.com ([134.134.136.20]:24149 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730001AbfB0QF4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Feb 2019 11:05:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Feb 2019 08:05:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,420,1544515200"; 
   d="scan'208";a="303011731"
Received: from unknown (HELO luv-build.sc.intel.com) ([172.25.110.25])
  by orsmga005.jf.intel.com with ESMTP; 27 Feb 2019 08:05:54 -0800
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>
Cc:     Ashok Raj <ashok.raj@intel.com>, Andi Kleen <andi.kleen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri@intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Tony Luck <tony.luck@intel.com>,
        Clemens Ladisch <clemens@ladisch.de>,
        Arnd Bergmann <arnd@arndb.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Nayna Jain <nayna@linux.ibm.com>
Subject: [RFC PATCH v2 12/14] x86/watchdog/hardlockup/hpet: Determine if HPET timer caused NMI
Date:   Wed, 27 Feb 2019 08:05:16 -0800
Message-Id: <1551283518-18922-13-git-send-email-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
References: <1551283518-18922-1-git-send-email-ricardo.neri-calderon@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The only direct method to determine whether an HPET timer caused an
interrupt is to read the Interrupt Status register. Unfortunately,
reading HPET registers is slow and, therefore, it is not recommended to
read them while in NMI context. Furthermore, status is not available if
the interrupt is generated vi the Front Side Bus.

An indirect manner is to compute the expected value of the the time-stamp
counter and, at the time of the interrupt and verify that its actual
value is within a range of the expected value. Since the hardlockup
detector operates in seconds, high precision is not needed. This
implementation considers that the HPET caused the HMI if the time-stamp
counter reads the expected value -/+ 1.5%. This value is selected is it
is equivalent to 1/64 and the division can be performed using bit
shifts. Experimentally, the error in the estimation is consistently less
than 1%.

Also, only read the time-stamp counter of the handling CPU (the one
targeted by the HPET timer). This helps to avoid variability of the time
stamp across CPUs.

Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Andi Kleen <andi.kleen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Clemens Ladisch <clemens@ladisch.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Nayna Jain <nayna@linux.ibm.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: x86@kernel.org
Suggested-by: Andi Kleen <andi.kleen@intel.com> 
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/hpet.h         |  2 ++
 arch/x86/kernel/watchdog_hld_hpet.c | 28 +++++++++++++++++++++++++---
 2 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/hpet.h b/arch/x86/include/asm/hpet.h
index 15dc3b576496..09763340c911 100644
--- a/arch/x86/include/asm/hpet.h
+++ b/arch/x86/include/asm/hpet.h
@@ -123,6 +123,8 @@ struct hpet_hld_data {
 	u32		num;
 	u32		flags;
 	u64		ticks_per_second;
+	u64		tsc_next;
+	u64		tsc_next_error;
 	u32		handling_cpu;
 	struct cpumask	cpu_monitored_mask;
 	struct msi_msg	msi_msg;
diff --git a/arch/x86/kernel/watchdog_hld_hpet.c b/arch/x86/kernel/watchdog_hld_hpet.c
index cfa284da4bf6..65b4699f249a 100644
--- a/arch/x86/kernel/watchdog_hld_hpet.c
+++ b/arch/x86/kernel/watchdog_hld_hpet.c
@@ -55,6 +55,11 @@ static inline void set_comparator(struct hpet_hld_data *hdata,
  *
  * Reprogram the timer to expire within watchdog_thresh seconds in the future.
  *
+ * Also compute the expected value of the time-stamp counter at the time of
+ * expiration as well as a deviation from the expected value. The maximum
+ * deviation is of ~1.5%. This deviation can be easily computed by shifting
+ * by 6 positions the delta between the current and expected time-stamp values.
+ *
  * Returns:
  *
  * None
@@ -62,7 +67,18 @@ static inline void set_comparator(struct hpet_hld_data *hdata,
 static void kick_timer(struct hpet_hld_data *hdata, bool force)
 {
 	bool kick_needed = force || !(hdata->flags & HPET_DEV_PERI_CAP);
-	unsigned long new_compare, count;
+	unsigned long tsc_curr, tsc_delta, new_compare, count;
+
+	/* Start obtaining the current TSC and HPET counts. */
+	tsc_curr = rdtsc();
+
+	if (kick_needed)
+		count = get_count();
+
+	tsc_delta = (unsigned long)watchdog_thresh * (unsigned long)tsc_khz
+		    * 1000L;
+	hdata->tsc_next = tsc_curr + tsc_delta;
+	hdata->tsc_next_error = tsc_delta >> 6;
 
 	/*
 	 * Update the comparator in increments of watch_thresh seconds relative
@@ -74,8 +90,6 @@ static void kick_timer(struct hpet_hld_data *hdata, bool force)
 	 */
 
 	if (kick_needed) {
-		count = get_count();
-
 		new_compare = count + watchdog_thresh * hdata->ticks_per_second;
 
 		set_comparator(hdata, new_compare);
@@ -147,6 +161,14 @@ static void set_periodic(struct hpet_hld_data *hdata)
  */
 static bool is_hpet_wdt_interrupt(struct hpet_hld_data *hdata)
 {
+	if (smp_processor_id() == hdata->handling_cpu) {
+		unsigned long tsc_curr;
+
+		tsc_curr = rdtsc();
+		if (abs(tsc_curr - hdata->tsc_next) < hdata->tsc_next_error)
+			return true;
+	}
+
 	return false;
 }
 
-- 
2.17.1

