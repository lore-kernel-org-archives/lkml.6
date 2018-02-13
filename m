Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x2247FE3DXxyFdawLURF8LWv1S+ZhtLg6dEqh69IZKmshtdO3Mwi19ZQf5Y+5ey193ho1eSVu
ARC-Seal: i=1; a=rsa-sha256; t=1518513315; cv=none;
        d=google.com; s=arc-20160816;
        b=SL1GEL3L4vSR+CZq/ZoWyl88BXA9mRE50FTPdeR5qq7Z4n59kEyOu4YWSg/1vMtKZ3
         4SWQKNTs74jWEhGDpXDTbZ36DL3tEAsyuB3icv99TFnmh5tgmrFmODKwo3IfiuyerObT
         /zNzU+5N8KezzB/hEiAtST/Uj1r//EKvEKh1nNhz7/f/fVJJLS9GoqzGeD6SM0cpO6fA
         LWI0I+FYDiFdxdBX/RwCpG9UXOyatJYDca3pZg7ckuKDFrU0OCBgTgmZ/37oAMRve4ih
         nU6NkgpD3m1MBNXt52538bknNVuuEc80lv0VfGqRjKeMVj9ReUh4gPaTbPyycgZW3W2H
         TRDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=l3eUXxql30gFL4VZIBJVI5DW+FSLKxcfgHeTnFRKVeg=;
        b=LfcGmsld4T6d7gJADbQvyMgUM6GBVy8KborW6WpX42QLbhrjxd/zsM91Hw3dQhnZTu
         ciTtr1jX9wV699dvKgimUK1ceXTzj5SQ/uEAzozi0gGfqgJsgXMOsDfbQCg6kGvBvMi4
         Dg3AsAWm3c0WtFAEeF0QhJqUSas7Z25DHY5Pl8+z8IODeK61su8qEMyyCTmBKO1rAzqP
         kj9nZAZd4FvUI3497zmsC3V9bh/i2f4r2sltDJKj5xTyXdza/lKACcL0BtYG9dNAYJJj
         U5PjxB+wjYbGuLlC2K6tGrI5DIpuU0BoBnJPrmCipeVqe/1gqK5xaPkoZTP0cRaUaN3o
         hMzw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Tue, 13 Feb 2018 00:58:49 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for David Woodhouse <tipbot@zytor.com>
Message-ID: <tip-928a4c39484281f8ca366f53a1db79330d058401@git.kernel.org>
Cc: bp@alien8.de, dwmw@amazon.co.uk, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, sironi@amazon.de, torvalds@linux-foundation.org,
        dan.j.williams@intel.com, peterz@infradead.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org, luto@kernel.org,
        jpoimboe@redhat.com, dwmw2@infradead.org
Reply-To: bp@alien8.de, dwmw@amazon.co.uk, dave.hansen@linux.intel.com,
        arjan@linux.intel.com, sironi@amazon.de, torvalds@linux-foundation.org,
        dan.j.williams@intel.com, peterz@infradead.org, pbonzini@redhat.com,
        linux-kernel@vger.kernel.org, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de, gregkh@linuxfoundation.org, luto@kernel.org,
        jpoimboe@redhat.com, dwmw2@infradead.org
In-Reply-To: <1518305967-31356-4-git-send-email-dwmw@amazon.co.uk>
References: <1518305967-31356-4-git-send-email-dwmw@amazon.co.uk>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] KVM/x86: Reduce retpoline performance impact in
 slot_handle_level_range(), by always inlining iterator helper methods
Git-Commit-ID: 928a4c39484281f8ca366f53a1db79330d058401
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592160357806412136?=
X-GMAIL-MSGID: =?utf-8?q?1592276617998546461?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  928a4c39484281f8ca366f53a1db79330d058401
Gitweb:     https://git.kernel.org/tip/928a4c39484281f8ca366f53a1db79330d058401
Author:     David Woodhouse <dwmw@amazon.co.uk>
AuthorDate: Sat, 10 Feb 2018 23:39:24 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 13 Feb 2018 08:59:45 +0100

KVM/x86: Reduce retpoline performance impact in slot_handle_level_range(), by always inlining iterator helper methods

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
Tested-by: Filippo Sironi <sironi@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Reviewed-by: Filippo Sironi <sironi@amazon.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: arjan.van.de.ven@intel.com
Cc: dave.hansen@intel.com
Cc: jmattson@google.com
Cc: karahmed@amazon.de
Cc: kvm@vger.kernel.org
Cc: rkrcmar@redhat.com
Link: http://lkml.kernel.org/r/1518305967-31356-4-git-send-email-dwmw@amazon.co.uk
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
