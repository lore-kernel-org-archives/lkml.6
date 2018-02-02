Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751916AbeBBPod (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 10:44:33 -0500
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:39690 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeBBPoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 10:44:13 -0500
X-IronPort-AV: E=Sophos;i="5.46,448,1511827200";
   d="scan'208";a="717895425"
From: "Sironi, Filippo" <sironi@amazon.de>
To: "Woodhouse, David" <dwmw@amazon.co.uk>
CC: "tglx@linutronix.de" <tglx@linutronix.de>,
        "Raslan, KarimAllah" <karahmed@amazon.de>,
        "x86@kernel.org" <x86@kernel.org>, KVM list <kvm@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "peterz@infradead.org" <peterz@infradead.org>
Subject: Re: [PATCH] KVM: x86: Reduce retpoline performance impact in
 slot_handle_level_range()
Thread-Topic: [PATCH] KVM: x86: Reduce retpoline performance impact in
 slot_handle_level_range()
Thread-Index: AQHTnDZtfMv+6qJwE06/n2K6yu3fBaORQJ2A
Date: Fri, 2 Feb 2018 15:43:07 +0000
Message-ID: <EED37F67-1A31-41C8-A7A3-CBCB946C2987@amazon.de>
References: <1517583559-424-1-git-send-email-dwmw@amazon.co.uk>
In-Reply-To: <1517583559-424-1-git-send-email-dwmw@amazon.co.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.111]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <6F56A181D246514F801480A3A9EABF05@amazon.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w12Fidbk020624


