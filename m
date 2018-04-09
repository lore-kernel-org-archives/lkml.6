Return-Path: <tipbot@zytor.com>
X-Google-Smtp-Source: AIpwx4+QfRIzHZ2utugOK5DYFRMzG6gHqkWxqbKUfXYC9tWXiSXNzbhFprcEjD5PAxW8IQYIAphe
ARC-Seal: i=1; a=rsa-sha256; t=1523294240; cv=none;
        d=google.com; s=arc-20160816;
        b=mOC7HZ1blIp7t/dMsSikRBtN5mEnVcv4YRLJnZ1Cw8fwtvFW9kmJjoSCJ8Z59fzNTA
         W4Foog+E4gmLzSpH3AMTyIsVTeoQVAqP37sizfk8Gcvt1srCowIt0/6J5ccILeiAjUY6
         PHFM94K7n77CPC8wLsdNXDRZqXIttgEigKcnezHADul/363OoGQ2cVGyDZEmBci8tZD7
         ddhARLJNbgNcPS+j+iJS7vXgDBoAYOLJXeNHuWsNkhFmdvF9VrnPtO1RO94Ne4/ErzkM
         h41aZl6UiQWJuxgEuIWLQsHtXlV6riSw+x64qAS5tVPH4obwyDUM+KKiO/sWNBib4PTZ
         4TRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=precedence:content-disposition:content-transfer-encoding
         :mime-version:robot-unsubscribe:robot-id:git-commit-id:subject:to
         :references:in-reply-to:reply-to:cc:message-id:from:sender:date
         :arc-authentication-results;
        bh=iWDl72cBa//+9ee/KEcO6HDWRZJPI8TgkqvidVeIIDA=;
        b=PAZT6Z86rhrwSdbQ82t/DL94maTGIaD04UtrLweV5KERg26Cct456AjyesHLd2tTeN
         cRbsR7jHTPMOp8ZtwbOXdrGfomLv9wKi3ABzaIqLML+Fw9yU8ryvKxOSi1Y+4wVsEpCS
         n4nowKBmHCevk4xnpY2YamJwDqDofJfkYnTDlQCh/vT/Z868ZTxg8KIY0hhzeRy8cH0c
         1KPiBs2cTPQhKqrgf6dCPPV4K/1gvjo1+tY4rYbTs6nBE33QzPa9u4XGeiaHCSH90vxW
         UvdP0YWXagPw6CrkXVWp+f82u+MItCcoGP8ivAgXOtmJFq7822Kh4DX99USNzh+ACA4J
         168w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of tipbot@zytor.com designates 198.137.202.136 as permitted sender) smtp.mailfrom=tipbot@zytor.com
Date: Mon, 9 Apr 2018 10:15:37 -0700
Sender: tip tree robot <tipbot@zytor.com>
From: tip-bot for Dave Hansen <tipbot@zytor.com>
Message-ID: <tip-e0bb456e32505b08e42477714169111fbdbff95b@git.kernel.org>
Cc: dan.j.williams@intel.com, luto@kernel.org, dave.hansen@linux.intel.com,
        hpa@zytor.com, torvalds@linux-foundation.org, arjan@linux.intel.com,
        mingo@kernel.org, keescook@google.com, peterz@infradead.org,
        dwmw2@infradead.org, bp@alien8.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, jpoimboe@redhat.com, tglx@linutronix.de,
        jgross@suse.com, aarcange@redhat.com, hughd@google.com,
        namit@vmware.com
Reply-To: luto@kernel.org, dave.hansen@linux.intel.com, hpa@zytor.com,
        dan.j.williams@intel.com, mingo@kernel.org, keescook@google.com,
        peterz@infradead.org, dwmw2@infradead.org,
        torvalds@linux-foundation.org, arjan@linux.intel.com,
        jpoimboe@redhat.com, tglx@linutronix.de, bp@alien8.de,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        aarcange@redhat.com, hughd@google.com, namit@vmware.com,
        jgross@suse.com
