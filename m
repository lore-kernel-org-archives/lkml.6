Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753819AbeBGLAz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 06:00:55 -0500
Received: from mga09.intel.com ([134.134.136.24]:22347 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753470AbeBGLAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 06:00:53 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,473,1511856000";
   d="scan'208";a="202004403"
Message-ID: <1518001244.23889.32.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] x86/tme: Detect if TME and MKTME is activated by
 BIOS
From: Kai Huang <kai.huang@linux.intel.com>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org
Date: Thu, 08 Feb 2018 00:00:44 +1300
In-Reply-To: <20180207081627.eomxuyqw74eew756@node.shutemov.name>
References: <20180131091509.26531-1-kirill.shutemov@linux.intel.com>
         <20180131091509.26531-3-kirill.shutemov@linux.intel.com>
         <1517978050.23889.23.camel@linux.intel.com>
         <20180207081627.eomxuyqw74eew756@node.shutemov.name>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-02-07 at 11:16 +0300, Kirill A. Shutemov wrote:
> On Wed, Feb 07, 2018 at 05:34:10PM +1300, Kai Huang wrote:
> > On Wed, 2018-01-31 at 12:15 +0300, Kirill A. Shutemov wrote:
> > > IA32_TME_ACTIVATE MSR (0x982) can be used to check if BIOS has
> > > enabled
> > > TME and MKTME. It includes which encryption policy/algorithm is
> > > selected
> > > for TME or available for MKTME. For MKTME, the MSR also
> > > enumerates
> > > how
> > > many KeyIDs are available.
> > > 
> > > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.co
> > > m>
> > > ---
> > >  arch/x86/kernel/cpu/intel.c | 83
> > > +++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 83 insertions(+)
> > > 
> > > diff --git a/arch/x86/kernel/cpu/intel.c
> > > b/arch/x86/kernel/cpu/intel.c
> > > index 6936d14d4c77..5b95fa484837 100644
> > > --- a/arch/x86/kernel/cpu/intel.c
> > > +++ b/arch/x86/kernel/cpu/intel.c
> > > @@ -517,6 +517,86 @@ static void detect_vmx_virtcap(struct
> > > cpuinfo_x86 *c)
> > >  	}
> > >  }
> > >  
> > > +#define MSR_IA32_TME_ACTIVATE		0x982
> > 
> > Should this MSR go into msr-index.h?
> 
> No. Comment from msr-index.h:
> 
>  * Do not add new entries to this file unless the definitions are
> shared
>  * between multiple compilation units.
> 
> > > +
> > > +#define TME_ACTIVATE_LOCKED(x)		(x & 0x1)
> > > +#define TME_ACTIVATE_ENABLED(x)		(x & 0x2)
> > > +
> > > +#define TME_ACTIVATE_POLICY(x)		((x >> 4) & 0xf)	
> > > /* Bits 7:4 */
> > > +#define TME_ACTIVATE_POLICY_AES_XTS	0
> > > +
> > > +#define TME_ACTIVATE_KEYID_BITS(x)	((x >> 32) & 0xf)	
> > > /
> > > * Bits 35:32 */
> > > +
> > > +#define TME_ACTIVATE_CRYPTO_ALGS(x)	((x >> 48) & 0xffff)	
> > > /* Bits 63:48 */
> > > +#define TME_ACTIVATE_CRYPTO_AES_XTS	1
> > > +
> > > +#define MKTME_ENABLED		0
> > > +#define MKTME_DISABLED		1
> > > +#define MKTME_UNINITIALIZED	2
> > > +static int mktme_status = MKTME_UNINITIALIZED;
> > > +
> > > +static void detect_tme(struct cpuinfo_x86 *c)
> > > +{
> > > +	u64 tme_activate, tme_policy, tme_crypto_algs;
> > > +	int keyid_bits = 0, nr_keyids = 0;
> > > +	static u64 tme_activate_cpu0 = 0;
> > > +
> > > +	rdmsrl(MSR_IA32_TME_ACTIVATE, tme_activate);
> > > +
> > > +	if (mktme_status != MKTME_UNINITIALIZED) {
> > > +		/* Broken BIOS? */
> > > +		if (tme_activate != tme_activate_cpu0) {
> > > +			pr_err_once("TME: configuation is
> > > inconsistent between CPUs\n");
> > > +			mktme_status = MKTME_DISABLED;
> > > +		}
> > > +		goto out;
> > 
> > Why goto out here? If something goes wrong, I think it is pointless
> > to
> > read keyID bits staff? IMHO if something goes wrong, you should set
> > mktme_status to disabled, and clear tme_activate_cpu0?
> 
> We still have to mask out keyid bits from x86_phys_bits if CPU has
> TME
> enabled. 

Reading spec again yes you are right.

> But yeah, as you pointed below, I need to check that it actually
> locked and enabled.
> 
> > > +	}
> > > +
> > > +	tme_activate_cpu0 = tme_activate;
> > > +
> > > +	if (!TME_ACTIVATE_LOCKED(tme_activate) ||
> > > !TME_ACTIVATE_ENABLED(tme_activate)) {
> > > +		pr_info("TME: not enabled by BIOS\n");
> > > +		mktme_status = MKTME_DISABLED;
> > > +		goto out;
> > 
> > I think it is pointless to read keyID bits staff if TME is not even
> > enabled.
> > 
> > > +	}
> > > +
> > > +	pr_info("TME: enabled by BIOS\n");
> > > +
> > > +	tme_policy = TME_ACTIVATE_POLICY(tme_activate);
> > > +	if (tme_policy != TME_ACTIVATE_POLICY_AES_XTS)
> > > +		pr_warn("TME: Unknown policy is active:
> > > %#llx\n",
> > > tme_policy);
> > > +
> > > +	tme_crypto_algs =
> > > TME_ACTIVATE_CRYPTO_ALGS(tme_activate);
> > > +	if (!(tme_crypto_algs & TME_ACTIVATE_CRYPTO_AES_XTS)) {
> > > +		pr_err("MKTME: No known encryption algorithm is
> > > supported: %#llx\n",
> > > +				tme_crypto_algs);
> > > +		mktme_status = MKTME_DISABLED;
> > > +	}
> > 
> > To me it is a little bit confusing about the naming. tme_policy is
> > the
> > crypto_alg used by TME keyID (0), and tme_crypto_algs is bitmap of
> > supported crypto_algs for MK-TME. Probably a better naming is
> > needed?
> > And the naming of TME_ACTIVATE_POLICY(x),
> > TME_ACTIVATE_CRYPTO_ALGS(x)
> > above as well?
> 
> Suggestions?

I would go with 'tme_cryto_alg', and 'mktme_supported_crypto_algs' for
the two variables, and TME_CRYPTO_ALG(x), TME_CRYPTO_ALG_AES_XTS_128, 
MKTME_SUPPORTED_CRYPTO_ALGS(x), and MKTME_CRYPTO_ALG_AES_XTS_128 for
the macros, but it's up to you and other guys.

Btw I do think AES_XTS should be AES_XTS_128, even you go with current
names, as AES cipher can also take 256-bit key.

Thanks,
-Kai
> 
