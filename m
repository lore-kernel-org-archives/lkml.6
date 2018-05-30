Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S968908AbeE3JUp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 05:20:45 -0400
Received: from mga17.intel.com ([192.55.52.151]:22680 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965116AbeE3JUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 05:20:37 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,459,1520924400";
   d="scan'208";a="232890677"
From: Feng Tang <feng.tang@intel.com>
To: Petr Mladek <pmladek@suse.com>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Alan Cox <gnomes@lxorguk.ukuu.org.uk>,
        Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Cc: alek.du@intel.com, Feng Tang <feng.tang@intel.com>
Subject: [RFC 1/2] printk: Enable platform to provide a early boot clock
Date: Wed, 30 May 2018 17:20:58 +0800
Message-Id: <1527672059-6225-1-git-send-email-feng.tang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently printk timestamp mostly come from the sched_clock which
depends on the clock setup, so there are many kernel logs started
with "[    0.000000]   " before the clock is calibrated.

This patch will provide an debug option for specific platform to
provide a early boot time clock, so that we can have time info in
kernel log much earlier, which can show the time info for the early
kernel boot, and make boottime tuning/optimization easier (boot time
is critical for phone/tablet and embedded devices).

Capable platform only need to setup the "boot_printk_clock_fn"
which could return time in nano seconds.

Together with a TSC patch on x86 system, we have easily captured
some early boottime killer like unwind_init() which takes about
300ms in boot phase.

Signed-off-by: Feng Tang <feng.tang@intel.com>
---
 include/linux/printk.h |  3 +++
 kernel/printk/printk.c | 15 +++++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/include/linux/printk.h b/include/linux/printk.h
index 6d7e800..7c13d4a 100644
--- a/include/linux/printk.h
+++ b/include/linux/printk.h
@@ -188,6 +188,9 @@ extern bool printk_timed_ratelimit(unsigned long *caller_jiffies,
 extern int printk_delay_msec;
 extern int dmesg_restrict;
 
+/* Return boot timestamp in nano seconds */
+extern u64 (*boot_printk_clock_fn)(void);
+
 extern int
 devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write, void __user *buf,
 			  size_t *lenp, loff_t *ppos);
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 2f4af21..7feffd8 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -190,6 +190,17 @@ int devkmsg_sysctl_set_loglvl(struct ctl_table *table, int write,
 	return 0;
 }
 
+u64 (*boot_printk_clock_fn)(void) __read_mostly;
+
+static u64 printk_clock(void)
+{
+	/* If platform provides early boot printk clock, then use it */
+	if (unlikely(system_state == SYSTEM_BOOTING && boot_printk_clock_fn))
+		return boot_printk_clock_fn();
+	else
+		return local_clock();
+}
+
 /*
  * Number of registered extended console drivers.
  *
@@ -628,7 +639,7 @@ static int log_store(int facility, int level,
 	if (ts_nsec > 0)
 		msg->ts_nsec = ts_nsec;
 	else
-		msg->ts_nsec = local_clock();
+		msg->ts_nsec = printk_clock();
 	memset(log_dict(msg) + dict_len, 0, pad_len);
 	msg->len = size;
 
@@ -1775,7 +1786,7 @@ static bool cont_add(int facility, int level, enum log_flags flags, const char *
 		cont.facility = facility;
 		cont.level = level;
 		cont.owner = current;
-		cont.ts_nsec = local_clock();
+		cont.ts_nsec = printk_clock();
 		cont.flags = flags;
 	}
 
-- 
2.7.4