In-Reply-To: <20180406205515.2977EE7D@viggo.jf.intel.com>
References: <20180406205515.2977EE7D@viggo.jf.intel.com>
To: linux-tip-commits@vger.kernel.org
Subject: [tip:x86/pti] x86/pti: Enable global pages for shared areas
Git-Commit-ID: e0bb456e32505b08e42477714169111fbdbff95b
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597289781405752273?=
X-GMAIL-MSGID: =?utf-8?q?1597289781405752273?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Commit-ID:  e0bb456e32505b08e42477714169111fbdbff95b
Gitweb:     https://git.kernel.org/tip/e0bb456e32505b08e42477714169111fbdbff95b
Author:     Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate: Fri, 6 Apr 2018 13:55:15 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Mon, 9 Apr 2018 18:27:34 +0200

x86/pti: Enable global pages for shared areas

The entry/exit text and cpu_entry_area are mapped into userspace and
the kernel.  But, they are not _PAGE_GLOBAL.  This creates unnecessary
TLB misses.

Add the _PAGE_GLOBAL flag for these areas.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Hugh Dickins <hughd@google.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@google.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mm@kvack.org
Link: http://lkml.kernel.org/r/20180406205515.2977EE7D@viggo.jf.intel.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/mm/cpu_entry_area.c | 14 +++++++++++++-
 arch/x86/mm/pti.c            | 23 ++++++++++++++++++++++-
 2 files changed, 35 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/cpu_entry_area.c b/arch/x86/mm/cpu_entry_area.c
index 476d810639a8..b45f5aaefd74 100644
--- a/arch/x86/mm/cpu_entry_area.c
+++ b/arch/x86/mm/cpu_entry_area.c
@@ -27,8 +27,20 @@ EXPORT_SYMBOL(get_cpu_entry_area);
 void cea_set_pte(void *cea_vaddr, phys_addr_t pa, pgprot_t flags)
 {
 	unsigned long va = (unsigned long) cea_vaddr;
+	pte_t pte = pfn_pte(pa >> PAGE_SHIFT, flags);
 
-	set_pte_vaddr(va, pfn_pte(pa >> PAGE_SHIFT, flags));
+	/*
+	 * The cpu_entry_area is shared between the user and kernel
+	 * page tables.  All of its ptes can safely be global.
+	 * _PAGE_GLOBAL gets reused to help indicate PROT_NONE for
+	 * non-present PTEs, so be careful not to set it in that
+	 * case to avoid confusion.
+	 */
+	if (boot_cpu_has(X86_FEATURE_PGE) &&
+	    (pgprot_val(flags) & _PAGE_PRESENT))
+		pte = pte_set_flags(pte, _PAGE_GLOBAL);
+
+	set_pte_vaddr(va, pte);
 }
 
 static void __init
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 631507f0c198..8082f8b0c10e 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -299,6 +299,27 @@ pti_clone_pmds(unsigned long start, unsigned long end, pmdval_t clear)
 		if (WARN_ON(!target_pmd))
 			return;
 
+		/*
+		 * Only clone present PMDs.  This ensures only setting
+		 * _PAGE_GLOBAL on present PMDs.  This should only be
+		 * called on well-known addresses anyway, so a non-
+		 * present PMD would be a surprise.
+		 */
+		if (WARN_ON(!(pmd_flags(*pmd) & _PAGE_PRESENT)))
+			return;
+
+		/*
+		 * Setting 'target_pmd' below creates a mapping in both
+		 * the user and kernel page tables.  It is effectively
+		 * global, so set it as global in both copies.  Note:
+		 * the X86_FEATURE_PGE check is not _required_ because
+		 * the CPU ignores _PAGE_GLOBAL when PGE is not
+		 * supported.  The check keeps consistentency with
+		 * code that only set this bit when supported.
+		 */
+		if (boot_cpu_has(X86_FEATURE_PGE))
+			*pmd = pmd_set_flags(*pmd, _PAGE_GLOBAL);
+
 		/*
 		 * Copy the PMD.  That is, the kernelmode and usermode
 		 * tables will share the last-level page tables of this
@@ -348,7 +369,7 @@ static void __init pti_clone_entry_text(void)
 {
 	pti_clone_pmds((unsigned long) __entry_text_start,
 			(unsigned long) __irqentry_text_end,
-		       _PAGE_RW | _PAGE_GLOBAL);
+		       _PAGE_RW);
 }
 
 /*
