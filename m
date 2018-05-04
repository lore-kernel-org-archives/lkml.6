Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525417733; cv=none;
        d=google.com; s=arc-20160816;
        b=IpgEimo1jggVH34t3G+Sa2M28Kc5GnPc7nUoNFTthlgn8487+x3874kTagaGzQ8x+/
         3x4KCgXxo9Ri09GK86Vi0OrIqMYchdyd8jfkO0M5zm/JKaF9W+fsFXr1J1AZMpp0zmWP
         ogFiyM85XokN1TCMYD3qsxjbiLTKeL9PQluOdvc5lLeclP4Kljlg4xKyNC8I/kqRZJxs
         u3VfuETB7pXEcN4af2U5WbSAGXmsS5T0jGjGl2uTa+YYnoPwVWclOhjdnEhmd6CYuPsA
         gtqzj9O32BdrmoC3rx0ygW99l826US+831qfK68gtWbYPByykLcPlbHBHEONVtJDbxEt
         /q/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=3aiI3kiE6HByxIoW7A57wa5Bds4Ky7Z3/xIJUax8Rdk=;
        b=IxOc3tdtuXk02Izk/4V5VKk6cAUytMK+voZqKIrEhwzruu/wksQ+FWn/QyDnla+ajj
         eUK4SF54vM3wDs2fo4FGdUcerValZZP9uADnh6p7EOwOcRKIIlDZR2cxrqk2G3KsXgw2
         08SIBdP2/yYapNglCOsUNIzg0/gtorF4sOR+2dHC8IMXi28Oq8h+450UdMmC/XoDYIyP
         Id17iE057HQFMTh5KAZxiVrG9BzKTxnbEWZBsNHxYEfSZLQHvfflbAzWG0bKsPrq/ReV
         qqakAVW5oKpiwKQmsKxqF+aEhQvReIMAnZVBXRYnDh06CVWSST0nTNm4YIsboSFnModd
         wENg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GwLK/2F4;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=GwLK/2F4;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZrF1hLVhXKPACndQwm2/aQ85kkTaIP/LYhutjG7PVXYs6Mon5ZKVBxWSRUx6PKeCOBGQvmNVw==
From: Baolin Wang <baolin.wang@linaro.org>
To: macro@linux-mips.org,
	ralf@linux-mips.org,
	jhogan@kernel.org,
	chenhc@lemote.com
Cc: kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	tglx@linutronix.de,
	pombredanne@nexb.com,
	arnd@arndb.de,
	broonie@kernel.org,
	paul.burton@mips.com,
	heiko@sntech.de,
	daniel.lezcano@linaro.org,
	viresh.kumar@linaro.org,
	baolin.wang@linaro.org,
	linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] MIPS: Convert read_persistent_clock() to read_persistent_clock64()
Date: Fri,  4 May 2018 15:07:47 +0800
Message-Id: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525417306.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599516425368341249?=
X-GMAIL-MSGID: =?utf-8?q?1599516425368341249?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since struct timespec is not y2038 safe on 32bit machines, this patch
converts read_persistent_clock() to read_persistent_clock64() using
struct timespec64, as well as converting mktime() to mktime64().

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
Changes since v1:
 - No updates.
---
 arch/mips/dec/time.c                   |    4 ++--
 arch/mips/include/asm/mc146818-time.h  |    4 ++--
 arch/mips/lasat/ds1603.c               |    2 +-
 arch/mips/loongson64/common/time.c     |    2 +-
 arch/mips/mti-malta/malta-time.c       |    2 +-
 arch/mips/sibyte/swarm/rtc_m41t81.c    |    4 ++--
 arch/mips/sibyte/swarm/rtc_xicor1241.c |    4 ++--
 arch/mips/sibyte/swarm/setup.c         |   10 +++++-----
 8 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
index a2a150e..9e992cf 100644
--- a/arch/mips/dec/time.c
+++ b/arch/mips/dec/time.c
@@ -19,7 +19,7 @@
 #include <asm/dec/ioasic.h>
 #include <asm/dec/machtype.h>
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	unsigned int year, mon, day, hour, min, sec, real_year;
 	unsigned long flags;
@@ -54,7 +54,7 @@ void read_persistent_clock(struct timespec *ts)
 
 	year += real_year - 72 + 2000;
 
-	ts->tv_sec = mktime(year, mon, day, hour, min, sec);
+	ts->tv_sec = mktime64(year, mon, day, hour, min, sec);
 	ts->tv_nsec = 0;
 }
 
diff --git a/arch/mips/include/asm/mc146818-time.h b/arch/mips/include/asm/mc146818-time.h
index 9e1ad26..cbf5cec 100644
--- a/arch/mips/include/asm/mc146818-time.h
+++ b/arch/mips/include/asm/mc146818-time.h
@@ -86,7 +86,7 @@ static inline int mc146818_set_rtc_mmss(unsigned long nowtime)
 	return retval;
 }
 
