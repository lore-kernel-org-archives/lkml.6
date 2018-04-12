Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753072AbeDLV0I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:26:08 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:32226 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751661AbeDLV0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:26:06 -0400
X-IronPort-AV: E=Sophos;i="5.48,443,1517875200";
   d="scan'208";a="715760739"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>
Subject: Re: [PATCH 00/10] KVM/X86: Handle guest memory that does not have a
 struct page
Thread-Topic: [PATCH 00/10] KVM/X86: Handle guest memory that does not have a
 struct page
Thread-Index: AQHT0m7vtsChAc4WZ0u3uapn1RQJfaP9pNKA
Date: Thu, 12 Apr 2018 21:25:58 +0000
Message-ID: <1523568357.32594.42.camel@amazon.de>
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
         <cedf2ad3-43ef-c2ec-0455-4dc27842f71a@redhat.com>
In-Reply-To: <cedf2ad3-43ef-c2ec-0455-4dc27842f71a@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA907D8D13BC1848BB6DABB8A38D4CD9@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3CLQDvI016090

On Thu, 2018-04-12 at 16:59 +0200, Paolo Bonzini wrote:
> On 21/02/2018 18:47, KarimAllah Ahmed wrote:
> > 
> > For the most part, KVM can handle guest memory that does not have a struct
> > page (i.e. not directly managed by the kernel). However, There are a few places
> > in the code, specially in the nested code, that does not support that.
> > 
> > Patch 1, 2, and 3 avoid the mapping and unmapping all together and just
> > directly use kvm_guest_read and kvm_guest_write.
> > 
> > Patch 4 introduces a new guest mapping interface that encapsulate all the
> > bioler plate code that is needed to map and unmap guest memory. It also
> > supports guest memory without "struct page".
> > 
> > Patch 5, 6, 7, 8, 9, and 10 switch most of the offending code in VMX and hyperv
> > to use the new guest mapping API.
> > 
> > This patch series is the first set of fixes. Handling SVM and APIC-access page
> > will be handled in a different patch series.
> 
> I like the patches and the new API.  However, I'm a bit less convinced
> about the caching aspect; keeping a page pinned is not the nicest thing
> with respect (for example) to memory hot-unplug.
> 
> Since you're basically reinventing kmap_high, or alternatively
> (depending on your background) xc_map_foreign_pages, it's not surprising
> that memremap is slow.  How slow is it really (as seen e.g. with
> vmexit.flat running in L1, on EC2 compared to vanilla KVM)?

I have not actually compared EC2 vs vanilla but I compared between the 
version with cached vs no-cache (both in EC2 setup). The one that 
cached the mappings was an order of magnitude better. For example, 
booting an Ubuntu L2 guest with QEMU took around 10-13 seconds with 
this caching and it took over 5 minutes without the caching.

I will test with vanilla KVM and post the results.

> 
> Perhaps you can keep some kind of per-CPU cache of the last N remapped
> pfns?  This cache would sit between memremap and __kvm_map_gfn and it
> would be completely transparent to the layer below since it takes raw
> pfns.  This removes the need to store the memslots generation etc.  (If
> you go this way please place it in virt/kvm/pfncache.[ch], since
> kvm_main.c is already way too big).

Yup, that sounds like a good idea. I actually already implemented some 
sort of a per-CPU mapping pool in order to reduce the overhead when
the vCPU is over-committed. I will clean this and post as you
suggested.

> 
> Thanks,
> 
> Paolo
> 
> > 
> > KarimAllah Ahmed (10):
> >   X86/nVMX: handle_vmon: Read 4 bytes from guest memory instead of
> >     map->read->unmap sequence
> >   X86/nVMX: handle_vmptrld: Copy the VMCS12 directly from guest memory
> >     instead of map->copy->unmap sequence.
> >   X86/nVMX: Update the PML table without mapping and unmapping the page
> >   KVM: Introduce a new guest mapping API
> >   KVM/nVMX: Use kvm_vcpu_map when mapping the L1 MSR bitmap
> >   KVM/nVMX: Use kvm_vcpu_map when mapping the virtual APIC page
> >   KVM/nVMX: Use kvm_vcpu_map when mapping the posted interrupt
> >     descriptor table
> >   KVM/X86: Use kvm_vcpu_map in emulator_cmpxchg_emulated
> >   KVM/X86: hyperv: Use kvm_vcpu_map in synic_clear_sint_msg_pending
> >   KVM/X86: hyperv: Use kvm_vcpu_map in synic_deliver_msg
> > 
> >  arch/x86/kvm/hyperv.c    |  28 ++++-----
> >  arch/x86/kvm/vmx.c       | 144 +++++++++++++++--------------------------------
> >  arch/x86/kvm/x86.c       |  13 ++---
> >  include/linux/kvm_host.h |  15 +++++
> >  virt/kvm/kvm_main.c      |  50 ++++++++++++++++
> >  5 files changed, 129 insertions(+), 121 deletions(-)
> > 
> 
> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
