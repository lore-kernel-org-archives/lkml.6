Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754460AbeDWIN5 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:13:57 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:54613 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754428AbeDWINw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:13:52 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] powerpc: use time64_t in update_persistent_clock
Date: Mon, 23 Apr 2018 10:10:28 +0200
Message-Id: <20180423081114.1813726-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180423081114.1813726-1-arnd@arndb.de>
References: <20180423081114.1813726-1-arnd@arndb.de>
X-Provags-ID: V03:K1:EGf12ycxRMVIqNBcezlC3xN2DidntPS5TuCmihuxw3fq3+Fls8Y
 VgoO2E6OBuzWJAkRggIVp2ygX/g6xWm7FsIFJ2zlyirYXWxQOX11SF4pvu2U/CwqXIIVBGR
 7AFLe0mi7lBSV35MyG9sXwA3VHgk9DFIkSsVryFKAi3ntXMUiDuE3VEVQUnHN+PG7GrqvFV
 1Fgox+h1rTzYrhP36muRw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:3q6KcNwNnCo=:0IKNj796LzMnvhLLCPKsX4
 ays3qOmW7dBWccHrrXYcoYAxOS7WQnN5FYdcX8/xuKJ3EiVxbFml2EppEO+2U5Wc12lT7OgMB
 BsoMRamRwgNBc6M/W2vh6Xie1JxcU2VI0D2fuA45yN9uISrASChMY+w2ubs3tap7c7Otvhbc8
 G5dDxpLoWTzRgUNgT4YGWn5Tm5ySEisQpC16PPbx7RGjqQ88PwuJ918bq5k1RqiT1cWTN7sFR
 SLU7fBj7K9P2ofG+AQOFjV3LG8JIxGK9WnUhMRJ9mMvpb5I985E+fMcdVOMFboDoHN2eNmU4S
 nTxbIMqXCseniniwiWJL7ywnP+rUB3TY/bqMdMMeZe3Ih4I2DjUeFF44pTiqpU6/hVWbrXg+U
 3o4C5e/K3j/cn3Ci6AZXQ2S65+SMTX6HeMTuIJzxwsr6woc4rODcuFfMax0KQwVp/SXPNCdSi
 c8JwWZikvoLvwfYNrxQ7SilWVs+40+aYsotrCyMz4dmB/TGHLwKylys34pbeECxl4myMhCmJH
 hfQs0CdcA0TXKtCdlUxabxS90amgwO2vRqI0hNU2eYBDdhykZTn2jytlxJVVQLPHaWm5uS+Pd
 X9fwtQZJsfxHcB9FGrFeTVhzK0Cg+7PW350GZ8NLNuuqsV5jZOrg8da0up4BpAaqQf2J18Pqy
 raoUlf53iq9GPKDFXInIvrpvH/z2VY0ZnoE7B3AZqRY9vcsHrW/ycKdusZYyX98XiRSjqCp05
 J6sKXpD07CSNh24xKWiOuIZCXf/6BmkTlpQZ7A==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

update_persistent_clock() is deprecated because it suffers from overflow
in 2038 on 32-bit architectures. This changes powerpc to use the
update_persistent_clock64() replacement, and to pass down 64-bit
timestamps consistently.

This is now simpler, as we no longer have to worry about the offset
numbers in tm_year and tm_mon that are different between the Linux
conventions and RTAS.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/kernel/time.c              |  6 ++----
 arch/powerpc/platforms/8xx/m8xx_setup.c |  7 +++----
 arch/powerpc/platforms/powermac/time.c  | 17 ++++-------------
 3 files changed, 9 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index afb27962b396..f9b0baa3fa2b 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -781,16 +781,14 @@ void __init generic_calibrate_decr(void)
 	}
 }
 
-int update_persistent_clock(struct timespec now)
+int update_persistent_clock64(struct timespec64 now)
 {
 	struct rtc_time tm;
 
 	if (!ppc_md.set_rtc_time)
 		return -ENODEV;
 
-	to_tm(now.tv_sec + 1 + timezone_offset, &tm);
-	tm.tm_year -= 1900;
-	tm.tm_mon -= 1;
+	rtc_time64_to_tm(now.tv_sec + 1 + timezone_offset, &tm);
 
 	return ppc_md.set_rtc_time(&tm);
 }
diff --git a/arch/powerpc/platforms/8xx/m8xx_setup.c b/arch/powerpc/platforms/8xx/m8xx_setup.c
index d76daa90647b..027c42d8966c 100644
--- a/arch/powerpc/platforms/8xx/m8xx_setup.c
+++ b/arch/powerpc/platforms/8xx/m8xx_setup.c
@@ -169,15 +169,14 @@ int mpc8xx_set_rtc_time(struct rtc_time *tm)
 {
 	sitk8xx_t __iomem *sys_tmr1;
 	sit8xx_t __iomem *sys_tmr2;
-	int time;
+	time64_t time;
 
 	sys_tmr1 = immr_map(im_sitk);
 	sys_tmr2 = immr_map(im_sit);
-	time = mktime(tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
-	              tm->tm_hour, tm->tm_min, tm->tm_sec);
+	time = rtc_tm_to_time64(tm);
 
 	out_be32(&sys_tmr1->sitk_rtck, KAPWR_KEY);
-	out_be32(&sys_tmr2->sit_rtc, time);
+	out_be32(&sys_tmr2->sit_rtc, (u32)time);
 	out_be32(&sys_tmr1->sitk_rtck, ~KAPWR_KEY);
 
 	immr_unmap(sys_tmr2);
diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index d5d1c452038e..7c968e46736f 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -84,15 +84,6 @@ long __init pmac_time_init(void)
 	return delta;
 }
 
-#if defined(CONFIG_ADB_CUDA) || defined(CONFIG_ADB_PMU) || \
-    defined(CONFIG_PMAC_SMU)
-static unsigned long from_rtc_time(struct rtc_time *tm)
-{
-	return mktime(tm->tm_year+1900, tm->tm_mon+1, tm->tm_mday,
-		      tm->tm_hour, tm->tm_min, tm->tm_sec);
-}
-#endif
-
 #ifdef CONFIG_ADB_CUDA
 static time64_t cuda_get_time(void)
 {
@@ -115,10 +106,10 @@ static time64_t cuda_get_time(void)
 
 static int cuda_set_rtc_time(struct rtc_time *tm)
 {
-	unsigned int nowtime;
+	time64_t nowtime;
 	struct adb_request req;
 
-	nowtime = from_rtc_time(tm) + RTC_OFFSET;
+	nowtime = rtc_tm_to_time64(tm) + RTC_OFFSET;
 	if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
 			 nowtime >> 24, nowtime >> 16, nowtime >> 8,
 			 nowtime) < 0)
@@ -158,10 +149,10 @@ static time64_t pmu_get_time(void)
 
 static int pmu_set_rtc_time(struct rtc_time *tm)
 {
-	unsigned int nowtime;
+	time64_t nowtime;
 	struct adb_request req;
 
-	nowtime = from_rtc_time(tm) + RTC_OFFSET;
+	nowtime = rtc_tm_to_time64(tm) + RTC_OFFSET;
 	if (pmu_request(&req, NULL, 5, PMU_SET_RTC, nowtime >> 24,
 			nowtime >> 16, nowtime >> 8, nowtime) < 0)
 		return -ENXIO;
-- 
2.9.0
