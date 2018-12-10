Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A919C6783B
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:06:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE5F22082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 16:06:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5F22082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727264AbeLJQGX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 11:06:23 -0500
Received: from relay.sw.ru ([185.231.240.75]:41316 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726146AbeLJQGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 11:06:23 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gWO4Z-0005ja-Bu; Mon, 10 Dec 2018 19:06:19 +0300
Subject: [PATCH] ksm: React on changing "sleep_millisecs" parameter faster
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, ktkhai@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gorcunov@virtuozzo.com
Date:   Mon, 10 Dec 2018 19:06:18 +0300
Message-ID: <154445792450.3178.16241744401215933502.stgit@localhost.localdomain>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ksm thread unconditionally sleeps in ksm_scan_thread()
after each iteration:

	schedule_timeout_interruptible(
		msecs_to_jiffies(ksm_thread_sleep_millisecs))

The timeout is configured in /sys/kernel/mm/ksm/sleep_millisecs.

In case of user writes a big value by a mistake, and the thread
enters into schedule_timeout_interruptible(), it's not possible
to cancel the sleep by writing a new smaler value; the thread
is just sleeping till timeout expires.

The patch fixes the problem by waking the thread each time
after the value is updated.

This also may be useful for debug purposes; and also for userspace
daemons, which change sleep_millisecs value in dependence of
system load.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 mm/ksm.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index 723bd32d4dd0..31452122e52b 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -294,6 +294,7 @@ static int ksm_nr_node_ids = 1;
 #define KSM_RUN_OFFLINE	4
 static unsigned long ksm_run = KSM_RUN_STOP;
 static void wait_while_offlining(void);
+static struct task_struct *ksm_task = NULL;
 
 static DECLARE_WAIT_QUEUE_HEAD(ksm_thread_wait);
 static DEFINE_MUTEX(ksm_thread_mutex);
@@ -2435,8 +2436,9 @@ static int ksm_scan_thread(void *nothing)
 	set_freezable();
 	set_user_nice(current, 5);
 
+	mutex_lock(&ksm_thread_mutex);
+	ksm_task = current;
 	while (!kthread_should_stop()) {
-		mutex_lock(&ksm_thread_mutex);
 		wait_while_offlining();
 		if (ksmd_should_run())
 			ksm_do_scan(ksm_thread_pages_to_scan);
@@ -2451,7 +2453,10 @@ static int ksm_scan_thread(void *nothing)
 			wait_event_freezable(ksm_thread_wait,
 				ksmd_should_run() || kthread_should_stop());
 		}
+		mutex_lock(&ksm_thread_mutex);
 	}
+	ksm_task = NULL;
+	mutex_unlock(&ksm_thread_mutex);
 	return 0;
 }
 
@@ -2864,7 +2869,11 @@ static ssize_t sleep_millisecs_store(struct kobject *kobj,
 	if (err || msecs > UINT_MAX)
 		return -EINVAL;
 
+	mutex_lock(&ksm_thread_mutex);
+	if (ksm_task)
+		wake_up_state(ksm_task, TASK_INTERRUPTIBLE);
 	ksm_thread_sleep_millisecs = msecs;
+	mutex_unlock(&ksm_thread_mutex);
 
 	return count;
 }

