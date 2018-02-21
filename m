Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x2264NkAyNVreH3IU6AoABsdJ61JUXqjc/Qf5A2pXNb7VLhoAkUM0tlPVe0Gvq5j9Fegqxi7k
ARC-Seal: i=1; a=rsa-sha256; t=1519217178; cv=none;
        d=google.com; s=arc-20160816;
        b=AjFeVuhUEc9F+M3m5Th0wGzJ+mJJ+mG3tgzyJW3y8TLXzLDwKFztVQGvjdXQcmsaf1
         CrTyI4QwjpsoxOc5emSSWMx12iQ3PV5lmcU5o16yEX3QeRFFd9/wHjgYPQoCYe5Bzln8
         9OQCFK1MgLe2YnlZwodebWEO+Q1DJUKk7ZLZcHQjYpHGMN+7mJ43Sm1Jccu7pBRmnf71
         RX1SypwbhHZYx6bCbqPvNLMWIM0+8Zkyop3Prq2dOgoldD18JSSO7M2ZhRs0pSVRVpfD
         lTP1A4l9piHFCdVxsIQDeyMfgfTXoHiR1afoTZNRLd8aO0Oh9rQYm+pA/O2fmZC/pXHS
         4Z0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=M8iBuSL1rEWmZlhVKv5Nbamf5XWfVyc7aKpbmUGxDQ4=;
        b=l0jq39A6DknU79hHpkz36ES0xTnX9WXQlesgae8menmbpzdzOIS7myg/Ajphe80EGQ
         /ThF+I3W3i6yHcTMWxcjNAzNEUkdU5yD7AQQWEZpUGDKfTKLw/n9UkgRurgAPN/P9RSy
         VgIuNB2gMR2M3r9BnxZSjM/BuOgpIWxr+5WkxqFa+/SVUUzRg04Hgdgg4MEfLhhFBJi7
         bMA22Nr+lNULDEPWfIc+uSG3uHbi+3K6YZ/dqs4BsAIX9DCmnGPXEh/amOM0MkDOe2R3
         iz5UAU3elhkP1Hixp+VBftNYDuU8VVJ/kYvSo6A1F0Zi4+Awijd/edMZdT8+9diJplFC
         1NKA==
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
Subject: [PATCH 4.4 09/33] KVM/x86: Reduce retpoline performance impact in slot_handle_level_range(), by always inlining iterator helper methods
Date: Wed, 21 Feb 2018 13:44:52 +0100
Message-Id: <20180221124410.165090932@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180221124409.564661689@linuxfoundation.org>
References: <20180221124409.564661689@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1593014672537786742?=
X-GMAIL-MSGID: =?utf-8?q?1593014672537786742?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -4503,7 +4503,7 @@ void kvm_mmu_setup(struct kvm_vcpu *vcpu
 typedef bool (*slot_level_handler) (struct kvm *kvm, unsigned long *rmap);
 
 /* The caller should hold mmu-lock before calling this function. */
-static bool
+static __always_inline bool
 slot_handle_level_range(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			slot_level_handler fn, int start_level, int end_level,
 			gfn_t start_gfn, gfn_t end_gfn, bool lock_flush_tlb)
@@ -4533,7 +4533,7 @@ slot_handle_level_range(struct kvm *kvm,
 	return flush;
 }
 
-static bool
+static __always_inline bool
 slot_handle_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		  slot_level_handler fn, int start_level, int end_level,
 		  bool lock_flush_tlb)
@@ -4544,7 +4544,7 @@ slot_handle_level(struct kvm *kvm, struc
 			lock_flush_tlb);
 }
 
-static bool
+static __always_inline bool
 slot_handle_all_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		      slot_level_handler fn, bool lock_flush_tlb)
 {
@@ -4552,7 +4552,7 @@ slot_handle_all_level(struct kvm *kvm, s
 				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb);
 }
 
-static bool
+static __always_inline bool
 slot_handle_large_level(struct kvm *kvm, struct kvm_memory_slot *memslot,
 			slot_level_handler fn, bool lock_flush_tlb)
 {
@@ -4560,7 +4560,7 @@ slot_handle_large_level(struct kvm *kvm,
 				 PT_MAX_HUGEPAGE_LEVEL, lock_flush_tlb);
 }
 
-static bool
+static __always_inline bool
 slot_handle_leaf(struct kvm *kvm, struct kvm_memory_slot *memslot,
 		 slot_level_handler fn, bool lock_flush_tlb)
 {
