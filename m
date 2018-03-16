Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752769AbeCPOTJ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 10:19:09 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57459 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750757AbeCPOTH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 10:19:07 -0400
Date: Fri, 16 Mar 2018 07:18:51 -0700
From: tip-bot for Rajvi Jingar <tipbot@zytor.com>
Message-ID: <tip-fc804f65d46236c211f530174904c1ed70db5888@git.kernel.org>
Cc: linux-kernel@vger.kernel.org, rajvi.jingar@intel.com, hpa@zytor.com,
        tglx@linutronix.de, christopher.s.hall@intel.com, mingo@kernel.org
Reply-To: hpa@zytor.com, linux-kernel@vger.kernel.org, rajvi.jingar@intel.com,
        christopher.s.hall@intel.com, mingo@kernel.org, tglx@linutronix.de
In-Reply-To: <1520530116-4925-1-git-send-email-rajvi.jingar@intel.com>
References: <1520530116-4925-1-git-send-email-rajvi.jingar@intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] x86/tsc: Convert ART in nanoseconds to TSC
Git-Commit-ID: fc804f65d46236c211f530174904c1ed70db5888
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  fc804f65d46236c211f530174904c1ed70db5888
Gitweb:     https://git.kernel.org/tip/fc804f65d46236c211f530174904c1ed70db5888
Author:     Rajvi Jingar <rajvi.jingar@intel.com>
AuthorDate: Thu, 8 Mar 2018 09:28:36 -0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 16 Mar 2018 15:14:35 +0100

x86/tsc: Convert ART in nanoseconds to TSC

Device drivers use get_device_system_crosststamp() to produce precise
system/device cross-timestamps. The PHC clock and ALSA interfaces, for
example, make the cross-timestamps available to user applications.  On
Intel platforms, get_device_system_crosststamp() requires a TSC value
derived from ART (Always Running Timer) to compute the monotonic raw and
realtime system timestamps.

Starting with Intel Goldmont platforms, the PCIe root complex supports the
PTM time sync protocol. PTM requires all timestamps to be in units of
nanoseconds. The Intel root complex hardware propagates system time derived
from ART in units of nanoseconds performing the conversion as follows:

     ART_NS = ART * 1e9 / <crystal frequency>

When user software requests a cross-timestamp, the system timestamps
(generally read from device registers) must be converted to TSC by the
driver software as follows:

    TSC = ART_NS * TSC_KHZ / 1e6

This is valid when CPU feature flag X86_FEATURE_TSC_KNOWN_FREQ is set
indicating that tsc_khz is derived from CPUID[15H]. Drivers should check
whether this flag is set before conversion to TSC is attempted.

Suggested-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Rajvi Jingar <rajvi.jingar@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: peterz@infradead.org
Link: https://lkml.kernel.org/r/1520530116-4925-1-git-send-email-rajvi.jingar@intel.com

---
 arch/x86/include/asm/tsc.h |  1 +
 arch/x86/kernel/tsc.c      | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
index cf5d53c3f9ea..2701d221583a 100644
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -31,6 +31,7 @@ static inline cycles_t get_cycles(void)
 }
 
 extern struct system_counterval_t convert_art_to_tsc(u64 art);
+extern struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns);
 
 extern void tsc_early_delay_calibrate(void);
 extern void tsc_init(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index fb4302738410..ef32297ff17e 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -1179,6 +1179,45 @@ struct system_counterval_t convert_art_to_tsc(u64 art)
 }
 EXPORT_SYMBOL(convert_art_to_tsc);
 
+/**
+ * convert_art_ns_to_tsc() - Convert ART in nanoseconds to TSC.
+ * @art_ns: ART (Always Running Timer) in unit of nanoseconds
+ *
+ * PTM requires all timestamps to be in units of nanoseconds. When user
+ * software requests a cross-timestamp, this function converts system timestamp
+ * to TSC.
+ *
+ * This is valid when CPU feature flag X86_FEATURE_TSC_KNOWN_FREQ is set
+ * indicating the tsc_khz is derived from CPUID[15H]. Drivers should check
+ * that this flag is set before conversion to TSC is attempted.
+ *
+ * Return:
+ * struct system_counterval_t - system counter value with the pointer to the
+ *	corresponding clocksource
+ *	@cycles:	System counter value
+ *	@cs:		Clocksource corresponding to system counter value. Used
+ *			by timekeeping code to verify comparibility of two cycle
+ *			values.
+ */
+
+struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
+{
+	u64 tmp, res, rem;
+
+	rem = do_div(art_ns, USEC_PER_SEC);
+
+	res = art_ns * tsc_khz;
+	tmp = rem * tsc_khz;
+
+	do_div(tmp, USEC_PER_SEC);
+	res += tmp;
+
+	return (struct system_counterval_t) { .cs = art_related_clocksource,
+					      .cycles = res};
+}
+EXPORT_SYMBOL(convert_art_ns_to_tsc);
+
+
 static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
