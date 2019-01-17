Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A29DC43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35DEA20859
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 22:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbfAQWln (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 17:41:43 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:37713 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfAQWlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 17:41:42 -0500
Received: from localhost (hadi-gate-vlan-851.hadiko.whka.de [141.70.45.131])
        (Authenticated sender: hle@owl.eu.com)
        by relay10.mail.gandi.net (Postfix) with ESMTPSA id 64500240007;
        Thu, 17 Jan 2019 22:41:37 +0000 (UTC)
Date:   Thu, 17 Jan 2019 23:41:35 +0100
From:   Hugo Lefeuvre <hle@owl.eu.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Greg Hartman <ghartman@google.com>,
        Alistair Strachan <strachan@google.com>,
        Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] sched/wait: introduce wait_event_freezable_hrtimeout
Message-ID: <20190117224135.GC8100@hle-laptop.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hQiwHBbRI9kgIhsi"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hQiwHBbRI9kgIhsi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

introduce wait_event_freezable_hrtimeout, an interruptible and freezable
version of wait_event_hrtimeout.

simplify handle_vsoc_cond_wait (drivers/staging/android/vsoc.c) using this
newly added helper and remove useless includes.

Signed-off-by: Hugo Lefeuvre <hle@owl.eu.com>
---
 drivers/staging/android/vsoc.c | 69 +++++-----------------------------
 include/linux/wait.h           | 25 ++++++++++--
 2 files changed, 31 insertions(+), 63 deletions(-)

diff --git a/drivers/staging/android/vsoc.c b/drivers/staging/android/vsoc.c
index 22571abcaa4e..7e620e69f39d 100644
--- a/drivers/staging/android/vsoc.c
+++ b/drivers/staging/android/vsoc.c
@@ -17,7 +17,6 @@
  */
=20
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
@@ -401,7 +399,6 @@ static int handle_vsoc_cond_wait(struct file *filp, str=
uct vsoc_cond_wait *arg)
 	DEFINE_WAIT(wait);
 	u32 region_number =3D iminor(file_inode(filp));
 	struct vsoc_region_data *data =3D vsoc_dev.regions_data + region_number;
-	struct hrtimer_sleeper timeout, *to =3D NULL;
 	int ret =3D 0;
 	struct vsoc_device_region *region_p =3D vsoc_region_from_filep(filp);
 	atomic_t *address =3D NULL;
@@ -420,69 +417,23 @@ static int handle_vsoc_cond_wait(struct file *filp, s=
truct vsoc_cond_wait *arg)
 	/* Ensure that the type of wait is valid */
 	switch (arg->wait_type) {
 	case VSOC_WAIT_IF_EQUAL:
+		ret =3D wait_event_freezable(data->futex_wait_queue,
+					   arg->wakes++ &&
+					   atomic_read(address) !=3D arg->value);
 		break;
 	case VSOC_WAIT_IF_EQUAL_TIMEOUT:
-		to =3D &timeout;
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
 		if (arg->wake_time_nsec >=3D NSEC_PER_SEC)
 			return -EINVAL;
 		wake_time =3D ktime_set(arg->wake_time_sec, arg->wake_time_nsec);
-
-		hrtimer_init_on_stack(&to->timer, CLOCK_MONOTONIC,
-				      HRTIMER_MODE_ABS);
-		hrtimer_set_expires_range_ns(&to->timer, wake_time,
-					     current->timer_slack_ns);
-
-		hrtimer_init_sleeper(to, current);
+		ret =3D wait_event_freezable_hrtimeout(data->futex_wait_queue,
+						     arg->wakes++ &&
+						     atomic_read(address) !=3D arg->value,
+						     wake_time);
+		break;
+	default:
+		return -EINVAL;
 	}
=20
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
-		if (atomic_read(address) !=3D arg->value) {
-			ret =3D 0;
-			break;
-		}
-		if (to) {
-			hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);
-			if (likely(to->task))
-				freezable_schedule();
-			hrtimer_cancel(&to->timer);
-			if (!to->task) {
-				ret =3D -ETIMEDOUT;
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
-			ret =3D -EINTR;
-			break;
-		}
-	}
-	finish_wait(&data->futex_wait_queue, &wait);
-	if (to)
-		destroy_hrtimer_on_stack(&to->timer);
 	return ret;
 }
=20
diff --git a/include/linux/wait.h b/include/linux/wait.h
index ed7c122cb31f..13a454884f8b 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -483,7 +483,7 @@ do {										\
 	__ret;									\
 })
=20
-#define __wait_event_hrtimeout(wq_head, condition, timeout, state)		\
+#define __wait_event_hrtimeout(wq_head, condition, timeout, state, cmd)		\
 ({										\
 	int __ret =3D 0;								\
 	struct hrtimer_sleeper __t;						\
@@ -500,7 +500,7 @@ do {										\
 			__ret =3D -ETIME;						\
 			break;							\
 		}								\
-		schedule());							\
+		cmd);							        \
 										\
 	hrtimer_cancel(&__t.timer);						\
 	destroy_hrtimer_on_stack(&__t.timer);					\
@@ -529,7 +529,23 @@ do {										\
 	might_sleep();								\
 	if (!(condition))							\
 		__ret =3D __wait_event_hrtimeout(wq_head, condition, timeout,	\
-					       TASK_UNINTERRUPTIBLE);		\
+					       TASK_UNINTERRUPTIBLE,		\
+					       schedule());			\
+	__ret;									\
+})
+
+/*
+ * like wait_event_hrtimeout() -- except it uses TASK_INTERRUPTIBLE to avo=
id
+ * increasing load and is freezable.
+ */
+#define wait_event_freezable_hrtimeout(wq_head, condition, timeout)		\
+({										\
+	int __ret =3D 0;								\
+	might_sleep();								\
+	if (!(condition))							\
+		__ret =3D __wait_event_hrtimeout(wq_head, condition, timeout,	\
+					       TASK_INTERRUPTIBLE,		\
+					       freezable_schedule());		\
 	__ret;									\
 })
=20
@@ -555,7 +571,8 @@ do {										\
 	might_sleep();								\
 	if (!(condition))							\
 		__ret =3D __wait_event_hrtimeout(wq, condition, timeout,		\
-					       TASK_INTERRUPTIBLE);		\
+					       TASK_INTERRUPTIBLE,		\
+					       schedule());			\
 	__ret;									\
 })
=20
--=20
2.20.1

--hQiwHBbRI9kgIhsi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEUFZhdgIWqBhwqCvuZYVUZx9w0DQFAlxBBJcACgkQZYVUZx9w
0DRmYwgAoFEEad6ceQGB/3Xw5E5IJJk9xJ2SiDH0T9hPsjhTf4x1WL8PbY1QYXlN
RBT7PFzXT5iJkX2R8gwYmi1OYLTjjLS+F/qnUPHgluXC9wrArT+cntWtZ9VtADEh
6FHiwb/PgI2fNcGPfYkZRyuvzj1o2WJY3MRFpJvN4vDKy94ejZXdX+HVowF1+ezc
SKqNpGM+cGhX1T4Us0RIhhIngxVKMgbhy9mPA5qGJsvreG24dUiyK7ZhJ/nkUlWf
GQMDAL3Pm2VfhfIiMlGlVLUMw6fsnpSeGeLIfZUJV8Gqi6x349NgqM/zvkWhlsqj
60KkdOUs7lxjcHWEEaiOC898L1dyIw==
=vNB9
-----END PGP SIGNATURE-----

--hQiwHBbRI9kgIhsi--
