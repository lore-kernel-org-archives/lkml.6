Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbeDNDL2 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 23:11:28 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:21620 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeDNDL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 23:11:26 -0400
X-IronPort-AV: E=Sophos;i="5.48,447,1517875200";
   d="scan'208";a="715907173"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "jmattson@google.com" <jmattson@google.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH 1/2] X86/KVM: Properly update 'tsc_offset' to represent
 the running guest
Thread-Topic: [PATCH 1/2] X86/KVM: Properly update 'tsc_offset' to represent
 the running guest
Thread-Index: AQHT0xnevTdOwUAGJkSIwmf/lTD+y6P+25QAgAAAaQCAALpSAA==
Date: Sat, 14 Apr 2018 03:11:18 +0000
Message-ID: <1523675478.32594.67.camel@amazon.de>
References: <1523618608-30574-1-git-send-email-pbonzini@redhat.com>
         <1523618608-30574-2-git-send-email-pbonzini@redhat.com>
         <CALMp9eSj=mNQbMzyBNQQWPPsijrrjmTFA9A=H-7KEwbfDqZz2A@mail.gmail.com>
         <46376fd5-5652-359b-0bdc-6408de33f00f@redhat.com>
In-Reply-To: <46376fd5-5652-359b-0bdc-6408de33f00f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D9AF314244392043BE10C3AEF37FAECC@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3E3BW6i013332

On Fri, 2018-04-13 at 18:04 +0200, Paolo Bonzini wrote:
> On 13/04/2018 18:02, Jim Mattson wrote:
> > 
> > On Fri, Apr 13, 2018 at 4:23 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > 
> > > From: KarimAllah Ahmed <karahmed@amazon.de>
> > > 
> > > Update 'tsc_offset' on vmenty/vmexit of L2 guests to ensure that it always
> > > captures the TSC_OFFSET of the running guest whether it is the L1 or L2
> > > guest.
> > > 
> > > Cc: Jim Mattson <jmattson@google.com>
> > > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > > Cc: Radim Krčmář <rkrcmar@redhat.com>
> > > Cc: kvm@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org
> > > Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> > > Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> > > [AMD changes, fix update_ia32_tsc_adjust_msr. - Paolo]
> > > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> > 
> > > 
> > > @@ -11489,6 +11497,9 @@ static int nested_vmx_run(struct kvm_vcpu *vcpu, bool launch)
> > >         if (enable_shadow_vmcs)
> > >                 copy_shadow_to_vmcs12(vmx);
> > > 
> > > +       if (vmcs12->cpu_based_vm_exec_control & CPU_BASED_USE_TSC_OFFSETING)
> > > +               vcpu->arch.tsc_offset += vmcs12->tsc_offset;
> > > +
> > 
> > This seems a little early, since we don't restore the L1 TSC offset on
> > the nested_vmx_failValid path.
> > 
> 
> Now this can be a nice one to introduce the VMX API tests. :)  I'll try
> to do it on Monday as punishment for not noticing the bug.  In the
> meanwhile, Karim, can you post a fixed fixed version?

done

> 
> Paolo
> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
