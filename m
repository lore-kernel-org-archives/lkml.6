Return-Path: <SRS0=cv1S=JM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC906C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:29:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 644E726C68
	for <linux-kernel@archiver.kernel.org>; Tue, 26 Jun 2018 14:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 644E726C68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=alien8.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936099AbeFZO3y (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 Jun 2018 10:29:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:51356 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S935339AbeFZO3x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jun 2018 10:29:53 -0400
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (blast.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id fdbsMcMnNCMh; Tue, 26 Jun 2018 16:29:52 +0200 (CEST)
Received: from zn.tnic (p200300EC2BCA5B00329C23FFFEA6A903.dip0.t-ipconnect.de [IPv6:2003:ec:2bca:5b00:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 33B681EC01D4;
        Tue, 26 Jun 2018 16:29:52 +0200 (CEST)
Date:   Tue, 26 Jun 2018 16:29:49 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     David Wang <davidwang@zhaoxin.com>
Cc:     tony.luck@intel.com, mingo@redhat.com, tglx@linutronix.de,
        hpa@zytor.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, cooperyan@zhaoxin.com,
        qiyuanwang@zhaoxin.com, benjaminpan@viatech.com,
        lukelin@viacpu.com, timguo@zhaoxin.com
Subject: Re: [PATCH v2] x86/mce: add CMCI support for Centaur CPUs
Message-ID: <20180626142949.GA4136@zn.tnic>
References: <1528079853-8101-1-git-send-email-davidwang@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1528079853-8101-1-git-send-email-davidwang@zhaoxin.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 04, 2018 at 10:37:33AM +0800, David Wang wrote:
> New Centaur CPU support CMCI mechanism, which is compatible with INTEL CMCI.
> 
> Signed-off-by: David Wang <davidwang@zhaoxin.com>

...

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

This ...

>  }
> +#else
> +static inline void mce_centaur_feature_init(struct cpuinfo_x86 *c) { }
> +#endif
>  
>  static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
>  {
> diff --git a/arch/x86/kernel/cpu/mcheck/mce_intel.c b/arch/x86/kernel/cpu/mcheck/mce_intel.c
> index d05be30..5b1b68f 100644
> --- a/arch/x86/kernel/cpu/mcheck/mce_intel.c
> +++ b/arch/x86/kernel/cpu/mcheck/mce_intel.c
> @@ -85,7 +85,8 @@ static int cmci_supported(int *banks)
>  	 * initialization is vendor keyed and this
>  	 * makes sure none of the backdoors are entered otherwise.
>  	 */
> -	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
> +	if ((boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
> +		boot_cpu_data.x86_vendor != X86_VENDOR_CENTAUR))
>  		return 0;
>  	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
>  		return 0;
> @@ -506,10 +507,20 @@ static void intel_ppin_init(struct cpuinfo_x86 *c)
>  
>  void mce_intel_feature_init(struct cpuinfo_x86 *c)
>  {
> -	intel_init_thermal(c);
> -	intel_init_cmci();
> -	intel_init_lmce();
> -	intel_ppin_init(c);
> +
> +	switch (c->x86_vendor) {
> +	case X86_VENDOR_INTEL:
> +		intel_init_thermal(c);
> +		intel_init_cmci();
> +		intel_init_lmce();
> +		intel_ppin_init(c);
> +		break;
> +	case X86_VENDOR_CENTAUR:
> +		intel_init_cmci();

... and this I really don't like for the simple reason that if the Intel
side gets changed, it could potentially break Centaur. And we don't want
that. And the vendor should be free to change their code without asking
another vendor for permission even if the other vendor is almost copying
the code...

Long story short, I think you should extract the facilities you're
going to need into generic, library-like ones and call them
from centaur-specific compilation units which get enabled when
CPU_SUP_CENTAUR is enabled.

So that the code can still be shared but there's no dependency on
other vendors and so that one vendor doesn't break the other one and
vice-versa.

IMO.

Thx.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
