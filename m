Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759251AbeD0URd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 16:17:33 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:48173 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1759077AbeD0URb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 16:17:31 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: y2038@lists.linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, Jan Kiszka <jan.kiszka@siemens.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, Andy Lutomirski <luto@kernel.org>,
        John Stultz <john.stultz@linaro.org>, linux-kernel@vger.kernel.org,
        jailhouse-dev@googlegroups.com, kvm@vger.kernel.org,
        xen-devel@lists.xenproject.org
Subject: [PATCH] [v3] x86: Convert x86_platform_ops to timespec64
Date: Fri, 27 Apr 2018 22:13:23 +0200
Message-Id: <20180427201435.3194219-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K1:kMB8ab3WpaXmbtwx3jpMsYgB+yRDDVYUX8cvpEJzCCbjo/JKXMM
 ifTJVQ474zUKOEsWdIDKjkmC3dvLFCRxhFY0yIoFU2zQqEmXF4IJTrv8R19Qj7RhdPUqhoZ
 26gI57N73qELCEM8CTRie0BjS0+VSpQzB2bQtlx03wySO3mZLj06OKf59y7o6h87YEX1qNb
 cnTCLjEeu0ULYBnNScjoA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r/E3phVmQeA=:65ACmGcwwoel3B18IzCJe1
 iMPtJ7tMnv9s3EMobRobu9RBp0D1jCHDkfSuNAC3O2NRvtpDjarnednhNhMdm3yq/zyFD5U1A
 W9gWKqFVh5foPYW6SMv5Tmz6cefqilC6Vu0EjFOye5kgXM8Q1DQFn4B92AyKoCLzng9MW1ijx
 R0e6d8Rb5R2HuFv4/EpGS8GSPMg+0TUF/JYfiozc72MoMXh2cRCKMIxp4InmuzGT2gOB26DUY
 MDFAkopWPjDTvxA6PCDvFC+H8ffg1+gAKmqibsUW7hMnZ/lqozVQMpphv/7TBh7Mp5CKMeCAg
 K6JO1+6LkfZftRdsaql6MdZsVN3QWO23t/O6e/CNLn6v0yIQnOOkeigkg5yPTmmcW3liSCIxf
 4D13Tivd5C0rLidfqBi433icF0TZ+IcgdQJmrqUGXPSzgr8R3I5bDHVTsh3IzAbS9smrjjxmb
 XsoTMjL8FUdxNedUIOtM4YGkkPHJKORVPHmvm/eYLilip+XhvfNrZABaGofiu3Hf+ad7mcFmX
 Hadphh1T2q7TszMH5dwkcS4sQ3Ccs+Rox86s2TgDJYNO7ukoujvhfhf8NA0kc6g1+c7n4rcm6
 CJ9fPeJ61cDHhBqyZ+/LZlhRoJPmM/UG5Ll07iXNjgpVDEVjt6r17G01OxNJVtvS6kPLJXMCI
 OaB136PaOznYDKnXfTBsZZ66Z822+Qw74VNx/5k/Q6S0MQMX7+/cecJDNAQW1mbUo8i0=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The x86 platform operations are fairly isolated, so we can
change them from using timespec to timespec64. I checked that
All the users and callers are safe, and there is only one
critical function that is broken beyond 2106:

pvclock_read_wallclock() uses a 32-bit number of seconds since
the epoch to communicate the boot time between host and guest
in a virtual environment. This will work until 2106, but we
should ideally find a replacement anyway. I've added a comment
about it there.

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2 changes:
- move comment block (Boris)
- remove unnecessary type cast (Boris)
- fix format string (0day bot)
- fix include order (0day bot)

v3 changes:
- add jailhouse specific change
- avoid include file header by relying on another
  patch ("timekeeping: Remove timespec64 hack")

Not sure how we want to merge this (assuming the last modification
worked, this has seen little testing). The "timekeeping: Remove
timespec64 hack" patch should go through the timekeeping branch
in tip, while this one is for x86. I assume the linux-tip maintainers
can come up with a plan.
---
 arch/x86/include/asm/intel_mid_vrtc.h        |  4 ++--
 arch/x86/include/asm/mc146818rtc.h           |  4 ++--
 arch/x86/include/asm/pvclock.h               |  2 +-
 arch/x86/include/asm/x86_init.h              |  6 +++---
 arch/x86/kernel/jailhouse.c                  |  2 +-
 arch/x86/kernel/kvmclock.c                   |  4 ++--
 arch/x86/kernel/pvclock.c                    | 15 +++++++++++----
 arch/x86/kernel/rtc.c                        | 10 +++++-----
 arch/x86/platform/intel-mid/intel_mid_vrtc.c | 12 ++++++------
 arch/x86/xen/time.c                          | 10 +++++-----
 10 files changed, 38 insertions(+), 31 deletions(-)

