Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751884AbeFDCKO convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 22:10:14 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:58910 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751373AbeFDCKN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 22:10:13 -0400
From: David Wang <davidwang@zhaoxin.com>
To: "'Borislav Petkov'" <bp@alien8.de>
CC: <tony.luck@intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>,
        <hpa@zytor.com>, <gregkh@linuxfoudation.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-edac@vger.kernel.org>,
        <brucechang@via-alliance.com>, <cooperyan@zhaoxin.com>,
        <qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>,
        <lukelin@viacpu.com>, <timguo@zhaoxin.com>
Subject: Re: [PATCH] x86/mce: add CMCI support for Centaur CPUs
Date: Mon, 4 Jun 2018 10:09:59 +0800
Message-ID: <000001d3fba9$23d5df20$6b819d60$@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdP7pK2W/DP9kgHBQ5+eP6bQ1aJlLw==
Content-Language: zh-cn
X-Originating-IP: [10.29.8.88]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Mail-----
> Sender: Borislav Petkov [mailto:bp@alien8.de]
> Time: 2018年6月1日 17:38
> Receiver: David Wang <davidwang@zhaoxin.com>
> CC: tony.luck@intel.com; mingo@redhat.com; tglx@linutronix.de;
> hpa@zytor.com; gregkh@linuxfoudation.org; x86@kernel.org;
> linux-kernel@vger.kernel.org; linux-edac@vger.kernel.org;
> brucechang@via-alliance.com; cooperyan@zhaoxin.com;
> qiyuanwang@zhaoxin.com; benjaminpan@viatech.com; lukelin@viacpu.com;
> timguo@zhaoxin.com
> Topic : Re: [PATCH] x86/mce: add CMCI support for Centaur CPUs
> 
> On Thu, May 31, 2018 at 11:28:58AM +0800, David Wang wrote:
> > Newer Centaur support CMCI mechanism, which is compatible with INTEL
> CMCI.
> >
> > Signed-off-by: David Wang <davidwang@zhaoxin.com>
> > ---
> >  arch/x86/Kconfig                 | 12 ++++++++++++
> >  arch/x86/kernel/cpu/mcheck/mce.c |  6 ++++++
> >  2 files changed, 18 insertions(+)
> >
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig index
> > dda87a3..1adff5f 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -1130,6 +1130,18 @@ config X86_MCE_AMD
> >  	   Additional support for AMD specific MCE features such as
> >  	   the DRAM Error Threshold.
> >
> > +config X86_MCE_CENTAUR
> > +	def_bool y
> > +	prompt "CENTAUR MCE features"
> > +	depends on CPU_SUP_CENTAUR && X86_MCE_INTEL
> > +	help
> > +	   Additional support for Centaur specific MCE features such as
> > +	   MCE broadcasting and CMCI support.
> > +	   New Centaur CPU support MCE broadcasting.
> > +	   New Centaur CPU support CMCI which is fully compliant with Intel
> CMCI.
> > +
> > +	   If unsure, say N here.
> > +
> >  config X86_ANCIENT_MCE
> >  	bool "Support for old Pentium 5 / WinChip machine checks"
> >  	depends on X86_32 && X86_MCE
> > diff --git a/arch/x86/kernel/cpu/mcheck/mce.c
> > b/arch/x86/kernel/cpu/mcheck/mce.c
> > index cd76380..2ebafc7 100644
> > --- a/arch/x86/kernel/cpu/mcheck/mce.c
> > +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> > @@ -1727,6 +1727,7 @@ static void __mcheck_cpu_init_early(struct
> cpuinfo_x86 *c)
> >  	}
> >  }
> >
> > +#ifdef CONFIG_X86_MCE_CENTAUR
> >  static void mce_centaur_feature_init(struct cpuinfo_x86 *c)  {
> >  	struct mca_config *cfg = &mca_cfg;
> > @@ -1740,7 +1741,12 @@ static void mce_centaur_feature_init(struct
> cpuinfo_x86 *c)
> >  		if (cfg->monarch_timeout < 0)
> >  			cfg->monarch_timeout = USEC_PER_SEC;
> >  	}
> > +	mce_intel_feature_init(c);
> > +	mce_adjust_timer = cmci_intel_adjust_timer;
> 
> So far so good but above says "New Centaur CPU[s]" but you're calling
> mce_intel_feature_init() unconditionally here, for *all* centaur CPUs.
> Ditto for setting the CMCI handler.

	There is a check for CMCI support or not In cmci_supported() function which will be called by mce_intel_feature_init.

		return !!(cap & MCG_CMCI_P);
	So, I didn't add Family/Model/Stepping check.

	But, I am sorry to add another patch just as following:

	@@ -85,7 +85,8 @@ static int cmci_supported(int *banks)
         * initialization is vendor keyed and this
         * makes sure none of the backdoors are entered otherwise.
         */
-       if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+       if ((boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
+               boot_cpu_data.x86_vendor != X86_VENDOR_CENTAUR))
                return 0;
        if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
                return 0;

	I will send patch v4 later to include this patch.
	Thank you.
> 
> Also mce_intel_feature_init() does more things than init CMCI so I think you
> wanna limit that to only intel_init_cmci(). IOW, something like the hunk below.
> 
> And frankly I'm not crazy about adding centaur code to mce_intel.c but since it
> is copying functionality, I think we should copy the sw support in the kernel too
> instead of adding a mce_centaur.c duplicate. For now at least...
> 
> Thx.
> 
> ---
> diff --git a/arch/x86/kernel/cpu/mcheck/mce_intel.c
> b/arch/x86/kernel/cpu/mcheck/mce_intel.c
> index d05be307d081..77d8a9b996a6 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce_intel.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce_intel.c
> @@ -506,8 +506,15 @@ static void intel_ppin_init(struct cpuinfo_x86 *c)
> 
>  void mce_intel_feature_init(struct cpuinfo_x86 *c)  {
> -	intel_init_thermal(c);
>  	intel_init_cmci();
> +
> +	/*
> +	 * Some Centaur variants support CMCI.
> +	 */
> +	if (c->x86_vendor == X86_VENDOR_CENTAUR)
> +		return;
> +
> +	intel_init_thermal(c);
>  	intel_init_lmce();
>  	intel_ppin_init(c);
>  }
> 
	OK. I will send patch V4 to fix this problem, just like:
	
void mce_intel_feature_init(struct cpuinfo_x86 *c)
 {
-       intel_init_thermal(c);
-       intel_init_cmci();
-       intel_init_lmce();
-       intel_ppin_init(c);
+
+       switch (c->x86_vendor) {
+       case X86_VENDOR_INTEL:
+               intel_init_thermal(c);
+               intel_init_cmci();
+               intel_init_lmce();
+               intel_ppin_init(c);
+               break;
+       case X86_VENDOR_CENTAUR:
+               intel_init_cmci();
+               break;
+       default:
+               break;
+       }
 }
	Thank you.

> --
> Regards/Gruss,
>     Boris.
> 
> ECO tip #101: Trim your mails when you reply.
> --
