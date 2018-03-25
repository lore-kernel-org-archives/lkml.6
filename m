Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeCYJAw (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 05:00:52 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:41161 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbeCYJAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 05:00:49 -0400
X-Google-Smtp-Source: AG47ELu9JX5E5IdH4rWYTd1TG4wgZAqS7USgYISuSqUCnZv0jQ/5PAJs5vTGywhTJjHiBqqRTsm9hA==
Date: Sun, 25 Mar 2018 11:00:44 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [GIT PULL] timer fix
Message-ID: <20180325090044.u5ayc5pej24piodm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

Please pull the latest timers-urgent-for-linus git tree from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers-urgent-for-linus

   # HEAD: 19b558db12f9f4e45a22012bae7b4783e62224da posix-timers: Protect posix clock array access against speculation

Make posix clock ID usage Spectre-safe.

 Thanks,

	Ingo

------------------>
Thomas Gleixner (1):
      posix-timers: Protect posix clock array access against speculation


 kernel/time/posix-timers.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 75043046914e..10b7186d0638 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -50,6 +50,7 @@
 #include <linux/export.h>
 #include <linux/hashtable.h>
 #include <linux/compat.h>
+#include <linux/nospec.h>
 
 #include "timekeeping.h"
 #include "posix-timers.h"
@@ -1346,11 +1347,15 @@ static const struct k_clock * const posix_clocks[] = {
 
 static const struct k_clock *clockid_to_kclock(const clockid_t id)
 {
-	if (id < 0)
+	clockid_t idx = id;
+
+	if (id < 0) {
 		return (id & CLOCKFD_MASK) == CLOCKFD ?
 			&clock_posix_dynamic : &clock_posix_cpu;
+	}
 
-	if (id >= ARRAY_SIZE(posix_clocks) || !posix_clocks[id])
+	if (id >= ARRAY_SIZE(posix_clocks))
 		return NULL;
-	return posix_clocks[id];
+
+	return posix_clocks[array_index_nospec(idx, ARRAY_SIZE(posix_clocks))];
 }
