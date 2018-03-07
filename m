Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuVziUgqhMcbipyD24hy5I1WcijM/xUg8i326TbDjBEiepqyV70rwsUkABFZmRne3POwkX8
ARC-Seal: i=1; a=rsa-sha256; t=1520451818; cv=none;
        d=google.com; s=arc-20160816;
        b=IBHHjkkXdbKIaNGqGfTK1z/yjNmhJdsmQu0EKG3VkswDQFYJfOh+pEqYE2uH8GKzPA
         XmroBzAtdH5uEEm2Yi5dmY7r5vvEC8TQHaXgexaOf7l8R1vYWVG8Ap6tZER5CPRi9lvw
         o5aYQ/9YV5Xlp/EjAekDzGv1yOZUukHg6Y2kqviWLuHPvVCvr2O6AN1eLqZHL8LeMPsv
         WO+ek8uAAs2i2WZUaOq6IWUTCVlbu9GsjhETnHX7m+j+MemuC8zM8Dx6GCqIqUK6hDgS
         KpsYdIXRbwEpk54465xpQU/LN12wLMyD74mga/s/VQ1+mHxpK1jMb2+rtQgjyRwexjaO
         EN/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=YuChzTQZKsL80q0mPf1dkWjfKiBl4nOyflrnyNaVYos=;
        b=u9K6qySAYBCBI4UTlDaQ+yGTaxhNhHTyNF3/lKR4jzQ7nY62I2KGDn8T+ykqLaqb1x
         Ur+DB1aZpGt46PNwdah6MUnT096d8VcA0eB87S1OH54GijHyW6R7iPqbP+IErYn9pTOh
         I1f5pCDlO3wioFim3YwnzlHxoy9hZtw4bfDWzH6g2FpPXmGhcppHIvS1Cl8WygCvHXDf
         Zjfmt4LmhiSVTO/twYtEtNpNxgDhg0Fi5v3aynJDpKdAp+0Ux1YS2SQDIydrm3lv2sSD
         Tvx2JszIr7ewKXY49WC7uyTiW7c801ljeRaH/X7Jes99MqntMgzzB4D4pR70XQRZhHUj
         u0Hw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 185.236.200.248 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Jan Beulich <jbeulich@suse.com>,
	Juergen Gross <jgross@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Andy Lutomirski <luto@kernel.org>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Borislav Petkov <bp@alien8.de>,
	Brian Gerst <brgerst@gmail.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: [PATCH 4.15 106/122] x86/mm: Fix {pmd,pud}_{set,clear}_flags()
Date: Wed,  7 Mar 2018 11:38:38 -0800
Message-Id: <20180307191744.867428031@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180307191729.190879024@linuxfoundation.org>
References: <20180307191729.190879024@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1594309285828589431?=
X-GMAIL-MSGID: =?utf-8?q?1594309285828589431?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jan Beulich <JBeulich@suse.com>

commit 842cef9113c2120f74f645111ded1e020193d84c upstream.

Just like pte_{set,clear}_flags() their PMD and PUD counterparts should
not do any address translation. This was outright wrong under Xen
(causing a dead boot with no useful output on "suitable" systems), and
produced needlessly more complicated code (even if just slightly) when
paravirt was enabled.

Signed-off-by: Jan Beulich <jbeulich@suse.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: http://lkml.kernel.org/r/5A8AF1BB02000078001A91C3@prv-mh.provo.novell.com
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/include/asm/pgtable.h       |    8 ++++----
 arch/x86/include/asm/pgtable_types.h |   10 ++++++++++
 2 files changed, 14 insertions(+), 4 deletions(-)

--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -350,14 +350,14 @@ static inline pmd_t pmd_set_flags(pmd_t
 {
 	pmdval_t v = native_pmd_val(pmd);
 
-	return __pmd(v | set);
+	return native_make_pmd(v | set);
 }
 
 static inline pmd_t pmd_clear_flags(pmd_t pmd, pmdval_t clear)
 {
 	pmdval_t v = native_pmd_val(pmd);
 
-	return __pmd(v & ~clear);
+	return native_make_pmd(v & ~clear);
 }
 
 static inline pmd_t pmd_mkold(pmd_t pmd)
@@ -409,14 +409,14 @@ static inline pud_t pud_set_flags(pud_t
 {
 	pudval_t v = native_pud_val(pud);
 
-	return __pud(v | set);
+	return native_make_pud(v | set);
 }
 
 static inline pud_t pud_clear_flags(pud_t pud, pudval_t clear)
 {
 	pudval_t v = native_pud_val(pud);
 
-	return __pud(v & ~clear);
+	return native_make_pud(v & ~clear);
 }
 
 static inline pud_t pud_mkold(pud_t pud)
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -323,6 +323,11 @@ static inline pudval_t native_pud_val(pu
 #else
 #include <asm-generic/pgtable-nopud.h>
 
+static inline pud_t native_make_pud(pudval_t val)
+{
+	return (pud_t) { .p4d.pgd = native_make_pgd(val) };
+}
+
 static inline pudval_t native_pud_val(pud_t pud)
 {
 	return native_pgd_val(pud.p4d.pgd);
@@ -344,6 +349,11 @@ static inline pmdval_t native_pmd_val(pm
 #else
 #include <asm-generic/pgtable-nopmd.h>
 
+static inline pmd_t native_make_pmd(pmdval_t val)
+{
+	return (pmd_t) { .pud.p4d.pgd = native_make_pgd(val) };
+}
+
 static inline pmdval_t native_pmd_val(pmd_t pmd)
 {
 	return native_pgd_val(pmd.pud.p4d.pgd);