> On 2. Feb 2018, at 15:59, David Woodhouse <dwmw@amazon.co.uk> wrote:
> 
> With retpoline, tight loops of "call this function for every XXX" are
> very much pessimised by taking a prediction miss *every* time.
> 
> This one showed up very high in our early testing, and it only has five
> things it'll ever call so make it take an 'op' enum instead of a
> function pointer and let's see how that works out...
> 
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
> Not sure I like this. Better suggestions welcomed...
> 
> In the general case, we have a few things we can do with the calls that
> retpoline turns into bottlenecks. This is one of them.
> 
> Another option, if there are just one or two "likely" functions, is
> something along the lines of
> 
> if (func == likelyfunc)
>    likelyfunc()
> else
>    (*func)(); // GCC does retpoline for this
> 
> For things like kvm_x86_ops we really could just turn *all* of those
> into direct calls at runtime, like pvops does.
> 
> There are some which land somewhere in the middle, like the default
> dma_ops. We probably want something like the 'likelyfunc' version
> above, except that we *also* want to flip the likelyfunc between the
> Intel and AMD IOMMU ops functions, at early boot. I'll see what I can
> come up with...
> 
> arch/x86/kvm/mmu.c | 72 ++++++++++++++++++++++++++++++++++++------------------
> 1 file changed, 48 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
> index 2b8eb4d..44f9de7 100644
> --- a/arch/x86/kvm/mmu.c
> +++ b/arch/x86/kvm/mmu.c
> @@ -5055,12 +5055,21 @@ void kvm_mmu_uninit_vm(struct kvm *kvm)
> }
> 
> /* The return value indicates if tlb flush on all vcpus is needed. */
> -typedef bool (*slot_level_handler) (struct kvm *kvm, struct kvm_rmap_head *rmap_head);
> +enum slot_handler_op {
> +	SLOT_RMAP_CLEAR_DIRTY,
> +	SLOT_RMAP_SET_DIRTY,
> +	SLOT_RMAP_WRITE_PROTECT,
> +	SLOT_ZAP_RMAPP,
> +	SLOT_ZAP_COLLAPSIBLE_SPTE,
> +};
> +
> +static bool kvm_mmu_zap_collapsible_spte(struct kvm *kvm,
> +					 struct kvm_rmap_head *rmap_head);
> 
> /* The caller should hold mmu-lock before calling this function. */
> static bool
> slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
> -			slot_level_handler fn, int start_level, int end_level,
> +			enum slot_handler_op op, int start_level, int end_level,
> 			gfn_t start_gfn, gfn_t end_gfn, bool lock_flush_tlb)
> {
> 	struct slot_rmap_walk_iterator iterator;
> @@ -5068,8 +5077,29 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
> 
> 	for_each_slot_rmap_range(memslot, start_level, end_level, start_gfn,
> 			end_gfn, &iterator) {
> -		if (iterator.rmap)
> -			flush |= fn(kvm, iterator.rmap);
> +		if (iterator.rmap) {
> +			switch (op) {
> +			case SLOT_RMAP_CLEAR_DIRTY:
> +				flush |= __rmap_clear_dirty(kvm, iterator.rmap);
> +				break;
> +
> +			case SLOT_RMAP_SET_DIRTY:
> +				flush |= __rmap_set_dirty(kvm, iterator.rmap);
> +				break;
> +
> +			case SLOT_RMAP_WRITE_PROTECT:
> +				flush |= __rmap_write_protect(kvm, iterator.rmap, false);
> +				break;
> +
> +			case SLOT_ZAP_RMAPP:
> +				flush |= kvm_zap_rmapp(kvm, iterator.rmap);
> +				break;
> +
> +			case SLOT_ZAP_COLLAPSIBLE_SPTE:
> +				flush |= kvm_mmu_zap_collapsible_spte(kvm, iterator.rmap);
> +				break;
> +			}
> +		}
> 
> 		if (need_resched() || spin_needbreak(&kvm->mmu_lock)) {
> 			if (flush && lock_flush_tlb) {
> @@ -5090,10 +5120,10 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
> 
> static bool
> slot_handle_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
> -		  slot_level_handler fn, int start_level, int end_level,
> +		  enum slot_handler_op op, int start_level, int end_level,
> 		  bool lock_flush_tlb)
> {
> -	return slot_handle_level_range(kvm, memslot, fn, start_level,
> +	return slot_handle_level_range(kvm, memslot, op, start_level,
> 			end_level, memslot->base_gfn,
> 			memslot->base_gfn + memslot->npages - 1,
> 			lock_flush_tlb);
> @@ -5101,25 +5131,25 @@ slot_handle_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
> 
> static bool
> slot_handle_all_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
> -		      slot_level_handler fn, bool lock_flush_tlb)
> +		      enum slot_handler_op op, bool lock_flush_tlb)
> {
> -	return slot_handle_level(kvm, memslot, fn, PT_PAGE_TABLE_LEVEL,
> +	return slot_handle_level(kvm, memslot, op, PT_PAGE_TABLE_LEVEL,
> 				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb);
> }
> 
> static bool
> slot_handle_large_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
> -			slot_level_handler fn, bool lock_flush_tlb)
> +			enum slot_handler_op op, bool lock_flush_tlb)
> {
> -	return slot_handle_level(kvm, memslot, fn, PT_PAGE_TABLE_LEVEL + 1,
> +	return slot_handle_level(kvm, memslot, op, PT_PAGE_TABLE_LEVEL + 1,
> 				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb);
> }
> 
> static bool
> slot_handle_leaf(struct kvm *kvm, struct kvm_memory_slot *memslot,
> -		 slot_level_handler fn, bool lock_flush_tlb)
> +		 enum slot_handler_op op, bool lock_flush_tlb)
> {
> -	return slot_handle_level(kvm, memslot, fn, PT_PAGE_TABLE_LEVEL,
> +	return slot_handle_level(kvm, memslot, op, PT_PAGE_TABLE_LEVEL,
> 				 PT_PAGE_TABLE_LEVEL, lock_flush_tlb);
> }
> 
> @@ -5140,7 +5170,7 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
> 			if (start >= end)
> 				continue;
> 
> -			slot_handle_level_range(kvm, memslot, kvm_zap_rmapp,
> +			slot_handle_level_range(kvm, memslot, SLOT_ZAP_RMAPP,
> 						PT_PAGE_TABLE_LEVEL, PT_MAX_HUGEPAGE_LEVEL,
> 						start, end - 1, true);
> 		}
> @@ -5149,19 +5179,13 @@ void kvm_zap_gfn_range(struct kvm *kvm, gfn_t gfn_start, gfn_t gfn_end)
> 	spin_unlock(&kvm->mmu_lock);
> }
> 
> -static bool slot_rmap_write_protect(struct kvm *kvm,
> -				    struct kvm_rmap_head *rmap_head)
> -{
> -	return __rmap_write_protect(kvm, rmap_head, false);
> -}
> -
> void kvm_mmu_slot_remove_write_access(struct kvm *kvm,
> 				      struct kvm_memory_slot *memslot)
> {
> 	bool flush;
> 
> 	spin_lock(&kvm->mmu_lock);
> -	flush = slot_handle_all_level(kvm, memslot, slot_rmap_write_protect,
> +	flush = slot_handle_all_level(kvm, memslot, SLOT_RMAP_WRITE_PROTECT,
> 				      false);
> 	spin_unlock(&kvm->mmu_lock);
> 
> @@ -5226,7 +5250,7 @@ void kvm_mmu_zap_collapsible_sptes(struct kvm *kvm,
> 	/* FIXME: const-ify all uses of struct kvm_memory_slot.  */
> 	spin_lock(&kvm->mmu_lock);
> 	slot_handle_leaf(kvm, (struct kvm_memory_slot *)memslot,
> -			 kvm_mmu_zap_collapsible_spte, true);
> +			 SLOT_ZAP_COLLAPSIBLE_SPTE, true);
> 	spin_unlock(&kvm->mmu_lock);
> }
> 
> @@ -5236,7 +5260,7 @@ void kvm_mmu_slot_leaf_clear_dirty(struct kvm *kvm,
> 	bool flush;
> 
> 	spin_lock(&kvm->mmu_lock);
> -	flush = slot_handle_leaf(kvm, memslot, __rmap_clear_dirty, false);
> +	flush = slot_handle_leaf(kvm, memslot, SLOT_RMAP_CLEAR_DIRTY, false);
> 	spin_unlock(&kvm->mmu_lock);
> 
> 	lockdep_assert_held(&kvm->slots_lock);
> @@ -5258,7 +5282,7 @@ void kvm_mmu_slot_largepage_remove_write_access(struct kvm *kvm,
> 	bool flush;
> 
> 	spin_lock(&kvm->mmu_lock);
> -	flush = slot_handle_large_level(kvm, memslot, slot_rmap_write_protect,
> +	flush = slot_handle_large_level(kvm, memslot, SLOT_RMAP_WRITE_PROTECT,
> 					false);
> 	spin_unlock(&kvm->mmu_lock);
> 
> @@ -5276,7 +5300,7 @@ void kvm_mmu_slot_set_dirty(struct kvm *kvm,
> 	bool flush;
> 
> 	spin_lock(&kvm->mmu_lock);
> -	flush = slot_handle_all_level(kvm, memslot, __rmap_set_dirty, false);
> +	flush = slot_handle_all_level(kvm, memslot, SLOT_RMAP_SET_DIRTY, false);
> 	spin_unlock(&kvm->mmu_lock);
> 
> 	lockdep_assert_held(&kvm->slots_lock);
> -- 
> 2.7.4
> 

Let's add more context.

vmx_slot_disable_log_dirty() was already one of the bottlenecks on instance launch
(at least with our setup).  With retpoline, it became horribly slow (like twice as
slow).

Up to know, we're using a ugly workaround that works for us but of course isn't
acceptable in the long run.  I'm going to explore the issue further earlier next
week.

Filippo


Amazon Development Center Germany GmbH
Berlin - Dresden - Aachen
main office: Krausenstr. 38, 10117 Berlin
Geschaeftsfuehrer: Dr. Ralf Herbrich, Christian Schlaeger
Ust-ID: DE289237879
Eingetragen am Amtsgericht Charlottenburg HRB 149173 B
