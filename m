Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF230C6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:57:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F5A52064D
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 15:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="NJBZzzI6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F5A52064D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732016AbeGZROd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 13:14:33 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:60598 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730413AbeGZROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 13:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1532620625; x=1564156625;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=z4BIzbPHdEU6SvDRqMmX28XcZhsZwFBJKx17wqXUjt0=;
  b=NJBZzzI6ZKsPYFYSN7yTWyid4ahaQ/TH65291BO0C7DyH4MIlDnBq7Vt
   xX7eHPnEMraU4LQER4YXEjA8rXqRfdl4wWCviFb7N4rI6NsRc/TEOWLti
   QkeuBQcHwOCidBvEawU0vFcBLtHaa3jhQn0qnz+MA7NFNVJHVx9Mkdjzo
   0=;
X-IronPort-AV: E=Sophos;i="5.51,405,1526342400"; 
   d="scan'208";a="349406153"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 26 Jul 2018 15:57:02 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2c-579b7f5b.us-west-2.amazon.com (8.14.7/8.14.7) with ESMTP id w6QFuxVa066597
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=FAIL);
        Thu, 26 Jul 2018 15:57:00 GMT
Received: from EX13D05UWB001.ant.amazon.com (10.43.161.181) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 26 Jul 2018 15:56:59 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D05UWB001.ant.amazon.com (10.43.161.181) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 26 Jul 2018 15:56:59 +0000
Received: from localhost (10.88.47.215) by mail-relay.amazon.com
 (10.43.161.249) with Microsoft SMTP Server id 15.0.1367.3 via Frontend
 Transport; Thu, 26 Jul 2018 15:56:58 +0000
From:   Eduardo Valentin <eduval@amazon.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
CC:     Eduardo Valentin <eduval@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dou Liyang <douly.fnst@cn.fujitsu.com>,
        Len Brown <len.brown@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "mike.travis@hpe.com" <mike.travis@hpe.com>,
        Rajvi Jingar <rajvi.jingar@intel.com>,
        Pavel Tatashin <pasha.tatashin@oracle.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>
Subject: [PATCH RESEND 1/1] x86: tsc: avoid system instability in hibernation
Date:   Thu, 26 Jul 2018 08:56:56 -0700
Message-ID: <20180726155656.14873-1-eduval@amazon.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System instability are seen during resume from hibernation when system
is under heavy CPU load. This is due to the lack of update of sched
clock data, and the scheduler would then think that heavy CPU hog
tasks need more time in CPU, causing the system to freeze
during the unfreezing of tasks. For example, threaded irqs,
and kernel processes servicing network interface may be delayed
for several tens of seconds, causing the system to be unreachable.

Situation like this can be reported by using lockup detectors
such as workqueue lockup detectors:

[root@ip-172-31-67-114 ec2-user]# echo disk > /sys/power/state

Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
 kernel:BUG: workqueue lockup - pool cpus=0 node=0 flags=0x0 nice=0 stuck for 57s!

Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
 kernel:BUG: workqueue lockup - pool cpus=1 node=0 flags=0x0 nice=0 stuck for 57s!

Message from syslogd@ip-172-31-67-114 at May  7 18:23:21 ...
 kernel:BUG: workqueue lockup - pool cpus=3 node=0 flags=0x1 nice=0 stuck for 57s!

Message from syslogd@ip-172-31-67-114 at May  7 18:29:06 ...
 kernel:BUG: workqueue lockup - pool cpus=3 node=0 flags=0x1 nice=0 stuck for 403s!

The fix for this situation is to mark the sched clock as unstable
as early as possible in the resume path, leaving it unstable
for the duration of the resume process. This will force the
scheduler to attempt to align the sched clock across CPUs using
the delta with time of day, updating sched clock data. In a post
hibernation event, we can then mark the sched clock as stable
again, avoiding unnecessary syncs with time of day on systems
in which TSC is reliable.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Dou Liyang <douly.fnst@cn.fujitsu.com>
Cc: Len Brown <len.brown@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: Eduardo Valentin <eduval@amazon.com>
Cc: "mike.travis@hpe.com" <mike.travis@hpe.com>
Cc: Rajvi Jingar <rajvi.jingar@intel.com>
Cc: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduval@amazon.com>
---

Hey,

No changes from first attempt, no pressure on resending. The RESEND
tag is just because I missed linux-pm in the first attempt.

BR,

 arch/x86/kernel/tsc.c       | 29 +++++++++++++++++++++++++++++
 include/linux/sched/clock.h |  5 +++++
 kernel/sched/clock.c        |  4 ++--
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 8ea117f8142e..f197c9742fef 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -13,6 +13,7 @@
 #include <linux/percpu.h>
 #include <linux/timex.h>
 #include <linux/static_key.h>
+#include <linux/suspend.h>
 
 #include <asm/hpet.h>
 #include <asm/timer.h>
@@ -1377,3 +1378,31 @@ unsigned long calibrate_delay_is_known(void)
 	return 0;
 }
 #endif
+
+static int tsc_pm_notifier(struct notifier_block *notifier,
+			   unsigned long pm_event, void *unused)
+{
+	switch (pm_event) {
+	case PM_HIBERNATION_PREPARE:
+		clear_sched_clock_stable();
+		break;
+	case PM_POST_HIBERNATION:
+		/* Set back to the default */
+		if (!check_tsc_unstable())
+			set_sched_clock_stable();
+		break;
+	}
+
+	return 0;
+};
+
+static struct notifier_block tsc_pm_notifier_block = {
+	.notifier_call = tsc_pm_notifier,
+};
+
+static int tsc_setup_pm_notifier(void)
+{
+	return register_pm_notifier(&tsc_pm_notifier_block);
+}
+
+subsys_initcall(tsc_setup_pm_notifier);
diff --git a/include/linux/sched/clock.h b/include/linux/sched/clock.h
index 867d588314e0..902654ac5f7e 100644
--- a/include/linux/sched/clock.h
+++ b/include/linux/sched/clock.h
@@ -32,6 +32,10 @@ static inline void clear_sched_clock_stable(void)
 {
 }
 
+static inline void set_sched_clock_stable(void)
+{
+}
+
 static inline void sched_clock_idle_sleep_event(void)
 {
 }
@@ -51,6 +55,7 @@ static inline u64 local_clock(void)
 }
 #else
 extern int sched_clock_stable(void);
+extern void set_sched_clock_stable(void);
 extern void clear_sched_clock_stable(void);
 
 /*
diff --git a/kernel/sched/clock.c b/kernel/sched/clock.c
index e086babe6c61..8453440e236c 100644
--- a/kernel/sched/clock.c
+++ b/kernel/sched/clock.c
@@ -131,7 +131,7 @@ static void __scd_stamp(struct sched_clock_data *scd)
 	scd->tick_raw = sched_clock();
 }
 
-static void __set_sched_clock_stable(void)
+void set_sched_clock_stable(void)
 {
 	struct sched_clock_data *scd;
 
@@ -228,7 +228,7 @@ static int __init sched_clock_init_late(void)
 	smp_mb(); /* matches {set,clear}_sched_clock_stable() */
 
 	if (__sched_clock_stable_early)
-		__set_sched_clock_stable();
+		set_sched_clock_stable();
 
 	return 0;
 }
-- 
2.18.0