diff --git a/arch/x86/include/asm/intel_mid_vrtc.h b/arch/x86/include/asm/intel_mid_vrtc.h
index 35555016b1be..0b44b1abe4d9 100644
--- a/arch/x86/include/asm/intel_mid_vrtc.h
+++ b/arch/x86/include/asm/intel_mid_vrtc.h
@@ -4,7 +4,7 @@
 
 extern unsigned char vrtc_cmos_read(unsigned char reg);
 extern void vrtc_cmos_write(unsigned char val, unsigned char reg);
-extern void vrtc_get_time(struct timespec *now);
-extern int vrtc_set_mmss(const struct timespec *now);
+extern void vrtc_get_time(struct timespec64 *now);
+extern int vrtc_set_mmss(const struct timespec64 *now);
 
 #endif
diff --git a/arch/x86/include/asm/mc146818rtc.h b/arch/x86/include/asm/mc146818rtc.h
index 1775a32f7ea6..97198001e567 100644
--- a/arch/x86/include/asm/mc146818rtc.h
+++ b/arch/x86/include/asm/mc146818rtc.h
@@ -95,8 +95,8 @@ static inline unsigned char current_lock_cmos_reg(void)
 unsigned char rtc_cmos_read(unsigned char addr);
 void rtc_cmos_write(unsigned char val, unsigned char addr);
 
-extern int mach_set_rtc_mmss(const struct timespec *now);
-extern void mach_get_cmos_time(struct timespec *now);
+extern int mach_set_rtc_mmss(const struct timespec64 *now);
+extern void mach_get_cmos_time(struct timespec64 *now);
 
 #define RTC_IRQ 8
 
diff --git a/arch/x86/include/asm/pvclock.h b/arch/x86/include/asm/pvclock.h
index a7471dcd2205..b6033680d458 100644
--- a/arch/x86/include/asm/pvclock.h
+++ b/arch/x86/include/asm/pvclock.h
@@ -12,7 +12,7 @@ void pvclock_set_flags(u8 flags);
 unsigned long pvclock_tsc_khz(struct pvclock_vcpu_time_info *src);
 void pvclock_read_wallclock(struct pvclock_wall_clock *wall,
 			    struct pvclock_vcpu_time_info *vcpu,
-			    struct timespec *ts);
+			    struct timespec64 *ts);
 void pvclock_resume(void);
 
 void pvclock_touch_watchdogs(void);
diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index ce8b4da07e35..2d27236c16a3 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -170,7 +170,7 @@ struct x86_cpuinit_ops {
 	void (*fixup_cpu_id)(struct cpuinfo_x86 *c, int node);
 };
 
-struct timespec;
+struct timespec64;
 
 /**
  * struct x86_legacy_devices - legacy x86 devices
@@ -264,8 +264,8 @@ struct x86_hyper_runtime {
 struct x86_platform_ops {
 	unsigned long (*calibrate_cpu)(void);
 	unsigned long (*calibrate_tsc)(void);
-	void (*get_wallclock)(struct timespec *ts);
-	int (*set_wallclock)(const struct timespec *ts);
+	void (*get_wallclock)(struct timespec64 *ts);
+	int (*set_wallclock)(const struct timespec64 *ts);
 	void (*iommu_shutdown)(void);
 	bool (*is_untracked_pat_range)(u64 start, u64 end);
 	void (*nmi_init)(void);
diff --git a/arch/x86/kernel/jailhouse.c b/arch/x86/kernel/jailhouse.c
index fa183a131edc..a0b05bf185ac 100644
--- a/arch/x86/kernel/jailhouse.c
+++ b/arch/x86/kernel/jailhouse.c
@@ -37,7 +37,7 @@ static uint32_t __init jailhouse_detect(void)
 	return jailhouse_cpuid_base();
 }
 
-static void jailhouse_get_wallclock(struct timespec *now)
+static void jailhouse_get_wallclock(struct timespec64 *now)
 {
 	memset(now, 0, sizeof(*now));
 }
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 8b26c9e01cc4..bf8d1eb7fca3 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -53,7 +53,7 @@ static struct pvclock_wall_clock *wall_clock;
  * have elapsed since the hypervisor wrote the data. So we try to account for
  * that with system time
  */
