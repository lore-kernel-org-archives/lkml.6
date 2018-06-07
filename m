Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id jIixBww+GVuMRwAAmS7hNA
	; Thu, 07 Jun 2018 14:15:40 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 0D778608BF; Thu,  7 Jun 2018 14:15:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 9CCEC6089E;
	Thu,  7 Jun 2018 14:15:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 9CCEC6089E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=decadent.org.uk
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933179AbeFGOPa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 10:15:30 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:39501 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933155AbeFGOJi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 10:09:38 -0400
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbM-0005Zm-8Q; Thu, 07 Jun 2018 15:09:20 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbE-0003IC-7r; Thu, 07 Jun 2018 15:09:12 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "David Woodhouse" <dwmw@amazon.co.uk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rasmus Villemoes" <rasmus.villemoes@prevas.dk>,
        "Greg KH" <gregkh@linuxfoundation.org>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Dan Williams" <dan.j.williams@intel.com>
Date: Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.813252163@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 389/410] posix-timers: Protect posix clock array
 access against speculation
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16:
 - Move the test of the clock_getres field below the lookup using
   array_index_nospec()
 - Adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/kernel/posix-timers.c
+++ b/kernel/posix-timers.c
@@ -48,6 +48,7 @@
 #include <linux/workqueue.h>
 #include <linux/export.h>
 #include <linux/hashtable.h>
+#include <linux/nospec.h>
 
 /*
  * Management arrays for POSIX timers. Timers are now kept in static hash table
@@ -578,13 +579,21 @@ static void release_posix_timer(struct k
 
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
