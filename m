Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753934AbeDWBDQ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 21:03:16 -0400
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:45702 "EHLO
        kvm5.telegraphics.com.au" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753825AbeDWBDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 21:03:11 -0400
Date: Mon, 23 Apr 2018 11:02:57 +1000
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        Sam Creasey <sammy@sammy.net>
Cc: linux-m68k@vger.kernel.org, linux-kernel@vger.kernel.org
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] m68k: Fix off-by-one calendar month
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-Id: <S1753934AbeDWBDQ/20180423010317Z+1318@vger.kernel.org>

This fixes a bug in read_persistent_clock() which causes the system
clock to lag the Real Time Clock by one month. The problem was noticed
on a Mac, but theoretically it must also affect Atari, BVME6000 and Q40.

The tm_mon value in the struct rtc_time passed to mach_hwclk() is
zero-based, and atari_mste_hwclk(), atari_tt_hwclk(), bvme6000_hwclk(),
mac_hwclk() and q40_hwclk() all make this adjustment. Unfortunately,
dn_dummy_hwclk(), mvme147_hwclk(), mvme16x_hwclk(), sun3_hwclk() and
sun3x_hwclk() fail to decrement tm_mon.

Bring these platforms into line and fix read_persistent_clock() so it
works correctly on all m68k platforms.

The datasheets for the RTC devices found on the affected platforms
all confirm that the year is stored as a value in the range 0-99 and
the month is stored as a value in the range 1-12. Please refer to the
datasheets for MC146818 (Apollo), DS1643 (MVME), ICM7170 (Sun 3)
and M48T02 (Sun 3x).

Reported-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/apollo/config.c  |  8 +++++---
 arch/m68k/kernel/time.c    | 14 +++++++-------
 arch/m68k/mvme147/config.c |  4 +++-
 arch/m68k/mvme16x/config.c |  4 +++-
 arch/m68k/sun3/intersil.c  |  8 +++++---
 arch/m68k/sun3x/time.c     |  8 +++++---
 6 files changed, 28 insertions(+), 18 deletions(-)

diff --git a/arch/m68k/apollo/config.c b/arch/m68k/apollo/config.c
index 0d27706f14d4..8a5f98904af3 100644
--- a/arch/m68k/apollo/config.c
+++ b/arch/m68k/apollo/config.c
@@ -221,8 +221,10 @@ int dn_dummy_hwclk(int op, struct rtc_time *t) {
     t->tm_hour=rtc->hours;
     t->tm_mday=rtc->day_of_month;
     t->tm_wday=rtc->day_of_week;
-    t->tm_mon=rtc->month;
+    t->tm_mon = rtc->month - 1;
     t->tm_year=rtc->year;
+    if (t->tm_year < 70)
+    	t->tm_year += 100;
   } else {
     rtc->second=t->tm_sec;
     rtc->minute=t->tm_min;
@@ -230,8 +232,8 @@ int dn_dummy_hwclk(int op, struct rtc_time *t) {
     rtc->day_of_month=t->tm_mday;
     if(t->tm_wday!=-1)
       rtc->day_of_week=t->tm_wday;
-    rtc->month=t->tm_mon;
-    rtc->year=t->tm_year;
+    rtc->month = t->tm_mon + 1;
+    rtc->year = t->tm_year % 100;
   }
 
   return 0;
diff --git a/arch/m68k/kernel/time.c b/arch/m68k/kernel/time.c
index 97dd4e26f234..6b4389a6e8ea 100644
--- a/arch/m68k/kernel/time.c
+++ b/arch/m68k/kernel/time.c
@@ -74,17 +74,17 @@ static irqreturn_t timer_interrupt(int irq, void *dummy)
 void read_persistent_clock(struct timespec *ts)
 {
 	struct rtc_time time;
+
 	ts->tv_sec = 0;
 	ts->tv_nsec = 0;
 
-	if (mach_hwclk) {
-		mach_hwclk(0, &time);
+	if (!mach_hwclk)
+		return;
+
+	mach_hwclk(0, &time);
 
-		if ((time.tm_year += 1900) < 1970)
-			time.tm_year += 100;
-		ts->tv_sec = mktime(time.tm_year, time.tm_mon, time.tm_mday,
-				      time.tm_hour, time.tm_min, time.tm_sec);
-	}
+	ts->tv_sec = mktime(time.tm_year + 1900, time.tm_mon + 1, time.tm_mday,
+			    time.tm_hour, time.tm_min, time.tm_sec);
 }
 
 #if defined(CONFIG_ARCH_USES_GETTIMEOFFSET) && IS_ENABLED(CONFIG_RTC_DRV_GENERIC)
diff --git a/arch/m68k/mvme147/config.c b/arch/m68k/mvme147/config.c
index 8778612d1f31..f8a710fd84cd 100644
--- a/arch/m68k/mvme147/config.c
+++ b/arch/m68k/mvme147/config.c
@@ -153,12 +153,14 @@ int mvme147_hwclk(int op, struct rtc_time *t)
 	if (!op) {
 		m147_rtc->ctrl = RTC_READ;
 		t->tm_year = bcd2int (m147_rtc->bcd_year);
-		t->tm_mon  = bcd2int (m147_rtc->bcd_mth);
+		t->tm_mon  = bcd2int(m147_rtc->bcd_mth) - 1;
 		t->tm_mday = bcd2int (m147_rtc->bcd_dom);
 		t->tm_hour = bcd2int (m147_rtc->bcd_hr);
 		t->tm_min  = bcd2int (m147_rtc->bcd_min);
 		t->tm_sec  = bcd2int (m147_rtc->bcd_sec);
 		m147_rtc->ctrl = 0;
+		if (t->tm_year < 70)
+			t->tm_year += 100;
 	}
 	return 0;
 }
