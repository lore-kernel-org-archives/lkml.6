Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BEF1C282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:29:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2217B21907
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 21:29:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbfBGV35 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 Feb 2019 16:29:57 -0500
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:37423 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726622AbfBGV35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Feb 2019 16:29:57 -0500
X-Originating-IP: 141.70.45.131
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 5C540E0002;
        Thu,  7 Feb 2019 21:29:52 +0000 (UTC)
Date:   Thu, 7 Feb 2019 22:29:51 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Greg Hartman <ghartman@google.com>,
        Alistair Strachan <astrachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH v2 2/2] staging/android: simplify handle_vsoc_cond_wait
Message-ID: <f0a8a656b6161ff297be76b29a65220f3275b6b6.1549564792.git.hle@owl.eu.com>
References: <cover.1549564792.git.hle@owl.eu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1549564792.git.hle@owl.eu.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

simplify handle_vsoc_cond_wait (drivers/staging/android/vsoc.c) using newly
added wait_event_freezable_hrtimeout helper and remove duplicate include.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
Changes in v2:
  - Fix removal of necessary linux/freezer.h include.
  - Make commit message more precise about the include removal.

 drivers/staging/android/vsoc.c | 68 +++++-----------------------------
 1 file changed, 10 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 22571abcaa4e..f2bb18158e5b 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -29,7 +29,6 @@
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <linux/interrupt.h>
-#include <linux/mutex.h>
 #include <linux/cdev.h>
 #include <linux/file.h>
 #include "uapi/vsoc_shm.h"
@@ -401,7 +400,6 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
 	DEFINE_WAIT(wait);
 	u32 region_number = iminor(file_inode(filp));
 	struct vsoc_region_data *data = vsoc_dev.regions_data + region_number;
-	struct hrtimer_sleeper timeout, *to = NULL;
 	int ret = 0;
 	struct vsoc_device_region *region_p = vsoc_region_from_filep(filp);
 	atomic_t *address = NULL;
@@ -420,69 +418,23 @@ static int handle_vsoc_cond_wait(struct file *filp, struct vsoc_cond_wait *arg)
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
