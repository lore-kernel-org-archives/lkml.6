Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932216AbeCDKSC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 05:18:02 -0500
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:59255 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbeCDKR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 05:17:59 -0500
X-IronPort-AV: E=Sophos;i="5.47,422,1515456000";
   d="scan'208";a="710330202"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [PATCH] X86/KVM: Update the exit_qualification access bits while
 walking an address
Thread-Topic: [PATCH] X86/KVM: Update the exit_qualification access bits while
 walking an address
Thread-Index: AQHTsL7uN8i8BkmWakqL1gIWWZ5a16O9OeOAgAKougA=
Date: Sun, 4 Mar 2018 10:17:53 +0000
Message-ID: <1520158672.28771.4.camel@amazon.de>
References: <1519841208-23349-1-git-send-email-karahmed@amazon.de>
         <d9c6c4f4-74f6-13b1-33ea-9423ff2efc8e@redhat.com>
In-Reply-To: <d9c6c4f4-74f6-13b1-33ea-9423ff2efc8e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.12]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F7718602AA63F4D85B38E0091319AEA@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w24AI7jv031991

On Fri, 2018-03-02 at 18:41 +0100, Paolo Bonzini wrote:
> On 28/02/2018 19:06, KarimAllah Ahmed wrote:
> > 
> > ... to avoid having a stale value when handling an EPT misconfig for MMIO
> > regions.
> > 
> > MMIO regions that are not passed-through to the guest are handled through
> > EPT misconfigs. The first time a certain MMIO page is touched it causes an
> > EPT violation, then KVM marks the EPT entry to cause an EPT misconfig
> > instead. Any subsequent accesses to the entry will generate an EPT
> > misconfig.
> > 
> > Things gets slightly complicated with nested guest handling for MMIO
> > regions that are not passed through from L0 (i.e. emulated by L0
> > user-space).
> > 
> > An EPT violation for one of these MMIO regions from L2, exits to L0
> > hypervisor. L0 would then look at the EPT12 mapping for L1 hypervisor and
> > realize it is not present (or not sufficient to serve the request). Then L0
> > injects an EPT violation to L1. L1 would then update its EPT mappings. The
> > EXIT_QUALIFICATION value for L1 would come from exit_qualification variable
> > in "struct vcpu". The problem is that this variable is only updated on EPT
> > violation and not on EPT misconfig. So if an EPT violation because of a
> > read happened first, then an EPT misconfig because of a write happened
> > afterwards. The L0 hypervisor will still contain exit_qualification value
> > from the previous read instead of the write and end up injecting an EPT
> > violation to the L1 hypervisor with an out of date EXIT_QUALIFICATION.
> > 
> > The EPT violation that is injected from L0 to L1 needs to have the correct
> > EXIT_QUALIFICATION specially for the access bits because the individual
> > access bits for MMIO EPTs are updated only on actual access of this
> > specific type. So for the example above, the L1 hypervisor will keep
> > updating only the read bit in the EPT then resume the L2 guest. The L2
> > guest would end up causing another exit where the L0 *again* will inject
> > another EPT violation to L1 hypervisor with *again* an out of date
> > exit_qualification which indicates a read and not a write. Then this
> > ping-pong just keeps happening without making any forward progress.
> > 
> > The behavior of mapping MMIO regions changed in:
> > 
> >    commit a340b3e229b24 ("kvm: Map PFN-type memory regions as writable (if possible)")
> > 
> > ... where an EPT violation for a read would also fixup the write bits to
> > avoid another EPT violation which by acciddent would fix the bug mentioned
> > above.
> > 
> > This commit fixes this situation and ensures that the access bits for the
> > exit_qualifcation is up to date. That ensures that even L1 hypervisor
> > running with a KVM version before the commit mentioned above would still
> > work.
> > 
> > ( The description above assumes EPT to be available and used by L1
> >   hypervisor + the L1 hypervisor is passing through the MMIO region to the L2
> >   guest while this MMIO region is emulated by the L0 user-space ).
> 
> This looks okay.  Would it be possible to add a kvm-unit-tests testcase
> for this?

Yup, makes sense. Just sent out a patch for kvm-unit-tests.

Thanks.

> 
> Thanks,
> 
> Paolo
> 
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Krčmář <rkrcmar@redhat.com>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ingo Molnar <mingo@redhat.com>
> > Cc: H. Peter Anvin <hpa@zytor.com>
> > Cc: x86@kernel.org
> > Cc: kvm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> > ---
> >  arch/x86/kvm/paging_tmpl.h | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/kvm/paging_tmpl.h b/arch/x86/kvm/paging_tmpl.h
> > index 5abae72..6288e9d 100644
> > --- a/arch/x86/kvm/paging_tmpl.h
> > +++ b/arch/x86/kvm/paging_tmpl.h
> > @@ -452,14 +452,21 @@ static int FNAME(walk_addr_generic)(struct guest_walker *walker,
> >  	 * done by is_rsvd_bits_set() above.
> >  	 *
> >  	 * We set up the value of exit_qualification to inject:
> > -	 * [2:0] - Derive from [2:0] of real exit_qualification at EPT violation
> > +	 * [2:0] - Derive from the access bits. The exit_qualification might be
> > +	 *         out of date if it is serving an EPT misconfiguration.
> >  	 * [5:3] - Calculated by the page walk of the guest EPT page tables
> >  	 * [7:8] - Derived from [7:8] of real exit_qualification
> >  	 *
> >  	 * The other bits are set to 0.
> >  	 */
> >  	if (!(errcode & PFERR_RSVD_MASK)) {
> > -		vcpu->arch.exit_qualification &= 0x187;
> > +		vcpu->arch.exit_qualification &= 0x180;
> > +		if (write_fault)
> > +			vcpu->arch.exit_qualification |= EPT_VIOLATION_ACC_WRITE;
> > +		if (user_fault)
> > +			vcpu->arch.exit_qualification |= EPT_VIOLATION_ACC_READ;
> > +		if (fetch_fault)
> > +			vcpu->arch.exit_qualification |= EPT_VIOLATION_ACC_INSTR;
> >  		vcpu->arch.exit_qualification |= (pte_access & 0x7) << 3;
> >  	}
> >  #endif
> > 
> 
> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
