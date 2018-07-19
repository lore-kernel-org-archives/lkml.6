Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58601ECDFB8
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EDF9120671
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Jul 2018 22:29:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF9120671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731392AbeGSXOa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Jul 2018 19:14:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36165 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730565AbeGSXOa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jul 2018 19:14:30 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w6JMTE3B2439243
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 19 Jul 2018 15:29:14 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w6JMTEQv2439240;
        Thu, 19 Jul 2018 15:29:14 -0700
Date:   Thu, 19 Jul 2018 15:29:14 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Pavel Tatashin <tipbot@zytor.com>
Message-ID: <tip-3eca993740b8eb40f514b90b1877a4dbcf0a6710@git.kernel.org>
Cc:     hpa@zytor.com, mingo@kernel.org, linux-kernel@vger.kernel.org,
        pasha.tatashin@oracle.com, tglx@linutronix.de
Reply-To: hpa@zytor.com, pasha.tatashin@oracle.com, mingo@kernel.org,
          linux-kernel@vger.kernel.org, tglx@linutronix.de
In-Reply-To: <20180719205545.16512-16-pasha.tatashin@oracle.com>
References: <20180719205545.16512-16-pasha.tatashin@oracle.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:x86/timers] timekeeping: Replace read_boot_clock64() with
 read_persistent_wall_and_boot_offset()
Git-Commit-ID: 3eca993740b8eb40f514b90b1877a4dbcf0a6710
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  3eca993740b8eb40f514b90b1877a4dbcf0a6710
Gitweb:     https://git.kernel.org/tip/3eca993740b8eb40f514b90b1877a4dbcf0a6710
Author:     Pavel Tatashin <pasha.tatashin@oracle.com>
AuthorDate: Thu, 19 Jul 2018 16:55:34 -0400
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Fri, 20 Jul 2018 00:02:40 +0200

timekeeping: Replace read_boot_clock64() with read_persistent_wall_and_boot_offset()

If architecture does not support exact boot time, it is challenging to
estimate boot time without having a reference to the current persistent
clock value. Yet, it cannot read the persistent clock time again, because
this may lead to math discrepancies with the caller of read_boot_clock64()
who have read the persistent clock at a different time.

This is why it is better to provide two values simultaneously: the
persistent clock value, and the boot time.

Replace read_boot_clock64() with:
read_persistent_wall_and_boot_offset(wall_time, boot_offset)

Where wall_time is returned by read_persistent_clock() And boot_offset is
wall_time - boot time, which defaults to 0.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: steven.sistare@oracle.com
Cc: daniel.m.jordan@oracle.com
Cc: linux@armlinux.org.uk
Cc: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com
Cc: john.stultz@linaro.org
Cc: sboyd@codeaurora.org
Cc: hpa@zytor.com
Cc: douly.fnst@cn.fujitsu.com
Cc: peterz@infradead.org
Cc: prarit@redhat.com
Cc: feng.tang@intel.com
Cc: pmladek@suse.com
Cc: gnomes@lxorguk.ukuu.org.uk
Cc: linux-s390@vger.kernel.org
Cc: boris.ostrovsky@oracle.com
Cc: jgross@suse.com
Cc: pbonzini@redhat.com
Link: https://lkml.kernel.org/r/20180719205545.16512-16-pasha.tatashin@oracle.com

---
 include/linux/timekeeping.h |  3 ++-
 kernel/time/timekeeping.c   | 59 +++++++++++++++++++++++----------------------
 2 files changed, 32 insertions(+), 30 deletions(-)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 86bc2026efce..686bc27acef0 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -243,7 +243,8 @@ extern void ktime_get_snapshot(struct system_time_snapshot *systime_snapshot);
 extern int persistent_clock_is_local;
 
 extern void read_persistent_clock64(struct timespec64 *ts);
