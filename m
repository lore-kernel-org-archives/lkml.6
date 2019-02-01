Return-Path: <SRS0=KKla=QI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E04EC282D8
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:39:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BF2820863
	for <linux-kernel@archiver.kernel.org>; Fri,  1 Feb 2019 05:39:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbfBAFjK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 1 Feb 2019 00:39:10 -0500
Received: from relay5-d.mail.gandi.net ([217.70.183.197]:50909 "EHLO
        relay5-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726060AbfBAFjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Feb 2019 00:39:09 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id A81631C0005;
        Fri,  1 Feb 2019 05:39:03 +0000 (UTC)
Date:   Fri, 1 Feb 2019 06:39:03 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Greg Hartman <ghartman@google.com>,
        Alistair Strachan <strachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 3/3] staging/android: simplify handle_vsoc_cond_wait
Message-ID: <f258c416123048ef9eb78baa8ee891b8aa4f6955.1548998323.git.hle@owl.eu.com>
References: <cover.1548998323.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1548998323.git.hle@owl.eu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simplify handle_vsoc_cond_wait (drivers/staging/android/vsoc.c) using newly
added wait_event_freezable_hrtimeout helper and remove useless includes.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
 drivers/staging/android/vsoc.c | 69 +++++-----------------------------
 1 file changed, 10 insertions(+), 59 deletions(-)

diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 22571abcaa4e..7e620e69f39d 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -17,7 +17,6 @@
  */
 
 #include <linux/dma-mapping.h>
-#include <linux/freezer.h>
 #include <linux/futex.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -29,7 +28,6 @@
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <linux/interrupt.h>
-#include <linux/mutex.h>
 #include <linux/cdev.h>
 #include <linux/file.h>
 #include "uapi/vsoc_shm.h"
@@ -401,7 +399,6 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
 	DEFINE_WAIT(wait);
 	u32 region_number = iminor(file_inode(filp));
 	struct vsoc_region_data *data = vsoc_dev.regions_data + region_number;
-	struct hrtimer_sleeper timeout, *to = NULL;
 	int ret = 0;
 	struct vsoc_device_region *region_p = vsoc_region_from_filep(filp);
 	atomic_t *address = NULL;
@@ -420,69 +417,23 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
 	/* Ensure that the type of wait is valid */
 	switch (arg->wait_type) {
 	case VSOC_WAIT_IF_EQUAL:
+		ret = wait_event_freezable(data->futex_wait_queue,
+					   arg->wakes++ &&
+					   atomic_read(address) != arg->value);
 		break;
 	case VSOC_WAIT_IF_EQUAL_TIMEOUT:
-		to = &timeout;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	if (to) {
-		/* Copy the user-supplied timesec into the kernel structure.
-		 * We do things this way to flatten differences between 32 bit
-		 * and 64 bit timespecs.
-		 */
 		if (arg->wake_time_nsec >= NSEC_PER_SEC)
 			return -EINVAL;
 		wake_time = ktime_set(arg->wake_time_sec, arg->wake_time_nsec);
-
-		hrtimer_init_on_stack(&to->timer, CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
-		hrtimer_set_expires_range_ns(&to->timer, wake_time,
-					     current->timer_slack_ns);
-
-		hrtimer_init_sleeper(to, current);
+		ret = wait_event_freezable_hrtimeout(data->futex_wait_queue,
+						     arg->wakes++ &&
+						     atomic_read(address) != arg->value,
+						     wake_time);
+		break;
+	default:
+		return -EINVAL;
 	}
 
-	while (1) {
-		prepare_to_wait(&data->futex_wait_queue, &wait,
-				TASK_INTERRUPTIBLE);
-		/*
-		 * Check the sentinel value after prepare_to_wait. If the value
-		 * changes after this check the writer will call signal,
-		 * changing the task state from INTERRUPTIBLE to RUNNING. That
-		 * will ensure that schedule() will eventually schedule this
-		 * task.
-		 */
-		if (atomic_read(address) != arg->value) {
-			ret = 0;
-			break;
-		}
-		if (to) {
-			hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);
-			if (likely(to->task))
-				freezable_schedule();
-			hrtimer_cancel(&to->timer);
-			if (!to->task) {
-				ret = -ETIMEDOUT;
-				break;
-			}
-		} else {
-			freezable_schedule();
-		}
-		/* Count the number of times that we woke up. This is useful
-		 * for unit testing.
-		 */
-		++arg->wakes;
-		if (signal_pending(current)) {
-			ret = -EINTR;
-			break;
-		}
-	}
-	finish_wait(&data->futex_wait_queue, &wait);
-	if (to)
-		destroy_hrtimer_on_stack(&to->timer);
 	return ret;
 }
 
-- 
2.20.1
