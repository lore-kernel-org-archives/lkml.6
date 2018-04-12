Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753294AbeDLOh1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 10:37:27 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47564 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbeDLOhX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 10:37:23 -0400
Date: Thu, 12 Apr 2018 10:36:48 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc: Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Kai Huang <kai.huang@linux.intel.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv2, RESEND] x86/mm: Do not lose cpuinfo_x86::x86_phys_bits
 adjustment
Message-ID: <20180412143648.GI25481@char.us.oracle.com>
References: <20180410092704.41106-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410092704.41106-1-kirill.shutemov@linux.intel.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8860 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=867
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804120145
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 12:27:04PM +0300, Kirill A. Shutemov wrote:
> Some features (Intel MKTME, AMD SME) reduce number of effectively
> available physical address bits. We adjust x86_phys_bits accordingly.
> 
> If get_cpu_cap() got called more than one time we lose this adjustement.
> 
> That's exactly what happens in setup_pku(): it gets called after
> detect_tme() and cpuinfo_x86::x86_phys_bits gets overwritten.
> 
> Extract address sizes enumeration into a separate routine and get it
> called only from early_identify_cpu() and from generic_identify().
> 
> It makes get_cpu_cap() safe to be called later during boot proccess
> without risk to overwrite cpuinfo_x86::x86_phys_bits.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reported-by: Kai Huang <kai.huang@linux.intel.com>
> Fixes: cb06d8e3d020 ("x86/tme: Detect if TME and MKTME is activated by BIOS")
> ---
>  arch/x86/kernel/cpu/common.c | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
> index 348cf4821240..2981bf287ef5 100644
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -848,18 +848,6 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
>  		c->x86_power = edx;
>  	}
>  
> -	if (c->extended_cpuid_level >= 0x80000008) {
> -		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
> -
> -		c->x86_virt_bits = (eax >> 8) & 0xff;
> -		c->x86_phys_bits = eax & 0xff;
> -		c->x86_capability[CPUID_8000_0008_EBX] = ebx;
> -	}
> -#ifdef CONFIG_X86_32
> -	else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
> -		c->x86_phys_bits = 36;
> -#endif
> -
>  	if (c->extended_cpuid_level >= 0x8000000a)
>  		c->x86_capability[CPUID_8000_000A_EDX] = cpuid_edx(0x8000000a);
>  
> @@ -874,6 +862,23 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
>  	apply_forced_caps(c);
>  }
>  
> +static void get_cpu_address_sizes(struct cpuinfo_x86 *c)
> +{
> +	u32 eax, ebx, ecx, edx;

Since you aren't using those in the else condition, could you move
them in:
> +
> +	if (c->extended_cpuid_level >= 0x80000008) {

Here?

And just to be on the safe side since the cpuid can be interecepted
by the hypervisor and give you nothing (that is not touch the registers),
perhaps also set eax = ebx, ecx and edx to zero?

Granted it would have to be a pretty messed up hypervisor to first
say  - yeah you can look at leaf 0x80000008, and then not fill out the
register values <shrugs>.

Either way you can add:

Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Thank you!
> +		cpuid(0x80000008, &eax, &ebx, &ecx, &edx);
> +
> +		c->x86_virt_bits = (eax >> 8) & 0xff;
> +		c->x86_phys_bits = eax & 0xff;
> +		c->x86_capability[CPUID_8000_0008_EBX] = ebx;
> +	}
> +#ifdef CONFIG_X86_32
> +	else if (cpu_has(c, X86_FEATURE_PAE) || cpu_has(c, X86_FEATURE_PSE36))
> +		c->x86_phys_bits = 36;
> +#endif
> +}
> +
>  static void identify_cpu_without_cpuid(struct cpuinfo_x86 *c)
>  {
>  #ifdef CONFIG_X86_32
> @@ -965,6 +970,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
>  		cpu_detect(c);
>  		get_cpu_vendor(c);
>  		get_cpu_cap(c);
> +		get_cpu_address_sizes(c);
>  		setup_force_cpu_cap(X86_FEATURE_CPUID);
>  
>  		if (this_cpu->c_early_init)
> @@ -1097,6 +1103,8 @@ static void generic_identify(struct cpuinfo_x86 *c)
>  
>  	get_cpu_cap(c);
>  
> +	get_cpu_address_sizes(c);
> +
>  	if (c->cpuid_level >= 0x00000001) {
>  		c->initial_apicid = (cpuid_ebx(1) >> 24) & 0xFF;
>  #ifdef CONFIG_X86_32
> -- 
> 2.16.3
> 
