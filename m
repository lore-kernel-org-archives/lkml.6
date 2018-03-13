Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752475AbeCMTNa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 15:13:30 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57548 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752000AbeCMTN2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 15:13:28 -0400
Date: Tue, 13 Mar 2018 20:12:42 +0100
From: Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, kvm@vger.kernel.org,
        x86@kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Michael Kelley (EOSG)" <Michael.H.Kelley@microsoft.com>,
        Mohammed Gamal <mmorsy@redhat.com>, Cathy Avery <cavery@redhat.com>,
        Bandan Das <bsd@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/7] x86/kvm: use Enlightened VMCS when running on
 Hyper-V
Message-ID: <20180313191242.GB13426@flask>
References: <20180309140249.2840-1-vkuznets@redhat.com>
 <20180309140249.2840-8-vkuznets@redhat.com>
 <alpine.DEB.2.21.1803091507300.1364@nanos.tec.linutronix.de>
 <87r2opcr6u.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r2opcr6u.fsf@vitty.brq.redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-03-12 15:19+0100, Vitaly Kuznetsov:
> Thomas Gleixner <tglx@linutronix.de> writes:
> 
> > On Fri, 9 Mar 2018, Vitaly Kuznetsov wrote:
> >
> >> Enlightened VMCS is just a structure in memory, the main benefit
> >> besides avoiding somewhat slower VMREAD/VMWRITE is using clean field
> >> mask: we tell the underlying hypervisor which fields were modified
> >> since VMEXIT so there's no need to inspect them all.
> >> 
> >> Tight CPUID loop test shows significant speedup:
> >> Before: 18890 cycles
> >> After: 8304 cycles
> >> 
> >> Static key is being used to avoid performance penalty for non-Hyper-V
> >> deployments. Tests show we add around 3 (three) CPU cycles on each
> >> VMEXIT (1077.5 cycles before, 1080.7 cycles after for the same CPUID
> >> loop on bare metal). We can probably avoid one test/jmp in vmx_vcpu_run()
> >> but I don't see a clean way to use static key in assembly.
> >
> > STATIC_JUMP_IF_TRUE, STATIC_JUMP_IF_FALSE are your friends.
> >
> 
> Thanks for the tip,
> 
> with a single kernel user of these APIs it was easy to miss :-)

Indeed, I had no idea.

> Unfortunately, these APIs are only present if HAVE_JUMP_LABEL and
> (afaiu) we still care about KVM on !HAVE_JUMP_LABEL builds. It would be
> nice if we can make them behave the same way static_branch_likely() and
> friends do: compile into something else when !HAVE_JUMP_LABEL so we can
> avoid nasty #ifdefs in C code.
> 
> That said I'd like to defer the question to KVM maintainers: Paolo,
> Radim, what would you like me to do? Use STATIC_JUMP_IF_TRUE/FALSE as
> they are, try to make them work for !HAVE_JUMP_LABEL and use them or
> maybe we can commit the series as-is and have it as a future
> optimization (e.g. when HAVE_JUMP_LABEL becomes mandatory)?

Please take a look into making a macro that uses STATIC_JUMP_IF_FALSE or
reads the value from provided static_key and does a test-jump, depending
on HAVE_JUMP_LABEL.
It doesn't need to be suited for general use, just something that moves
the ugliness away from vmx_vcpu_run.
(Although having it in jump_label.h would be great. I think the main
 obstacle is clobbering of flags.)

If it were still looking horrible, I'm ok with the series as-is,

thanks.
