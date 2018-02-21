Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226h6S+R2gWDFitBd6PehMbAzcdr1DuH7MNIlB3txesl7MRfeuEHxk6M+1w1+ev/MDoeHhps
ARC-Seal: i=1; a=rsa-sha256; t=1519217995; cv=none;
        d=google.com; s=arc-20160816;
        b=p7jpP57OKrafcy5J2My2ahasqttL1lyhXw0SwEGnUEQqA73y19ZKQS9Am73j5PMK97
         0YmZbPWDsSydMLRrLR1LD4vv/FiFEFJvpxC5SoOVkv0SPfEZvycz1bBj+CE8OEGOEmv9
         D7uM8Zadsee66bY15DoeTouQh6ljIcxFc0AkzKPaT1KPGe5L9iQOA+wleLfk8UYtWrG2
         btVbYz7XyzeT4DKRhyb4LLvunFP/JATrKlgaTE6mKFRa3c9l3FaNw0ocFMKmfUmKYoys
         N3/gK2rJVck8CsBBa682YRxGfbZ+AsP9frzbmdx4Doc9KvStK51MPKtpQHMIyCEQ4Unu
         fU8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=LcYlzSkbyXS7tWP0Zi1/gm++a19QCLZGgU4pAYatS5g=;
        b=wLNK9ps+R8Jdcc6LtJt6gSEhw/TivJoWzmy1RiSAC1QnXuzcBz220Hq1VDcbMBWL+x
         651/hkLkQRLwXXCv4EiRt6HQd9EQ+KOYIg2whDyHRdncvkAYEabeonpMqqgsafUlYcNT
         j0iMkJUCEnRZB4/FjqqvqvtjzykmpRUC+tFCLX9s5KPLFlIB4mjq3v8UE+o1kv3jsk0/
         gS+2vkrA5otFvYQBfPcC5aesdc5KENo8HBtwHSK/B4V735TbnzX65Vfu4PP6Og+3Ue6U
         PZWntkyORLt0iURucT1HRxD3XveArGWKYvIB/eJ1e1F+2QBvT4kUY/jX3f4Aio6Ajooy
         08nQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Filippo Sironi <sironi@amazon.de>,
	David Woodhouse <dwmw@amazon.co.uk>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Borislav Petkov <bp@alien8.de>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	arjan.van.de.ven@intel.com,
	dave.hansen@intel.com,
	jmattson@google.com,
	karahmed@amazon.de,
	kvm@vger.kernel.org,
	rkrcmar@redhat.com,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.14 051/167] KVM/x86: Reduce retpoline performance impact in slot_handle_level_range(), by always inlining iterator helper methods
Date: Wed, 21 Feb 2018 13:47:42 +0100
Message-Id: <20180221124527.332064034@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124524.639039577@linuxfoundation.org>
References: <20180221124524.639039577@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593015306559718735?=
X-GMAIL-MSGID: =?utf-8?q?1593015529059354224?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Woodhouse <dwmw@amazon.co.uk>

commit 928a4c39484281f8ca366f53a1db79330d058401 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/kvm/mmu.c |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

--- a/arch/x86/kvm/mmu.c
+++ b/arch/x86/kvm/mmu.c
@@ -5063,7 +5063,7 @@ void kvm_mmu_uninit_vm(struct kvm *kvm)
 typedef bool (*slot_level_handler) (struct kvm *kvm, struct kvm_rmap_head *rmap_head);
 
 /* The caller should hold mmu-lock before calling this function. */
-static bool
+static __always_inline bool
 slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			slot_level_handler fn, int start_level, int end_level,
 			gfn_t start_gfn, gfn_t end_gfn, bool lock_flush_tlb)
@@ -5093,7 +5093,7 @@ slot_handle_level_range(struct kvm *kvm,
 	return flush;
 }
 
-static bool
+static __always_inline bool
 slot_handle_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		  slot_level_handler fn, int start_level, int end_level,
 		  bool lock_flush_tlb)
@@ -5104,7 +5104,7 @@ slot_handle_level(struct kvm *kvm, struc
 			lock_flush_tlb);
 }
 
-static bool
+static __always_inline bool
 slot_handle_all_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		      slot_level_handler fn, bool lock_flush_tlb)
 {
@@ -5112,7 +5112,7 @@ slot_handle_all_level(struct kvm *kvm, s
 				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb);
 }
 
-static bool
+static __always_inline bool
 slot_handle_large_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			slot_level_handler fn, bool lock_flush_tlb)
 {
@@ -5120,7 +5120,7 @@ slot_handle_large_level(struct kvm *kvm,
 				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb);
 }
 
-static bool
+static __always_inline bool
 slot_handle_leaf(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		 slot_level_handler fn, bool lock_flush_tlb)
 {