diff --git a/arch/m68k/mvme16x/config.c b/arch/m68k/mvme16x/config.c
index 6fa06d4d16bf..4ffd9ef98de4 100644
--- a/arch/m68k/mvme16x/config.c
+++ b/arch/m68k/mvme16x/config.c
@@ -400,12 +400,14 @@ int mvme16x_hwclk(int op, struct rtc_time *t)
 	if (!op) {
 		rtc->ctrl = RTC_READ;
 		t->tm_year = bcd2int (rtc->bcd_year);
-		t->tm_mon  = bcd2int (rtc->bcd_mth);
+		t->tm_mon  = bcd2int(rtc->bcd_mth) - 1;
 		t->tm_mday = bcd2int (rtc->bcd_dom);
 		t->tm_hour = bcd2int (rtc->bcd_hr);
 		t->tm_min  = bcd2int (rtc->bcd_min);
 		t->tm_sec  = bcd2int (rtc->bcd_sec);
 		rtc->ctrl = 0;
+		if (t->tm_year < 70)
+			t->tm_year += 100;
 	}
 	return 0;
 }
diff --git a/arch/m68k/sun3/intersil.c b/arch/m68k/sun3/intersil.c
index 2cd0bcbe6f30..d911070af02a 100644
--- a/arch/m68k/sun3/intersil.c
+++ b/arch/m68k/sun3/intersil.c
@@ -48,9 +48,9 @@ int sun3_hwclk(int set, struct rtc_time *t)
 		todintersil->hour = t->tm_hour;
 		todintersil->minute = t->tm_min;
 		todintersil->second = t->tm_sec;
-		todintersil->month = t->tm_mon;
+		todintersil->month = t->tm_mon + 1;
 		todintersil->day = t->tm_mday;
-		todintersil->year = t->tm_year - 68;
+		todintersil->year = (t->tm_year - 68) % 100;
 		todintersil->weekday = t->tm_wday;
 	} else {
 		/* read clock */
@@ -58,10 +58,12 @@ int sun3_hwclk(int set, struct rtc_time *t)
 		t->tm_hour = todintersil->hour;
 		t->tm_min = todintersil->minute;
 		t->tm_sec = todintersil->second;
-		t->tm_mon = todintersil->month;
+		t->tm_mon = todintersil->month - 1;
 		t->tm_mday = todintersil->day;
 		t->tm_year = todintersil->year + 68;
 		t->tm_wday = todintersil->weekday;
+		if (t->tm_year < 70)
+			t->tm_year += 100;
 	}
 
 	intersil_clock->cmd_reg = START_VAL;
diff --git a/arch/m68k/sun3x/time.c b/arch/m68k/sun3x/time.c
index 7a2c53d9f779..047e2bcee3d7 100644
--- a/arch/m68k/sun3x/time.c
+++ b/arch/m68k/sun3x/time.c
@@ -52,8 +52,8 @@ int sun3x_hwclk(int set, struct rtc_time *t)
 		h->hour = bin2bcd(t->tm_hour);
 		h->wday = bin2bcd(t->tm_wday);
 		h->mday = bin2bcd(t->tm_mday);
-		h->month = bin2bcd(t->tm_mon);
-		h->year = bin2bcd(t->tm_year);
+		h->month = bin2bcd(t->tm_mon + 1);
+		h->year = bin2bcd(t->tm_year % 100);
 		h->csr &= ~C_WRITE;
 	} else {
 		h->csr |= C_READ;
@@ -62,9 +62,11 @@ int sun3x_hwclk(int set, struct rtc_time *t)
 		t->tm_hour = bcd2bin(h->hour);
 		t->tm_wday = bcd2bin(h->wday);
 		t->tm_mday = bcd2bin(h->mday);
-		t->tm_mon = bcd2bin(h->month);
+		t->tm_mon = bcd2bin(h->month) - 1;
 		t->tm_year = bcd2bin(h->year);
 		h->csr &= ~C_READ;
+		if (t->tm_year < 70)
+			t->tm_year += 100;
 	}
 
 	local_irq_restore(flags);
-- 
2.16.1
