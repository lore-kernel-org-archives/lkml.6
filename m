Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AE4C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A00021A28
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:35:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kepstin.ca header.i=@kepstin.ca header.b="nPaz6fyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A00021A28
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kepstin.ca
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeHQTjH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:39:07 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36766 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727804AbeHQTjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:39:05 -0400
Received: by mail-it0-f65.google.com with SMTP id p81-v6so12522220itp.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Aug 2018 09:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kepstin.ca; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nvUh0UDB9l+yHlWfA39LQUjHQrfWLjEkEyq8WfNmIik=;
        b=nPaz6fyC2kIfmdj6cnYTB134nhdstzacyfRB/ZuTUahbXSnjT+ATkrmnosZP+hhbLQ
         SNr+PcqlNIXxqKBK6mCFMTGLQfjCs/JybBRoRZlT3hpAsn6RstMuq4Vjq3Pd3ioVuU6F
         7uQrStZbroHbCGryCXNw62kBEDNGdQL3jGKII=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=nvUh0UDB9l+yHlWfA39LQUjHQrfWLjEkEyq8WfNmIik=;
        b=Xcbt5Sqspiq92SsznuGl1Hn4nu+9JSRnTE80324KzPFs9708gmwUhH4ofzFFe69u8V
         8S6C6mQfSJ/Gq90KDWx/O9akaigRdDJ1ZdwCb148icEyeVPz+Ofg+mzod38zVBOdXHhA
         LAA+oRPTls1iTD6j5Fo+LPkMwg/A8yMcN+JgZ34fi1fsks10avnbDtzIIR1F+KngsBlM
         KDG5j4ihawzVmosh9KdYXU4AvIPuRscrw3JAt9ddmj6f8IJptUlU8gdHhfedU0th+c39
         GnhN9+KqoobNNJxOJH/lOSxMh0Pk3aQLW1YT/MnLp8MbHmZ25gWaNAHXD5DTEXm1i/uZ
         Rovw==
X-Gm-Message-State: AOUpUlHg9i/+DHym+riZ7wXphMmFJoQ/BsylZwKLoGsZQ2i/kv4n9PUe
        16Wxc+/HGg9v7GE+xuKo9Lw5sg==
X-Google-Smtp-Source: AA+uWPyKJYe8dx5crE4iE8DVRH5Y/ltERl+TqUmaipFVLYOfXO+zPVlkaAEBQcn6NlGJIFAOAyXo6A==
X-Received: by 2002:a24:6e95:: with SMTP id w143-v6mr4683115itc.34.1534523702123;
        Fri, 17 Aug 2018 09:35:02 -0700 (PDT)
Received: from fuko.kepstin.ca ([2001:470:b3f4::561])
        by smtp.gmail.com with ESMTPSA id e140-v6sm1947974itc.24.2018.08.17.09.35.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Aug 2018 09:35:01 -0700 (PDT)
From:   Calvin Walton <calvin.walton@kepstin.ca>
To:     Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Calvin Walton <calvin.walton@kepstin.ca>
Subject: [PATCH v3 1/2] tools/power turbostat: Add support for AMD Fam 17h (Zen) RAPL
Date:   Fri, 17 Aug 2018 12:34:41 -0400
Message-Id: <20180817163442.10065-2-calvin.walton@kepstin.ca>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180817163442.10065-1-calvin.walton@kepstin.ca>
References: <20180817163442.10065-1-calvin.walton@kepstin.ca>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on the Open-Source Register Reference for AMD Family 17h
Processors Models 00h-2Fh:
https://support.amd.com/TechDocs/56255_OSRR.pdf

These processors report RAPL support in bit 14 of CPUID 0x80000007 EDX,
and the following MSRs are present:
0xc0010299 (RAPL_PWR_UNIT), like Intel's RAPL_POWER_UNIT
0xc001029a (CORE_ENERGY_STAT), kind of like Intel's PP0_ENERGY_STATUS
0xc001029b (PKG_ENERGY_STAT), like Intel's PKG_ENERGY_STATUS

A notable difference from the Intel implementation is that AMD reports
the "Cores" energy usage separately for each core, rather than a
per-package total. The code has been adjusted to handle either case in a
generic way.

I haven't yet enabled collection of package power, due to being unable
to test it on multi-node systems (TR, EPYC).

Signed-off-by: Calvin Walton <calvin.walton@kepstin.ca>
---
 tools/power/x86/turbostat/turbostat.c | 159 +++++++++++++++++++++-----
 1 file changed, 130 insertions(+), 29 deletions(-)

diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
index 6837a65409ba..89d4e2e75774 100644
--- a/tools/power/x86/turbostat/turbostat.c
+++ b/tools/power/x86/turbostat/turbostat.c
@@ -44,6 +44,7 @@
 #include <cpuid.h>
 #include <linux/capability.h>
 #include <errno.h>
