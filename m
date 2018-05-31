Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754413AbeEaUZ2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 16:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:49410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754089AbeEaUZ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 16:25:27 -0400
X-Google-Smtp-Source: ADUXVKJ2zmr0p2KMoKiHjHfj1cpm3HdtAgjen+PuoQS+vOxOl0HDzx3PExhFzs9FU4xk5V46lpVxvDiHm6xieAO8O/E=
MIME-Version: 1.0
References: <1527789525-8857-1-git-send-email-chang.seok.bae@intel.com> <1527789525-8857-6-git-send-email-chang.seok.bae@intel.com>
In-Reply-To: <1527789525-8857-6-git-send-email-chang.seok.bae@intel.com>
From: Andy Lutomirski <luto@kernel.org>
Date: Thu, 31 May 2018 13:25:12 -0700
X-Gmail-Original-Message-ID: <CALCETrXy0bFxGoUB3rfwyJaM0ab5ZPZR0ku-wnBwfx+P+MaL8A@mail.gmail.com>
Message-ID: <CALCETrXy0bFxGoUB3rfwyJaM0ab5ZPZR0ku-wnBwfx+P+MaL8A@mail.gmail.com>
Subject: Re: [PATCH V2 05/15] x86/vdso: Move out the CPU number store
To: "Bae, Chang Seok" <chang.seok.bae@intel.com>
Cc: Andrew Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Metzger, Markus T" <markus.t.metzger@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 10:58 AM Chang S. Bae <chang.seok.bae@intel.com> wrote:
>
> The CPU (and node) number will be written, as early enough,
> to the segment limit of per CPU data and TSC_AUX MSR entry.
> The information has been retrieved by vgetcpu in user space
> and will be also loaded from the paranoid entry, when
> FSGSBASE enabled. So, it is moved out from vDSO to the CPU
> initialization path where IST setup is serialized.
>
> Now, redundant setting of the segment in entry/vdso/vma.c
> was removed; a substantial code removal. It removes a
> hotplug notifier, makes a facility useful to both the kernel
> and userspace unconditionally available much sooner, and
> unification with i386. (Thanks to HPA for suggesting the
> cleanup)
>
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: H. Peter Anvin <hpa@zytor.com>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Andi Kleen <ak@linux.intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@kernel.org>

> +/* Bit size and mask of CPU number stored in the per CPU data */
> +#define PERCPU_CPU_SIZE                        12
> +#define PERCPU_CPU_MASK                        0xfff

This name is confusing.  Maybe LSL_TSCP_CPU_MASK?

Can you also add a helpers like:

static inline unsigned long make_lsl_tscp(unsigned int cpu, unsigned
int node) { ... }
static inline unsigned int lsl_tscp_to_cpu(unsigned long x) { ... }
static inline unsigned int lsl_tscp_to_node(unsigned long x) { ... }

and use them everywhere?  This will make it lot easier to understand the code.

> +#ifdef CONFIG_X86_32
> +                       GDT_ENTRY_PERCPU,
> +#else /* 64 bit */
> +                       GDT_ENTRY_PER_CPU,
>  #endif

Please just rename one of these to match the other one.
