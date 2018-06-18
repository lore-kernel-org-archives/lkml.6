Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56395C5CFC0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:33:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE6A20852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 14:33:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DE6A20852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935148AbeFROdP (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 10:33:15 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:33837 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935072AbeFROdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 10:33:12 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue005 [212.227.15.129]) with ESMTPA (Nemesis) id
 0Mcj5x-1fmB700mET-00Htdb; Mon, 18 Jun 2018 16:32:47 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] posix-timers: Use new ktime_get_*_ts64() helpers
Date:   Mon, 18 Jun 2018 16:32:24 +0200
Message-Id: <20180618143246.3865099-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:6bdONtQglpD7vXCZAWKArAanS0s6iJC5f39/7U5GGeHM58V24+M
 WN5t1/kgBWJZNiqzZf+Nm17hIRuoZ0ooEbtW5TOM+AKXkj+A8iq1A7yLc6mP9AlWcn7uvar
 Nq9rHU8NWBgnXDd1tGF4ZzAMoGxMyhhsBjYCACxzAR2fnW9g/0frsvv2+iYvqDpy8bp/dS3
 Kyg1I/nW9yXvGTsrFmqEw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lNxvMUgOGuc=:C/SAJ7m79JrPM4iFanYgy3
 7xMvUNod/qSM6c+o8LzW6U4NpRAPoV4MCqyynVKNpLxcdC/0X5yRMCBgwPfrHlXHeb3FRZ9z7
 ca08QI2JuKc9Jnr17dgJ24SiNBNCrhWoihDiWX4mrie5hE7zsNaHMNsVVFUzyICSNlBw3qYJK
 sgKHY6AzxnY2rI59I6WjAQBE0Aj/D2S1M7FArsqun/OroAEcH7V7AHpRCV/Kzf2KLXVGct4QS
 o14862BFUg8Ed/7vORYPl4LwdWuLXN+TtqjA2py2mZKLy/9MBvgcoq3fSd6p4M6km0kwxqGBK
 DER5JAcLbheJq27nNJiWD1Xf0Gx8/Mve59gxtAnDiYcSMAIhXT0ZmQwIuDKeGmD+5F7GdNmZu
 JWNx7MutidMMzIkn0btBIChNEOytDseA92tPHjgESM8lmZou84Qpa1RucoJi04W9l1m3ZxC6r
 Ey6lzOpqqh88gkq3t6VjS1Mo/xYcftTOiOjKM4lyvXq7QrtgXfY17eyQy9eg8beX8Rs6wSrLt
 ewoipF04norHHAUzdBIO9Sm8Y9H7GVuPCbsCQu9EW/QOPOwbL4dRMpUZV9P0H5vFQDxIB04ZF
 WHojXP1YRcJF7hHP50hdJVSuXkmVa5jW7B1BAJ2ILddY0dpmLr+vWCeTN7zyzFpH17Mdlb5YF
 L555Uc/IoyA7SyF7Vocge+R7r9hk2VIGojEXkps4/TsMnvmdwbmKxZZ/erE1q9RZ12+k=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the oddly named time accessor functions now have a more
consistent naming, which should be used from now on so we can
remove the aliases.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 kernel/time/posix-stubs.c  |  2 +-
 kernel/time/posix-timers.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/time/posix-stubs.c b/kernel/time/posix-stubs.c
index 26203a705011..706e2c7338d2 100644
--- a/kernel/time/posix-stubs.c
+++ b/kernel/time/posix-stubs.c
@@ -81,7 +81,7 @@ int do_clock_gettime(clockid_t which_clock, struct timespec64 *tp)
 		ktime_get_ts64(tp);
 		break;
 	case CLOCK_BOOTTIME:
-		get_monotonic_boottime64(tp);
+		ktime_get_boottime_ts64(tp);
 		break;
 	default:
 		return -EINVAL;
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 4cb8316bb042..234fb699caf1 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -228,21 +228,21 @@ static int posix_ktime_get_ts(clockid_t which_clock, struct timespec64 *tp)
  */
 static int posix_get_monotonic_raw(clockid_t which_clock, struct timespec64 *tp)
 {
-	getrawmonotonic64(tp);
+	ktime_get_raw_ts64(tp);
 	return 0;
 }
 
 
 static int posix_get_realtime_coarse(clockid_t which_clock, struct timespec64 *tp)
 {
-	*tp = current_kernel_time64();
+	ktime_get_coarse_real_ts64(tp);
 	return 0;
 }
 
 static int posix_get_monotonic_coarse(clockid_t which_clock,
 						struct timespec64 *tp)
 {
-	*tp = get_monotonic_coarse64();
+	ktime_get_coarse_ts64(tp);
 	return 0;
 }
 
@@ -254,13 +254,13 @@ static int posix_get_coarse_res(const clockid_t which_clock, struct timespec64 *
 
 static int posix_get_boottime(const clockid_t which_clock, struct timespec64 *tp)
 {
-	get_monotonic_boottime64(tp);
+	ktime_get_boottime_ts64(tp);
 	return 0;
 }
 
 static int posix_get_tai(clockid_t which_clock, struct timespec64 *tp)
 {
-	timekeeping_clocktai64(tp);
+	ktime_get_clocktai_ts64(tp);
 	return 0;
 }
 
-- 
2.9.0