+#include <math.h>
 
 char *proc_stat = "/proc/stat";
 FILE *outf;
@@ -141,9 +142,21 @@ unsigned int first_counter_read = 1;
 
 #define RAPL_CORES_ENERGY_STATUS	(1 << 9)
 					/* 0x639 MSR_PP0_ENERGY_STATUS */
+#define RAPL_PER_CORE_ENERGY	(1 << 10)
+					/* Indicates cores energy collection is per-core,
+					 * not per-package. */
+#define RAPL_AMD_F17H		(1 << 11)
+					/* 0xc0010299 MSR_RAPL_PWR_UNIT */
+					/* 0xc001029a MSR_CORE_ENERGY_STAT */
+					/* 0xc001029b MSR_PKG_ENERGY_STAT */
 #define RAPL_CORES (RAPL_CORES_ENERGY_STATUS | RAPL_CORES_POWER_LIMIT)
 #define	TJMAX_DEFAULT	100
 
+/* MSRs that are not yet in the kernel-provided header. */
+#define MSR_RAPL_PWR_UNIT	0xc0010299
+#define MSR_CORE_ENERGY_STAT	0xc001029a
+#define MSR_PKG_ENERGY_STAT	0xc001029b
+
 #define MAX(a, b) ((a) > (b) ? (a) : (b))
 
 /*
@@ -187,6 +200,7 @@ struct core_data {
 	unsigned long long c7;
 	unsigned long long mc6_us;	/* duplicate as per-core for now, even though per module */
 	unsigned int core_temp_c;
+	unsigned int core_energy;	/* MSR_CORE_ENERGY_STAT */
 	unsigned int core_id;
 	unsigned long long counter[MAX_ADDED_COUNTERS];
 } *core_even, *core_odd;
@@ -680,6 +694,14 @@ void print_header(char *delim)
 	if (DO_BIC(BIC_CoreTmp))
 		outp += sprintf(outp, "%sCoreTmp", (printed++ ? delim : ""));
 
+	if (do_rapl && !rapl_joules) {
+		if (DO_BIC(BIC_CorWatt) && (do_rapl & RAPL_PER_CORE_ENERGY))
+			outp += sprintf(outp, "%sCorWatt", (printed++ ? delim : ""));
+	} else if (do_rapl && rapl_joules) {
+		if (DO_BIC(BIC_Cor_J) && (do_rapl & RAPL_PER_CORE_ENERGY))
+			outp += sprintf(outp, "%sCor_J", (printed++ ? delim : ""));
+	}
+
 	for (mp = sys.cp; mp; mp = mp->next) {
 		if (mp->format == FORMAT_RAW) {
 			if (mp->width == 64)
@@ -734,7 +756,7 @@ void print_header(char *delim)
 	if (do_rapl && !rapl_joules) {
 		if (DO_BIC(BIC_PkgWatt))
 			outp += sprintf(outp, "%sPkgWatt", (printed++ ? delim : ""));
-		if (DO_BIC(BIC_CorWatt))
+		if (DO_BIC(BIC_CorWatt) && !(do_rapl & RAPL_PER_CORE_ENERGY))
 			outp += sprintf(outp, "%sCorWatt", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_GFXWatt))
 			outp += sprintf(outp, "%sGFXWatt", (printed++ ? delim : ""));
@@ -747,7 +769,7 @@ void print_header(char *delim)
 	} else if (do_rapl && rapl_joules) {
 		if (DO_BIC(BIC_Pkg_J))
 			outp += sprintf(outp, "%sPkg_J", (printed++ ? delim : ""));
-		if (DO_BIC(BIC_Cor_J))
+		if (DO_BIC(BIC_Cor_J) && !(do_rapl & RAPL_PER_CORE_ENERGY))
 			outp += sprintf(outp, "%sCor_J", (printed++ ? delim : ""));
 		if (DO_BIC(BIC_GFX_J))
 			outp += sprintf(outp, "%sGFX_J", (printed++ ? delim : ""));
@@ -808,6 +830,7 @@ int dump_counters(struct thread_data *t, struct core_data *c,
 		outp += sprintf(outp, "c6: %016llX\n", c->c6);
 		outp += sprintf(outp, "c7: %016llX\n", c->c7);
 		outp += sprintf(outp, "DTS: %dC\n", c->core_temp_c);
+		outp += sprintf(outp, "Joules: %0X\n", c->core_energy);
 
 		for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 			outp += sprintf(outp, "cADDED [%d] msr0x%x: %08llX\n",
@@ -1033,6 +1056,20 @@ int format_counters(struct thread_data *t, struct core_data *c,
 		}
 	}
 
+	/*
+	 * If measurement interval exceeds minimum RAPL Joule Counter range,
+	 * indicate that results are suspect by printing "**" in fraction place.
+	 */
+	if (interval_float < rapl_joule_counter_range)
+		fmt8 = "%s%.2f";
+	else
+		fmt8 = "%6.0f**";
+
+	if (DO_BIC(BIC_CorWatt) && (do_rapl & RAPL_PER_CORE_ENERGY))
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), c->core_energy * rapl_energy_units / interval_float);
+	if (DO_BIC(BIC_Cor_J) && (do_rapl & RAPL_PER_CORE_ENERGY))
+		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), c->core_energy * rapl_energy_units);
+
 	/* print per-package data only for 1st core in package */
 	if (!(t->flags & CPU_IS_FIRST_CORE_IN_PACKAGE))
 		goto done;
