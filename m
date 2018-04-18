Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752743AbeDRIuL (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 04:50:11 -0400
Received: from zxshcas2.zhaoxin.com ([180.169.121.92]:40443 "EHLO
        ZXSHCAS2.zhaoxin.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751444AbeDRIuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 04:50:09 -0400
From: David Wang <davidwang@zhaoxin.com>
To: "'Thomas Gleixner'" <tglx@linutronix.de>
CC: <mingo@redhat.com>, <hpa@zytor.com>, <mingo@kernel.org>,
        <grehkg@linuxfoundation.org>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>, <brucechang@via-alliance.com>,
        <cooperyan@zhaoxin.com>, <qiyuanwang@zhaoxin.com>,
        <benjaminpan@viatech.com>, <lukelin@viacpu.com>, <timguo@zhaoxin.com>
Subject: Re: [PATCH] x86/Centaur: show more HW features in /proc/cpuinfo
Date: Wed, 18 Apr 2018 16:49:30 +0800
Message-ID: <000101d3d6f2$2a82ef10$7f88cd30$@zhaoxin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdPW8Vv/AOehcyEeSUi9LI0aEieWNA==
Content-Language: zh-cn
X-Originating-IP: [10.29.8.18]
X-ClientProxiedBy: zxbjmbx1.zhaoxin.com (10.29.252.163) To
 zxbjmbx3.zhaoxin.com (10.29.252.165)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Mail-----
> Sender: Thomas Gleixner [mailto:tglx@linutronix.de]
> Time: 2018/4/17 18:19
> Receiver: David Wang <davidwang@zhaoxin.com>
> CC: mingo@redhat.com; hpa@zytor.com; mingo@kernel.org;
> grehkg@linuxfoundation.org; x86@kernel.org; linux-
> kernel@vger.kernel.org; brucechang@via-alliance.com;
> cooperyan@zhaoxin.com; qiyuanwang@zhaoxin.com;
> benjaminpan@viatech.com; lukelin@viacpu.com; timguo@zhaoxin.com
> Subject: Re: [PATCH] x86/Centaur: show more HW features in /proc/cpuinfo
> 
> On Sun, 8 Apr 2018, David Wang wrote:
> 
> > We add this patch to show correct HW features(arch_perfmon,
> > tpr_shadow, vnmi, flexpriority, ept and vpid) when user execute "cat
> /proc/cpuinfo".
> 
> See the other mail vs. the changelog.
>

 
OK. Thanks.

> >
> > Signed-off-by: David Wang <davidwang@zhaoxin.com>
> > ---
> >  arch/x86/kernel/cpu/centaur.c | 49
> > +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 49 insertions(+)
> >
> > diff --git a/arch/x86/kernel/cpu/centaur.c
> > b/arch/x86/kernel/cpu/centaur.c index e5ec0f1..969fb8f 100644
> > --- a/arch/x86/kernel/cpu/centaur.c
> > +++ b/arch/x86/kernel/cpu/centaur.c
> > @@ -112,6 +112,44 @@ static void early_init_centaur(struct cpuinfo_x86
> *c)
> >  	}
> >  }
> >
> > +static void centaur_detect_vmx_virtcap(struct cpuinfo_x86 *c) {
> > +#define X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW	0x00200000
> > +#define X86_VMX_FEATURE_PROC_CTLS_VNMI		0x00400000
> > +#define X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS	0x80000000
> > +#define X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC	0x00000001
> > +#define X86_VMX_FEATURE_PROC_CTLS2_EPT		0x00000002
> > +#define X86_VMX_FEATURE_PROC_CTLS2_VPID		0x00000020
> 
> Please move the defines outside the function. This is horrible to read,

OK.

> 
> > +
> > +	u32 vmx_msr_low, vmx_msr_high, msr_ctl, msr_ctl2;
> > +
> > +	clear_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
> > +	clear_cpu_cap(c, X86_FEATURE_VNMI);
> > +	clear_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
> > +	clear_cpu_cap(c, X86_FEATURE_EPT);
> > +	clear_cpu_cap(c, X86_FEATURE_VPID);
> 
> Why are you clearing the capabilities? They are cleared at boot time.
> 

OK. It's really useless. 

> > +	rdmsr(MSR_IA32_VMX_PROCBASED_CTLS, vmx_msr_low,
> vmx_msr_high);
> > +	msr_ctl = vmx_msr_high | vmx_msr_low;
> > +
> > +	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW)
> > +		set_cpu_cap(c, X86_FEATURE_TPR_SHADOW);
> > +	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_VNMI)
> > +		set_cpu_cap(c, X86_FEATURE_VNMI);
> > +	if (msr_ctl & X86_VMX_FEATURE_PROC_CTLS_2ND_CTLS) {
> > +		rdmsr(MSR_IA32_VMX_PROCBASED_CTLS2,
> > +		      vmx_msr_low, vmx_msr_high);
> > +		msr_ctl2 = vmx_msr_high | vmx_msr_low;
> > +		if ((msr_ctl2 &
> X86_VMX_FEATURE_PROC_CTLS2_VIRT_APIC) &&
> > +		    (msr_ctl &
> X86_VMX_FEATURE_PROC_CTLS_TPR_SHADOW))
> > +			set_cpu_cap(c, X86_FEATURE_FLEXPRIORITY);
> > +		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_EPT)
> > +			set_cpu_cap(c, X86_FEATURE_EPT);
> > +		if (msr_ctl2 & X86_VMX_FEATURE_PROC_CTLS2_VPID)
> > +			set_cpu_cap(c, X86_FEATURE_VPID);
> > +	}
> > +}
> > +
> >  static void init_centaur(struct cpuinfo_x86 *c)  {  #ifdef
> > CONFIG_X86_32 @@ -128,6 +166,14 @@ static void init_centaur(struct
> > cpuinfo_x86 *c)
> >  	clear_cpu_cap(c, 0*32+31);
> >  #endif
> >  	early_init_centaur(c);
> > +
> > +	if (c->cpuid_level > 9) {
> > +		unsigned eax = cpuid_eax(10);
> 
> Missing newline between variable declaration and code. checkpatch.pl
> should have told you that.
> 

OK. 

> > +		/* Check for version and the number of counters */
> > +		if ((eax & 0xff) && (((eax >> 8) & 0xff) > 1))
> 
> Magic constants and a comment which does not explain how the check
> works.
> 

OK. I will explain more detail in the comments.

> > +			set_cpu_cap(c, X86_FEATURE_ARCH_PERFMON);
> 
> Thanks,
> 
> 	tglx

Thanks,

---
David