-static void kvm_get_wallclock(struct timespec *now)
+static void kvm_get_wallclock(struct timespec64 *now)
 {
 	struct pvclock_vcpu_time_info *vcpu_time;
 	int low, high;
@@ -72,7 +72,7 @@ static void kvm_get_wallclock(struct timespec *now)
 	put_cpu();
 }
 
-static int kvm_set_wallclock(const struct timespec *now)
+static int kvm_set_wallclock(const struct timespec64 *now)
 {
 	return -ENODEV;
 }
diff --git a/arch/x86/kernel/pvclock.c b/arch/x86/kernel/pvclock.c
index 761f6af6efa5..637982efecd8 100644
--- a/arch/x86/kernel/pvclock.c
+++ b/arch/x86/kernel/pvclock.c
@@ -123,28 +123,35 @@ u64 pvclock_clocksource_read(struct pvclock_vcpu_time_info *src)
 
 void pvclock_read_wallclock(struct pvclock_wall_clock *wall_clock,
 			    struct pvclock_vcpu_time_info *vcpu_time,
-			    struct timespec *ts)
+			    struct timespec64 *ts)
 {
 	u32 version;
 	u64 delta;
-	struct timespec now;
+	struct timespec64 now;
 
 	/* get wallclock at system boot */
 	do {
 		version = wall_clock->version;
 		rmb();		/* fetch version before time */
+		/*
+		 * Note: wall_clock->sec is a u32 value, so it can
+		 * only store dates between 1970 and 2106. To allow
+		 * times beyond that, we need to create a new hypercall
+		 * interface with an extended pvclock_wall_clock structure
+		 * like ARM has.
+		 */
 		now.tv_sec  = wall_clock->sec;
 		now.tv_nsec = wall_clock->nsec;
 		rmb();		/* fetch time before checking version */
 	} while ((wall_clock->version & 1) || (version != wall_clock->version));
 
 	delta = pvclock_clocksource_read(vcpu_time);	/* time since system boot */
-	delta += now.tv_sec * (u64)NSEC_PER_SEC + now.tv_nsec;
+	delta += now.tv_sec * NSEC_PER_SEC + now.tv_nsec;
 
 	now.tv_nsec = do_div(delta, NSEC_PER_SEC);
 	now.tv_sec = delta;
 
-	set_normalized_timespec(ts, now.tv_sec, now.tv_nsec);
+	set_normalized_timespec64(ts, now.tv_sec, now.tv_nsec);
 }
 
 void pvclock_set_pvti_cpu0_va(struct pvclock_vsyscall_time_info *pvti)
diff --git a/arch/x86/kernel/rtc.c b/arch/x86/kernel/rtc.c
index f7b82ed7b5b5..586f718b8e95 100644
--- a/arch/x86/kernel/rtc.c
+++ b/arch/x86/kernel/rtc.c
@@ -39,7 +39,7 @@ EXPORT_SYMBOL(rtc_lock);
  * jump to the next second precisely 500 ms later. Check the Motorola
  * MC146818A or Dallas DS12887 data sheet for details.
  */
-int mach_set_rtc_mmss(const struct timespec *now)
+int mach_set_rtc_mmss(const struct timespec64 *now)
 {
 	unsigned long long nowtime = now->tv_sec;
 	struct rtc_time tm;
@@ -60,7 +60,7 @@ int mach_set_rtc_mmss(const struct timespec *now)
 	return retval;
 }
 
-void mach_get_cmos_time(struct timespec *now)
+void mach_get_cmos_time(struct timespec64 *now)
 {
 	unsigned int status, year, mon, day, hour, min, sec, century = 0;
 	unsigned long flags;
@@ -118,7 +118,7 @@ void mach_get_cmos_time(struct timespec *now)
 	} else
 		year += CMOS_YEARS_OFFS;
 
-	now->tv_sec = mktime(year, mon, day, hour, min, sec);
+	now->tv_sec = mktime64(year, mon, day, hour, min, sec);
 	now->tv_nsec = 0;
 }
 
@@ -145,13 +145,13 @@ void rtc_cmos_write(unsigned char val, unsigned char addr)
 }
 EXPORT_SYMBOL(rtc_cmos_write);
 
-int update_persistent_clock(struct timespec now)
+int update_persistent_clock64(struct timespec64 now)
 {
 	return x86_platform.set_wallclock(&now);
 }
 
 /* not static: needed by APM */
