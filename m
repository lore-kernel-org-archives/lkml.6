Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753174AbeBGEeP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 23:34:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:56551 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752682AbeBGEeN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 23:34:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,471,1511856000";
   d="scan'208";a="202129993"
Message-ID: <1517978050.23889.23.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] x86/tme: Detect if TME and MKTME is activated by
 BIOS
From: Kai Huang <kai.huang@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Date: Wed, 07 Feb 2018 17:34:10 +1300
In-Reply-To: <20180131091509.26531-3-kirill.shutemov@linux.intel.com>
References: <20180131091509.26531-1-kirill.shutemov@linux.intel.com>
         <20180131091509.26531-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-01-31 at 12:15 +0300, Kirill A. Shutemov wrote:
> IA32_TME_ACTIVATE MSR (0x982) can be used to check if BIOS has
> enabled
> TME and MKTME. It includes which encryption policy/algorithm is
> selected
> for TME or available for MKTME. For MKTME, the MSR also enumerates
> how
> many KeyIDs are available.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  arch/x86/kernel/cpu/intel.c | 83
> +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 83 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/intel.c
> b/arch/x86/kernel/cpu/intel.c
> index 6936d14d4c77..5b95fa484837 100644
> --- a/arch/x86/kernel/cpu/intel.c
> +++ b/arch/x86/kernel/cpu/intel.c
> @@ -517,6 +517,86 @@ static void detect_vmx_virtcap(struct
> cpuinfo_x86 *c)
>  	}
>  }
>  
> +#define MSR_IA32_TME_ACTIVATE		0x982

Should this MSR go into msr-index.h?

> +
> +#define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
> +#define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
> +
> +#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	
> /* Bits 7:4 */
> +#define TME_ACTIVATE_POLICY_AES_XTS	0
> +
> +#define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	/
> * Bits 35:32 */
> +
> +#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	
> /* Bits 63:48 */
> +#define TME_ACTIVATE_CRYPTO_AES_XTS	1
> +
> +#define MKTME_ENABLED		0
> +#define MKTME_DISABLED		1
> +#define MKTME_UNINITIALIZED	2
> +static int mktme_status = MKTME_UNINITIALIZED;
> +
> +static void detect_tme(struct cpuinfo_x86 *c)
> +{
> +	u64 tme_activate, tme_policy, tme_crypto_algs;
> +	int keyid_bits = 0, nr_keyids = 0;
> +	static u64 tme_activate_cpu0 = 0;
> +
> +	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
> +
> +	if (mktme_status != MKTME_UNINITIALIZED) {
> +		/* Broken BIOS? */
> +		if (tme_activate != tme_activate_cpu0) {
> +			pr_err_once("TME: configuation is
> inconsistent between CPUs\n");
> +			mktme_status = MKTME_DISABLED;
> +		}
> +		goto out;

Why goto out here? If something goes wrong, I think it is pointless to
read keyID bits staff? IMHO if something goes wrong, you should set
mktme_status to disabled, and clear tme_activate_cpu0?

> +	}
> +
> +	tme_activate_cpu0 = tme_activate;
> +
> +	if (!TME_ACTIVATE_LOCKED(tme_activate) ||
> !TME_ACTIVATE_ENABLED(tme_activate)) {
> +		pr_info("TME: not enabled by BIOS\n");
> +		mktme_status = MKTME_DISABLED;
> +		goto out;

I think it is pointless to read keyID bits staff if TME is not even
enabled.

> +	}
> +
> +	pr_info("TME: enabled by BIOS\n");
> +
> +	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
> +	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS)
> +		pr_warn("TME: Unknown policy is active: %#llx\n",
> tme_policy);
> +
> +	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
> +	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS)) {
> +		pr_err("MKTME: No known encryption algorithm is
> supported: %#llx\n",
> +				tme_crypto_algs);
> +		mktme_status = MKTME_DISABLED;
> +	}

To me it is a little bit confusing about the naming. tme_policy is the
crypto_alg used by TME keyID (0), and tme_crypto_algs is bitmap of
supported crypto_algs for MK-TME. Probably a better naming is needed?
And the naming of TME_ACTIVATE_POLICY(x), TME_ACTIVATE_CRYPTO_ALGS(x)
above as well?

> +out:
> +	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
> +	nr_keyids = (1UL << keyid_bits) - 1;
> +	if (nr_keyids) {
> +		pr_info_once("MKTME: enabled by BIOS\n");
> +		pr_info_once("MKTME: %d KeyIDs available\n",
> nr_keyids);
> +	} else {
> +		pr_info_once("MKTME: disabled by BIOS\n");
> +	}
> +
> +	if (mktme_status == MKTME_UNINITIALIZED) {
> +		/* MKTME is usable */
> +		mktme_status = MKTME_ENABLED;
> +	}
> +
> +	/*
> +	 * Exclude KeyID bits from physical address bits.
> +	 *
> +	 * We have to do this even if we are not going to use KeyID
> bits
> +	 * ourself. VM guests still have to know that these bits are
> not usable
> +	 * for physical address.
> +	 */
Currently KVM uses CPUID to get such info directly, but not consulting
c->x86_phys_bits. I think it may be reasonable for KVM to consulting c-
>x86_phys_bits for MK-TME, but IMHO the real reason we need to do this
is this is just the fact, and c->x86_phys_bits needs to reflect the
fact, so probably the comments can be refined.

Thanks,
-Kai

> +	c->x86_phys_bits -= keyid_bits;
> +}
> +
>  static void init_intel_energy_perf(struct cpuinfo_x86 *c)
>  {
>  	u64 epb;
> @@ -687,6 +767,9 @@ static void init_intel(struct cpuinfo_x86 *c)
>  	if (cpu_has(c, X86_FEATURE_VMX))
>  		detect_vmx_virtcap(c);
>  
> +	if (cpu_has(c, X86_FEATURE_TME))
> +		detect_tme(c);
> +
>  	init_intel_energy_perf(c);
>  
>  	init_intel_misc_features(c);
