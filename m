Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752007AbeBVC4M (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 21:56:12 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:49844 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751810AbeBVC4K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 21:56:10 -0500
X-IronPort-AV: E=Sophos;i="5.47,376,1515456000";
   d="scan'208";a="720988724"
From: "Raslan, KarimAllah" <karahmed@amazon.de>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
CC: "hpa@zytor.com" <hpa@zytor.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>
Subject: Re: [PATCH 08/10] KVM/X86: Use kvm_vcpu_map in
 emulator_cmpxchg_emulated
Thread-Topic: [PATCH 08/10] KVM/X86: Use kvm_vcpu_map in
 emulator_cmpxchg_emulated
Thread-Index: AQHTqzwV5FLsBskogUij6sW8WWG+qaOvuuSA
Date: Thu, 22 Feb 2018 02:56:05 +0000
Message-ID: <1519268165.24247.40.camel@amazon.de>
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
         <1519235241-6500-9-git-send-email-karahmed@amazon.de>
In-Reply-To: <1519235241-6500-9-git-send-email-karahmed@amazon.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.101]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B568B4929A50BF4A911B44C3C220DB8D@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w1M2uGpi013253

On Wed, 2018-02-21 at 18:47 +0100, KarimAllah Ahmed wrote:
> ... since using kvm_vcpu_gpa_to_page() and kmap() will only work for guest
> memory that has a "struct page".
> 
> Signed-off-by: KarimAllah Ahmed <karahmed@amazon.de>
> ---
>  arch/x86/kvm/x86.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 37f5df9..197a395 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -5013,9 +5013,9 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
>  				     unsigned int bytes,
>  				     struct x86_exception *exception)
>  {
> +	struct kvm_host_map map;

"map" here needs to be memset to '0'. Will fix in v2

>  	struct kvm_vcpu *vcpu = emul_to_vcpu(ctxt);
>  	gpa_t gpa;
> -	struct page *page;
>  	char *kaddr;
>  	bool exchanged;
>  
> @@ -5032,12 +5032,11 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
>  	if (((gpa + bytes - 1) & PAGE_MASK) != (gpa & PAGE_MASK))
>  		goto emul_write;
>  
> -	page = kvm_vcpu_gfn_to_page(vcpu, gpa >> PAGE_SHIFT);
> -	if (is_error_page(page))
> +	if (!kvm_vcpu_map(vcpu, gpa_to_gfn(gpa), &map))
>  		goto emul_write;
>  
> -	kaddr = kmap_atomic(page);
> -	kaddr += offset_in_page(gpa);
> +	kaddr = map.kaddr + offset_in_page(gpa);
> +
>  	switch (bytes) {
>  	case 1:
>  		exchanged = CMPXCHG_TYPE(u8, kaddr, old, new);
> @@ -5054,8 +5053,8 @@ static int emulator_cmpxchg_emulated(struct x86_emulate_ctxt *ctxt,
>  	default:
>  		BUG();
>  	}
> -	kunmap_atomic(kaddr);
> -	kvm_release_page_dirty(page);
> +
> +	kvm_vcpu_unmap(&map);
>  
>  	if (!exchanged)
>  		return X86EMUL_CMPXCHG_FAILED;
Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
