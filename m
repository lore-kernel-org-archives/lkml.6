Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752092AbeBHMgf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 07:36:35 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:34395 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeBHMgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 07:36:32 -0500
X-IronPort-AV: E=Sophos;i="5.46,478,1511827200";
   d="scan'208";a="718755655"
From: "Sironi, Filippo" <sironi@amazon.de>
To: David Woodhouse <dwmw2@infradead.org>
CC: "tglx@linutronix.de" <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "x86@kernel.org" <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, Peter Zijlstra <peterz@infradead.org>,
        "tim.c.chen@linux.intel.com" <tim.c.chen@linux.intel.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "arjan.van.de.ven@intel.com" <arjan.van.de.ven@intel.com>,
        KVM list <kvm@vger.kernel.org>
Subject: Re: [Fwd: [RFC PATCH 2/4] KVM: x86: Reduce retpoline performance
 impact in slot_handle_level_range()]
Thread-Topic: [Fwd: [RFC PATCH 2/4] KVM: x86: Reduce retpoline performance
 impact in slot_handle_level_range()]
Thread-Index: AQHToNb3bSxUHhkeYk6zvWFKRQTOqqOabtwA
Date: Thu, 8 Feb 2018 12:28:05 +0000
Message-ID: <9305C305-6BDD-4A1B-873E-35161C254AAB@amazon.de>
References: <1517961794-14972-3-git-send-email-dwmw@amazon.co.uk>
 <1518092274.3677.177.camel@infradead.org>
In-Reply-To: <1518092274.3677.177.camel@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.165.16]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D03EF90D3FB44747BB662BA83753C10E@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w18CagYO001527


> On 8. Feb 2018, at 13:17, David Woodhouse <dwmw2@infradead.org> wrote:
> 
> 
> From: David Woodhouse <dwmw@amazon.co.uk>
> Subject: [RFC PATCH 2/4] KVM: x86: Reduce retpoline performance impact in slot_handle_level_range()
> Date: 7. February 2018 at 01:03:12 GMT+1
> To: tglx@linutronix.de, torvalds@linux-foundation.org, x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org, tim.c.chen@linux.intel.com, dave.hansen@intel.com, arjan.van.de.ven@intel.com
> 
> 
> With retpoline, tight loops of "call this function for every XXX" are
> very much pessimised by taking a prediction miss *every* time. This one
> showed up very high in our early testing.
> 
> By marking the iterator slot_handle_…() functions always_inline, we can
> ensure that the indirect function call can be optimised away into a
> direct call and it actually generates slightly smaller code because
> some of the other conditionals can get optimised away too.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> arch/x86/kvm/mmu.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index 2b8eb4d..cc83bdc 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -5058,7 +5058,7 @@ void kvm_mmu_uninit_vm(struct kvm *kvm)
> typedef bool (*slot_level_handler) (struct kvm *kvm, struct kvm_rmap_head *rmap_head);
> 
> /* The caller should hold mmu-lock before calling this function. */
> -static bool
> +static __always_inline bool
> slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
> 			slot_level_handler fn, int start_level, int end_level,
> 			gfn_t start_gfn, gfn_t end_gfn, bool lock_flush_tlb)
> @@ -5088,7 +5088,7 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
> 	return flush;
> }
> 
> -static bool
> +static __always_inline bool
> slot_handle_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
> 		  slot_level_handler fn, int start_level, int end_level,
> 		  bool lock_flush_tlb)
> @@ -5099,7 +5099,7 @@ slot_handle_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
> 			lock_flush_tlb);
> }
> 
> -static bool
> +static __always_inline bool
> slot_handle_all_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
> 		      slot_level_handler fn, bool lock_flush_tlb)
> {
> @@ -5107,7 +5107,7 @@ slot_handle_all_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
> 				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb);
> }
> 
> -static bool
> +static __always_inline bool
> slot_handle_large_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
> 			slot_level_handler fn, bool lock_flush_tlb)
> {
> @@ -5115,7 +5115,7 @@ slot_handle_large_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
> 				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb);
> }
> 
> -static bool
> +static __always_inline bool
> slot_handle_leaf(struct kvm *kvm, struct kvm_memory_slot *memslot,
> 		 slot_level_handler fn, bool lock_flush_tlb)
> {
> -- 
> 2.7.4

+kvm@vger.kernel.org

With this patch, launches of "large instances" are pretty close to what we see with
nospectre_v2 (within tens of milliseconds).

Reviewed-by: Filippo Sironi <sironi@amazon.de>
Tested-by: Filippo Sironi <sironi@amazon.de>

Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
