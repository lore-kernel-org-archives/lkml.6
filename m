Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751102AbeCHU4B (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 15:56:01 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38782 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750896AbeCHU4A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 15:56:00 -0500
Date: Thu, 8 Mar 2018 21:55:19 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Wanpeng Li <kernellwp@gmail.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/3] KVM: X86: Provides userspace with a capability to
 not intercept MWAIT
Message-ID: <20180308205519.GM12290@flask>
References: <1519897782-8124-1-git-send-email-wanpengli@tencent.com>
 <20180308203132.GJ12290@flask>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180308203132.GJ12290@flask>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-08 21:31+0100, Radim Krčmář:
> 2018-03-01 17:49+0800, Wanpeng Li:
> > @@ -264,10 +262,12 @@ static inline u64 nsec_to_cycles(struct kvm_vcpu *vcpu, u64 nsec)
> >  	    __rem;						\
> >  	 })
> >  
> > -static inline bool kvm_mwait_in_guest(void)
> > +#define KVM_X86_DISABLE_EXITS_MWAIT          (1 << 0)
> > +#define KVM_X86_DISABLE_VALID_EXITS          (KVM_X86_DISABLE_EXITS_MWAIT)
> > +
> > +static inline bool kvm_mwait_in_guest(struct kvm *kvm)
> >  {
> > -	return boot_cpu_has(X86_FEATURE_MWAIT) &&
> > -		!boot_cpu_has_bug(X86_BUG_MONITOR);
> > +	return kvm->arch.mwait_in_guest;
> 
> With this nice variable, the wrapper actually makes the code harder to
> read.  Please use kvm->arch.mwait_in_guest directly (and the same for
> the other two future exits),

I take that back.  kvm->arch.mwait_in_guest looks ok, but it would be
vmx->vcpu.kvm->arch.mwait_in_guest elsewhere and that is just too bad.
