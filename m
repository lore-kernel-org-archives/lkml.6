Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81A9C433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:08:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89D9C20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:08:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89D9C20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933830AbeFROIz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:08:55 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:50337 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754601AbeFROIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:08:53 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue102 [212.227.15.145]) with ESMTPA (Nemesis) id
 0MC1MO-1fM58435wO-008vJO; Mon, 18 Jun 2018 16:08:40 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] timekeeping: use ktime_get_real_ts64() instead of getnstimeofday64()
Date:   Mon, 18 Jun 2018 16:08:01 +0200
Message-Id: <20180618140811.2998503-3-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180618140811.2998503-1-arnd@arndb.de>
References: <20180618140811.2998503-1-arnd@arndb.de>
X-Provags-ID: V03:K1:Wjc6Acd7epJAakSEfRIj6Q0bDR2aY4j5OVhwZfl6AS4iA9yxzzS
 LX80oCYQRT8sPr9mePhBUrkuq4cDxK2orqsufvKQ9xajCGzVW3dD8D1luWs7uywT4SHTRUo
 PQF7u0BwvTRA0AV0VldV9mHl0jqvpcYcU1aGHUIV6IojEoyXQKNpiOuZ0SyP0n7hYQ/jxSZ
 Asqhq0SHcVIkUhDSLre8Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K1Xd0KNhYVY=:YxRkWWetJz0fF4O9xKXQHN
 LYxYKkkyWuCZ9qfzrPZe0unqU4ZxoSt7sOioub+aeFqVWMJRwwTfgGOoE+kpBkhtSBQWCgXvV
 3+Xh4I78Kne1bTwHcRhwVd89bKkrtvMl18F86+Km8GAsQUjEaBJHSW86lq5djcWcqc9YXVodH
 gWh3NXuCzDMBMu9wRxh8Elpw0ja/2Z1tlvlMGWWtcss8bJQtozCwGqmJhuEv2LPqsplDZn2pc
 WHHI3YmcWhATD1yGcChWh8F5ea6ebt2DJL01LwglKZ+HR8d7J+ChNtpL+iIs6nwuFoSp53mqN
 euPsh8ZQQHsufa1vRYs4+bnxz6OL/wXz5EKSRYv0u71FpN6mI15xAF2RxU/mODTj5ZzuEkupG
 1L3i/uGq8oUHX+P0Cf9vaKv432y5W/HDzviFvBHTAGBU18e9QiSh58QEcAC13qQDs8vo+TB7G
 VlLRZnlInNZ0VyYnCi9ZkZtLcg13yV6Qrb89KTNvMtNN4E5AT6AZVj2AhyPtE9vxtpy8mWi47
 LfTt4Vf5JeQPwMJMwNm2L9JllOzDi/OnVa4gZ3/+o+qL1rSO4UhM+d/fG2xxeT66A4mOohph5
 Jy2bF5ydq2O7y+t7LckR3WDWcKb49+IGJSkEUk3r8Fc0xg2nIXjSVY7IkaCY8CJa5OCWDTH/2
 LhHn2MmUiaYrCnB3JKnVgtvzoQccM2ULo4+38/GffwGWt+SdUXE2QJCnscS9cR6Byp10=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The two do the same, this moves all users to the newer name for consistency.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
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
-- 
2.9.0

