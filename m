Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525316084; cv=none;
        d=google.com; s=arc-20160816;
        b=upSr8XwAlYUqDIKQgHEgBu9X1G60A0c8Bd3WQUJzJMCex7I0UgAwvc7b2LZ0Wco2ku
         u/ibhDt7HEuqw6UULZU8/aGuD5/9dwMu7HgPVGz3hZGc1Tw6RgpxltxbgbHMWVJjNe9f
         N0aacTDqbWPvAUO7egAw21Lpg7K2fMVim8Jybcn8Stg5KjBWEtPukxbhX7wg9ySb6oeY
         A5gSAO/XRedaYME2uN3ecxtkUrB6r0XKyRCwduEFYF4zQBevIEADeFeAFGpgkVXKc4Av
         9xnuFFC/lhoK8BIxSFrgGrhS3+OHLSiFIFEb0cbbeOYUD8We5kEhPkOceTJRmaCwYtIT
         m2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=XSoftft/olyeIJpXhLFzsucFm9+9I0bsHekgZW7hQoU=;
        b=aRL2WdpVW8Pm7WlKN9bfEnYMidCObS9Wctf0/Hla9Z/0qVNmBWNzNhKaYOU8iOgOVR
         2z0MYJKc7GUW0SQKf6eCR8ptIS7jXMDshsqsVqN+VnkYb5RUL9r7qNjE/aAyXOZynkDs
         aKU7F/7uuYVBau/vvyw4+MekdeLH1peEsyO28/9iVJUFNDNTGAteh1k+INJcz/1LVPcu
         g7JYho/VxQLK4Q1W9ATWB7crgn92tCL4cdpXVUG1SmaxOwLSrFyjOT+eljvbAnhsTCmK
         nJ9E3D9XpS1ZXOKbw2ddodHVhu2xqNxRHSwX4+X4sKrX6qRpKMsulcVxskeJ3S3jVp5E
         5C8w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EkC6HcdU;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=EkC6HcdU;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZo1HSnvbNBO5yLowD2sM2QHe9rMc/GhVX+HOEYQAksuErlwPQU38m4KqfbiuJcpfku7LNd6pQ==
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
Subject: [PATCH 1/2] MIPS: Convert read_persistent_clock() to read_persistent_clock64()
Date: Thu,  3 May 2018 10:53:17 +0800
Message-Id: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525262725.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599409838833171647?=
X-GMAIL-MSGID: =?utf-8?q?1599409838833171647?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since struct timespec is not y2038 safe on 32bit machines, this patch
converts read_persistent_clock() to read_persistent_clock64() using
struct timespec64, as well as converting mktime() to mktime64().

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
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
