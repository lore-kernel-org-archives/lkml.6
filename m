Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0214DC28CF6
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:11:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 903DD20673
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 19:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 903DD20673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731082AbeGZU3T (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 16:29:19 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:36791 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730198AbeGZU3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 16:29:19 -0400
Received: by mail-qt0-f196.google.com with SMTP id t5-v6so2687836qtn.3;
        Thu, 26 Jul 2018 12:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yPTpeAVTtUUsv+mIDbT+E8mN6mcEAOfWteHaKPtSHz8=;
        b=PuzaBB1ckl/j9X29rV5U2tZB0CyYeLCS1AKhxe/f9W5g5gXNLNLXx289N+fTAhWXg5
         Rd/DecZhPCUya9gE5DiVUPEdbJ17c2GS0pUhN6ZVO5rIDE2cvr5oM2xKO0CxoD5dS1OU
         XrL38fpRZ2upnN4NsQsXLKGAQnok/FAbyHFeZVJQ77eAZnhWCoD7FDwJjUsziuwp+VDa
         5PoETMGrEVyzC5dfVc0aJDjD2O9zsOOPC5WjwB54Xe94LneEl4+hExBm9eTGIJlkmxG+
         e1LfGMsEzPu58wJTMMFQOdPf4BAPDDk8ZxLGhTs9GCVm7p8xGo7Qm5rCoLOx8LE4UYZS
         nNlQ==
X-Gm-Message-State: AOUpUlHQ4lSvwRknk823Y5EyX9kB9xJqqgeqsvALYYT2IivjNYs9tHQ+
        m3WNc+mALIhbLN7DomoX2PQrc+zSo67WQYnl6cCBZg==
X-Google-Smtp-Source: AAOMgpfc7Vhzm9iyDltue/NG3DKIPD9STEzQ47iiIQWAivDia5Jp625641OrUvsS4oelhoRP9J6toOfDIFUnIeULtHw=
X-Received: by 2002:a0c:b0cc:: with SMTP id p12-v6mr2881133qvc.42.1532632266554;
 Thu, 26 Jul 2018 12:11:06 -0700 (PDT)
MIME-Version: 1.0
References: <20180718222656.11795-1-calvin.walton@kepstin.ca> <20180718222656.11795-3-calvin.walton@kepstin.ca>
In-Reply-To: <20180718222656.11795-3-calvin.walton@kepstin.ca>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 26 Jul 2018 15:10:55 -0400
Message-ID: <CAJvTdKnnaGrj3PSMd00B2GVAYk-KQ07aV72mbzPSTZRbXSsdng@mail.gmail.com>
Subject: Re: [PATCH 2/2] turbostat: Add support for AMD Fam 17h (Zen) RAPL
To:     calvin.walton@kepstin.ca
Cc:     Linux PM list <linux-pm@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Brown, Len" <len.brown@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Calvin,
I'll assume you are waiting for this to be tested by somebody who has
the HW (sorry, I don't have AMD HW to test this)
and will re-send a checkpatch.pl clean version when you have that result.

thanks,
-Len

On Wed, Jul 18, 2018 at 6:27 PM Calvin Walton <calvin.walton@kepstin.ca> wrote:
>
> Based on the Open-Source Register Reference for AMD Family 17h
> Processors Models 00h-2Fh:
> https://support.amd.com/TechDocs/56255_OSRR.pdf
>
> These processors report RAPL support in bit 14 of CPUID 0x80000007 EDX,
> and the following MSRs are present:
> 0xc0010299 (RAPL_PWR_UNIT), like Intel's RAPL_POWER_UNIT
> 0xc001029a (CORE_ENERGY_STAT), kind of like Intel's PP0_ENERGY_STATUS
> 0xc001029b (PKG_ENERGY_STAT), like Intel's PKG_ENERGY_STATUS
>
> A notable difference from the Intel implementation is that AMD reports
> the "Cores" energy usage separately for each core, rather than a
> per-package total. The code has been adjusted to handle either case in a
> generic way.
> ---
>  tools/power/x86/turbostat/turbostat.c | 171 ++++++++++++++++++++++----
>  1 file changed, 145 insertions(+), 26 deletions(-)
>
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index f404d67fda92..1ab351512044 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -43,6 +43,7 @@
>  #include <cpuid.h>
>  #include <linux/capability.h>
>  #include <errno.h>
> +#include <math.h>
>
>  char *proc_stat = "/proc/stat";
>  FILE *outf;
> @@ -64,6 +65,7 @@ unsigned int has_epb;
>  unsigned int do_irtl_snb;
>  unsigned int do_irtl_hsw;
>  unsigned int units = 1000000;  /* MHz etc */
> +unsigned int authentic_amd;
>  unsigned int genuine_intel;
>  unsigned int has_invariant_tsc;
>  unsigned int do_nhm_platform_info;
> @@ -129,9 +131,21 @@ unsigned int has_misc_feature_control;
>
>  #define RAPL_CORES_ENERGY_STATUS       (1 << 9)
>                                         /* 0x639 MSR_PP0_ENERGY_STATUS */
> +#define RAPL_PER_CORE_ENERGY   (1 << 10)
> +                                       /* Indicates cores energy collection is per-core,
> +                                        * not per-package. */
> +#define RAPL_AMD_F17H          (1 << 11)
> +                                       /* 0xc0010299 MSR_RAPL_PWR_UNIT */
> +                                       /* 0xc001029a MSR_CORE_ENERGY_STAT */
> +                                       /* 0xc001029b MSR_PKG_ENERGY_STAT */
>  #define RAPL_CORES (RAPL_CORES_ENERGY_STATUS | RAPL_CORES_POWER_LIMIT)
>  #define        TJMAX_DEFAULT   100
>
> +/* MSRs that are not yet in the kernel-provided header. */
> +#define MSR_RAPL_PWR_UNIT      0xc0010299
> +#define MSR_CORE_ENERGY_STAT   0xc001029a
> +#define MSR_PKG_ENERGY_STAT    0xc001029b
> +
>  #define MAX(a, b) ((a) > (b) ? (a) : (b))
>
>  /*
> @@ -171,6 +185,7 @@ struct core_data {
>         unsigned long long c7;
>         unsigned long long mc6_us;      /* duplicate as per-core for now, even though per module */
>         unsigned int core_temp_c;
> +       unsigned int core_energy;       /* MSR_CORE_ENERGY_STAT */
>         unsigned int core_id;
>         unsigned long long counter[MAX_ADDED_COUNTERS];
>  } *core_even, *core_odd;
> @@ -589,6 +604,14 @@ void print_header(char *delim)
>         if (DO_BIC(BIC_CoreTmp))
>                 outp += sprintf(outp, "%sCoreTmp", (printed++ ? delim : ""));
>
> +       if (do_rapl && !rapl_joules) {
> +               if (DO_BIC(BIC_CorWatt) && (do_rapl & RAPL_PER_CORE_ENERGY))
> +                       outp += sprintf(outp, "%sCorWatt", (printed++ ? delim : ""));
> +       } else if (do_rapl && rapl_joules) {
> +               if (DO_BIC(BIC_Cor_J) && (do_rapl & RAPL_PER_CORE_ENERGY))
> +                       outp += sprintf(outp, "%sCor_J", (printed++ ? delim : ""));
> +       }
> +
>         for (mp = sys.cp; mp; mp = mp->next) {
>                 if (mp->format == FORMAT_RAW) {
>                         if (mp->width == 64)
> @@ -639,7 +662,7 @@ void print_header(char *delim)
>         if (do_rapl && !rapl_joules) {
>                 if (DO_BIC(BIC_PkgWatt))
>                         outp += sprintf(outp, "%sPkgWatt", (printed++ ? delim : ""));
> -               if (DO_BIC(BIC_CorWatt))
> +               if (DO_BIC(BIC_CorWatt) && !(do_rapl & RAPL_PER_CORE_ENERGY))
>                         outp += sprintf(outp, "%sCorWatt", (printed++ ? delim : ""));
>                 if (DO_BIC(BIC_GFXWatt))
>                         outp += sprintf(outp, "%sGFXWatt", (printed++ ? delim : ""));
> @@ -652,7 +675,7 @@ void print_header(char *delim)
>         } else if (do_rapl && rapl_joules) {
>                 if (DO_BIC(BIC_Pkg_J))
>                         outp += sprintf(outp, "%sPkg_J", (printed++ ? delim : ""));
> -               if (DO_BIC(BIC_Cor_J))
> +               if (DO_BIC(BIC_Cor_J) && !(do_rapl & RAPL_PER_CORE_ENERGY))
>                         outp += sprintf(outp, "%sCor_J", (printed++ ? delim : ""));
>                 if (DO_BIC(BIC_GFX_J))
>                         outp += sprintf(outp, "%sGFX_J", (printed++ ? delim : ""));
> @@ -713,6 +736,7 @@ int dump_counters(struct thread_data *t, struct core_data *c,
>                 outp += sprintf(outp, "c6: %016llX\n", c->c6);
>                 outp += sprintf(outp, "c7: %016llX\n", c->c7);
>                 outp += sprintf(outp, "DTS: %dC\n", c->core_temp_c);
> +               outp += sprintf(outp, "Joules: %0X\n", c->core_energy);
>
>                 for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
>                         outp += sprintf(outp, "cADDED [%d] msr0x%x: %08llX\n",
> @@ -912,6 +936,20 @@ int format_counters(struct thread_data *t, struct core_data *c,
>                 }
>         }
>
> +       /*
> +        * If measurement interval exceeds minimum RAPL Joule Counter range,
> +        * indicate that results are suspect by printing "**" in fraction place.
> +        */
> +       if (interval_float < rapl_joule_counter_range)
> +               fmt8 = "%s%.2f";
> +       else
> +               fmt8 = "%6.0f**";
> +
> +       if (DO_BIC(BIC_CorWatt) && (do_rapl & RAPL_PER_CORE_ENERGY))
> +               outp += sprintf(outp, fmt8, (printed++ ? delim : ""), c->core_energy * rapl_energy_units / interval_float);
> +       if (DO_BIC(BIC_Cor_J) && (do_rapl & RAPL_PER_CORE_ENERGY))
> +               outp += sprintf(outp, fmt8, (printed++ ? delim : ""), c->core_energy * rapl_energy_units);
> +
>         /* print per-package data only for 1st core in package */
>         if (!(t->flags & CPU_IS_FIRST_CORE_IN_PACKAGE))
>                 goto done;
> @@ -959,18 +997,9 @@ int format_counters(struct thread_data *t, struct core_data *c,
>         if (DO_BIC(BIC_Pkgpc10))
>                 outp += sprintf(outp, "%s%.2f", (printed++ ? delim : ""), 100.0 * p->pc10/tsc);
>
> -       /*
> -        * If measurement interval exceeds minimum RAPL Joule Counter range,
> -        * indicate that results are suspect by printing "**" in fraction place.
> -        */
> -       if (interval_float < rapl_joule_counter_range)
> -               fmt8 = "%s%.2f";
> -       else
> -               fmt8 = "%6.0f**";
> -
>         if (DO_BIC(BIC_PkgWatt))
>                 outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units / interval_float);
> -       if (DO_BIC(BIC_CorWatt))
> +       if (DO_BIC(BIC_CorWatt) && !(do_rapl & RAPL_PER_CORE_ENERGY))
>                 outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units / interval_float);
>         if (DO_BIC(BIC_GFXWatt))
>                 outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_gfx * rapl_energy_units / interval_float);
> @@ -978,7 +1007,7 @@ int format_counters(struct thread_data *t, struct core_data *c,
>                 outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_dram * rapl_dram_energy_units / interval_float);
>         if (DO_BIC(BIC_Pkg_J))
>                 outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_pkg * rapl_energy_units);
> -       if (DO_BIC(BIC_Cor_J))
> +       if (DO_BIC(BIC_Cor_J) && !(do_rapl & RAPL_PER_CORE_ENERGY))
>                 outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_cores * rapl_energy_units);
>         if (DO_BIC(BIC_GFX_J))
>                 outp += sprintf(outp, fmt8, (printed++ ? delim : ""), p->energy_gfx * rapl_energy_units);
> @@ -1122,6 +1151,8 @@ delta_core(struct core_data *new, struct core_data *old)
>         old->core_temp_c = new->core_temp_c;
>         old->mc6_us = new->mc6_us - old->mc6_us;
>
> +       DELTA_WRAP32(new->core_energy, old->core_energy);
> +
>         for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
>                 if (mp->format == FORMAT_RAW)
>                         old->counter[i] = new->counter[i];
> @@ -1244,6 +1275,7 @@ void clear_counters(struct thread_data *t, struct core_data *c, struct pkg_data
>         c->c7 = 0;
>         c->mc6_us = 0;
>         c->core_temp_c = 0;
> +       c->core_energy = 0;
>
>         p->pkg_wtd_core_c0 = 0;
>         p->pkg_any_core_c0 = 0;
> @@ -1311,6 +1343,8 @@ int sum_counters(struct thread_data *t, struct core_data *c,
>
>         average.cores.core_temp_c = MAX(average.cores.core_temp_c, c->core_temp_c);
>
> +       average.cores.core_energy += c->core_energy;
> +
>         for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
>                 if (mp->format == FORMAT_RAW)
>                         continue;
> @@ -1630,6 +1664,12 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
>                 c->core_temp_c = tcc_activation_temp - ((msr >> 16) & 0x7F);
>         }
>
> +       if (do_rapl & RAPL_AMD_F17H) {
> +               if (get_msr(cpu, MSR_CORE_ENERGY_STAT, &msr))
> +                       return -14;
> +               c->core_energy = msr & 0xFFFFFFFF;
> +       }
> +
>         for (i = 0, mp = sys.cp; mp; i++, mp = mp->next) {
>                 if (get_mp(cpu, mp, &c->counter[i]))
>                         return -10;
> @@ -1714,6 +1754,11 @@ int get_counters(struct thread_data *t, struct core_data *c, struct pkg_data *p)
>                         return -16;
>                 p->rapl_dram_perf_status = msr & 0xFFFFFFFF;
>         }
> +       if (do_rapl & RAPL_AMD_F17H) {
> +               if (get_msr(cpu, MSR_PKG_ENERGY_STAT, &msr))
> +                       return -13;
> +               p->energy_pkg = msr & 0xFFFFFFFF;
> +       }
>         if (DO_BIC(BIC_PkgTmp)) {
>                 if (get_msr(cpu, MSR_IA32_PACKAGE_THERM_STATUS, &msr))
>                         return -17;
> @@ -3329,6 +3374,16 @@ double get_tdp(unsigned int model)
>         }
>  }
>
> +double get_tdp_amd(unsigned int family)
> +{
> +       switch (family) {
> +       case 0x17:
> +       default:
> +               /* This is the max stock TDP of HEDT/Server Fam17h chips */
> +               return 180.0;
> +       }
> +}
> +
>  /*
>   * rapl_dram_energy_units_probe()
>   * Energy units are either hard-coded, or come from RAPL Energy Unit MSR.
> @@ -3350,21 +3405,12 @@ rapl_dram_energy_units_probe(int  model, double rapl_energy_units)
>         }
>  }
>
> -
> -/*
> - * rapl_probe()
> - *
> - * sets do_rapl, rapl_power_units, rapl_energy_units, rapl_time_units
> - */
> -void rapl_probe(unsigned int family, unsigned int model)
> +void rapl_probe_intel(unsigned int family, unsigned int model)
>  {
>         unsigned long long msr;
>         unsigned int time_unit;
>         double tdp;
>
> -       if (!genuine_intel)
> -               return;
> -
>         if (family != 6)
>                 return;
>
> @@ -3502,6 +3548,69 @@ void rapl_probe(unsigned int family, unsigned int model)
>         return;
>  }
>
> +void rapl_probe_amd(unsigned int family, unsigned int model)
> +{
> +       unsigned long long msr;
> +       unsigned int max_extended_level, eax, ebx, ecx, edx;
> +       unsigned int has_rapl = 0;
> +       double tdp;
> +
> +       max_extended_level = ebx = ecx = edx = 0;
> +       __cpuid(0x80000000, max_extended_level, ebx, ecx, edx);
> +
> +       if (max_extended_level >= 0x80000007) {
> +               __cpuid(0x80000007, eax, ebx, ecx, edx);
> +               /* RAPL (Fam 17h) */
> +               has_rapl = edx & (1 << 14);
> +       }
> +
> +       if (!has_rapl)
> +               return;
> +
> +       switch (family) {
> +       case 0x17: /* Zen, Zen+ */
> +               do_rapl = RAPL_AMD_F17H | RAPL_PER_CORE_ENERGY;
> +               if (rapl_joules) {
> +                       BIC_PRESENT(BIC_Pkg_J);
> +                       BIC_PRESENT(BIC_Cor_J);
> +               } else {
> +                       BIC_PRESENT(BIC_PkgWatt);
> +                       BIC_PRESENT(BIC_CorWatt);
> +               }
> +               break;
> +       default:
> +               return;
> +       }
> +
> +       if (get_msr(base_cpu, MSR_RAPL_PWR_UNIT, &msr))
> +               return;
> +
> +       rapl_time_units = ldexp(1.0, -(msr >> 16 & 0xf));
> +       rapl_energy_units = ldexp(1.0, -(msr >> 8 & 0x1f));
> +       rapl_power_units = ldexp(1.0, -(msr & 0xf));
> +
> +       tdp = get_tdp_amd(model);
> +
> +       rapl_joule_counter_range = 0xFFFFFFFF * rapl_energy_units / tdp;
> +       if (!quiet)
> +               fprintf(outf, "RAPL: %.0f sec. Joule Counter Range, at %.0f Watts\n", rapl_joule_counter_range, tdp);
> +
> +       return;
> +}
> +
> +/*
> + * rapl_probe()
> + *
> + * sets do_rapl, rapl_power_units, rapl_energy_units, rapl_time_units
> + */
> +void rapl_probe(unsigned int family, unsigned int model)
> +{
> +       if (genuine_intel)
> +               rapl_probe_intel(family, model);
> +       if (authentic_amd)
> +               rapl_probe_amd(family, model);
> +}
> +
>  void perf_limit_reasons_probe(unsigned int family, unsigned int model)
>  {
>         if (!genuine_intel)
> @@ -3599,6 +3708,7 @@ void print_power_limit_msr(int cpu, unsigned long long msr, char *label)
>  int print_rapl(struct thread_data *t, struct core_data *c, struct pkg_data *p)
>  {
>         unsigned long long msr;
> +       const char *msr_name;
>         int cpu;
>
>         if (!do_rapl)
> @@ -3614,10 +3724,17 @@ int print_rapl(struct thread_data *t, struct core_data *c, struct pkg_data *p)
>                 return -1;
>         }
>
> -       if (get_msr(cpu, MSR_RAPL_POWER_UNIT, &msr))
> -               return -1;
> +       if (do_rapl & RAPL_AMD_F17H) {
> +               msr_name = "MSR_RAPL_PWR_UNIT";
> +               if (get_msr(cpu, MSR_RAPL_PWR_UNIT, &msr))
> +                       return -1;
> +       } else {
> +               msr_name = "MSR_RAPL_POWER_UNIT";
> +               if (get_msr(cpu, MSR_RAPL_POWER_UNIT, &msr))
> +                       return -1;
> +       }
>
> -       fprintf(outf, "cpu%d: MSR_RAPL_POWER_UNIT: 0x%08llx (%f Watts, %f Joules, %f sec.)\n", cpu, msr,
> +       fprintf(outf, "cpu%d: %s: 0x%08llx (%f Watts, %f Joules, %f sec.)\n", cpu, msr_name, msr,
>                 rapl_power_units, rapl_energy_units, rapl_time_units);
>
>         if (do_rapl & RAPL_PKG_POWER_INFO) {
> @@ -4022,6 +4139,8 @@ void process_cpuid()
>
>         if (ebx == 0x756e6547 && edx == 0x49656e69 && ecx == 0x6c65746e)
>                 genuine_intel = 1;
> +       if (ebx == 0x68747541 && edx == 0x69746e65 && ecx == 0x444d4163)
> +               authentic_amd = 1;
>
>         if (!quiet)
>                 fprintf(outf, "CPUID(0): %.4s%.4s%.4s ",
> --
> 2.18.0
>


-- 
Len Brown, Intel Open Source Technology Center
