Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754592AbeDWIhJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 04:37:09 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:44543 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754460AbeDWIhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 04:37:02 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        y2038@lists.linaro.org, arnd@arndb.de
Subject: [PATCH 4/5] powerpc: use time64_t in update_persistent_clock
Date: Mon, 23 Apr 2018 10:36:41 +0200
Message-Id: <20180423083642.2608886-4-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20180423083642.2608886-1-arnd@arndb.de>
References: <20180423083642.2608886-1-arnd@arndb.de>
X-Provags-ID: V03:K1:i63MvfCuZ7Wx+sv739EyVTndhVZT0rXBFW6AebTXY1+jMIVqX0s
 P7In6PFoMNFMHtsyTbXB/HJKmt7EBUlEi4tM22Fk2SgZnUbK6s/Tx6juHLN4lKHk2CnY2dJ
 k5xP3B29BBunlGgWof81essBJqC7WrL8qHVQuggLOcieRYilfEGKevOiteVBOADwComZpk0
 7A4Vp9pmRovaDdNtCqNeg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:bclzS236dUY=:FzqmGPHCBFRqiAuwUlvlu1
 7/p9TDxk4pwj/Lj8UC+/tViK1J9Q49liYHw3v7jbSWKiNaDY7h09Lxc+GVE1aQwqSnq0XYKFt
 pet9lGW8DsNvwi1lQmgQ7DhUn/NUko3M2KdQ/QgW26cX3ej1YgoMqEZ2nJqzz0vlRY+ArokiR
 ErZzXCsOE2z5q8LD4JAag0XYYbWSztSdABEkJzDRRriqXtG7rdz8Xem9mQQJQK6Q5LpMGlPwr
 wnw2tmBCHOoH0DXwKyRDr8pCecEUdyt6z1eoZNO2w2qVARi8zXy7gXgpZ8fb/mdmHrpBm6Zsf
 iji0nGvRFRE6Lb4khLDriB+GeszBpzy9zj6UePjuliKPOwszxP3pVR2NltSGFephJn0K25VkW
 jTijKSDJqBViM1v7NsjNT0h9KmTLKGoJ/JslgsHsXl6qpnlSNJ/Vnfv2cx2mxCEipomM9Wi5b
 KTAMTyhyTTFVaZ/8HuSS7Zfp0XVO5HluxFL8H9AORohZGc4U1zgfWZlFbLednVK2b08kuTLcj
 DZCVzKmUPHKIWj8tkmUcI56t5CckWfDRsvPlbhbwwHZTZdHln/LmscCoC1Ejky5IOJX/HelDg
 VoKyv/qq1Fxzi408lRdxtHnaUI3WH8ZylqI1KBjutgvzO8RjFHkJ1sq+o/Huu2pBLP11VO5yg
 t3UzNqEkOca4dpWTbpL8hy3wXMcm/bq4R7TVMhU2kSMMoXpwXSjkCwCkrlLidtXbSHsncvNMt
 icCvQAroWqWq236UmzoGqFmCrJas/3wXRNh72Q==
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
