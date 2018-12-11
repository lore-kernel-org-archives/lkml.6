Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09198C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD16020880
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:11:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD16020880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbeLKPLb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:11:31 -0500
Received: from relay.sw.ru ([185.231.240.75]:58724 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726402AbeLKPLb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:11:31 -0500
Received: from [172.16.25.169] (helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.91)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1gWjh0-0001Dg-EJ; Tue, 11 Dec 2018 18:11:26 +0300
Subject: [PATCH v3] ksm: React on changing "sleep_millisecs" parameter faster
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     akpm@linux-foundation.org, mhocko@suse.com, ktkhai@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        gorcunov@virtuozzo.com
Date:   Tue, 11 Dec 2018 18:11:25 +0300
Message-ID: <154454107680.3258.3558002210423531566.stgit@localhost.localdomain>
In-Reply-To: <2dd9cc7b-9384-df11-bb5a-3aed45cc914b@virtuozzo.com>
References: <2dd9cc7b-9384-df11-bb5a-3aed45cc914b@virtuozzo.com>
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

v3: Do not use mutex: to acquire it may take much time in case long
    list of ksm'able mm and pages.
v2: Use wait_event_interruptible_timeout() instead of unconditional
    schedule_timeout().
---
 mm/ksm.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/ksm.c b/mm/ksm.c
index daa14db01e4d..383f961e577a 100644
--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -296,6 +296,7 @@ static unsigned long ksm_run = KSM_RUN_STOP;
 static void wait_while_offlining(void);
 
 static DECLARE_WAIT_QUEUE_HEAD(ksm_thread_wait);
+static DECLARE_WAIT_QUEUE_HEAD(ksm_iter_wait);
 static DEFINE_MUTEX(ksm_thread_mutex);
 static DEFINE_SPINLOCK(ksm_mmlist_lock);
 
@@ -2412,6 +2413,8 @@ static int ksmd_should_run(void)
 
 static int ksm_scan_thread(void *nothing)
 {
+	unsigned int sleep_ms;
+
 	set_freezable();
 	set_user_nice(current, 5);
 
@@ -2425,8 +2428,10 @@ static int ksm_scan_thread(void *nothing)
 		try_to_freeze();
 
 		if (ksmd_should_run()) {
-			schedule_timeout_interruptible(
-				msecs_to_jiffies(ksm_thread_sleep_millisecs));
+			sleep_ms = READ_ONCE(ksm_thread_sleep_millisecs);
+			wait_event_interruptible_timeout(ksm_iter_wait,
+				sleep_ms != READ_ONCE(ksm_thread_sleep_millisecs),
+				msecs_to_jiffies(sleep_ms));
 		} else {
 			wait_event_freezable(ksm_thread_wait,
 				ksmd_should_run() || kthread_should_stop());
@@ -2845,6 +2850,7 @@ static ssize_t sleep_millisecs_store(struct kobject *kobj,
 		return -EINVAL;
 
 	ksm_thread_sleep_millisecs = msecs;
+	wake_up_interruptible(&ksm_iter_wait);
 
 	return count;
 }

