Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx491UzApj2Jfh1jXXj29dsBPVurlciVhXuBPpJYJrmtntw5xT3NAU/EBDpVQtKFC0+BSAPsN
ARC-Seal: i=1; a=rsa-sha256; t=1524498474; cv=none;
        d=google.com; s=arc-20160816;
        b=jOx20vnzXvNvwGqTx2QyIgHU1W/awjl+XJTLxVZ+i97Ji2a3/ayjNNNIId7mC+tFPy
         R890lY9/SOalhobwX+jZfC3E/swLPSVGxqT1E00Io3YpJEAe3uV41rTftF8ZwuLDdvVQ
         odlnLFKQCZUxsYged2BeJ1ahml34MGiI/sGvfLM1EABqebrJ4WuGXiDQc6D4RIG+REiN
         OAT/c5vr8MwoX7M3XhhyBpYsHn5UrdpEM+v/5McpDP/DtbRonu4bLotMZhs76YxbF5ut
         5/+SLXpFp0aD7VCyC2Cd2wFH4tlaoawmb0jMxdkv/VWTa8JfVmcyWTHpPcZx2GaVy1fw
         pC5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=WeXc/Ao+LnCoDUTx4VGRj1iHDitMElHV+QHmbKrVox4=;
        b=VV3N5g0kobzJPk424PD+r5LLZ86BLiiWjBtrmIoVC83x/aCHjrHtWu6vVUmbzVMmsO
         YwTxSz2y2+Q/7I1yaMjid5ZDuiE5XekmSkPkGqg8lft1//I9L5PJ2aL9OMB33OGLIGZK
         nbpW2uTMUWPc1pkpAKl/8vdrCwaYt9iLajLM5OQwVTMF2pRtIPjmziD75bcmokyuOWAk
         lzu3kxyKca94aF/uBVutKa/7CNUEtRSA7RWKVR6SSlxk8DT0r1bzDWurL4mejI7jPlHY
         FgNzYxfr9vDiGz1+drsYq0GWr5p2JzNVIeHSzrSm8bUrk22DoTXNZLRr7uW6WfPdvyuk
         875w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=XDfO2s8k;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=XDfO2s8k;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
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
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 21/37] x86/mm/pae: Populate valid user PGD entries
Date: Mon, 23 Apr 2018 17:47:24 +0200
Message-Id: <1524498460-25530-22-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552512896556873?=
X-GMAIL-MSGID: =?utf-8?q?1598552512896556873?=
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
 arch/x86/include/asm/pgtable_types.h | 28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/pgtable_types.h b/arch/x86/include/asm/pgtable_types.h
index 1e5a406..65f2dbaf 100644
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
@@ -267,14 +268,37 @@ typedef struct pgprot { pgprotval_t pgprot; } pgprot_t;
 
 typedef struct { pgdval_t pgd; } pgd_t;
 
+#ifdef CONFIG_X86_PAE
+
+/*
+ * PHYSICAL_PAGE_MASK might be non-constant when SME is compiled in, so we can't
+ * use it here.
+ */
+
+#define PGD_PAE_PAGE_MASK	((signed long)PAGE_MASK)
+#define PGD_PAE_PHYS_MASK	(((1ULL << __PHYSICAL_MASK_SHIFT)-1) & PGD_PAE_PAGE_MASK)
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
