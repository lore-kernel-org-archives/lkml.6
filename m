Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JePnL6Fj"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B077606DD
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933718AbeFFRZa (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 13:25:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:53100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933527AbeFFRZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 13:25:29 -0400
X-Google-Smtp-Source: ADUXVKIU3jqyuOLjpcyRwZAXCA+g8R17F80ju8rlFhyX93C8eK6shOMea6qPDTH6UUrTIPg6iUKNWjMRr35ixda6bSo=
MIME-Version: 1.0
References: <1528302199-29619-1-git-send-email-chang.seok.bae@intel.com> <1528302199-29619-9-git-send-email-chang.seok.bae@intel.com>
In-Reply-To: <1528302199-29619-9-git-send-email-chang.seok.bae@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Wed, 6 Jun 2018 10:25:15 -0700
X-Gmail-Original-Message-ID: <CALCETrVkFvC4R6dfrUL5B9iN1v3X6hE3QNHBrAHjPBrA9S7FWg@mail.gmail.com>
Message-ID: <CALCETrVkFvC4R6dfrUL5B9iN1v3X6hE3QNHBrAHjPBrA9S7FWg@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] x86/vdso: Move out the CPU number store
To: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc: Andrew Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 6, 2018 at 9:23 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> The CPU (and node) number will be written, as early enough,
> to the segment limit of per CPU data and TSC_AUX MSR entry.
> The information has been retrieved by vgetcpu in user space
> and will be also loaded from the paranoid entry, when
> FSGSBASE enabled. So, it is moved out from vDSO to the CPU
> initialization path where IST setup is serialized.
>

Please split this into two patches.  One patch should do the cleanups
and one patch should move the code.

> diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
> index 8ec3d1f..3284069 100644
> --- a/arch/x86/entry/vdso/vgetcpu.c
> +++ b/arch/x86/entry/vdso/vgetcpu.c
> @@ -18,9 +18,9 @@ __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
>         p = __getcpu();
>
>         if (cpu)
> -               *cpu = p & VGETCPU_CPU_MASK;
> +               *cpu = lsl_tscp_to_cpu(p);
>         if (node)
> -               *node = p >> 12;
> +               *node = lsl_tscp_to_node(p);
>         return 0;

This goes in the cleanup patch.

> +/* Bit size and mask of CPU number stored in the per CPU data (and TSC_AUX) */
> +#define LSL_TSCP_CPU_SIZE              12
> +#define LSL_TSCP_CPU_MASK              0xfff
> +
> +#ifndef __ASSEMBLY__
> +
> +/* Helper functions to store/load CPU and node numbers */
> +
> +static inline unsigned long make_lsl_tscp(int cpu, unsigned long node)
> +{
> +       return ((node << LSL_TSCP_CPU_SIZE) | cpu);
> +}
> +
> +static inline unsigned int lsl_tscp_to_cpu(unsigned long x)
> +{
> +       return (x & LSL_TSCP_CPU_MASK);
> +}
> +
> +static inline unsigned int lsl_tscp_to_node(unsigned long x)
> +{
> +       return (x >> LSL_TSCP_CPU_SIZE);
> +}

As do these.  But maybe they should be #ifdef CONFIG_X86_64 to make it
clear that they are not presently supported on 32-bit systems.
(Unless I'm wrong and they are supported.)

> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 38276f5..c7b54f0 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -1665,6 +1665,11 @@ void cpu_init(void)
>
>         wrmsrl(MSR_FS_BASE, 0);
>         wrmsrl(MSR_KERNEL_GS_BASE, 0);
> +#ifdef CONFIG_NUMA
> +       write_rdtscp_aux(make_lsl_tscp(cpu, early_cpu_to_node(cpu)));
> +#else
> +       write_rdtscp_aux(make_lsl_tscp(cpu, 0));
> +#endif

Why the ifdef?  early_cpu_to_node() should return 0 if !CONFIG_NUMA.

> +static inline void setup_cpu_number_segment(int cpu)
> +{
> +#ifdef CONFIG_NUMA
> +       unsigned long node = early_cpu_to_node(cpu);
> +#else
> +       unsigned long node = 0;
> +#endif

This duplicates half the rdtscp_aux code.  How about making this one
function setup_cpu_number() that does all of it?

> +       struct desc_struct d = GDT_ENTRY_INIT(0x40f5, 0x0,
> +                          make_lsl_tscp(cpu, node));

Please get rid of the GDT_ENTRY_INIT stuff and just fill out all the
fields, just like it is in the code that you're moving.  No one enjoys
decoding hex segment descriptors.  (Well, Linus and hpa probably
*love* doing it just to show off.)
