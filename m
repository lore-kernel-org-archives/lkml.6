Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1525316089; cv=none;
        d=google.com; s=arc-20160816;
        b=jR9o25iiAuc2rjV7nIwRAW+8JmG18N4A99GSDRAf6La9DB538Z/rwPZSpuZUvJjg2/
         OHUEl64SA4K0VOHxzscEJrKmwe7aFUHeG9l66D2t4azvMSGNzA++36JELEHioAhpYz6f
         neR93kotL/X+G/GUu4tr/iWJjtNIKXBsL5+OUHHZJvZAhwtW+YhiSYd9Et0Xr/SJTmFR
         GQhwnCBolU/At+ANsOL8aM3PA93gJ1bLyJRm0tsL8J+EW5eWV85rxgq51aMI2OFfvTlI
         41SV6na0lJujbaIdy+4FxC72IZEvnZjEjjlx1e27R5Xq7NRZTb77AkkVhpb6UoOMjGZp
         aVkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=cQ+5/kQaK3QLhGVNWvUfqX3223qL2I21JjAReG4Mla4=;
        b=Jf++NiBdteEnmHo8ixePn1Smzb51lnO8Sa9J4ysDSOImpU2CPXiX1teiYRDS/rc8gT
         EJu8yiFpcUj/u7thTUW+/KI0LvMKxSOXiNusvWM9yQMwBYb6HFldOJXIi65/ruiFMol0
         x1cOjl8HiBlNURVGw/Z83WW3B+yw9kj6THMrs9geJ1sPcaM3u2GSkyFwf7pSNgaqG4Al
         Z0pMNwNVxau6nwUx23zbP738sQ5HQAt9lzNKadKS9RZl3xYnqnz2gkIQqVGa+SKA8elz
         wlXOypgAQM3Fq+Ft8cb90OmHuB1hR4x7qU7vr4GJlurhlqAzMN8yRi0lv/4VnoSb1cq4
         c6cQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=CVsErqug;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=CVsErqug;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZq/wwbIpC0ucRSbEUPpkUbK00xI6UmJLWQVwijksudA7qlvNLCM7+Bum19syZ0FhFGIjcuGvQ==
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
Subject: [PATCH 2/2] MIPS: Convert update_persistent_clock() to update_persistent_clock64()
Date: Thu,  3 May 2018 10:53:18 +0800
Message-Id: <e8ddeeea84626e43dcac4f0731992cbad932ce7a.1525262725.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525262725.git.baolin.wang@linaro.org>
References: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525262725.git.baolin.wang@linaro.org>
In-Reply-To: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525262725.git.baolin.wang@linaro.org>
References: <c26982955db16b8f790e7f5f2a5b63e42bc78192.1525262725.git.baolin.wang@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599409843687594194?=
X-GMAIL-MSGID: =?utf-8?q?1599409843687594194?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Since struct timespec is not y2038 safe on 32bit machines, this patch
converts update_persistent_clock() to update_persistent_clock64() using
struct timespec64.

This patch also changes rtc_mips_set_time()/rtc_mips_set_mmss() interfaces
to use time64_t, which is y2038 safe.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/mips/dec/time.c                   |    2 +-
 arch/mips/include/asm/time.h           |    4 ++--
 arch/mips/kernel/time.c                |    6 +++---
 arch/mips/lasat/ds1603.c               |    4 ++--
 arch/mips/lasat/sysctl.c               |    6 +++---
 arch/mips/sibyte/swarm/rtc_m41t81.c    |    4 ++--
 arch/mips/sibyte/swarm/rtc_xicor1241.c |    4 ++--
 arch/mips/sibyte/swarm/setup.c         |    6 +++---
 8 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/arch/mips/dec/time.c b/arch/mips/dec/time.c
index 9e992cf..c2d6ec8 100644
--- a/arch/mips/dec/time.c
+++ b/arch/mips/dec/time.c
@@ -65,7 +65,7 @@ void read_persistent_clock64(struct timespec64 *ts)
  * jump to the next second precisely 500 ms later.  Check the Dallas
  * DS1287 data sheet for details.
  */