-static inline unsigned long mc146818_get_cmos_time(void)
+static inline time64_t mc146818_get_cmos_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
 	unsigned long flags;
@@ -113,7 +113,7 @@ static inline unsigned long mc146818_get_cmos_time(void)
 	spin_unlock_irqrestore(&rtc_lock, flags);
 	year = mc146818_decode_year(year);
 
-	return mktime(year, mon, day, hour, min, sec);
+	return mktime64(year, mon, day, hour, min, sec);
 }
 
 #endif /* __ASM_MC146818_TIME_H */
diff --git a/arch/mips/lasat/ds1603.c b/arch/mips/lasat/ds1603.c
index 8bd5cf8..d75c887 100644
--- a/arch/mips/lasat/ds1603.c
+++ b/arch/mips/lasat/ds1603.c
@@ -136,7 +136,7 @@ static void rtc_end_op(void)
 	lasat_ndelay(1000);
 }
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	unsigned long word;
 	unsigned long flags;
diff --git a/arch/mips/loongson64/common/time.c b/arch/mips/loongson64/common/time.c
index e1a5382a..0ba53c5 100644
--- a/arch/mips/loongson64/common/time.c
+++ b/arch/mips/loongson64/common/time.c
@@ -29,7 +29,7 @@ void __init plat_time_init(void)
 #endif
 }
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	ts->tv_sec = mc146818_get_cmos_time();
 	ts->tv_nsec = 0;
diff --git a/arch/mips/mti-malta/malta-time.c b/arch/mips/mti-malta/malta-time.c
index 66c8667..d22b7ed 100644
--- a/arch/mips/mti-malta/malta-time.c
+++ b/arch/mips/mti-malta/malta-time.c
@@ -134,7 +134,7 @@ static void __init estimate_frequencies(void)
 	}
 }
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	ts->tv_sec = mc146818_get_cmos_time();
 	ts->tv_nsec = 0;
diff --git a/arch/mips/sibyte/swarm/rtc_m41t81.c b/arch/mips/sibyte/swarm/rtc_m41t81.c
index e624664..aa27a22 100644
--- a/arch/mips/sibyte/swarm/rtc_m41t81.c
+++ b/arch/mips/sibyte/swarm/rtc_m41t81.c
@@ -188,7 +188,7 @@ int m41t81_set_time(unsigned long t)
 	return 0;
 }
 
-unsigned long m41t81_get_time(void)
+time64_t m41t81_get_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec;
 	unsigned long flags;
@@ -218,7 +218,7 @@ unsigned long m41t81_get_time(void)
 
 	year += 2000;
 
-	return mktime(year, mon, day, hour, min, sec);
+	return mktime64(year, mon, day, hour, min, sec);
 }
 
 int m41t81_probe(void)
diff --git a/arch/mips/sibyte/swarm/rtc_xicor1241.c b/arch/mips/sibyte/swarm/rtc_xicor1241.c
index 50a82c4..a2121c1 100644
--- a/arch/mips/sibyte/swarm/rtc_xicor1241.c
+++ b/arch/mips/sibyte/swarm/rtc_xicor1241.c
@@ -168,7 +168,7 @@ int xicor_set_time(unsigned long t)
 	return 0;
 }
 
-unsigned long xicor_get_time(void)
+time64_t xicor_get_time(void)
 {
 	unsigned int year, mon, day, hour, min, sec, y2k;
 	unsigned long flags;
@@ -201,7 +201,7 @@ unsigned long xicor_get_time(void)
 
 	year += (y2k * 100);
 
-	return mktime(year, mon, day, hour, min, sec);
+	return mktime64(year, mon, day, hour, min, sec);
 }
 
 int xicor_probe(void)
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 494fb0a..7073940 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -58,11 +58,11 @@
 
 extern int xicor_probe(void);
 extern int xicor_set_time(unsigned long);
-extern unsigned long xicor_get_time(void);
+extern time64_t xicor_get_time(void);
 
 extern int m41t81_probe(void);
 extern int m41t81_set_time(unsigned long);
-extern unsigned long m41t81_get_time(void);
+extern time64_t m41t81_get_time(void);
 
 const char *get_system_type(void)
 {
@@ -87,9 +87,9 @@ enum swarm_rtc_type {
 
 enum swarm_rtc_type swarm_rtc_type;
 
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
-	unsigned long sec;
+	time64_t sec;
 
 	switch (swarm_rtc_type) {
 	case RTC_XICOR:
@@ -102,7 +102,7 @@ void read_persistent_clock(struct timespec *ts)
 
 	case RTC_NONE:
 	default:
-		sec = mktime(2000, 1, 1, 0, 0, 0);
+		sec = mktime64(2000, 1, 1, 0, 0, 0);
 		break;
 	}
 	ts->tv_sec = sec;
-- 
1.7.9.5
