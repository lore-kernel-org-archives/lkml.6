Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1774C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 671F82083A
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 08:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 671F82083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937481AbeFSIBp (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 04:01:45 -0400
Received: from terminus.zytor.com ([198.137.202.136]:49675 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937309AbeFSIBn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 04:01:43 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id w5J81MJp3015090
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 19 Jun 2018 01:01:22 -0700
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id w5J81Mtv3015087;
        Tue, 19 Jun 2018 01:01:22 -0700
Date:   Tue, 19 Jun 2018 01:01:22 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnd Bergmann <tipbot@zytor.com>
Message-ID: <tip-d30faff900e666f9a6395a159fdd353c02f5bed0@git.kernel.org>
Cc:     linux-kernel@vger.kernel.org, john.stultz@linaro.org,
        mlichvar@redhat.com, arnd@arndb.de, sboyd@kernel.org,
        hpa@zytor.com, mingo@kernel.org, tglx@linutronix.de
Reply-To: arnd@arndb.de, john.stultz@linaro.org, mlichvar@redhat.com,
          linux-kernel@vger.kernel.org, tglx@linutronix.de, hpa@zytor.com,
          mingo@kernel.org, sboyd@kernel.org
In-Reply-To: <20180618140811.2998503-3-arnd@arndb.de>
References: <20180618140811.2998503-3-arnd@arndb.de>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:timers/core] timekeeping: Use ktime_get_real_ts64() instead of
 getnstimeofday64()
Git-Commit-ID: d30faff900e666f9a6395a159fdd353c02f5bed0
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit-ID:  d30faff900e666f9a6395a159fdd353c02f5bed0
Gitweb:     https://git.kernel.org/tip/d30faff900e666f9a6395a159fdd353c02f5bed0
Author:     Arnd Bergmann <arnd@arndb.de>
AuthorDate: Mon, 18 Jun 2018 16:08:01 +0200
Committer:  Thomas Gleixner <tglx@linutronix.de>
CommitDate: Tue, 19 Jun 2018 09:56:26 +0200

timekeeping: Use ktime_get_real_ts64() instead of getnstimeofday64()

The two do the same, this moves all users to the newer name for consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: John Stultz <john.stultz@linaro.org>
Cc: y2038@lists.linaro.org
Cc: Stephen Boyd <sboyd@kernel.org>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Link: https://lkml.kernel.org/r/20180618140811.2998503-3-arnd@arndb.de

---
 kernel/time/ntp.c         | 6 +++---
 kernel/time/timekeeping.c | 2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index a09ded765f6c..10a79053e82f 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -502,7 +502,7 @@ static void sched_sync_hw_clock(struct timespec64 now,
 {
 	struct timespec64 next;
 
-	getnstimeofday64(&next);
+	ktime_get_real_ts64(&next);
 	if (!fail)
 		next.tv_sec = 659;
 	else {
@@ -537,7 +537,7 @@ static void sync_rtc_clock(void)
 	if (!IS_ENABLED(CONFIG_RTC_SYSTOHC))
 		return;
 
-	getnstimeofday64(&now);
+	ktime_get_real_ts64(&now);
 
 	adjust = now;
 	if (persistent_clock_is_local)
@@ -591,7 +591,7 @@ static bool sync_cmos_clock(void)
 	 * Architectures are strongly encouraged to use rtclib and not
 	 * implement this legacy API.
 	 */
-	getnstimeofday64(&now);
+	ktime_get_real_ts64(&now);
 	if (rtc_tv_nsec_ok(-1 * target_nsec, &adjust, &now)) {
 		if (persistent_clock_is_local)
 			adjust.tv_sec -= (sys_tz.tz_minuteswest * 60);
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 4786df904c22..77c436a0070b 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -2310,7 +2310,7 @@ int do_adjtimex(struct timex *txc)
 			return ret;
 	}
 
-	getnstimeofday64(&ts);
+	ktime_get_real_ts64(&ts);
 
 	raw_spin_lock_irqsave(&timekeeper_lock, flags);
 	write_seqcount_begin(&tk_core.seq);
