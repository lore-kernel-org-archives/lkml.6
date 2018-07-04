Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F11C6778A
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:45:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66529246D6
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 02:45:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 66529246D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933171AbeGDCpt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 22:45:49 -0400
Received: from ZXSHCAS2.zhaoxin.com ([203.148.12.82]:40602 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S932254AbeGDCps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 22:45:48 -0400
Received: from zxbjmbx3.zhaoxin.com (10.29.252.165) by ZXSHCAS2.zhaoxin.com
 (10.28.252.162) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 4 Jul
 2018 10:45:40 +0800
Received: from TimGuoL10 (10.29.24.84) by zxbjmbx3.zhaoxin.com (10.29.252.165)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1261.35; Wed, 4 Jul
 2018 10:45:39 +0800
From:   David Wang <davidwang@zhaoxin.com>
To:     'Borislav Petkov' <bp@alien8.de>
CC:     <tony.luck@intel.com>, <mingo@redhat.com>, <tglx@linutronix.de>,
        <hpa@zytor.com>, <x86@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-edac@vger.kernel.org>, <cooperyan@zhaoxin.com>,
        <qiyuanwang@zhaoxin.com>, <benjaminpan@viatech.com>,
        <lukelin@viacpu.com>, <timguo@zhaoxin.com>
Subject: Re: [PATCH v2] x86/mce: add CMCI support for Centaur CPUs
Date:   Wed, 4 Jul 2018 10:45:38 +0800
Message-ID: <000001d41341$17f681a0$47e384e0$@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdQTQNEL6vNHYx7rSMShwCqYSM0xQQ==
Content-Language: zh-cn
X-Originating-IP: [10.29.24.84]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Mail-----
>  Sender: Borislav Petkov [mailto:bp@alien8.de]
>  Time: 2018年6月26日 22:30
>  Receiver: David Wang <davidwang@zhaoxin.com>
> CC: tony.luck@intel.com; mingo@redhat.com; tglx@linutronix.de;
> hpa@zytor.com; x86@kernel.org; linux-kernel@vger.kernel.org;
> linux-edac@vger.kernel.org; cooperyan@zhaoxin.com;
> qiyuanwang@zhaoxin.com; benjaminpan@viatech.com;
> lukelin@viacpu.com; timguo@zhaoxin.com
> Topic : Re: [PATCH v2] x86/mce: add CMCI support for Centaur CPUs
> 
> On Mon, Jun 04, 2018 at 10:37:33AM +0800, David Wang wrote:
> > New Centaur CPU support CMCI mechanism, which is compatible with
> INTEL CMCI.
> >
> > Signed-off-by: David Wang <davidwang@zhaoxin.com>
> 
> ...
> 
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
> This ...
> 
> >  }
> > +#else
> > +static inline void mce_centaur_feature_init(struct cpuinfo_x86 *c) {
> > +} #endif
> >
> >  static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)  { diff
> > --git a/arch/x86/kernel/cpu/mcheck/mce_intel.c
> > b/arch/x86/kernel/cpu/mcheck/mce_intel.c
> > index d05be30..5b1b68f 100644
> > --- a/arch/x86/kernel/cpu/mcheck/mce_intel.c
> > +++ b/arch/x86/kernel/cpu/mcheck/mce_intel.c
> > @@ -85,7 +85,8 @@ static int cmci_supported(int *banks)
> >  	 * initialization is vendor keyed and this
> >  	 * makes sure none of the backdoors are entered otherwise.
> >  	 */
> > -	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
> > +	if ((boot_cpu_data.x86_vendor != X86_VENDOR_INTEL &&
> > +		boot_cpu_data.x86_vendor != X86_VENDOR_CENTAUR))
> >  		return 0;
> >  	if (!boot_cpu_has(X86_FEATURE_APIC) || lapic_get_maxlvt() < 6)
> >  		return 0;
> > @@ -506,10 +507,20 @@ static void intel_ppin_init(struct cpuinfo_x86
> > *c)
> >
> >  void mce_intel_feature_init(struct cpuinfo_x86 *c)  {
> > -	intel_init_thermal(c);
> > -	intel_init_cmci();
> > -	intel_init_lmce();
> > -	intel_ppin_init(c);
> > +
> > +	switch (c->x86_vendor) {
> > +	case X86_VENDOR_INTEL:
> > +		intel_init_thermal(c);
> > +		intel_init_cmci();
> > +		intel_init_lmce();
> > +		intel_ppin_init(c);
> > +		break;
> > +	case X86_VENDOR_CENTAUR:
> > +		intel_init_cmci();
> 
> ... and this I really don't like for the simple reason that if the Intel side gets
> changed, it could potentially break Centaur. And we don't want that. And
> the vendor should be free to change their code without asking another
> vendor for permission even if the other vendor is almost copying the
> code...
> 
> Long story short, I think you should extract the facilities you're going to
> need into generic, library-like ones and call them from centaur-specific
> compilation units which get enabled when CPU_SUP_CENTAUR is enabled.
> 
> So that the code can still be shared but there's no dependency on other
> vendors and so that one vendor doesn't break the other one and
> vice-versa.
> 
> IMO.
> 
> Thx.
> 
	OK. I will adjust code.
	Thank you.
> --
> Regards/Gruss,
>     Boris.
> 
> Good mailing practices for 400: avoid top-posting and trim the reply.

