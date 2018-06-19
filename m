Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE34C5CFC1
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2123520652
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 14:04:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2123520652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756005AbeFSOEP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 10:04:15 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:39583 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965688AbeFSOEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 10:04:10 -0400
Received: from wuerfel.lan ([95.208.111.237]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MVV8g-1fi2Hw1jig-00Yged; Tue, 19 Jun 2018 16:02:54 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Joshua Thompson <funaho@jurai.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Meelis Roos <mroos@linux.ee>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 1/3] [v2] powerpc: mac: fix rtc read/write functions
Date:   Tue, 19 Jun 2018 16:02:27 +0200
Message-Id: <20180619140229.3615110-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:iis7jj1S1jizfZfiIt7caPncO9M3AZTOsho/OZGf++hvGlEvt6m
 VM0K+Zdu6snHQVjFJPFFk6dmazQ6SaO5tz4z2WWxHi/80DmDJNT/+I5D4ZI69FkdMyvCUoK
 g4cBAEFB18yG93BiaEOIeN0aWeTeFHlPI1zwJ8KZwr/hG0a9Mg9onSx4mwkSBuaSbDP3Drz
 7UfKE16FLEZkYj/vNDUGQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:9atu+VflZP8=:bb/gnLFmPYwVnB2YW4Navx
 7S5W9W7o2YcW308+QtTg7c+gUv5dw6VZaiGQwnvMLerYB4FIvndA8kYQ3sbYXPcfYaE2Zh2tJ
 RSRSXSx5TqqLv5QHYmZQxqVtgLdCKK4ypli/HWLtNu9JY0holl6eiWzcL2O/j3SweD7CdRJFc
 OtvbeBtkfAekwsjNJmy3+BhWvuFHpmHcPvCJvibDQdavXaKSPERCg9k6R+wRCABXZqzpwCnIc
 oj78m4PC67RhMeMC9jTAqLVcW/BB4fS8sWM4PlvYzK6mDBde8EN/13Ntn0eIAxeWVibbcYMZV
 GA32ecoM/WDbQjpoTuHPitXb6olHCPMpfn65d0g+7jyvlYnv/ARttuiOkTVMqTsVDZKitF5oi
 W05K2pqMPRp3zLnrqMANIb0xxFL7iaqxInyICnJLvnK5bukByQvrWA5wM5cT1/+C3D1d/OM8E
 4w//1e9wKtoC/jANniFLPf8D0sQDaYi29fjE1LH+7oVNIi4ABPr5LQfDYsVDd3wxLRrxIkHUO
 moIo9GsF3wZw+WaoHAjUa1e6UeQSMJA6/KhSNFA5FYjHN/j7dEx0A1sRaKV7ZJM7AZgKWlUYj
 Fdf7GSS9eOwCXlLzAShEPf9JYzCi7BEwKI8Dd4rsmW4YUvhoh1QnZMyQGqlQrUfDFcYTWieq6
 N5Jm9C2yv3tOShsbud6VXLnQfOYk1SWRMpfNp+DI0yQ2oTCWM6UCRn3mi9/YSw1INrgM=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As Mathieu pointed out, my conversion to time64_t was incorrect and resulted
in negative times to be read from the RTC. The problem is that during the
conversion from a byte array to a time64_t, the 'unsigned char' variable
holding the top byte gets turned into a negative signed 32-bit integer
before being assigned to the 64-bit variable for any times after 1972.

This changes the logic to cast to an unsigned 32-bit number first for
the Macintosh time and then convert that to the Unix time, which then gives
us a time in the documented 1904..2040 year range. I decided not to use
the longer 1970..2106 range that other drivers use, for consistency with
the literal interpretation of the register, but that could be easily
changed if we decide we want to support any Mac after 2040.

Just to be on the safe side, I'm also adding a WARN_ON that will trigger
if either the year 2040 has come and is observed by this driver, or we
run into an RTC that got set back to a pre-1970 date for some reason
(the two are indistinguishable).

