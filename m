Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752509AbeESMC0 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 08:02:26 -0400
Received: from terminus.zytor.com ([198.137.202.136]:33345 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752153AbeESMCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 08:02:23 -0400
Date: Sat, 19 May 2018 05:02:15 -0700
From: tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-b9ff604cff1135cc576cf952d394ed9401aa234b@git.kernel.org>
Cc: john.stultz@linaro.org, mingo@kernel.org, sboyd@kernel.org,
        arnd@arndb.de, hpa@zytor.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org
Reply-To: tglx@linutronix.de, hpa@zytor.com, arnd@arndb.de, sboyd@kernel.org,
        mingo@kernel.org, john.stultz@linaro.org, linux-kernel@vger.kernel.org
In-Reply-To: <20180427134016.2525989-5-arnd@arndb.de>
References: <20180427134016.2525989-5-arnd@arndb.de>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:timers/2038] timekeeping: Add ktime_get_coarse_with_offset
Git-Commit-ID: b9ff604cff1135cc576cf952d394ed9401aa234b
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

Commit-ID:  b9ff604cff1135cc576cf952d394ed9401aa234b
Gitweb:     https://git.kernel.org/tip/b9ff604cff1135cc576cf952d394ed9401aa234b
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Fri, 27 Apr 2018 15:40:15 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Sat, 19 May 2018 13:57:32 +0200

timekeeping: Add ktime_get_coarse_with_offset

I have run into a couple of drivers using current_kernel_time()
suffering from the y2038 problem, and they could be converted
to using ktime_t, but don't have interfaces that skip the nanosecond
calculation at the moment.

This introduces ktime_get_coarse_with_offset() as a simpler
variant of ktime_get_with_offset(), and adds wrappers for the
three time domains we support with the existing function.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: y2038@lists.linaro.org
Cc: John Stultz <john.stultz@linaro.org>
Link: https://lkml.kernel.org/r/20180427134016.2525989-5-arnd@arndb.de

---
 include/linux/timekeeping.h | 16 ++++++++++++++++
 kernel/time/timekeeping.c   | 19 +++++++++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 3ef9791d7d75..42f71f4b658a 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -51,6 +51,7 @@ enum tk_offsets {
 
 extern ktime_t ktime_get(void);
 extern ktime_t ktime_get_with_offset(enum tk_offsets offs);
+extern ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs);
 extern ktime_t ktime_mono_to_any(ktime_t tmono, enum tk_offsets offs);
 extern ktime_t ktime_get_raw(void);
 extern u32 ktime_get_resolution_ns(void);
@@ -63,6 +64,11 @@ static inline ktime_t ktime_get_real(void)
 	return ktime_get_with_offset(TK_OFFS_REAL);
 }
 
+static inline ktime_t ktime_get_coarse_real(void)
+{
+	return ktime_get_coarse_with_offset(TK_OFFS_REAL);
+}
+
 /**
  * ktime_get_boottime - Returns monotonic time since boot in ktime_t format
  *
@@ -74,6 +80,11 @@ static inline ktime_t ktime_get_boottime(void)
 	return ktime_get_with_offset(TK_OFFS_BOOT);
 }
 
+static inline ktime_t ktime_get_coarse_boottime(void)
+{
+	return ktime_get_coarse_with_offset(TK_OFFS_BOOT);
+}
+
 /**
  * ktime_get_clocktai - Returns the TAI time of day in ktime_t format
  */
@@ -82,6 +93,11 @@ static inline ktime_t ktime_get_clocktai(void)
 	return ktime_get_with_offset(TK_OFFS_TAI);
 }
 
+static inline ktime_t ktime_get_coarse_clocktai(void)
+{
+	return ktime_get_coarse_with_offset(TK_OFFS_TAI);
+}
+
 /**
  * ktime_mono_to_real - Convert monotonic time to clock realtime
  */
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index ed9b74ec9c0b..4786df904c22 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -795,6 +795,25 @@ ktime_t ktime_get_with_offset(enum tk_offsets offs)
 }
 EXPORT_SYMBOL_GPL(ktime_get_with_offset);
 
+ktime_t ktime_get_coarse_with_offset(enum tk_offsets offs)
+{
+	struct timekeeper *tk = &tk_core.timekeeper;
+	unsigned int seq;
+	ktime_t base, *offset = offsets[offs];
+
+	WARN_ON(timekeeping_suspended);
+
+	do {
+		seq = read_seqcount_begin(&tk_core.seq);
+		base = ktime_add(tk->tkr_mono.base, *offset);
+
+	} while (read_seqcount_retry(&tk_core.seq, seq));
+
+	return base;
+
+}
+EXPORT_SYMBOL_GPL(ktime_get_coarse_with_offset);
+
 /**
  * ktime_mono_to_any() - convert mononotic time to any other time
  * @tmono:	time to convert.