@@ -1085,18 +1122,9 @@ int format_counters(struct thread_data *t, struct core_data *c,
 	if (DO_BIC(BIC_SYS_LPI))
 		outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->sys_lpi / 1000000.0 / interval_float);
 
-	/*
- 	 * If measurement interval exceeds minimum RAPL Joule Counter range,
- 	 * indicate that results are suspect by printing "**" in fraction place.
- 	 */
-	if (interval_float < rapl_joule_counter_range)
-		fmt8 = "%s%.2f";
-	else
-		fmt8 = "%6.0f**";
-
 	if (DO_BIC(BIC_PkgWatt))
 		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units / interval_float);
-	if (DO_BIC(BIC_CorWatt))
+	if (DO_BIC(BIC_CorWatt) && !(do_rapl & RAPL_PER_CORE_ENERGY))
 		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units / interval_float);
 	if (DO_BIC(BIC_GFXWatt))
 		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_gfx * rapl_energy_units / interval_float);
@@ -1104,7 +1132,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
 		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_dram * rapl_dram_energy_units / interval_float);
 	if (DO_BIC(BIC_Pkg_J))
 		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units);
-	if (DO_BIC(BIC_Cor_J))
+	if (DO_BIC(BIC_Cor_J) && !(do_rapl & RAPL_PER_CORE_ENERGY))
 		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units);
 	if (DO_BIC(BIC_GFX_J))
 		outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_gfx * rapl_energy_units);
@@ -1249,6 +1277,8 @@ delta_core(struct core_data *new, struct core_data *old)
 	old->core_temp_c = new->core_temp_c;
 	old->mc6_us = new->mc6_us - old->mc6_us;
 
+	DELTA_WRAP32(new->core_energy, old->core_energy);
+
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
 			old->counter[i] = new->counter[i];
