Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751379AbeFDUVK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 16:21:10 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:37416 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751058AbeFDUVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 16:21:07 -0400
Date: Mon, 4 Jun 2018 16:20:24 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Tom Lendacky <thomas.lendacky@amd.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, x86@kernel.org,
        tglx@linutronix.de, andrew.cooper3@citrix.com,
        Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Joerg Roedel <joro@8bytes.org>, Borislav Petkov <bp@suse.de>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Janakarajan Natarajan <Janakarajan.Natarajan@amd.com>,
        Kees Cook <keescook@chromium.org>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH v1 2/3] x86/bugs: Add AMD's SPEC_CTRL MSR usage
Message-ID: <20180604202024.GF5867@char.us.oracle.com>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
 <20180601145921.9500-3-konrad.wilk@oracle.com>
 <fa831d0c-3e7b-b5ab-17a0-5d3b1bfd6142@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fa831d0c-3e7b-b5ab-17a0-5d3b1bfd6142@amd.com>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8914 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806040233
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
> > index 26110c202b19..950ec50f77c3 100644
> > --- a/arch/x86/kvm/svm.c
> > +++ b/arch/x86/kvm/svm.c
> > @@ -4115,7 +4115,8 @@ static int svm_get_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> >  		break;
> >  	case MSR_IA32_SPEC_CTRL:
> >  		if (!msr_info->host_initiated &&
> > -		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS))
> > +		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) &&
> > +		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))
> 
> Shouldn't the IBRS/SSBD check be an "or" check?  I don't think it's
> necessarily true that IBRS and SSBD have to both be set.  Maybe something
> like:
> 
> 	if (!msr_info->host_initiated &&
> 	    !(guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) ||
> 	      guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))
> 
> Does that make sense?

The '!' on each of the CPUID and '&&' make this the same. See:


 AMD_IBRS set	|  AMD_SSBD set	| !AMD_IBRS && !AMD_SSBD | !(AMD_IBRS || AMD_SSBD)
	0	|	0	| 1 && 1 -> return 1	 | !(0) -> 1 -> return 1
	1	|	0	| 0 && 1, continue	 | !(1 || 0) -> continue
	1	|	1	| 0 && 0, continue	 | !(1 || 1) -> continue
	0	|	1	| 1 && 0, continue	 | !(0 || 1) -> continue

Meaning we will return 1 if:
 the host has not initiator it or,
 the guest CPUID does not have AMD_IBRS flag or,
 the guest CPUID does not have AMD SSBD flag

I am fine modifying it the way you had in mind, but in the past the logic
was to use ! and &&, hence stuck to that.
> 
> >  			return 1;
> >  
> >  		msr_info->data = svm->spec_ctrl;
> > @@ -4217,11 +4218,12 @@ static int svm_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr)
> >  		break;
> >  	case MSR_IA32_SPEC_CTRL:
> >  		if (!msr->host_initiated &&
> > -		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS))
> > +		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_IBRS) &&
> > +		    !guest_cpuid_has(vcpu, X86_FEATURE_AMD_SSBD))
> 
> Same question as above.
> 
> Thanks,
> Tom
> 
> >  			return 1;
> >  
> >  		/* The STIBP bit doesn't fault even if it's not advertised */
> > -		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP))
> > +		if (data & ~(SPEC_CTRL_IBRS | SPEC_CTRL_STIBP | SPEC_CTRL_SSBD))
> >  			return 1;
> >  
> >  		svm->spec_ctrl = data;
> > 
