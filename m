Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbeDLUYj (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 16:24:39 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:60995 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751972AbeDLUYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 16:24:37 -0400
X-IronPort-AV: E=Sophos;i="5.48,443,1517875200";
   d="scan'208";a="674598540"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "jmattson@google.com" <jmattson@google.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH 1/2] X86/KVM: Properly restore 'tsc_offset' when running
 an L2 guest
Thread-Topic: [PATCH 1/2] X86/KVM: Properly restore 'tsc_offset' when running
 an L2 guest
Thread-Index: AQHT0nC4lLvkNnIRDkiE27bl+IOiw6P9U6KAgAAIAICAAAS/AIAAMoWAgAAAwAA=
Date: Thu, 12 Apr 2018 20:24:32 +0000
Message-ID: <1523564672.32594.35.camel@amazon.de>
References: <1523545958-28059-1-git-send-email-karahmed@amazon.de>
         <d03d253a-d184-4c95-91b2-45e94659b9bd@redhat.com>
         <1523552643.32594.18.camel@amazon.de> <1523553662.32594.29.camel@amazon.de>
         <ca0e9ac3-1f7b-cefb-a0fe-cc8e6f938c6c@redhat.com>
In-Reply-To: <ca0e9ac3-1f7b-cefb-a0fe-cc8e6f938c6c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.166.193]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8E58071E0F9DF5459DBCAFB737A547D3@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3CKOhR0011417

On Thu, 2018-04-12 at 22:21 +0200, Paolo Bonzini wrote:
> On 12/04/2018 19:21, Raslan, KarimAllah wrote:
> > 
> > Now looking further at the code, it seems that everywhere in the code
> > tsc_offset is treated as the L01 TSC_OFFSET.
> > 
> > Like here:
> > 
> >         if (vmcs12->cpu_based_vm_exec_control &
> > CPU_BASED_USE_TSC_OFFSETING)
> >                 vmcs_write64(TSC_OFFSET,
> >                         vcpu->arch.tsc_offset + vmcs12->tsc_offset);
> > 
> > and here:
> > 
> >         vmcs_write64(TSC_OFFSET, vcpu->arch.tsc_offset);
> > 
> > and here:
> > 
> > u64 kvm_read_l1_tsc(struct kvm_vcpu *vcpu, u64 host_tsc)
> > {
> >         return vcpu->arch.tsc_offset + kvm_scale_tsc(vcpu, host_tsc);
> > }
> > EXPORT_SYMBOL_GPL(kvm_read_l1_tsc);
> > 
> > ... would not it be simpler and more inline with the current code to
> > just do what I did above + remove the "+ l1_tsc_offset" + probably
> > document tsc_offset ?
> 
> Problem is, I don't think it's correct. :)  A good start would be to try
> disabling MSR_IA32_TSC interception in KVM, prepare a kvm-unit-tests
> test that reads the MSR, and see if you get the host or guest TSC...

I actually just submitted a patch with your original suggestion
(I hope)  because I realized that adjust tsc was still using the wrong
tsc_offset anyway :)

> 
> Paolo
> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
