Return-Path: <SRS0=t/yM=Q5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4E9BC43381
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:30:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2FBA9206B6
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 00:30:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbfBVAau (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 19:30:50 -0500
Received: from mga18.intel.com ([134.134.136.126]:32615 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726298AbfBVAau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 19:30:50 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Feb 2019 16:30:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,397,1544515200"; 
   d="scan'208";a="276915325"
Received: from sjchrist-coffee.jf.intel.com (HELO linux.intel.com) ([10.54.74.181])
  by orsmga004.jf.intel.com with ESMTP; 21 Feb 2019 16:30:49 -0800
Date:   Thu, 21 Feb 2019 16:30:49 -0800
From:   Sean Christopherson <sean.j.christopherson@intel.com>
To:     Joao Martins <joao.m.martins@oracle.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ankur Arora <ankur.a.arora@oracle.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH RFC 02/39] KVM: x86/xen: intercept xen hypercalls if
 enabled
Message-ID: <20190222003049.GF7224@linux.intel.com>
References: <20190220201609.28290-1-joao.m.martins@oracle.com>
 <20190220201609.28290-3-joao.m.martins@oracle.com>
 <20190221182910.GC7224@linux.intel.com>
 <1f6a2410-f9da-15ed-327c-7d8c1255368b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f6a2410-f9da-15ed-327c-7d8c1255368b@oracle.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2019 at 08:56:06PM +0000, Joao Martins wrote:
> On 2/21/19 6:29 PM, Sean Christopherson wrote:
> > On Wed, Feb 20, 2019 at 08:15:32PM +0000, Joao Martins wrote:
> >> Add a new exit reason for emulator to handle Xen hypercalls.
> >> Albeit these are injected only if guest has initialized the Xen
> >> hypercall page - the hypercall is just a convenience but one
> >> that is done by pretty much all guests. Hence if the guest
> >> sets the hypercall page, we assume a Xen guest is going to
> >> be set up.
> >>
> >> Emulator will then panic with:
> >>
> >> KVM: unknown exit reason 28
> >> RAX=0000000000000011 RBX=ffffffff81e03e94 RCX=0000000040000000
> >> RDX=0000000000000000
> >> RSI=ffffffff81e03e70 RDI=0000000000000006 RBP=ffffffff81e03e90
> >> RSP=ffffffff81e03e68
> >> R8 =73726576206e6558 R9 =ffffffff81e03e90 R10=ffffffff81e03e94
> >> R11=2e362e34206e6f69
> >> R12=0000000040000004 R13=ffffffff81e03e8c R14=ffffffff81e03e88
> >> R15=0000000000000000
> >> RIP=ffffffff81001228 RFL=00000082 [--S----] CPL=0 II=0 A20=1 SMM=0 HLT=0
> >> ES =0000 0000000000000000 ffffffff 00c00000
> >> CS =0010 0000000000000000 ffffffff 00a09b00 DPL=0 CS64 [-RA]
> >> SS =0000 0000000000000000 ffffffff 00c00000
> >> DS =0000 0000000000000000 ffffffff 00c00000
> >> FS =0000 0000000000000000 ffffffff 00c00000
> >> GS =0000 ffffffff81f34000 ffffffff 00c00000
> >> LDT=0000 0000000000000000 ffffffff 00c00000
> >> TR =0020 0000000000000000 00000fff 00808b00 DPL=0 TSS64-busy
> >> GDT=     ffffffff81f3c000 0000007f
> >> IDT=     ffffffff83265000 00000fff
> >> CR0=80050033 CR2=ffff880001fa6ff8 CR3=0000000001fa6000 CR4=000406a0
> >> DR0=0000000000000000 DR1=0000000000000000 DR2=0000000000000000
> >> DR3=0000000000000000
> >> DR6=00000000ffff0ff0 DR7=0000000000000400
> >> EFER=0000000000000d01
> >> Code=cc cc cc cc cc cc cc cc cc cc cc cc b8 11 00 00 00 0f 01 c1 <c3> cc
> >> cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc cc b8 12
> >> 00 00 00 0f
> >>
> >> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> >> ---
> >>  arch/x86/include/asm/kvm_host.h | 13 +++++++
> >>  arch/x86/kvm/Makefile           |  2 +-
> >>  arch/x86/kvm/trace.h            | 33 +++++++++++++++++
> >>  arch/x86/kvm/x86.c              | 12 +++++++
> >>  arch/x86/kvm/xen.c              | 79 +++++++++++++++++++++++++++++++++++++++++
> >>  arch/x86/kvm/xen.h              | 10 ++++++
> >>  include/uapi/linux/kvm.h        | 17 ++++++++-
> >>  7 files changed, 164 insertions(+), 2 deletions(-)
> >>  create mode 100644 arch/x86/kvm/xen.c
> >>  create mode 100644 arch/x86/kvm/xen.h
> > 
> > ...
> > 
> >> diff --git a/arch/x86/kvm/Makefile b/arch/x86/kvm/Makefile
> >> index 31ecf7a76d5a..2b46c93c9380 100644
> >> --- a/arch/x86/kvm/Makefile
> >> +++ b/arch/x86/kvm/Makefile
> >> @@ -10,7 +10,7 @@ kvm-$(CONFIG_KVM_ASYNC_PF)	+= $(KVM)/async_pf.o
> >>  
> >>  kvm-y			+= x86.o mmu.o emulate.o i8259.o irq.o lapic.o \
> >>  			   i8254.o ioapic.o irq_comm.o cpuid.o pmu.o mtrr.o \
> >> -			   hyperv.o page_track.o debugfs.o
> >> +			   hyperv.o xen.o page_track.o debugfs.o
> > 
> > Can this be wrapped in a config?  Or even better, as a loadable module?
> 
> Turning that into a loadable module might be a little trickier, but I think it
> is doable if that's what folks/maintainers would prefer.
> 
> The Xen addition follows the same structure as Hyper-V in kvm (what you suggest
> here is probably applicable for both). i.e. there's some Xen specific routines
> for vm/vcpu init/teardown, and timer handling. We would have to place some of
> those functions into a struct that gets registered at modinit.

Huh.  I never really hooked at the Hyper-V code, for some reason I always
assumed it was only related to running KVM on Hyper-V.  I agree that this
extra hurdle only makes sense if it's also applied to Hyper-V.
