Return-Path: <baolin.wang@linaro.org>
ARC-Seal: i=1; a=rsa-sha256; t=1526288253; cv=none;
        d=google.com; s=arc-20160816;
        b=v1BbzO4eYVnqqYbYS+0TaQIcquRu22/qqxrLc+OeXu50hrRwzLaxTxdUQIN2uZOX3D
         aulgt1VAt4GJn6Xq9SHffwcQhgb+ldTqDLRlW0FA8pDjH5+/CbpwpbOofMRkPAbaZ/VM
         AV6HlmjnLh3ni1SUKJKGnmL5cMgFOgOEpb/TKINTtiPAm3aXmw6OcMBePeEcSNlalxce
         Kww+c79qt8uCRKL6O+Asy2JvzM3c0bitzNARBnB86jnDYgRI2hLq3EQSSJ2cdBkDN23C
         D33ly/sNV9rLsAhr29hCgxmwsj2wBb4EtLSfQkTwNfrOv0z9dnBNHovuTmP88EBYdruF
         GsRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:references:in-reply-to:message-id:date
         :subject:cc:to:from:dkim-signature:arc-authentication-results;
        bh=6dTncBxPB46L6hH2lsBRv+i0+ICaH1S5Yj0USGe1ULU=;
        b=N8tUG5dzv9yyYHeQmXVKsHnfz+qKm2FD+WfQw582jnir92I0RAOhmvX/OKizQytn2Y
         MiFKyFvBR16GLEN/9Sg00rLMGnIWKFM4IpHmGRfMn3h5LhVzHGBEjgWe2MR5Ejt94JFY
         YJqIRSuwOse/+i3DMh+sXWq6ud0RwbRa4ZZ3g7qVRyNzM7TICrTngf/aPIj/sAd2FLW/
         KozoP6vd79SKAvUxzSrrU5eeagV49xqxs75YthggPiWyW9t/jdn3YsX1mb2pX5a0vX03
         65GWVCKPmJWVqV3VjIKgtjG4XXFptMEsgIa/1iTil9IDOuVgVQX9dqb96IqF+mMFVhay
         f9Yw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=O7LuXt9D;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linaro.org header.s=google header.b=O7LuXt9D;
       spf=pass (google.com: domain of baolin.wang@linaro.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=baolin.wang@linaro.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=linaro.org
X-Google-Smtp-Source: AB8JxZo3EboH5j0rOkcgS5ID7lKGvWmJqXO/A+aUqM8m87TyP8zqOjsWDTHTk8Z65mB9gwai7pGAJA==
From: Baolin Wang <baolin.wang@linaro.org>
To: tglx@linutronix.de,
	john.stultz@linaro.org,
	daniel.lezcano@linaro.org,
	arnd@arndb.de,
	tony@atomide.com,
	aaro.koskinen@iki.fi,
	linux@armlinux.org.uk,
	mark.rutland@arm.com,
	marc.zyngier@arm.com
Cc: baolin.wang@linaro.org,
	broonie@kernel.org,
	paulmck@linux.vnet.ibm.com,
	mlichvar@redhat.com,
	rdunlap@infradead.org,
	kstewart@linuxfoundation.org,
	gregkh@linuxfoundation.org,
	pombredanne@nexb.com,
	thierry.reding@gmail.com,
	jonathanh@nvidia.com,
	heiko@sntech.de,
	linus.walleij@linaro.org,
	viresh.kumar@linaro.org,
	mingo@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	douly.fnst@cn.fujitsu.com,
	len.brown@intel.com,
	rajvi.jingar@intel.com,
	alexandre.belloni@bootlin.com,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-omap@vger.kernel.org
Subject: [RFC PATCH 09/10] x86: tsc: Register the persistent clock
Date: Mon, 14 May 2018 16:55:35 +0800
Message-Id: <3b626f6d7dd5ca047e6835b10c3a4e662db2539f.1526285602.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1526285602.git.baolin.wang@linaro.org>
References: <cover.1526285602.git.baolin.wang@linaro.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600429232051472181?=
X-GMAIL-MSGID: =?utf-8?q?1600429232051472181?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Register the tsc as one persistent clock to compensate the suspend time
if the tsc clocksource is always available.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 arch/x86/Kconfig      |    1 +
 arch/x86/kernel/tsc.c |   16 ++++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index c07f492..667e3a7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -195,6 +195,7 @@ config X86
 	select USER_STACKTRACE_SUPPORT
 	select VIRT_TO_BUS
 	select X86_FEATURE_NAMES		if PROC_FS
+	select PERSISTENT_CLOCK
 
 config INSTRUCTION_DECODER
 	def_bool y
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 74392d9..dd8d7c3 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -11,6 +11,7 @@
 #include <linux/delay.h>
 #include <linux/clocksource.h>
 #include <linux/percpu.h>
+#include <linux/persistent_clock.h>
 #include <linux/timex.h>
 #include <linux/static_key.h>
 
@@ -1032,6 +1033,11 @@ static u64 read_tsc(struct clocksource *cs)
 	return (u64)rdtsc_ordered();
 }
 
+static u64 notrace tsc_read_persistent_clock(void)
+{
+	return (u64)rdtsc_ordered();
+}
+
 static void tsc_cs_mark_unstable(struct clocksource *cs)
 {
 	if (tsc_unstable)
@@ -1300,6 +1306,11 @@ static void tsc_refine_calibration_work(struct work_struct *work)
 	if (boot_cpu_has(X86_FEATURE_ART))
 		art_related_clocksource = &clocksource_tsc;
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
+
+	if (clocksource_tsc.flags & CLOCK_SOURCE_SUSPEND_NONSTOP)
+		persistent_clock_init_and_register(tsc_read_persistent_clock,
+						   CLOCKSOURCE_MASK(64),
+						   tsc_khz, 0);
 unreg:
 	clocksource_unregister(&clocksource_tsc_early);
 }
@@ -1327,6 +1338,11 @@ static int __init init_tsc_clocksource(void)
 		if (boot_cpu_has(X86_FEATURE_ART))
 			art_related_clocksource = &clocksource_tsc;
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
+
+		if (clocksource_tsc.flags & CLOCK_SOURCE_SUSPEND_NONSTOP)
+			persistent_clock_init_and_register(tsc_read_persistent_clock,
+							   CLOCKSOURCE_MASK(64),
+							   tsc_khz, 0);
 unreg:
 		clocksource_unregister(&clocksource_tsc_early);
 		return 0;
-- 
1.7.9.5
