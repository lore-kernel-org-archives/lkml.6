Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751349AbeDNGb4 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 14 Apr 2018 02:31:56 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:18123 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750912AbeDNGby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Apr 2018 02:31:54 -0400
X-IronPort-AV: E=Sophos;i="5.48,448,1517875200";
   d="scan'208";a="606851716"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "jmattson@google.com" <jmattson@google.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH 1/2] X86/KVM: Properly update 'tsc_offset' to represent
 the running guest
Thread-Topic: [PATCH 1/2] X86/KVM: Properly update 'tsc_offset' to represent
 the running guest
Thread-Index: AQHT0xnevTdOwUAGJkSIwmf/lTD+y6P+ovQAgAAw3gCAAPqCAA==
Date: Sat, 14 Apr 2018 06:31:48 +0000
Message-ID: <1523687508.32594.69.camel@amazon.de>
References: <1523618608-30574-1-git-send-email-pbonzini@redhat.com>
         <1523618608-30574-2-git-send-email-pbonzini@redhat.com>
         <1523623218.32594.51.camel@amazon.de>
         <6ae8f089-4c77-d1cb-b79f-ec414f39a8d0@redhat.com>
In-Reply-To: <6ae8f089-4c77-d1cb-b79f-ec414f39a8d0@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.76]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E53D21AA8EA4704689319B3387F552A6@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3E6Vwlv013618

On Fri, 2018-04-13 at 17:35 +0200, Paolo Bonzini wrote:
> On 13/04/2018 14:40, Raslan, KarimAllah wrote:
> > 
> > > 
> > >  
> > >  static void update_ia32_tsc_adjust_msr(struct kvm_vcpu *vcpu, s64 offset)
> > >  {
> > > -	u64 curr_offset = vcpu->arch.tsc_offset;
> > > +	u64 curr_offset = kvm_x86_ops->read_l1_tsc_offset(vcpu);
> > I might be missing something but is this really strictly needed or is
> > it really a bug?
> > 
> > I can see update_ia32_tsc_adjust_msr called from kvm_write_tsc only 
> > which is called from a) vmx_set_msr or b) kvm_arch_vcpu_postcreate.
> > The adjust_msr would only be called if !host_initiated. So only 
> > vmx_set_msr which is coming from an L1 write (or a restore but that
> > would not be !host_initiated). So the only that tsc_adjust is called is
> > !is_guest_mode.
> 
> It can also be called from guest mode if the MSR bitmap says there's no
> L1 vmexit for that MSR; that's what the testcases do.

Apparently I will never wrap my head around this nested stuff :D

> 
> Paolo
> 
> > 
> > > 
> > >  	vcpu->arch.ia32_tsc_adjust_msr += offset - curr_offset;
> 
> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
