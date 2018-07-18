Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7182ECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:25:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 994792075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 02:25:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="x4QbQ19e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 994792075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732063AbeGRDBA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:01:00 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:45048 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731800AbeGRC7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 22:59:40 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6I2LgEI002259;
        Wed, 18 Jul 2018 02:23:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=wP1EAwPBudwlpkgBbz/HfISvhtkakFKuwq1hfZ/WEPo=;
 b=x4QbQ19eao0qvs4J70KPDz2U7Xnx9wXXXX5LaWILgkNtSWTAhc5F0oNPbdnH4Vzy/DeK
 ZlunA5cBvzNFOydomZuLbt42Hdij5AHhrf2TwrLWBYYYaykPXGmtV1XrMbtaW5ckatFl
 NOnGXQij7SviGBb+GOwWXA5Nm+YqmJaaAMW+c44iZNmpkziFHbCrVxtWJExpNV0vRyJL
 45EqWz0h8IYS6pNo9rURbSTG+7B0cIccBwFivPNyCBfYvhhk6ZPJ6u5Hw1lWH2nJcDla
 6lT4CrSyySFztszgtkY+v0veByJ3gHOFwXV0TH9EhHhf+P5sUjOQMeyeWhOedHthyl+B lQ== 
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
        by aserp2130.oracle.com with ESMTP id 2k7a3t34dv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:23:18 +0000
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2NI0R029182
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Jul 2018 02:23:18 GMT
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w6I2NH02017708;
        Wed, 18 Jul 2018 02:23:17 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 17 Jul 2018 19:23:16 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, pasha.tatashin@oracle.com,
        boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
Subject: [PATCH v14 23/25] sched: move sched clock initialization and merge with generic clock
Date:   Tue, 17 Jul 2018 22:22:09 -0400
Message-Id: <20180718022211.6259-24-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718022211.6259-1-pasha.tatashin@oracle.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8957 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807180026
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_clock_postinit() initializes a generic clock on systems where no
other clock is porvided. This function may be called only after
timekeeping_init().

Rename sched_clock_postinit to generic_clock_inti() and call it from
sched_clock_init(). Move the call for sched_clock_init() until after
time_init().

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 include/linux/sched_clock.h |  5 ++---
 init/main.c                 |  4 ++--
 kernel/sched/clock.c        | 27 +++++++++++++++++----------
 kernel/sched/core.c         |  1 -
 kernel/time/sched_clock.c   |  2 +-
 5 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/include/linux/sched_clock.h b/include/linux/sched_clock.h
index 411b52e424e1..abe28d5cb3f4 100644
--- a/include/linux/sched_clock.h
+++ b/include/linux/sched_clock.h
@@ -9,17 +9,16 @@
 #define LINUX_SCHED_CLOCK
 
 #ifdef CONFIG_GENERIC_SCHED_CLOCK
-extern void sched_clock_postinit(void);
+extern void generic_sched_clock_init(void);
 
 extern void sched_clock_register(u64 (*read)(void), int bits,
 				 unsigned long rate);
 #else
-static inline void sched_clock_postinit(void) { }
+static inline void generic_sched_clock_init(void) { }
 
 static inline void sched_clock_register(u64 (*read)(void), int bits,
 					unsigned long rate)
 {
-	;
 }
 #endif
 
diff --git a/init/main.c b/init/main.c
index 3b4ada11ed52..162d931c9511 100644
--- a/init/main.c
+++ b/init/main.c
@@ -79,7 +79,7 @@
 #include <linux/pti.h>
 #include <linux/blkdev.h>
 #include <linux/elevator.h>
-#include <linux/sched_clock.h>
+#include <linux/sched/clock.h>
 #include <linux/sched/task.h>
 #include <linux/sched/task_stack.h>
 #include <linux/context_tracking.h>
@@ -642,7 +642,7 @@ asmlinkage __visible void __init start_kernel(void)
 	softirq_init();
 	timekeeping_init();
 	time_init();
-	sched_clock_postinit();
+	sched_clock_init();
 	printk_safe_init();
 	perf_event_init();
 	profile_init();
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index 10c83e73837a..0e9dbb2d9aea 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -53,6 +53,7 @@
  *
  */
 #include "sched.h"
+#include <linux/sched_clock.h>
 
 /*
  * Scheduler clock - returns current time in nanosec units.
@@ -68,11 +69,6 @@ EXPORT_SYMBOL_GPL(sched_clock);
 
 __read_mostly int sched_clock_running;
 
-void sched_clock_init(void)
-{
-	sched_clock_running = 1;
-}
-
 #ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
 /*
  * We must start with !__sched_clock_stable because the unstable -> stable
@@ -199,6 +195,15 @@ void clear_sched_clock_stable(void)
 		__clear_sched_clock_stable();
 }
 
+static void __sched_clock_gtod_offset(void)
+{
+	__gtod_offset = (sched_clock() + __sched_clock_offset) - ktime_get_ns();
+}
+
+void __init sched_clock_init(void)
+{
+	sched_clock_running = 1;
+}
 /*
  * We run this as late_initcall() such that it runs after all built-in drivers,
  * notably: acpi_processor and intel_idle, which can mark the TSC as unstable.
@@ -385,8 +390,6 @@ void sched_clock_tick(void)
 
 void sched_clock_tick_stable(void)
 {
-	u64 gtod, clock;
-
 	if (!sched_clock_stable())
 		return;
 
@@ -398,9 +401,7 @@ void sched_clock_tick_stable(void)
 	 * TSC to be unstable, any computation will be computing crap.
 	 */
 	local_irq_disable();
-	gtod = ktime_get_ns();
-	clock = sched_clock();
-	__gtod_offset = (clock + __sched_clock_offset) - gtod;
+	__sched_clock_gtod_offset();
 	local_irq_enable();
 }
 
@@ -434,6 +435,12 @@ EXPORT_SYMBOL_GPL(sched_clock_idle_wakeup_event);
 
 #else /* CONFIG_HAVE_UNSTABLE_SCHED_CLOCK */
 
+void __init sched_clock_init(void)
+{
+	sched_clock_running = 1;
+	generic_sched_clock_init();
+}
+
 u64 sched_clock_cpu(int cpu)
 {
 	if (unlikely(!sched_clock_running))
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index fe365c9a08e9..552406e9713b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5954,7 +5954,6 @@ void __init sched_init(void)
 	int i, j;
 	unsigned long alloc_size = 0, ptr;
 
-	sched_clock_init();
 	wait_bit_init();
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 2d8f05aad442..cbc72c2c1fca 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -237,7 +237,7 @@ sched_clock_register(u64 (*read)(void), int bits, unsigned long rate)
 	pr_debug("Registered %pF as sched_clock source\n", read);
 }
 
-void __init sched_clock_postinit(void)
+void __init generic_sched_clock_init(void)
 {
 	/*
 	 * If no sched_clock() function has been provided at that point,
-- 
2.18.0

