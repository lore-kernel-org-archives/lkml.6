Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750986AbeBGWJk (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 17:09:40 -0500
Received: from mga11.intel.com ([192.55.52.93]:48620 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750720AbeBGWJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 17:09:39 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="16430481"
Message-ID: <1518041375.23889.48.camel@linux.intel.com>
Subject: Re: [PATCHv2 2/5] x86/tme: Detect if TME and MKTME is activated by
 BIOS
From: Kai Huang <kai.huang@linux.intel.com>
To: Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2018 11:09:35 +1300
In-Reply-To: <191f2605-0cba-ec81-2039-0872dcb63791@intel.com>
References: <20180207125946.5906-1-kirill.shutemov@linux.intel.com>
         <20180207125946.5906-3-kirill.shutemov@linux.intel.com>
         <191f2605-0cba-ec81-2039-0872dcb63791@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-07 at 11:02 -0800, Dave Hansen wrote:
> On 02/07/2018 04:59 AM, Kirill A. Shutemov wrote:
> > IA32_TME_ACTIVATE MSR (0x982) can be used to check if BIOS has
> > enabled
> > TME and MKTME. It includes which encryption policy/algorithm is
> > selected
> > for TME or available for MKTME. For MKTME, the MSR also enumerates
> > how
> > many KeyIDs are available.
> 
> The hacking of the phys_addr_bits is a pretty important part of this.
> Are you sure it's not worth calling out in the description?
> 
> > +#define MSR_IA32_TME_ACTIVATE		0x982
> > +
> > +#define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
> > +#define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
> > +
> > +#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	
> > /* Bits 7:4 */
> > +#define TME_ACTIVATE_POLICY_AES_XTS_128	0
> > +
> > +#define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	
> > /* Bits 35:32 */
> > +
> > +#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	
> > /* Bits 63:48 */
> > +#define TME_ACTIVATE_CRYPTO_AES_XTS_128	1
> > +
> > +#define MKTME_ENABLED		0
> > +#define MKTME_DISABLED		1
> > +#define MKTME_UNINITIALIZED	2
> 
> The indentation there looks a bit wonky.  Might want to double-check
> it.
> 
> Also, can you clearly spell out which of these things are software
> constructs vs. hardware ones?  MKTME_* look like software constructs.
> 
> > +static int mktme_status = MKTME_UNINITIALIZED;
> > +
> > +static void detect_keyid_bits(struct cpuinfo_x86 *c, u64
> > tme_activate)
> > +{
> > +	int keyid_bits = 0, nr_keyids = 0;
> > +
> > +	keyid_bits = TME_ACTIVATE_KEYID_BITS(tme_activate);
> > +	nr_keyids = (1UL << keyid_bits) - 1;
> > +	if (nr_keyids) {
> > +		pr_info_once("x86/mktme: enabled by BIOS\n");
> > +		pr_info_once("x86/mktme: %d KeyIDs available\n",
> > nr_keyids);
> > +	} else {
> > +		pr_info_once("x86/mktme: disabled by BIOS\n");
> > +	}
> 
> Just curious, but how do you know that this indicates the BIOS
> disabling
> MKTME?
> 
> > +	if (mktme_status == MKTME_UNINITIALIZED) {
> > +		/* MKTME is usable */
> > +		mktme_status = MKTME_ENABLED;
> > +	}
> 
> To me, it's a little bit odd that we "enable" MKTME down in the keyid
> detection code.  I wonder if you could just return the resulting
> number
> of keyids and then actually do the mktme_status munging in one place
> (detect_tme()).
> 
> > +	/*
> > +	 * Exclude KeyID bits from physical address bits.
> > +	 *
> > +	 * We have to do this even if we are not going to use
> > KeyID bits
> > +	 * ourself. VM guests still have to know that these bits
> > are not usable
> > +	 * for physical address.
> > +	 */
> > +	c->x86_phys_bits -= keyid_bits;
> > +}
> 
> How do we tell guests about this?  kvm_set_mmio_spte_mask()?

Hi Dave,

KVM tells guest physical bits info in CPUID emulating from guest.
Currently KVM uses native CPUID to get physical bits info, and report
it to guest in CPUID emulating. KVM is not consulting c->x86_phys_bits
in CPUID emulation now, but for MK-TME I think it should be reasonable
for KVM to do that.

The kvm_set_mmio_spte_mask() you mentioned is used to setup pte mask to
cause page fault for guest's MMIO pages (in shadow MMU mode only, for
EPT we have different function). It is using
boot_cpu_data.x86_phys_bits (for which we need to do code update for
MK-TME), but this function is not related to reporting physical bits
info to guest.

Thanks,
-Kai
> 
> > +static void detect_tme(struct cpuinfo_x86 *c)
> > +{
> > +	u64 tme_activate, tme_policy, tme_crypto_algs;
> > +	static u64 tme_activate_cpu0 = 0;
> > +
> > +	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
> > +
> > +	if (mktme_status != MKTME_UNINITIALIZED) {
> > +		if (tme_activate != tme_activate_cpu0) {
> > +			/* Broken BIOS? */
> > +			pr_err_once("x86/tme: configuation is
> > inconsistent between CPUs\n");
> > +			pr_err_once("x86/tme: MKTME is not
> > usable\n");
> > +			mktme_status = MKTME_DISABLED;
> > +
> > +			/* Proceed. We may need to exclude bits
> > from x86_phys_bits. */
> > +		}
> > +	} else {
> > +		tme_activate_cpu0 = tme_activate;
> > +	}
> > +
> > +	if (!TME_ACTIVATE_LOCKED(tme_activate) ||
> > !TME_ACTIVATE_ENABLED(tme_activate)) {
> > +		pr_info_once("x86/tme: not enabled by BIOS\n");
> > +		mktme_status = MKTME_DISABLED;
> > +		return;
> > +	}
> > +
> > +	if (mktme_status != MKTME_UNINITIALIZED)
> > +		return detect_keyid_bits(c, tme_activate);
> 
> Returning the result of a void function is a bit odd-looking.  Would
> it
> look nicer to just have a label and some gotos to the detection?
> 
> > +	pr_info("x86/tme: enabled by BIOS\n");
> > +
> > +	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
> > +	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS_128)
> > +		pr_warn("x86/tme: Unknown policy is active:
> > %#llx\n", tme_policy);
> > +
> > +	tme_crypto_algs = TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
> > +	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS_128))
> > {
> > +		pr_err("x86/mktme: No known encryption algorithm
> > is supported: %#llx\n",
> > +				tme_crypto_algs);
> > +		mktme_status = MKTME_DISABLED;
> > +	}
> > +
> > +	detect_keyid_bits(c, tme_activate);
> > +}
> 
> I noticed that this code is not optional, other than by disabling
> CPU_SUP_INTEL.  Was that intentional?  What were your thoughts behind
> that?
