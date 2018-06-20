Return-Path: <SRS0=ENXv=JG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CCAC43141
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:29:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A71152083A
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Jun 2018 21:29:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="GBlc/Wf0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A71152083A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933580AbeFTV3S (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 17:29:18 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:43574 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933146AbeFTV3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 17:29:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w5KLPVkv005698;
        Wed, 20 Jun 2018 21:27:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2017-10-26;
 bh=YsNJp5q96MGV3JYBBW414GtWK7o5pkti4m6bDWsAKhI=;
 b=GBlc/Wf06qYJwkGRDlNxRqa55OJlta27alR3SLtu+nv+MtxpSVhDmp98Gtk3Jl9U4mO9
 NB61VuBqwL6r1Vbfy0zruIg93ctXnVAH18Tr8nTXJWNIJR/bdkC+s0lUw5YqRV/5Nh8g
 GIOWag+b+iVArqHF2Rt7SSK/u/r27xcMcSMDdp2KaCvxM9G/ezpKg4PeTnVmTtASOJti
 Mq2u00ZYopOF1HHwbKqsa4x4PBxZdooAcd4L5JVezVF7Og/AqqsqNeXNU9+Bvp3XAX4h
 jxDWDpcARs14Pd+Kz8MPRyM6TSCwrS3A+g8d+UFA2blivb9sh66p+5nGzllphDNseDmR 0A== 
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by userp2130.oracle.com with ESMTP id 2jmt01pbtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 21:27:12 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id w5KLRBAd011657
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Jun 2018 21:27:11 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w5KLR9ae000322;
        Wed, 20 Jun 2018 21:27:10 GMT
Received: from xakep.us.oracle.com (/10.39.216.167)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 Jun 2018 14:27:09 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk
Subject: [PATCH v11 3/6] time: replace read_boot_clock64() with read_persistent_wall_and_boot_offset()
Date:   Wed, 20 Jun 2018 17:26:57 -0400
Message-Id: <20180620212700.29178-4-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180620212700.29178-1-pasha.tatashin@oracle.com>
References: <20180620212700.29178-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8930 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=403
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806200231
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If architecture does not support exact boot time, it is challenging to
estimate boot time without having a reference to the current persistent
clock value. Yet, we cannot read the persistent clock time again, because
this may lead to math discrepancies with the caller of read_boot_clock64()
who have read the persistent clock at a different time.

This is why it is better to provide two values simultaneously: the
persistent clock value, and the boot time.

Thus, we replace read_boot_clock64() with:
read_persistent_wall_and_boot_offset(wall_time, boot_offset)

Where wall_time is returned by read_persistent_clock()
And boot_offset is wall_time - boot time

We calculate boot_offset using the current value of local_clock() so
architectures, that do not have a dedicated boot_clock but have early
sched_clock(), such as SPARCv9, x86, and possibly more will benefit from
this change by getting a better and more consistent estimate of the boot
time without need for an arch specific implementation.

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/arm/kernel/time.c      | 12 +-------
 arch/s390/kernel/time.c     | 11 +++++--
 include/linux/timekeeping.h |  3 +-
 kernel/time/timekeeping.c   | 61 +++++++++++++++++++------------------
 4 files changed, 43 insertions(+), 44 deletions(-)

diff --git a/arch/arm/kernel/time.c b/arch/arm/kernel/time.c
index cf2701cb0de8..0a6a457b13c7 100644
--- a/arch/arm/kernel/time.c
+++ b/arch/arm/kernel/time.c
@@ -83,29 +83,19 @@ static void dummy_clock_access(struct timespec64 *ts)
 }
 
 static clock_access_fn __read_persistent_clock = dummy_clock_access;
-static clock_access_fn __read_boot_clock = dummy_clock_access;
 
 void read_persistent_clock64(struct timespec64 *ts)
 {
 	__read_persistent_clock(ts);
 }
 
-void read_boot_clock64(struct timespec64 *ts)
-{
-	__read_boot_clock(ts);
-}
-
 int __init register_persistent_clock(clock_access_fn read_boot,
 				     clock_access_fn read_persistent)
 {
 	/* Only allow the clockaccess functions to be registered once */
-	if (__read_persistent_clock == dummy_clock_access &&
-	    __read_boot_clock == dummy_clock_access) {
-		if (read_boot)
-			__read_boot_clock = read_boot;
+	if (__read_persistent_clock == dummy_clock_access) {
 		if (read_persistent)
 			__read_persistent_clock = read_persistent;
-
 		return 0;
 	}
 
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index cf561160ea88..a69355166f97 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -221,17 +221,22 @@ void read_persistent_clock64(struct timespec64 *ts)
 	ext_to_timespec64(clk, ts);
 }
 
-void read_boot_clock64(struct timespec64 *ts)
+void __init read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
+						 struct timespec64 *boot_offset)
 {
 	unsigned char clk[STORE_CLOCK_EXT_SIZE];
+	struct timespec64 boot_time;
 	__u64 delta;
 
 	delta = initial_leap_seconds + TOD_UNIX_EPOCH;
-	memcpy(clk, tod_clock_base, 16);
+	memcpy(clk, tod_clock_base, STORE_CLOCK_EXT_SIZE);
 	*(__u64 *) &clk[1] -= delta;
 	if (*(__u64 *) &clk[1] > delta)
 		clk[0]--;
-	ext_to_timespec64(clk, ts);
+	ext_to_timespec64(clk, &boot_time);
+
+	read_persistent_clock64(wall_time);
+	*boot_offset = timespec64_sub(*wall_time, boot_time);
 }
 
 static u64 read_tod_clock(struct clocksource *cs)
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
index 4786df904c22..aface5c13e7d 100644
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
@@ -1496,18 +1497,23 @@ void __weak read_persistent_clock64(struct timespec64 *ts64)
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
+ * The default function calculates offset based on the current value of
+ * local_clock(). This way architectures that support sched_clock() but don't
+ * support dedicated boot time clock will provide the best estimate of the
+ * boot time.
  */
-void __weak read_boot_clock64(struct timespec64 *ts)
+void __weak __init
+read_persistent_wall_and_boot_offset(struct timespec64 *wall_time,
+				     struct timespec64 *boot_offset)
 {
-	ts->tv_sec = 0;
-	ts->tv_nsec = 0;
+	read_persistent_clock64(wall_time);
+	*boot_offset = ns_to_timespec64(local_clock());
 }
 
 /* Flag for if timekeeping_resume() has injected sleeptime */
@@ -1521,28 +1527,28 @@ static bool persistent_clock_exists;
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
+	    timespec64_to_ns(&wall_time)) {
+		persistent_clock_exists = true;
+	} else {
+		pr_warn("Persistent clock returned invalid value");
+		wall_time = (struct timespec64){0};
 	}
 
+	if (timespec64_compare(&wall_time, &boot_offset) < 0)
+		boot_offset = (struct timespec64){0};
+
+	/* We want set wall_to_mono, so the following is true:
+	 * wall time + wall_to_mono = boot time
+	 */
+	wall_to_mono = timespec64_sub(boot_offset, wall_time);
+
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
 	ntp_init();
@@ -1552,13 +1558,10 @@ void __init timekeeping_init(void)
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
 
-- 
2.17.1

