Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x2273EiEMQpVGzyHf8LDSnT1JYaffqD0y3jABW7n3LVRvKZJMTQ+uHWJBpvERmjC7UQzHnpAf
ARC-Seal: i=1; a=rsa-sha256; t=1518168365; cv=none;
        d=google.com; s=arc-20160816;
        b=VRh1KlX/lAncZNwYqfLui5TTrNQOAjHmkklkItRv8Y8760WvczTT7gnCa2kZgEZlz6
         fCUK5ZrkmyfoH7hwujyR9CJU2i7AwlCcQuAxYAll6iOB0WB1fmJE8YTej8kHGsjuRAJI
         7QQUzi3+hTXPVYVw8AaodMJeSmgNiFYXILzHmVdXlXKCA0iqE8QzCziWMFHpUbmpEEH1
         O+uPv4Z9k9JdWFSRIQPR5aDFSvonMJO3MXXP+WbCUw1T2wbjkSUYe6IQFtZFkbFo8p8w
         VbUbELM0j4mAr4MBDLJ/qLttqsN1N7B4wQZc1jTYt4slz5yD+ohy/wdRnc68ntjngEjY
         SLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=oYC3VCVmw4xmAo9+2f9aJAJDcdMYv4+pCeVRgT5SRog=;
        b=wdGhRnXYk2O7qT7b6bDgLbTB5S/7VV7m3DFEGGNKWUSmAG7VwqB9Y0qwLqbzxpq0zY
         9dIbWQVlemfBQRmd+7s1Y7jPxWgOw59tBx+U/Thf6lTGhAgScl6D6W3A36j6P3dBEq9U
         MxdKotXhvOAmKjcyI05ZeCx9AFPaw4ahbzfUuNaT1/124VVBoT06ddEFTK6q4oP90A0x
         hWXT3js9kZATplVTONOjkxvFJac+lstzL0T6O3bDXAtHGYjLs1mfsxmphDs+HWfh+Be8
         iWrXHhc2J7QSxjm2OgQ9zRdKeQsYBzBQsweeUfwqTNuWEtCajaddntE9kyDig/q4ffYS
         V2zg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Hva0t/xU;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Hva0t/xU;
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
Subject: [PATCH 24/31] x86/mm/pti: Clone CPU_ENTRY_AREA on PMD level on x86_32
Date: Fri,  9 Feb 2018 10:25:33 +0100
Message-Id: <1518168340-9392-25-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914912031319296?=
X-GMAIL-MSGID: =?utf-8?q?1591914912031319296?=
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
index 7f5e698..ec9852a 100644
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