For the RTC write functions, Andreas found another problem: both
pmu_request() and cuda_request() are varargs functions, so changing
the type of the arguments passed into them from 32 bit to 64 bit
breaks the API for the set_rtc_time functions. This changes it
back to 32 bits.

The same code exists in arch/m68k/ and is patched in an identical way now
in a separate patch.

Fixes: 5bfd643583b2 ("powerpc: use time64_t in read_persistent_clock")
Reported-by: Mathieu Malaterre <malat@debian.org>
Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/powerpc/platforms/powermac/time.c | 29 ++++++++++++++++++++---------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/time.c b/arch/powerpc/platforms/powermac/time.c
index 7c968e46736f..12e6e4d30602 100644
--- a/arch/powerpc/platforms/powermac/time.c
+++ b/arch/powerpc/platforms/powermac/time.c
@@ -42,7 +42,11 @@
 #define DBG(x...)
 #endif
 
-/* Apparently the RTC stores seconds since 1 Jan 1904 */
+/*
+ * Offset between Unix time (1970-based) and Mac time (1904-based). Cuda and PMU
+ * times wrap in 2040. If we need to handle later times, the read_time functions
+ * need to be changed to interpret wrapped times as post-2040.
+ */
 #define RTC_OFFSET	2082844800
 
 /*
@@ -97,8 +101,11 @@ static time64_t cuda_get_time(void)
 	if (req.reply_len != 7)
 		printk(KERN_ERR "cuda_get_time: got %d byte reply\n",
 		       req.reply_len);
-	now = (req.reply[3] << 24) + (req.reply[4] << 16)
-		+ (req.reply[5] << 8) + req.reply[6];
+	now = (u32)((req.reply[3] << 24) + (req.reply[4] << 16) +
+		    (req.reply[5] << 8) + req.reply[6]);
+	/* it's either after year 2040, or the RTC has gone backwards */
+	WARN_ON(now < RTC_OFFSET);
+
 	return now - RTC_OFFSET;
 }
 
@@ -106,10 +113,10 @@ static time64_t cuda_get_time(void)
 
 static int cuda_set_rtc_time(struct rtc_time *tm)
 {
-	time64_t nowtime;
+	u32 nowtime;
 	struct adb_request req;
 
-	nowtime = rtc_tm_to_time64(tm) + RTC_OFFSET;
+	nowtime = lower_32_bits(rtc_tm_to_time64(tm) + RTC_OFFSET);
 	if (cuda_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
 			 nowtime >> 24, nowtime >> 16, nowtime >> 8,
 			 nowtime) < 0)
@@ -140,8 +147,12 @@ static time64_t pmu_get_time(void)
 	if (req.reply_len != 4)
 		printk(KERN_ERR "pmu_get_time: got %d byte reply from PMU\n",
 		       req.reply_len);
-	now = (req.reply[0] << 24) + (req.reply[1] << 16)
-		+ (req.reply[2] << 8) + req.reply[3];
+	now = (u32)((req.reply[0] << 24) + (req.reply[1] << 16)	+
+		    (req.reply[2] << 8) + req.reply[3]);
+
+	/* it's either after year 2040, or the RTC has gone backwards */
+	WARN_ON(now < RTC_OFFSET);
+
 	return now - RTC_OFFSET;
 }
 
@@ -149,10 +160,10 @@ static time64_t pmu_get_time(void)
 
 static int pmu_set_rtc_time(struct rtc_time *tm)
 {
-	time64_t nowtime;
+	u32 nowtime;
 	struct adb_request req;
 
-	nowtime = rtc_tm_to_time64(tm) + RTC_OFFSET;
+	nowtime = lower_32_bits(rtc_tm_to_time64(tm) + RTC_OFFSET);
 	if (pmu_request(&req, NULL, 5, PMU_SET_RTC, nowtime >> 24,
 			nowtime >> 16, nowtime >> 8, nowtime) < 0)
 		return -ENXIO;
-- 
2.9.0

