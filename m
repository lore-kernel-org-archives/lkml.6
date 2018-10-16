Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC395C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:55:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC6D205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 16:55:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6FC6D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbeJQAqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 20:46:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53348 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727114AbeJQAqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 20:46:36 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D5924C05006D;
        Tue, 16 Oct 2018 16:55:18 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41ABC100191D;
        Tue, 16 Oct 2018 16:55:14 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v3] kernel/hung_task.c: disable on suspend
Date:   Tue, 16 Oct 2018 18:55:13 +0200
Message-Id: <20181016165513.7133-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Tue, 16 Oct 2018 16:55:18 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to observe hung_task complaints when system goes to
suspend-to-idle state:

 # echo freeze > /sys/power/state

 PM: Syncing filesystems ... done.
 Freezing user space processes ... (elapsed 0.001 seconds) done.
 OOM killer disabled.
 Freezing remaining freezable tasks ... (elapsed 0.002 seconds) done.
 sd 0:0:0:0: [sda] Synchronizing SCSI cache
 INFO: task bash:1569 blocked for more than 120 seconds.
       Not tainted 4.19.0-rc3_+ #687
 "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
 bash            D    0  1569    604 0x00000000
 Call Trace:
  ? __schedule+0x1fe/0x7e0
  schedule+0x28/0x80
  suspend_devices_and_enter+0x4ac/0x750
  pm_suspend+0x2c0/0x310

Register a PM notifier to disable the detector on suspend and re-enable
back on wakeup.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes since v2:
- Resurrect 'v1' as zeroing timeouts can be racy [Rafael J. Wysocki]
---
 kernel/hung_task.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index b9132d1269ef..41955c5d8427 100644
--- a/kernel/hung_task.c
+++ b/kernel/hung_task.c
@@ -15,6 +15,7 @@
 #include <linux/lockdep.h>
 #include <linux/export.h>
 #include <linux/sysctl.h>
+#include <linux/suspend.h>
 #include <linux/utsname.h>
 #include <linux/sched/signal.h>
 #include <linux/sched/debug.h>
@@ -242,6 +243,26 @@ void reset_hung_task_detector(void)
 }
 EXPORT_SYMBOL_GPL(reset_hung_task_detector);
 
+static bool hung_detector_suspended;
+
+static int hungtask_pm_notify(struct notifier_block *self,
+			      unsigned long action, void *hcpu)
+{
+	switch (action) {
+	case PM_SUSPEND_PREPARE:
+	case PM_HIBERNATION_PREPARE:
+		hung_detector_suspended = true;
+		break;
+	case PM_POST_SUSPEND:
+	case PM_POST_HIBERNATION:
+		hung_detector_suspended = false;
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
 /*
  * kthread which checks for tasks stuck in D state
  */
@@ -261,7 +282,8 @@ static int watchdog(void *dummy)
 		interval = min_t(unsigned long, interval, timeout);
 		t = hung_timeout_jiffies(hung_last_checked, interval);
 		if (t <= 0) {
-			if (!atomic_xchg(&reset_hung_task, 0))
+			if (!atomic_xchg(&reset_hung_task, 0) &&
+			    !hung_detector_suspended)
 				check_hung_uninterruptible_tasks(timeout);
 			hung_last_checked = jiffies;
 			continue;
@@ -275,6 +297,10 @@ static int watchdog(void *dummy)
 static int __init hung_task_init(void)
 {
 	atomic_notifier_chain_register(&panic_notifier_list, &panic_block);
+
+	/* Disable hung task detector on suspend */
+	pm_notifier(hungtask_pm_notify, 0);
+
 	watchdog_task = kthread_run(watchdog, NULL, "khungtaskd");
 
 	return 0;
-- 
2.17.1