-int rtc_mips_set_mmss(unsigned long nowtime)
+int rtc_mips_set_mmss(time64_t nowtime)
 {
 	int retval = 0;
 	int real_seconds, real_minutes, cmos_minutes;
diff --git a/arch/mips/include/asm/time.h b/arch/mips/include/asm/time.h
index 17d4cd2..c4e2a1a 100644
--- a/arch/mips/include/asm/time.h
+++ b/arch/mips/include/asm/time.h
@@ -27,8 +27,8 @@
  *	rtc_mips_set_mmss - similar to rtc_set_time, but only min and sec need
  *			to be set.  Used by RTC sync-up.
  */
-extern int rtc_mips_set_time(unsigned long);
-extern int rtc_mips_set_mmss(unsigned long);
+extern int rtc_mips_set_time(time64_t);
+extern int rtc_mips_set_mmss(time64_t);
 
 /*
  * board specific routines required by time_init().
diff --git a/arch/mips/kernel/time.c b/arch/mips/kernel/time.c
index a6ebc81..01ba5ab 100644
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -34,17 +34,17 @@
 DEFINE_SPINLOCK(rtc_lock);
 EXPORT_SYMBOL(rtc_lock);
 
-int __weak rtc_mips_set_time(unsigned long sec)
+int __weak rtc_mips_set_time(time64_t sec)
 {
 	return -ENODEV;
 }
 
-int __weak rtc_mips_set_mmss(unsigned long nowtime)
+int __weak rtc_mips_set_mmss(time64_t nowtime)
 {
 	return rtc_mips_set_time(nowtime);
 }
 
-int update_persistent_clock(struct timespec now)
+int update_persistent_clock64(struct timespec64 now)
 {
 	return rtc_mips_set_mmss(now.tv_sec);
 }
diff --git a/arch/mips/lasat/ds1603.c b/arch/mips/lasat/ds1603.c
index d75c887..580cf3a 100644
--- a/arch/mips/lasat/ds1603.c
+++ b/arch/mips/lasat/ds1603.c
@@ -98,7 +98,7 @@ static void rtc_write_byte(unsigned int byte)
 	}
 }
 
-static void rtc_write_word(unsigned long word)
+static void rtc_write_word(time64_t word)
 {
 	int i;
 
@@ -152,7 +152,7 @@ void read_persistent_clock64(struct timespec64 *ts)
 	ts->tv_nsec = 0;
 }
 
-int rtc_mips_set_mmss(unsigned long time)
+int rtc_mips_set_mmss(time64_t time)
 {
 	unsigned long flags;
 
diff --git a/arch/mips/lasat/sysctl.c b/arch/mips/lasat/sysctl.c
index 6f74224..4264107 100644
--- a/arch/mips/lasat/sysctl.c
+++ b/arch/mips/lasat/sysctl.c
@@ -53,7 +53,7 @@ int proc_dolasatstring(struct ctl_table *table, int write,
 }
 
 #ifdef CONFIG_DS1603
-static int rtctmp;
+static time64_t rtctmp;
 
 /* proc function to read/write RealTime Clock */
 int proc_dolasatrtc(struct ctl_table *table, int write,
@@ -69,7 +69,7 @@ int proc_dolasatrtc(struct ctl_table *table, int write,
 		if (rtctmp < 0)
 			rtctmp = 0;
 	}
-	r = proc_dointvec(table, write, buffer, lenp, ppos);
+	r = proc_doulongvec_minmax(table, write, buffer, lenp, ppos);
 	if (r)
 		return r;
 
@@ -224,7 +224,7 @@ int proc_lasat_prid(struct ctl_table *table, int write,
 	{
 		.procname	= "rtc",
 		.data		= &rtctmp,
-		.maxlen		= sizeof(int),
+		.maxlen		= sizeof(time64_t),
 		.mode		= 0644,
 		.proc_handler	= proc_dolasatrtc,
 	},
diff --git a/arch/mips/sibyte/swarm/rtc_m41t81.c b/arch/mips/sibyte/swarm/rtc_m41t81.c
index aa27a22..4ac8ccd 100644
--- a/arch/mips/sibyte/swarm/rtc_m41t81.c
+++ b/arch/mips/sibyte/swarm/rtc_m41t81.c
@@ -141,13 +141,13 @@ static int m41t81_write(uint8_t addr, int b)
 	return 0;
 }
 
-int m41t81_set_time(unsigned long t)
+int m41t81_set_time(time64_t t)
 {
 	struct rtc_time tm;
 	unsigned long flags;
 
 	/* Note we don't care about the century */
-	rtc_time_to_tm(t, &tm);
+	rtc_time64_to_tm(t, &tm);
 
 	/*
 	 * Note the write order matters as it ensures the correctness.
diff --git a/arch/mips/sibyte/swarm/rtc_xicor1241.c b/arch/mips/sibyte/swarm/rtc_xicor1241.c
index a2121c1..2dcaaa7 100644
--- a/arch/mips/sibyte/swarm/rtc_xicor1241.c
+++ b/arch/mips/sibyte/swarm/rtc_xicor1241.c
@@ -109,13 +109,13 @@ static int xicor_write(uint8_t addr, int b)
 	}
 }
 
-int xicor_set_time(unsigned long t)
+int xicor_set_time(time64_t t)
 {
 	struct rtc_time tm;
 	int tmp;
 	unsigned long flags;
 
-	rtc_time_to_tm(t, &tm);
+	rtc_time64_to_tm(t, &tm);
 	tm.tm_year += 1900;
 
 	spin_lock_irqsave(&rtc_lock, flags);
diff --git a/arch/mips/sibyte/swarm/setup.c b/arch/mips/sibyte/swarm/setup.c
index 7073940..f356ecd 100644
--- a/arch/mips/sibyte/swarm/setup.c
+++ b/arch/mips/sibyte/swarm/setup.c
@@ -57,11 +57,11 @@
 #endif
 
 extern int xicor_probe(void);
-extern int xicor_set_time(unsigned long);
+extern int xicor_set_time(time64_t);
 extern time64_t xicor_get_time(void);
 
 extern int m41t81_probe(void);
-extern int m41t81_set_time(unsigned long);
+extern int m41t81_set_time(time64_t);
 extern time64_t m41t81_get_time(void);
 
 const char *get_system_type(void)
@@ -109,7 +109,7 @@ void read_persistent_clock64(struct timespec64 *ts)
 	ts->tv_nsec = 0;
 }
 
-int rtc_mips_set_time(unsigned long sec)
+int rtc_mips_set_time(time64_t sec)
 {
 	switch (swarm_rtc_type) {
 	case RTC_XICOR:
-- 
1.7.9.5
