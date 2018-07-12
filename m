Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30C5FC43A1D
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:08:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D32B820BEC
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 00:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a9SxLvD0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D32B820BEC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390934AbeGLANI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Jul 2018 20:13:08 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:39134 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390892AbeGLANI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jul 2018 20:13:08 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.22/8.16.0.22) with SMTP id w6C04Qut178167;
        Thu, 12 Jul 2018 00:04:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : in-reply-to : references; s=corp-2018-07-02;
 bh=BnhuCls2990QOU2QVZKg8SSP+Kb7VQwHxe4VsfAi5Qg=;
 b=a9SxLvD0pMSNpQFf6ffKELjgQonOY/C3Y6Iw+ECqWNwejTBDaPLxj3jELeFI5SDVm0hI
 YVCWn7oNIIGlUghqPJe1wGba6umwF11JuzdUw3CLFNYtx3p9efrguqMCXUuHw5Nahrbn
 hKjdTZgmtOlD1tdoaJ6ThBT9hDJrpyZCNG1cwskJpV9mA39JRkr5dHaq7zNasnHh+gfx
 9BpiqBpUScIkmtDVaMsx2MKTKE766cuZ2UuP4t4aN8nBb3Ixjf+6nnDnTA6jKo9xDvR1
 uNCmnechI1q1SptQfEF6LwlnwqoPO3gyWfxt4+wTlOiX63ZN01wq59tgiXNShWT9SS4n dg== 
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp2130.oracle.com with ESMTP id 2k2p760978-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 00:04:57 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w6C04tmm013583
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Jul 2018 00:04:56 GMT
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w6C04tT2032125;
        Thu, 12 Jul 2018 00:04:55 GMT
Received: from localhost.localdomain (/73.69.118.222)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 11 Jul 2018 17:04:55 -0700
From:   Pavel Tatashin <pasha.tatashin@oracle.com>
To:     steven.sistare@oracle.com, daniel.m.jordan@oracle.com,
        linux@armlinux.org.uk, schwidefsky@de.ibm.com,
        heiko.carstens@de.ibm.com, john.stultz@linaro.org,
        sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com,
        douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com,
        feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk,
        linux-s390@vger.kernel.org, pasha.tatashin@oracle.com,
        boris.ostrovsky@oracle.com, jgross@suse.com
Subject: [PATCH v13 16/18] sched: move sched clock initialization and merge with generic clock
Date:   Wed, 11 Jul 2018 20:04:17 -0400
Message-Id: <20180712000419.5165-17-pasha.tatashin@oracle.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180712000419.5165-1-pasha.tatashin@oracle.com>
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8951 signatures=668706
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1806210000 definitions=main-1807110252
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
 kernel/sched/clock.c        | 26 ++++++++++++++++----------
 kernel/sched/core.c         |  1 -
 kernel/time/sched_clock.c   |  2 +-
 5 files changed, 21 insertions(+), 17 deletions(-)

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
index 10c83e73837a..3b02be1fdfda 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -68,11 +68,6 @@ EXPORT_SYMBOL_GPL(sched_clock);
 
 __read_mostly int sched_clock_running;
 
-void sched_clock_init(void)
-{
-	sched_clock_running = 1;
-}
-
 #ifdef CONFIG_HAVE_UNSTABLE_SCHED_CLOCK
 /*
  * We must start with !__sched_clock_stable because the unstable -> stable
@@ -199,6 +194,15 @@ void clear_sched_clock_stable(void)
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
@@ -385,8 +389,6 @@ void sched_clock_tick(void)
 
 void sched_clock_tick_stable(void)
 {
-	u64 gtod, clock;
-
 	if (!sched_clock_stable())
 		return;
 
@@ -398,9 +400,7 @@ void sched_clock_tick_stable(void)
 	 * TSC to be unstable, any computation will be computing crap.
 	 */
 	local_irq_disable();
-	gtod = ktime_get_ns();
-	clock = sched_clock();
-	__gtod_offset = (clock + __sched_clock_offset) - gtod;
+	__sched_clock_gtod_offset();
 	local_irq_enable();
 }
 
@@ -434,6 +434,12 @@ EXPORT_SYMBOL_GPL(sched_clock_idle_wakeup_event);
 
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