-void read_persistent_clock(struct timespec *ts)
+void read_persistent_clock64(struct timespec64 *ts)
 {
 	x86_platform.get_wallclock(ts);
 }
diff --git a/arch/x86/platform/intel-mid/intel_mid_vrtc.c b/arch/x86/platform/intel-mid/intel_mid_vrtc.c
index 58024862a7eb..a52914aa3b6c 100644
--- a/arch/x86/platform/intel-mid/intel_mid_vrtc.c
+++ b/arch/x86/platform/intel-mid/intel_mid_vrtc.c
@@ -57,7 +57,7 @@ void vrtc_cmos_write(unsigned char val, unsigned char reg)
 }
 EXPORT_SYMBOL_GPL(vrtc_cmos_write);
 
-void vrtc_get_time(struct timespec *now)
+void vrtc_get_time(struct timespec64 *now)
 {
 	u8 sec, min, hour, mday, mon;
 	unsigned long flags;
@@ -83,18 +83,18 @@ void vrtc_get_time(struct timespec *now)
 	pr_info("vRTC: sec: %d min: %d hour: %d day: %d "
 		"mon: %d year: %d\n", sec, min, hour, mday, mon, year);
 
-	now->tv_sec = mktime(year, mon, mday, hour, min, sec);
+	now->tv_sec = mktime64(year, mon, mday, hour, min, sec);
 	now->tv_nsec = 0;
 }
 
-int vrtc_set_mmss(const struct timespec *now)
+int vrtc_set_mmss(const struct timespec64 *now)
 {
 	unsigned long flags;
 	struct rtc_time tm;
 	int year;
 	int retval = 0;
 
-	rtc_time_to_tm(now->tv_sec, &tm);
+	rtc_time64_to_tm(now->tv_sec, &tm);
 	if (!rtc_valid_tm(&tm) && tm.tm_year >= 72) {
 		/*
 		 * tm.year is the number of years since 1900, and the
@@ -110,8 +110,8 @@ int vrtc_set_mmss(const struct timespec *now)
 		vrtc_cmos_write(tm.tm_sec, RTC_SECONDS);
 		spin_unlock_irqrestore(&rtc_lock, flags);
 	} else {
-		pr_err("%s: Invalid vRTC value: write of %lx to vRTC failed\n",
-			__func__, now->tv_sec);
+		pr_err("%s: Invalid vRTC value: write of %llx to vRTC failed\n",
+			__func__, (s64)now->tv_sec);
 		retval = -EINVAL;
 	}
 	return retval;
diff --git a/arch/x86/xen/time.c b/arch/x86/xen/time.c
index 29163c43ebbd..e0f1bcf01d63 100644
--- a/arch/x86/xen/time.c
+++ b/arch/x86/xen/time.c
@@ -57,7 +57,7 @@ static u64 xen_clocksource_get_cycles(struct clocksource *cs)
 	return xen_clocksource_read();
 }
 
-static void xen_read_wallclock(struct timespec *ts)
+static void xen_read_wallclock(struct timespec64 *ts)
 {
 	struct shared_info *s = HYPERVISOR_shared_info;
 	struct pvclock_wall_clock *wall_clock = &(s->wc);
@@ -68,12 +68,12 @@ static void xen_read_wallclock(struct timespec *ts)
 	put_cpu_var(xen_vcpu);
 }
 
-static void xen_get_wallclock(struct timespec *now)
+static void xen_get_wallclock(struct timespec64 *now)
 {
 	xen_read_wallclock(now);
 }
 
-static int xen_set_wallclock(const struct timespec *now)
+static int xen_set_wallclock(const struct timespec64 *now)
 {
 	return -ENODEV;
 }
@@ -461,7 +461,7 @@ static void __init xen_time_init(void)
 {
 	struct pvclock_vcpu_time_info *pvti;
 	int cpu = smp_processor_id();
-	struct timespec tp;
+	struct timespec64 tp;
 
 	/* As Dom0 is never moved, no penalty on using TSC there */
 	if (xen_initial_domain())
@@ -479,7 +479,7 @@ static void __init xen_time_init(void)
 
 	/* Set initial system time with full resolution */
 	xen_read_wallclock(&tp);
-	do_settimeofday(&tp);
+	do_settimeofday64(&tp);
 
 	setup_force_cpu_cap(X86_FEATURE_TSC);
 
-- 
2.9.0
