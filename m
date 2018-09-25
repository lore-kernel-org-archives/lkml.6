Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA820C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:16:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 697ED2086B
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 12:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 697ED2086B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729023AbeIYSYB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 14:24:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56358 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727531AbeIYSYB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 14:24:01 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 13979368E7;
        Tue, 25 Sep 2018 12:16:44 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.43.2.217])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9D3EE60BEC;
        Tue, 25 Sep 2018 12:16:37 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>
Subject: [PATCH v2] kernel/hung_task.c: disable on suspend
Date:   Tue, 25 Sep 2018 14:16:36 +0200
Message-Id: <20180925121636.592-1-vkuznets@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Tue, 25 Sep 2018 12:16:44 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is possible to observe hung_task complaints when system goes to
suspend-to-idle state:

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

The root cause of the issue is that under certain circumstances jiffies
counter keeps advancing, some work to prevent that is currently ongoing.
However, it seems that it would make sense to disable hung task detector
on suspend and re-enable it on wakeup regardless.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
Changes since v1:
- Implement detector disabling by zeroing timeout [Rafael J. Wysocki]
---
 kernel/hung_task.c | 36 +++++++++++++++++++++++++++++++++++-
 1 file changed, 35 insertions(+), 1 deletion(-)

diff --git a/kernel/hung_task.c b/kernel/hung_task.c
index b9132d1269ef..ac6e8c9306bd 100644
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
@@ -242,12 +243,14 @@ void reset_hung_task_detector(void)
 }
 EXPORT_SYMBOL_GPL(reset_hung_task_detector);
 
+static unsigned long hung_last_checked;
+
 /*
  * kthread which checks for tasks stuck in D state
  */
 static int watchdog(void *dummy)
 {
-	unsigned long hung_last_checked = jiffies;
+	hung_last_checked = jiffies;
 
 	set_user_nice(current, 0);
 
@@ -272,9 +275,40 @@ static int watchdog(void *dummy)
 	return 0;
 }
 
+static int hungtask_pm_notify(struct notifier_block *self,
+			      unsigned long action, void *hcpu)
+{
+	static unsigned long saved_timeout, saved_interval;
+
+	switch (action) {
+	case PM_SUSPEND_PREPARE:
+	case PM_HIBERNATION_PREPARE:
+		saved_timeout = sysctl_hung_task_timeout_secs;
+		saved_interval = sysctl_hung_task_check_interval_secs;
+		sysctl_hung_task_timeout_secs = 0;
+		sysctl_hung_task_check_interval_secs = 0;
+		wake_up_process(watchdog_task);
+		break;
+	case PM_POST_SUSPEND:
+	case PM_POST_HIBERNATION:
+		sysctl_hung_task_timeout_secs = saved_timeout;
+		sysctl_hung_task_check_interval_secs = saved_interval;
+		hung_last_checked = jiffies;
+		wake_up_process(watchdog_task);
+		break;
+	default:
+		break;
+	}
+	return NOTIFY_OK;
+}
+
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

