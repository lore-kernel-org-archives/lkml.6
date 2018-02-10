Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752982AbeBJXjv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Feb 2018 18:39:51 -0500
Received: from smtp-fw-9101.amazon.com ([207.171.184.25]:12571 "EHLO
        smtp-fw-9101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752896AbeBJXjr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Feb 2018 18:39:47 -0500
X-IronPort-AV: E=Sophos;i="5.46,492,1511827200";
   d="scan'208";a="722034696"
From: David Woodhouse <dwmw@amazon.co.uk>
To: tglx@linutronix.de, karahmed@amazon.de, sironi@amazon.de,
        x86@kernel.org, kvm@vger.kernel.org, torvalds@linux-foundation.org,
        pbonzini@redhat.com, linux-kernel@vger.kernel.org, bp@alien8.de,
        peterz@infradead.org, jmattson@google.com, rkrcmar@redhat.com,
        arjan.van.de.ven@intel.com, dave.hansen@intel.com
Subject: [PATCH v2 3/6] KVM: x86: Reduce retpoline performance impact in slot_handle_level_range()
Date: Sat, 10 Feb 2018 23:39:24 +0000
Message-Id: <1518305967-31356-4-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
References: <1518305967-31356-1-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With retpoline, tight loops of "call this function for every XXX" are
very much pessimised by taking a prediction miss *every* time. This one
is by far the biggest contributor to the guest launch time with retpoline.

By marking the iterator slot_handle_…() functions always_inline, we can
ensure that the indirect function call can be optimised away into a
direct call and it actually generates slightly smaller code because
some of the other conditionals can get optimised away too.

Performance is now pretty close to what we see with nospectre_v2 on
the command line.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Filippo Sironi <sironi@amazon.de>
Tested-by: Filippo Sironi <sironi@amazon.de>
---
 arch/x86/kvm/mmu.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/mmu.c b/arch/x86/kvm/mmu.c
index 2b8eb4d..cc83bdc 100644
--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5058,7 +5058,7 @@ void kvm_mmu_uninit_vm(struct kvm *kvm)
 typedef bool (*slot_level_handler) (struct kvm *kvm, struct kvm_rmap_head *rmap_head);
 
 /* The caller should hold mmu-lock before calling this function. */
-static bool
+static __always_inline bool
 slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			slot_level_handler fn, int start_level, int end_level,
 			gfn_t start_gfn, gfn_t end_gfn, bool lock_flush_tlb)
@@ -5088,7 +5088,7 @@ slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 	return flush;
 }
 
-static bool
+static __always_inline bool
 slot_handle_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		  slot_level_handler fn, int start_level, int end_level,
 		  bool lock_flush_tlb)
@@ -5099,7 +5099,7 @@ slot_handle_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			lock_flush_tlb);
 }
 
-static bool
+static __always_inline bool
 slot_handle_all_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		      slot_level_handler fn, bool lock_flush_tlb)
 {
@@ -5107,7 +5107,7 @@ slot_handle_all_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb);
 }
 
-static bool
+static __always_inline bool
 slot_handle_large_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			slot_level_handler fn, bool lock_flush_tlb)
 {
@@ -5115,7 +5115,7 @@ slot_handle_large_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb);
 }
 
-static bool
+static __always_inline bool
 slot_handle_leaf(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		 slot_level_handler fn, bool lock_flush_tlb)
 {
-- 
2.7.4
