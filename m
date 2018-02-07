Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932171AbeBGADr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 19:03:47 -0500
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:60349 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932153AbeBGADn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 19:03:43 -0500
X-IronPort-AV: E=Sophos;i="5.46,470,1511827200";
   d="scan'208";a="331027616"
From: David Woodhouse <dwmw@amazon.co.uk>
To: tglx@linutronix.de, torvalds@linux-foundation.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, bp@alien8.de, peterz@infradead.org,
        tim.c.chen@linux.intel.com, dave.hansen@intel.com,
        arjan.van.de.ven@intel.com
Subject: [RFC PATCH 2/4] KVM: x86: Reduce retpoline performance impact in slot_handle_level_range()
Date: Wed,  7 Feb 2018 00:03:12 +0000
Message-Id: <1517961794-14972-3-git-send-email-dwmw@amazon.co.uk>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1517961794-14972-1-git-send-email-dwmw@amazon.co.uk>
References: <1517961794-14972-1-git-send-email-dwmw@amazon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With retpoline, tight loops of "call this function for every XXX" are
very much pessimised by taking a prediction miss *every* time. This one
showed up very high in our early testing.

By marking the iterator slot_handle_…() functions always_inline, we can
ensure that the indirect function call can be optimised away into a
direct call and it actually generates slightly smaller code because
some of the other conditionals can get optimised away too.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
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
