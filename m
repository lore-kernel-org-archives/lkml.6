Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753136AbeDQPXa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 11:23:30 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59863 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751836AbeDQPX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 11:23:29 -0400
Date: Tue, 17 Apr 2018 08:23:22 -0700
From: tip-bot for Baolin Wang <tipbot@zytor.com>
Message-ID: <tip-e142aa09ed88be98395dde7acb96fb2263566b68@git.kernel.org>
Cc: tglx@linutronix.de, baolin.wang@linaro.org, mingo@kernel.org,
        linux-kernel@vger.kernel.org, hpa@zytor.com
Reply-To: tglx@linutronix.de, mingo@kernel.org, baolin.wang@linaro.org,
        hpa@zytor.com, linux-kernel@vger.kernel.org
In-Reply-To: <1a9dbea7ee2cda7efe9ed330874075cf17fdbff6.1523596316.git.baolin.wang@linaro.org>
References: <1a9dbea7ee2cda7efe9ed330874075cf17fdbff6.1523596316.git.baolin.wang@linaro.org>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/urgent] timekeeping: Remove __current_kernel_time()
Git-Commit-ID: e142aa09ed88be98395dde7acb96fb2263566b68
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  e142aa09ed88be98395dde7acb96fb2263566b68
Gitweb:     https://git.kernel.org/tip/e142aa09ed88be98395dde7acb96fb2263566b68
Author:     Baolin Wang <baolin.wang@linaro.org>
AuthorDate: Fri, 13 Apr 2018 13:27:58 +0800
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 17 Apr 2018 17:18:05 +0200

timekeeping: Remove __current_kernel_time()

The __current_kernel_time() function based on 'struct timespec' is no
longer recommended for new code, and the only user of this function has
been replaced by commit 6909e29fdefb ("kdb: use __ktime_get_real_seconds
instead of __current_kernel_time").

Remove the obsolete interface.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: arnd@arndb.de
Cc: sboyd@kernel.org
Cc: broonie@kernel.org
Cc: john.stultz@linaro.org
Link: https://lkml.kernel.org/r/1a9dbea7ee2cda7efe9ed330874075cf17fdbff6.1523596316.git.baolin.wang@linaro.org

---
 include/linux/timekeeping32.h | 3 ---
 kernel/time/timekeeping.c     | 7 -------
 2 files changed, 10 deletions(-)

diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
index af4114d5dc17..3616b4becb59 100644
--- a/include/linux/timekeeping32.h
+++ b/include/linux/timekeeping32.h
@@ -9,9 +9,6 @@
 extern void do_gettimeofday(struct timeval *tv);
 unsigned long get_seconds(void);
 
-/* does not take xtime_lock */
-struct timespec __current_kernel_time(void);
-
 static inline struct timespec current_kernel_time(void)
 {
 	struct timespec64 now = current_kernel_time64();
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ca90219a1e73..dcf7f20fcd12 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2139,13 +2139,6 @@ unsigned long get_seconds(void)
 }
 EXPORT_SYMBOL(get_seconds);
 
-struct timespec __current_kernel_time(void)
-{
-	struct timekeeper *tk = &tk_core.timekeeper;
-
-	return timespec64_to_timespec(tk_xtime(tk));
-}
-
 struct timespec64 current_kernel_time64(void)
 {
 	struct timekeeper *tk = &tk_core.timekeeper;
