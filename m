Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753709AbeE3LiG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:38:06 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60777 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752217AbeE3LHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:01 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Greg KH" <gregkh@linuxfoundation.org>,
        "Dan Williams" <dan.j.williams@intel.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "David Woodhouse" <dwmw@amazon.co.uk>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rasmus Villemoes" <rasmus.villemoes@prevas.dk>
Date: Wed, 30 May 2018 11:52:42 +0100
Message-ID: <lsq.1527677562.676481802@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 140/153] posix-timers: Protect posix clock array
 access against speculation
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit 19b558db12f9f4e45a22012bae7b4783e62224da upstream.

The clockid argument of clockid_to_kclock() comes straight from user space
via various syscalls and is used as index into the posix_clocks array.

Protect it against spectre v1 array out of bounds speculation. Remove the
redundant check for !posix_clock[id] as this is another source for
speculation and does not provide any advantage over the return
posix_clock[id] path which returns NULL in that case anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
Cc: Greg KH <gregkh@linuxfoundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Link: https://lkml.kernel.org/r/alpine.DEB.2.21.1802151718320.1296@nanos.tec.linutronix.de
[bwh: Backported to 3.2:
 - Move the test of the clock_getres field below the lookup using
   array_index_nospec()
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -47,6 +47,7 @@
 #include <linux/wait.h>
 #include <linux/workqueue.h>
 #include <linux/export.h>
+#include <linux/nospec.h>
 
 /*
  * Management arrays for POSIX timers.	 Timers are kept in slab memory
@@ -520,13 +521,21 @@ static void release_posix_timer(struct k
 
 static struct k_clock *clockid_to_kclock(const clockid_t id)
 {
-	if (id < 0)
+	clockid_t idx = id;
+	struct k_clock *kc;
+
+	if (id < 0) {
 		return (id & CLOCKFD_MASK) == CLOCKFD ?
 			&clock_posix_dynamic : &clock_posix_cpu;
+	}
+
+	if (id >= ARRAY_SIZE(posix_clocks))
+		return NULL;
 
-	if (id >= MAX_CLOCKS || !posix_clocks[id].clock_getres)
+	kc = &posix_clocks[array_index_nospec(idx, ARRAY_SIZE(posix_clocks))];
+	if (!kc->clock_getres)
 		return NULL;
-	return &posix_clocks[id];
+	return kc;
 }
 
 static int common_timer_create(struct k_itimer *new_timer)
