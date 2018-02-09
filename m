Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x225c6dK/aYbAL3f8G4ss0Gyv8M6+7pSn7/zXGx6NSpxc2xbQ9rJSlEf8tAUFRZUu0xzYF4N/
ARC-Seal: i=1; a=rsa-sha256; t=1518168362; cv=none;
        d=google.com; s=arc-20160816;
        b=ziO+JDJqyr5aiB0IyJYlAqiJyywkI00o6dW0JwSLaxFXMVwnQSrNfYoskHkIysJNQ1
         8DOsj3IkIeQctczHafqLMaKWtPUvlilptsOoOmdMHgiZBhklgMqS14aZue8mhoLW2SWe
         Xp64xT4XsAHP0cWvUa4nUGMdKphIRN4TOSHcPTPQAilPkZu/eDr1LSLmiD/r7cltUzfV
         E8Yn6VDYYjUHoaoU8RFW+MovGWgnMAPV3tRmmL4kLD2tcsMWzTqDeWFNlhGqRqtl0xl3
         NSay8S6ypry6XzyEqLxFig9REJbFJi/P4dp2sNn+AiX4hbXYucIBF4M6XV2BDZhtS5ne
         MEug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=XAM3PsK4PnC6+A6RvlgUGm+9w2TdAjqLZV7jFb3GTJc=;
        b=NPNFuk+s4NxHyOg36VTd8nInhclWQAV6yQmL1L94t5apwesTCkZDiWMPWphYF4OQnL
         R2zbLCLilSJVhKNg14VPv30AtWoYogWlAoLdGg2p4n0ePU4QIfPceORdGQFY7RSDRROi
         tYe4oHQNQFGjTlQRp521XO3+88kOxVxtat5pH7dOuQf1hdsld8VT2Nuf6XZSQr8UR9UM
         TVcsr8ldVRSjlhBkJEvfIPqN6O8OZ0uaudlp+SZu2gPw+bRohlmuZoisiWf8t1LDH0z8
         mhuN9lVosjoWu1GShnKPNKMbXIXttdsFZjVlOVqRyPdn9vf028duBht1E0ddoElCMo8Q
         mRlA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=lwNCN8tC;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=lwNCN8tC;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>,
	Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>,
	aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at,
	hughd@google.com,
	keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>,
	Pavel Machek <pavel@ucw.cz>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 19/31] x86/mm/pae: Populate valid user PGD entries
Date: Fri,  9 Feb 2018 10:25:28 +0100
Message-Id: <1518168340-9392-20-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914908450442630?=
X-GMAIL-MSGID: =?utf-8?q?1591914908450442630?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Generic page-table code populates all non-leaf entries with
_KERNPG_TABLE bits set. This is fine for all paging modes
except PAE.

In PAE mode only a subset of the bits is allowed to be set.
Make sure we only set allowed bits by masking out the
reserved bits.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable_types.h | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 3696398..5027470 100644
--- a/arch/x86/include/asm/pgtable_types.h
+++ b/arch/x86/include/asm/pgtable_types.h
@@ -50,6 +50,7 @@
 #define _PAGE_GLOBAL	(_AT(pteval_t, 1) << _PAGE_BIT_GLOBAL)
 #define _PAGE_SOFTW1	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW1)
 #define _PAGE_SOFTW2	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW2)
+#define _PAGE_SOFTW3	(_AT(pteval_t, 1) << _PAGE_BIT_SOFTW3)
 #define _PAGE_PAT	(_AT(pteval_t, 1) << _PAGE_BIT_PAT)
 #define _PAGE_PAT_LARGE (_AT(pteval_t, 1) << _PAGE_BIT_PAT_LARGE)
 #define _PAGE_SPECIAL	(_AT(pteval_t, 1) << _PAGE_BIT_SPECIAL)
@@ -267,14 +268,35 @@ typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
 
 typedef struct { pgdval_t pgd; } pgd_t;
 
+#ifdef CONFIG_X86_PAE
+
+/*
+ * PHYSICAL_PAGE_MASK might be non-constant when SME is compiled in, so we can't
+ * use it here.
+ */
+#define PGD_PAE_PHYS_MASK	(((1ULL << __PHYSICAL_MASK_SHIFT)-1) & PAGE_MASK)
+
+/*
+ * PAE allows Base Address, P, PWT, PCD and AVL bits to be set in PGD entries.
+ * All other bits are Reserved MBZ
+ */
+#define PGD_ALLOWED_BITS	(PGD_PAE_PHYS_MASK | _PAGE_PRESENT | \
+				 _PAGE_PWT | _PAGE_PCD | \
+				 _PAGE_SOFTW1 | _PAGE_SOFTW2 | _PAGE_SOFTW3 )
+
+#else
+/* No need to mask any bits for !PAE */
+#define PGD_ALLOWED_BITS	(~0ULL)
+#endif
+
 static inline pgd_t native_make_pgd(pgdval_t val)
 {
-	return (pgd_t) { val };
+	return (pgd_t) { val & PGD_ALLOWED_BITS };
 }
 
 static inline pgdval_t native_pgd_val(pgd_t pgd)
 {
-	return pgd.pgd;
+	return pgd.pgd & PGD_ALLOWED_BITS;
 }
 
 static inline pgdval_t pgd_flags(pgd_t pgd)
-- 
2.7.4
