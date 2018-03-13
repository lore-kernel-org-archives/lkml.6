Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932377AbeCMWIE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:08:04 -0400
Received: from mga02.intel.com ([134.134.136.20]:52634 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932197AbeCMWID (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:08:03 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,466,1515484800";
   d="scan'208";a="37087576"
Message-ID: <1520978865.13820.3.camel@linux.intel.com>
Subject: Re: [tip:x86/mm] x86/tme: Detect if TME and MKTME is activated by
 BIOS
From: Kai Huang <kai.huang@linux.intel.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: dave.hansen@intel.com, peterz@infradead.org, hpa@zytor.com,
        mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, kirill.shutemov@linux.intel.com,
        thomas.lendacky@amd.com, linux-tip-commits@vger.kernel.org
Date: Wed, 14 Mar 2018 11:07:45 +1300
In-Reply-To: <20180313124956.z426zmsr4xl6zomx@node.shutemov.name>
References: <20180305162610.37510-3-kirill.shutemov@linux.intel.com>
         <tip-cb06d8e3d020c30fe10ae711c925a5319ab82c88@git.kernel.org>
         <1520907122.6421.8.camel@linux.intel.com>
         <20180313124956.z426zmsr4xl6zomx@node.shutemov.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-03-13 at 15:49 +0300, Kirill A. Shutemov wrote:
> On Tue, Mar 13, 2018 at 03:12:02PM +1300, Kai Huang wrote:
> > It seems setup_pku() will call get_cpu_cap to restore c-
> > >x86_phys_bits
> > later? In which case I think you need to change setup_pku as well.
> 
> Thanks for catching this.
> 
> I think setup_pku() shouldn't call get_cpu_cap().
> 
> Any objections against this:
> 
> diff --git a/arch/x86/kernel/cpu/common.c
> b/arch/x86/kernel/cpu/common.c
> index 348cf4821240..ce10d8ae4cd6 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -362,6 +362,8 @@ static bool pku_disabled;
> 
>  static __always_inline void setup_pku(struct cpuinfo_x86 *c)
>  {
> +       u32 eax, ebx, ecx, edx;
> +
>         /* check the boot processor, plus compile options for PKU: */
>         if (!cpu_feature_enabled(X86_FEATURE_PKU))
>                 return;
> @@ -377,7 +379,8 @@ static __always_inline void setup_pku(struct
> cpuinfo_x86 *c)
>          * cpuid bit to be set.  We need to ensure that we
>          * update that bit in this CPU's "cpu_info".
>          */
> -       get_cpu_cap(c);
> +       cpuid_count(0x00000007, 0, &eax, &ebx, &ecx, &edx);
> +       c->x86_capability[CPUID_7_ECX] = ecx;
>  }
> 
>  #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
> 
> > And for the comments here, I think it can be refined. It is true
> > that
> > VM guest needs to know bits of physical address, but this info is
> > not
> > used only by VM. I think the reason we need to update is this is
> > simply
> > the fact.
> 
> Fair enough. Like this?

Yes good to me. Thanks.

Thanks,
-Kai
> 
> diff --git a/arch/x86/kernel/cpu/intel.c
> b/arch/x86/kernel/cpu/intel.c
> index e8ddc6dcfd53..ac45ba7398d9 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -612,11 +612,8 @@ static void detect_tme(struct cpuinfo_x86 *c)
>  #endif
> 
>         /*
> -        * Exclude KeyID bits from physical address bits.
> -        *
> -        * We have to do this even if we are not going to use KeyID
> bits
> -        * ourself. VM guests still have to know that these bits are
> not usable
> -        * for physical address.
> +        * KeyID bits effectively lower number of physical address
> bits.
> +        * Let's update cpuinfo_x86::x86_phys_bits to reflect the
> fact.
>          */
>         c->x86_phys_bits -= keyid_bits;
>  }