@@ -1391,6 +1421,7 @@ void clear_counters(struct thread_data *t, struct core_data *c, struct pkg_data
 	c->c7 = 0;
 	c->mc6_us = 0;
 	c->core_temp_c = 0;
+	c->core_energy = 0;
 
 	p->pkg_wtd_core_c0 = 0;
 	p->pkg_any_core_c0 = 0;
@@ -1473,6 +1504,8 @@ int sum_counters(struct thread_data *t, struct core_data *c,
 
 	average.cores.core_temp_c = MAX(average.cores.core_temp_c, c->core_temp_c);
 
+	average.cores.core_energy += c->core_energy;
+
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 		if (mp->format == FORMAT_RAW)
 			continue;
@@ -1845,6 +1878,12 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		c->core_temp_c = tcc_activation_temp - ((msr >> 16) & 0x7F);
 	}
 
+	if (do_rapl & RAPL_AMD_F17H) {
+		if (get_msr(cpu, MSR_CORE_ENERGY_STAT, &msr))
+			return -14;
+		c->core_energy = msr & 0xFFFFFFFF;
+	}
+
 	for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
 		if (get_mp(cpu, mp, &c->counter[i]))
 			return -10;
@@ -3738,7 +3777,7 @@ int print_perf_limit(struct thread_data *t, struct core_data *c, struct pkg_data
 #define	RAPL_POWER_GRANULARITY	0x7FFF	/* 15 bit power granularity */
 #define	RAPL_TIME_GRANULARITY	0x3F /* 6 bit time granularity */
 
-double get_tdp(unsigned int model)
+double get_tdp_intel(unsigned int model)
 {
 	unsigned long long msr;
 
@@ -3755,6 +3794,16 @@ double get_tdp(unsigned int model)
 	}
 }
 
+double get_tdp_amd(unsigned int family)
+{
+	switch (family) {
+	case 0x17:
+	default:
+		/* This is the max stock TDP of HEDT/Server Fam17h chips */
+		return 250.0;
+	}
+}
+
 /*
  * rapl_dram_energy_units_probe()
  * Energy units are either hard-coded, or come from RAPL Energy Unit MSR.
@@ -3776,21 +3825,12 @@ rapl_dram_energy_units_probe(int  model, double rapl_energy_units)
 	}
 }
 
-
-/*
- * rapl_probe()
- *
- * sets do_rapl, rapl_power_units, rapl_energy_units, rapl_time_units
- */
-void rapl_probe(unsigned int family, unsigned int model)
+void rapl_probe_intel(unsigned int family, unsigned int model)
 {
 	unsigned long long msr;
 	unsigned int time_unit;
 	double tdp;
 
-	if (!genuine_intel)
-		return;
-
 	if (family != 6)
 		return;
 
@@ -3920,13 +3960,66 @@ void rapl_probe(unsigned int family, unsigned int model)
 
 	rapl_time_units = 1.0 / (1 << (time_unit));
 
-	tdp = get_tdp(model);
+	tdp = get_tdp_intel(model);
+
+	rapl_joule_counter_range = 0xFFFFFFFF * rapl_energy_units / tdp;
+	if (!quiet)
+		fprintf(outf, "RAPL: %.0f sec. Joule Counter Range, at %.0f Watts\n", rapl_joule_counter_range, tdp);
+}
+
+void rapl_probe_amd(unsigned int family, unsigned int model)
+{
+	unsigned long long msr;
+	unsigned int eax, ebx, ecx, edx;
+	unsigned int has_rapl = 0;
+	double tdp;
+
+	if (max_extended_level >= 0x80000007) {
+		__cpuid(0x80000007, eax, ebx, ecx, edx);
+		/* RAPL (Fam 17h) */
+		has_rapl = edx & (1 << 14);
+	}
+
+	if (!has_rapl)
+		return;
+
+	switch (family) {
+	case 0x17: /* Zen, Zen+ */
+		do_rapl = RAPL_AMD_F17H | RAPL_PER_CORE_ENERGY;
+		if (rapl_joules)
+			BIC_PRESENT(BIC_Cor_J);
+		else
+			BIC_PRESENT(BIC_CorWatt);
+		break;
+	default:
+		return;
+	}
+
+	if (get_msr(base_cpu, MSR_RAPL_PWR_UNIT, &msr))
+		return;
+
+	rapl_time_units = ldexp(1.0, -(msr >> 16 & 0xf));
+	rapl_energy_units = ldexp(1.0, -(msr >> 8 & 0x1f));
+	rapl_power_units = ldexp(1.0, -(msr & 0xf));
+
+	tdp = get_tdp_amd(model);
 
 	rapl_joule_counter_range = 0xFFFFFFFF * rapl_energy_units / tdp;
 	if (!quiet)
 		fprintf(outf, "RAPL: %.0f sec. Joule Counter Range, at %.0f Watts\n", rapl_joule_counter_range, tdp);
+}
 
-	return;
+/*
+ * rapl_probe()
+ *
+ * sets do_rapl, rapl_power_units, rapl_energy_units, rapl_time_units
+ */
+void rapl_probe(unsigned int family, unsigned int model)
+{
+	if (genuine_intel)
+		rapl_probe_intel(family, model);
+	if (authentic_amd)
+		rapl_probe_amd(family, model);
 }
 
 void perf_limit_reasons_probe(unsigned int family, unsigned int model)
@@ -4032,6 +4125,7 @@ void print_power_limit_msr(int cpu, unsigned long long msr, char *label)
 int print_rapl(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 {
 	unsigned long long msr;
+	const char *msr_name;
 	int cpu;
 
 	if (!do_rapl)
@@ -4047,10 +4141,17 @@ int print_rapl(struct thread_data *t, struct core_data *c, struct pkg_data *p)
 		return -1;
 	}
 
-	if (get_msr(cpu, MSR_RAPL_POWER_UNIT, &msr))
-		return -1;
+	if (do_rapl & RAPL_AMD_F17H) {
+		msr_name = "MSR_RAPL_PWR_UNIT";
+		if (get_msr(cpu, MSR_RAPL_PWR_UNIT, &msr))
+			return -1;
+	} else {
+		msr_name = "MSR_RAPL_POWER_UNIT";
+		if (get_msr(cpu, MSR_RAPL_POWER_UNIT, &msr))
+			return -1;
+	}
 
-	fprintf(outf, "cpu%d: MSR_RAPL_POWER_UNIT: 0x%08llx (%f Watts, %f Joules, %f sec.)\n", cpu, msr,
+	fprintf(outf, "cpu%d: %s: 0x%08llx (%f Watts, %f Joules, %f sec.)\n", cpu, msr_name, msr,
 		rapl_power_units, rapl_energy_units, rapl_time_units);
 
 	if (do_rapl & RAPL_PKG_POWER_INFO) {
-- 
2.18.0

