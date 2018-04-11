Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx48TsJr/XMvhWpT91DE+U4sAF70nisxx104cajVvStvrNvwvosgLr6qiuJWUbWH/Jz5bDjS1
ARC-Seal: i=1; a=rsa-sha256; t=1523460282; cv=none;
        d=google.com; s=arc-20160816;
        b=fGaUtfpydFnaXMjWtomRVrTLNePpwfSN1JKlbsHbcn5S6tn4jQG87DBMO8gB3yiO0z
         Sra9Oh+XyEP5HYQBcfDNtPIExOpQm5yp5POJssCvSE/mgJypOTV7SNp7MJXJEzXSzznl
         9kcACmLPY9yb1bH0APUlHZZq+Xh/vZI2r9UnV6iTj0cWWsV/Zkj0sDVtmAScF/HRc8Vj
         oW3wJ7pUXUZMsTAD4rC7iOOZ+tO72VEXrMxyYDcHOqLbxowsqtefYblgpChpxgZcdhjp
         YDgAPgyuClUf6aL8Ci/8zSWvPAJG7wMuTnIFjCbexbqgzp7ZtJ5T6yRrEyxVz5qG+16C
         eszg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=D/DYAdcDIGj75chQFZ3E+Z9V4m3Skqel1QbyfQ1R6d4=;
        b=RWQeVvW5jbVo5fIALthvBtK7qykytjoiFNSd5nC6dAIEPV/nJrzb5Z/al4LUhVEtY4
         InfR6WkvzeWa5qwJ2yRNT7wxTdU7jaSSHwEGoDwGcqxTjj5RGuqyH5ev7hf8J24Sbjn3
         EKdrDodmZcUw/lJOIOTtvCdwAJ4AJz40/3bpFYKAwvLmEWUEFkdu+FSvRdmiWC4wb3FL
         kebzJAaNTTdS9GcuQDV7BSlYWuxCE8fEFKL2RD4eMawS70mVvQXWx12RwyYorVoXIN7S
         mmyOQ9kDIN8LGc2cviGieZq0/3mQR5BXcdY5IL0/NOHruGO0e+611LatWrOS/JMgqtqq
         8FKA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=MUZgK1Fk;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=MUZgK1Fk;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Date: Wed, 11 Apr 2018 17:24:38 +0200
From: Joerg Roedel <joro@8bytes.org>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
	"H . Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>,
	Dave Hansen <dave.hansen@intel.com>,
	Josh Poimboeuf <jpoimboe@redhat.com>,
	Juergen Gross <jgross@suse.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Brian Gerst <brgerst@gmail.com>,
	David Laight <David.Laight@aculab.com>,
	Denys Vlasenko <dvlasenk@redhat.com>,
	Eduardo Valentin <eduval@amazon.com>,
	Greg KH <gregkh@linuxfoundation.org>,
	Will Deacon <will.deacon@arm.com>, aliguori@amazon.com,
	daniel.gruss@iaik.tugraz.at, hughd@google.com, keescook@google.com,
	Andrea Arcangeli <aarcange@redhat.com>,
	Waiman Long <llong@redhat.com>, Pavel Machek <pavel@ucw.cz>,
	jroedel@suse.de, "David H. Gutteridge" <dhgutteridge@sympatico.ca>
Subject: [PATCH] x86/pgtable: Don't set huge pud/pmd on non-leaf entries
Message-ID: <20180411152437.GC15462@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597463888498671722?=
X-GMAIL-MSGID: =?utf-8?q?1597463888498671722?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Ingo, Thomas,

below patch is an update to this series and I plan to include it in the
next post. David H. Gutteridge (CC'ed) was so kind to do additional
testing of these patches and found that a BUG_ON was triggered in
vmalloc_sync_one() when PTI is enabled.

My debugging showed that the bug was present before my patches but that
they uncovered this bug by setting SHARED_KERNEL_PMD to 0 when PTI is
enabled.

So please have a look at the issue description below and the patch and
let me know what you think. I know there are other and better variants
to fix that, but I felt a rework to make the generic ioremap code more
safe against this is out-of-scope at least for this patch-set.


Thanks,

	Joerg

>From 48cb37800794be8f0611e87f9ef23774c3b36ecc Mon Sep 17 00:00:00 2001
From: Joerg Roedel <joro@localhost.localdomain>
Date: Wed, 11 Apr 2018 15:55:14 +0200
Subject: [PATCH] x86/pgtable: Don't set huge pud/pmd on non-leaf entries

The pmd_set_huge() and pud_set_huge() functions are used from
generic ioremap code to establish large mappings where this
is possible.

But the generic ioremap code does not check whether the
pmd/pud entries are already populated with a non-leaf entry,
so that any page-table pages these entries point to will be
lost.

Further, on x86-32 with SHARED_KERNEL_PMD=0, this causes a
BUG_ON() in vmalloc_sync_one() when pmd entries are synced
from swapper_pg_dir to the current page-table. This happens
because the pmd entry from swapper_pg_dir was promoted to a
huge-page entry while the current pgd still contains the
non-leaf entry. Because both entries are present and point
to a different page, the BUG_ON triggers.

This was actually triggered with pti-x32 enabled in a KVM
virtual machine by the graphics driver.

A real and better fix for that would be to improve the
page-table handling in the generic ioremap code. But that is
out-of-scope for this patch-set and left for later work.

Reported-by: David H. Gutteridge <dhgutteridge@sympatico.ca>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/pgtable.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
index d95bc7b1ffb4..6b72d2805058 100644
--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/mm.h>
 #include <linux/gfp.h>
+#include <linux/hugetlb.h>
 #include <asm/pgalloc.h>
 #include <asm/pgtable.h>
 #include <asm/tlb.h>
@@ -699,6 +700,10 @@ int pud_set_huge(pud_t *pud, phys_addr_t addr, pgprot_t prot)
 	    (mtrr != MTRR_TYPE_WRBACK))
 		return 0;
 
+	/* Bail out if we are we on a populated non-leaf entry */
+	if (pud_present(*pud) && !pud_huge(*pud))
+		return 0;
+
 	prot = pgprot_4k_2_large(prot);
 
 	set_pte((pte_t *)pud, pfn_pte(
@@ -727,6 +732,10 @@ int pmd_set_huge(pmd_t *pmd, phys_addr_t addr, pgprot_t prot)
 		return 0;
 	}
 
+	/* Bail out if we are we on a populated non-leaf entry */
+	if (pmd_present(*pmd) && !pmd_huge(*pmd))
+		return 0;
+
 	prot = pgprot_4k_2_large(prot);
 
 	set_pte((pte_t *)pmd, pfn_pte(
-- 
2.13.6
