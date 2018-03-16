Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELtPMk+Ht1gyJzFqxL2SdA92ItpG50H2PJAa7RURpQdQi2vAhz/yBqsvDD0BbCCDD99wAN6s
ARC-Seal: i=1; a=rsa-sha256; t=1521228608; cv=none;
        d=google.com; s=arc-20160816;
        b=BBbu/SqYTp3ILgw2LKMH7hASan/4NwM4VKalVhwFVxUc1uJNUJWzVxUAX59NX5ZfhE
         HUP/d4XPboQFKL9z8/3i6NERYiLPnSl/eepeJAQewBnK5CDQEGPVzR1CEkDDoF1b8lGG
         EhwYDPsbCn6jfuRrJky1l7DENaqEjGnwRpH7891bvFLDUa7jYIEOzUK0OI2TW679yaNB
         ziMe4FylThKdkFfsDMwh+kmsDTmuX4GvD9L74KSjO6o/X1lqEIkVsV6kvxO7++SNixEo
         LiGadBYSp2qATvzo1ojNvEs3GIfRCQEv1p3RoPwZRsD1ZQAShTeDeL/mpyneE4plMCWl
         eVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=OtmgrQzGNTF1dKS8rsrXdj2gmkkzEVOS8D3O/x8SeY0=;
        b=a+9TbxBr7BpYrlzQvoNYL3DqfPN4WKPXYVWwz2/lc47+QfBZhPlLCxPrfudgGV5dHW
         26cPgcQ1gWkuzuN18GlAt0SxuRvU2/i5VeTOn3OA51f8pMDJpeuW9++4JTFaNJ3+BGEf
         tAOgPhR5QxUIoVrPlOQjTn7GDCRxmCx4OGphI6zKT1bMmamSDpmyx+Ifhz6268PtT/ED
         Oxg97ZZTn4n0OEXyc54Cv+0X6VgA3ZSH3pXVC6TmyUS/YNACNw07SWnNJi0pv+xv+yL+
         rx5ESNMnYggLMgaq1heOIJMUUuKkc71SRtzGmXdfdikkD+jZUIRHqTdQ97k7ZitkK4AJ
         sa9Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=HAJ3gCTV;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=HAJ3gCTV;
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
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 21/35] x86/mm/pae: Populate valid user PGD entries
Date: Fri, 16 Mar 2018 20:29:39 +0100
Message-Id: <1521228593-3820-22-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123809173379585?=
X-GMAIL-MSGID: =?utf-8?q?1595123809173379585?=
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
index 3696398..48fc70b 100644
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
