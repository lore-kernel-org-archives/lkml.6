Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbeEVPmR (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 11:42:17 -0400
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:56364 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeEVPmQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 11:42:16 -0400
X-IronPort-AV: E=Sophos;i="5.49,430,1520899200";
   d="scan'208";a="742232522"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "rkrcmar@redhat.com" <rkrcmar@redhat.com>
Subject: Re: [PATCH] KVM: Switch 'requests' to be 64-bit (explicitly)
Thread-Topic: [PATCH] KVM: Switch 'requests' to be 64-bit (explicitly)
Thread-Index: AQHT1D++Gdqnz/tFy0K4EdrtXKZQKaQDl3kAgDiG6QA=
Date: Tue, 22 May 2018 15:42:08 +0000
Message-ID: <1527003728.13207.55.camel@amazon.de>
References: <1523744804-8220-1-git-send-email-karahmed@amazon.de>
         <53700469-74f0-f3b0-96a4-d8ace2919b36@redhat.com>
In-Reply-To: <53700469-74f0-f3b0-96a4-d8ace2919b36@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7F024E4BA91BD94EAA6E79E996156847@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4MFgN7b011966

On Mon, 2018-04-16 at 18:28 +0200, Paolo Bonzini wrote:
> On 15/04/2018 00:26, KarimAllah Ahmed wrote:
> > 
> > Switch 'requests' to be explicitly 64-bit and update BUILD_BUG_ON check to
> > use the size of "requests" instead of the hard-coded '32'.
> > 
> > That gives us a bit more room again for arch-specific requests as we
> > already ran out of space for x86 due to the hard-coded check.
> > 
> > Cc: Paolo Bonzini <pbonzini@redhat.com>
> > Cc: Radim Krčmář <rkrcmar@redhat.com>
> > Cc: kvm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> 
> I'm afraid architectures like ARM 32 need this to be conditional (using
> Kconfig).

Why would using a 64-bit 'requests' be a problem for ARM32? Are you 
concerned about performance here or is there some symantic problem?

> 
> Thanks,
> 
> Paolo
> 
> > 
> > ---
> >  include/linux/kvm_host.h | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
> > index 6930c63..fe4f46b 100644
> > --- a/include/linux/kvm_host.h
> > +++ b/include/linux/kvm_host.h
> > @@ -129,7 +129,7 @@ static inline bool is_error_page(struct page *page)
> >  #define KVM_REQUEST_ARCH_BASE     8
> >  
> >  #define KVM_ARCH_REQ_FLAGS(nr, flags) ({ \
> > -	BUILD_BUG_ON((unsigned)(nr) >= 32 - KVM_REQUEST_ARCH_BASE); \
> > +	BUILD_BUG_ON((unsigned)(nr) >= (sizeof(((struct kvm_vcpu *)0)->requests) * 8) - KVM_REQUEST_ARCH_BASE); \
> >  	(unsigned)(((nr) + KVM_REQUEST_ARCH_BASE) | (flags)); \
> >  })
> >  #define KVM_ARCH_REQ(nr)           KVM_ARCH_REQ_FLAGS(nr, 0)
> > @@ -223,7 +223,7 @@ struct kvm_vcpu {
> >  	int vcpu_id;
> >  	int srcu_idx;
> >  	int mode;
> > -	unsigned long requests;
> > +	u64 requests;
> >  	unsigned long guest_debug;
> >  
> >  	int pre_pcpu;
> > @@ -1122,7 +1122,7 @@ static inline void kvm_make_request(int req, struct kvm_vcpu *vcpu)
> >  	 * caller.  Paired with the smp_mb__after_atomic in kvm_check_request.
> >  	 */
> >  	smp_wmb();
> > -	set_bit(req & KVM_REQUEST_MASK, &vcpu->requests);
> > +	set_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);
> >  }
> >  
> >  static inline bool kvm_request_pending(struct kvm_vcpu *vcpu)
> > @@ -1132,12 +1132,12 @@ static inline bool kvm_request_pending(struct kvm_vcpu *vcpu)
> >  
> >  static inline bool kvm_test_request(int req, struct kvm_vcpu *vcpu)
> >  {
> > -	return test_bit(req & KVM_REQUEST_MASK, &vcpu->requests);
> > +	return test_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);
> >  }
> >  
> >  static inline void kvm_clear_request(int req, struct kvm_vcpu *vcpu)
> >  {
> > -	clear_bit(req & KVM_REQUEST_MASK, &vcpu->requests);
> > +	clear_bit(req & KVM_REQUEST_MASK, (void *)&vcpu->requests);
> >  }
> >  
> >  static inline bool kvm_check_request(int req, struct kvm_vcpu *vcpu)
> > 
> 
> 
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
