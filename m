Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELtAGlSDLke1XrWWb1fnx88PQ/o8Vsm/9Li1F14s71rPacNAtDYFWahUGqXQpVtfEu+p7Qrb
ARC-Seal: i=1; a=rsa-sha256; t=1520245578; cv=none;
        d=google.com; s=arc-20160816;
        b=R3TWCTCQK3DmblTB71coSzFCW6Ssvi7SLepbPRZsdT6APdVpj58aYh2QWU5GT/XJU+
         vdWNuhTxsXiMAiVfwOHflQcZP9m0sCZ5AZofjbsrB4C+I8MmItauCnrsOiTPTyLjVjpa
         mHvIJTWfkMLDN4Bb9vTHGqvMjj+Vu3CC0FLKTQ483j1qMm1duDvjHuLd9Tm9rSAoV46r
         KhzTaXQ5NN6gGBSeBoa8oMIm9KY0IWbABYf5oIrBPN7m2U84/TovVjHKPC+UKI/yB9sM
         rwUTcR6DcFy0Tm76QXD6O++b6PXLZwOIYD+08LgT4wyfQz8eSTwnCxuBdMGAvz9p2cVO
         y+rQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=fxqqdR30HdE5nJ4R83bfo1x7u9xYefePfoB7rp7Zl2Y=;
        b=kLSkIU8ZwWWhwGEo66e4pDFLXvc08MUZM4d04gtWFw1Rjp15gP4nm+IZMKbwXNwq5j
         qIswKW9FazBcBdUlAqfjCKHrjBq5EnjwKqfpokk781U+sDqrCEyxowXPtzPJoBEOTNna
         8pXSOD5LtJpKtqvqQOFV0o767miwc/OLAfyiezzLQUwMkFpB34gnaAlBiYHY+g/d6Ulx
         U0aY9ih8A/Mbv6MeasckHjpACljBxNRuOrJujb2BnO8U8yQO3flKBNlTC4zlKXw5N/o1
         LY3a8cu2s6kdrxIlocTBMCTC4fY+0deQE0BjN0PYwX3lR7m5fF3Y4g3Gm7hhJi0Twn4w
         HuhA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=bdBLHE7Q;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=bdBLHE7Q;
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
Subject: [PATCH 26/34] x86/mm/pti: Clone CPU_ENTRY_AREA on PMD level on x86_32
Date: Mon,  5 Mar 2018 11:25:55 +0100
Message-Id: <1520245563-8444-27-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093028419811410?=
X-GMAIL-MSGID: =?utf-8?q?1594093028419811410?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Cloning on the P4D level would clone the complete kernel
address space into the user-space page-tables for PAE
kernels. Cloning on PMD level is fine for PAE and legacy
paging.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/mm/pti.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 96a690e..3ffd923 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -312,6 +312,7 @@ pti_clone_pmds(unsigned long start, unsigned long end, pmdval_t clear)
 	}
 }
 
+#ifdef CONFIG_X86_64
 /*
  * Clone a single p4d (i.e. a top-level entry on 4-level systems and a
  * next-level entry on 5-level systems.
@@ -335,6 +336,25 @@ static void __init pti_clone_user_shared(void)
 	pti_clone_p4d(CPU_ENTRY_AREA_BASE);
 }
 
+#else /* CONFIG_X86_64 */
+
+/*
+ * On 32 bit PAE systems with 1GB of Kernel address space there is only
+ * one pgd/p4d for the whole kernel. Cloning that would map the whole
+ * address space into the user page-tables, making PTI useless. So clone
+ * the page-table on the PMD level to prevent that.
+ */
+static void __init pti_clone_user_shared(void)
+{
+	unsigned long start, end;
+
+	start = CPU_ENTRY_AREA_BASE;
+	end   = start + (PAGE_SIZE * CPU_ENTRY_AREA_PAGES);
+
+	pti_clone_pmds(start, end, _PAGE_GLOBAL);
+}
+#endif /* CONFIG_X86_64 */
+
 /*
  * Clone the ESPFIX P4D into the user space visinble page table
  */
-- 
2.7.4
