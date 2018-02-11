Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AH8x227sHi8uAQJH2mAbdGOLhwoQMSTGnUi/Xzi4BP8ll0HYtrdcassnBYDSrk2x4VkpmTXexEfL
ARC-Seal: i=1; a=rsa-sha256; t=1518402441; cv=none;
        d=google.com; s=arc-20160816;
        b=RtXj6nWz/qY3V6XxoFvGsYEka6G6YPze1oh1A8wC0+eiLNFyKoBJjFcFA0YngA3UBD
         AY/el/t4D45VSxq+KbQmJRcsgcFEMXbV7uy+cYqHRgdmNmOXmb/lXBDt09lFOkqVRJ0c
         q/39DLThbm5sanVN8RXRwMDQE2v8Bs7kmGUs7rYW+SCH80SAxIVlwo8qsg62X+aNmHL2
         Nu/hgrpi+UfUjWTfc++kqp4EoIze+GdrpOXaZNB9mMpsdfJ9CE6AeVKTPLJctoQRpFua
         yRFho9VvkW0mZv19OGQzk5uFdC+7EINPll23OK3gvFxWc9R5f3yllP5q/sVM4sd/0vEf
         Mplg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=78jj7+oHJHUpfu0vZEih/RnVpBK2/IUMQS0K4hXfO2k=;
        b=N79291oCtfgJLOeDohEtROugckkbcaZHgB8cMZ4O3CGocmW2Mtxzn5mfV6+3EBM2W/
         CZ388QAbBYQajSB5ynY831Q33ePL+aSJlNQt0cI3FwWblAlpJtOwk8QzjSbwgJouojnZ
         w3fZY2vra7nH3citf8AQ0kjfBB5msJmAen04KlUsLHwQ2uImEwtMklFPy3FijExEL7Ml
         /LPEa7E39FQAforrrd9hl4aQRGNZ+la8ziJQP0RZB9FaILJOEdu9VyojiqXo9+39wWUL
         OdXLUzJ3plYukGjUa1nx9Ny39V1APZidrBVRttGkENNSMQV0aYPbsIpjl2INfI4wjF0K
         kE9g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Sun, 11 Feb 2018 04:09:54 -0800
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for David Woodhouse <tipbot@zytor.com>
Message-ID: <tip-33f1e899478efb7c77b2b833e7edee1203a24a48@git.kernel.org>
Cc: gregkh@linuxfoundation.org, dwmw@amazon.co.uk, hpa@zytor.com,
        peterz@infradead.org, luto@kernel.org, arjan@linux.intel.com,
        dwmw2@infradead.org, sironi@amazon.de, jpoimboe@redhat.com,
        torvalds@linux-foundation.org, dave.hansen@linux.intel.com,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        dan.j.williams@intel.com, bp@alien8.de
Reply-To: torvalds@linux-foundation.org, jpoimboe@redhat.com,
        dave.hansen@linux.intel.com, tglx@linutronix.de,
        dan.j.williams@intel.com, bp@alien8.de, mingo@kernel.org,
        linux-kernel@vger.kernel.org, peterz@infradead.org, hpa@zytor.com,
        dwmw@amazon.co.uk, gregkh@linuxfoundation.org, sironi@amazon.de,
        luto@kernel.org, arjan@linux.intel.com, dwmw2@infradead.org
In-Reply-To: <1518305967-31356-4-git-send-email-dwmw@amazon.co.uk>
References: <1518305967-31356-4-git-send-email-dwmw@amazon.co.uk>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] KVM/x86: Reduce retpoline performance impact in
 slot_handle_level_range(), by always inlining iterator helper methods
Git-Commit-ID: 33f1e899478efb7c77b2b833e7edee1203a24a48
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
X-GMAIL-MSGID: =?utf-8?q?1592160357806412136?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  33f1e899478efb7c77b2b833e7edee1203a24a48
Gitweb:     https://git.kernel.org/tip/33f1e899478efb7c77b2b833e7edee1203a24a48
Author:     David Woodhouse <dwmw@amazon.co.uk>
AuthorDate: Sat, 10 Feb 2018 23:39:24 +0000
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Sun, 11 Feb 2018 11:24:15 +0100

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
Cc: pbonzini@redhat.com
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
