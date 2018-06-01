Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751637AbeFAJh0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 05:37:26 -0400
Received: from mail.skyhub.de ([5.9.137.197]:39816 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750790AbeFAJhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 05:37:23 -0400
Date: Fri, 1 Jun 2018 11:37:35 +0200
From: Borislav Petkov <bp@alien8.de>
To: David Wang <davidwang@zhaoxin.com>
Cc: tony.luck@intel.com, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, gregkh@linuxfoudation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        brucechang@via-alliance.com, cooperyan@zhaoxin.com,
        qiyuanwang@zhaoxin.com, benjaminpan@viatech.com, lukelin@viacpu.com,
        timguo@zhaoxin.com
Subject: Re: [PATCH] x86/mce: add CMCI support for Centaur CPUs
Message-ID: <20180601093735.GG17783@nazgul.tnic>
References: <1527737338-4036-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1527737338-4036-1-git-send-email-davidwang@zhaoxin.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 11:28:58AM +0800, David Wang wrote:
> Newer Centaur support CMCI mechanism, which is compatible with INTEL CMCI.
> 
> Signed-off-by: David Wang <davidwang@zhaoxin.com>
> ---
>  arch/x86/Kconfig                 | 12 ++++++++++++
>  arch/x86/kernel/cpu/mcheck/mce.c |  6 ++++++
>  2 files changed, 18 insertions(+)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index dda87a3..1adff5f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1130,6 +1130,18 @@ config X86_MCE_AMD
>  	   Additional support for AMD specific MCE features such as
>  	   the DRAM Error Threshold.
>  
> +config X86_MCE_CENTAUR
> +	def_bool y
> +	prompt "CENTAUR MCE features"
> +	depends on CPU_SUP_CENTAUR && X86_MCE_INTEL
> +	help
> +	   Additional support for Centaur specific MCE features such as
> +	   MCE broadcasting and CMCI support.
> +	   New Centaur CPU support MCE broadcasting.
> +	   New Centaur CPU support CMCI which is fully compliant with Intel CMCI.
> +
> +	   If unsure, say N here.
> +
>  config X86_ANCIENT_MCE
>  	bool "Support for old Pentium 5 / WinChip machine checks"
>  	depends on X86_32 && X86_MCE
> diff --git a/arch/x86/kernel/cpu/mcheck/mce.c b/arch/x86/kernel/cpu/mcheck/mce.c
> index cd76380..2ebafc7 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce.c
> @@ -1727,6 +1727,7 @@ static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
>  	}
>  }
>  
> +#ifdef CONFIG_X86_MCE_CENTAUR
>  static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
>  {
>  	struct mca_config *cfg = &mca_cfg;
> @@ -1740,7 +1741,12 @@ static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
>  		if (cfg->monarch_timeout < 0)
>  			cfg->monarch_timeout = USEC_PER_SEC;
>  	}
> +	mce_intel_feature_init(c);
> +	mce_adjust_timer = cmci_intel_adjust_timer;

So far so good but above says "New Centaur CPU[s]" but you're calling
mce_intel_feature_init() unconditionally here, for *all* centaur CPUs.
Ditto for setting the CMCI handler.

Also mce_intel_feature_init() does more things than init CMCI so I think
you wanna limit that to only intel_init_cmci(). IOW, something like the
hunk below.

And frankly I'm not crazy about adding centaur code to mce_intel.c but
since it is copying functionality, I think we should copy the sw support
in the kernel too instead of adding a mce_centaur.c duplicate. For now
at least...

Thx.

---
diff --git a/arch/x86/kernel/cpu/mcheck/mce_intel.c b/arch/x86/kernel/cpu/mcheck/mce_intel.c
index d05be307d081..77d8a9b996a6 100644
--- a/arch/x86/kernel/cpu/mcheck/mce_intel.c
+++ b/arch/x86/kernel/cpu/mcheck/mce_intel.c
@@ -506,8 +506,15 @@ static void intel_ppin_init(struct cpuinfo_x86 *c)
 
 void mce_intel_feature_init(struct cpuinfo_x86 *c)
 {
-	intel_init_thermal(c);
 	intel_init_cmci();
+
+	/*
+	 * Some Centaur variants support CMCI.
+	 */
+	if (c->x86_vendor == X86_VENDOR_CENTAUR)
+		return;
+
+	intel_init_thermal(c);
 	intel_init_lmce();
 	intel_ppin_init(c);
 }

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.
--