-extern void read_boot_clock64(struct timespec64 *ts);
+void read_persistent_clock_and_boot_offset(struct timespec64 *wall_clock,
+					   struct timespec64 *boot_offset);
 extern int update_persistent_clock64(struct timespec64 now);
 
 /*
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4786df904c22..cb738f825c12 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -17,6 +17,7 @@
 #include <linux/nmi.h>
 #include <linux/sched.h>
 #include <linux/sched/loadavg.h>
+#include <linux/sched/clock.h>
 #include <linux/syscore_ops.h>
 #include <linux/clocksource.h>
 #include <linux/jiffies.h>
@@ -1496,18 +1497,20 @@ void __weak read_persistent_clock64(struct timespec64 *ts64)
 }
 
 /**
- * read_boot_clock64 -  Return time of the system start.
+ * read_persistent_wall_and_boot_offset - Read persistent clock, and also offset
+ *                                        from the boot.
  *
  * Weak dummy function for arches that do not yet support it.
- * Function to read the exact time the system has been started.
- * Returns a timespec64 with tv_sec=0 and tv_nsec=0 if unsupported.
- *
- *  XXX - Do be sure to remove it once all arches implement it.
+ * wall_time	- current time as returned by persistent clock
+ * boot_offset	- offset that is defined as wall_time - boot_time
+ *		  default to 0.
  */
-void __weak read_boot_clock64(struct timespec64 *ts)
+void __weak __init
+read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
+				     struct timespec64 *boot_offset)
 {
-	ts->tv_sec = 0;
-	ts->tv_nsec = 0;
+	read_persistent_clock64(wall_time);
+	*boot_offset = (struct timespec64){0};
 }
 
 /* Flag for if timekeeping_resume() has injected sleeptime */
@@ -1521,28 +1524,29 @@ static bool persistent_clock_exists;
  */
 void __init timekeeping_init(void)
 {
+	struct timespec64 wall_time, boot_offset, wall_to_mono;
 	struct timekeeper *tk = &tk_core.timekeeper;
 	struct clocksource *clock;
 	unsigned long flags;
-	struct timespec64 now, boot, tmp;
-
-	read_persistent_clock64(&now);
-	if (!timespec64_valid_strict(&now)) {
-		pr_warn("WARNING: Persistent clock returned invalid value!\n"
-			"         Check your CMOS/BIOS settings.\n");
-		now.tv_sec = 0;
-		now.tv_nsec = 0;
-	} else if (now.tv_sec || now.tv_nsec)
-		persistent_clock_exists = true;
 
-	read_boot_clock64(&boot);
-	if (!timespec64_valid_strict(&boot)) {
-		pr_warn("WARNING: Boot clock returned invalid value!\n"
-			"         Check your CMOS/BIOS settings.\n");
-		boot.tv_sec = 0;
-		boot.tv_nsec = 0;
+	read_persistent_wall_and_boot_offset(&wall_time, &boot_offset);
+	if (timespec64_valid_strict(&wall_time) &&
+	    timespec64_to_ns(&wall_time) > 0) {
+		persistent_clock_exists = true;
+	} else {
+		pr_warn("Persistent clock returned invalid value");
+		wall_time = (struct timespec64){0};
 	}
 
+	if (timespec64_compare(&wall_time, &boot_offset) < 0)
+		boot_offset = (struct timespec64){0};
+
+	/*
+	 * We want set wall_to_mono, so the following is true:
+	 * wall time + wall_to_mono = boot time
+	 */
+	wall_to_mono = timespec64_sub(boot_offset, wall_time);
+
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 	ntp_init();
@@ -1552,13 +1556,10 @@ void __init timekeeping_init(void)
 		clock->enable(clock);
 	tk_setup_internals(tk, clock);
 
-	tk_set_xtime(tk, &now);
+	tk_set_xtime(tk, &wall_time);
 	tk->raw_sec = 0;
-	if (boot.tv_sec == 0 && boot.tv_nsec == 0)
-		boot = tk_xtime(tk);
 
-	set_normalized_timespec64(&tmp, -boot.tv_sec, -boot.tv_nsec);
-	tk_set_wall_to_mono(tk, tmp);
+	tk_set_wall_to_mono(tk, wall_to_mono);
 
 	timekeeping_update(tk, TK_MIRROR | TK_CLOCK_WAS_SET);
 
