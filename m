Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx49dQ+GkQys0C5I78/bciBakpoOmmD10z/eNHMFJMB8LfmqiCyj7wGCe490HOi0WuJrc27zV
ARC-Seal: i=1; a=rsa-sha256; t=1524498477; cv=none;
        d=google.com; s=arc-20160816;
        b=YI6zNhC2Yi0G10yqb8SwBGG1gIoFUDaR3TuG+t1TscAEiH9kTvlmixqZG6wv5brfvZ
         taXlgiabADwpmTGPSkhFHPYaNjApBP7jxWYNB8E+wsfXyyQxwCQq/H1LZVQcvbfWnyfm
         aL2Kc2VE22IZRpijelIkYd0LoqaBkmQFal+qGZKkB1poIiga3zCXosfT8BSAQJCr/w2x
         NBdaF/yv4QxXb7yhHDtLwPMz5T35SgLAvMjU+vv/LDWzoZ4kcudmMNN/sOC9dcSCXO4g
         7GJAwIDiNjjwqDW62i4UUEifBQBlzm4sHdFvkHvpmtZhFWpRap0cJCbDvZzvczgzXWrU
         MfOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=K+DM/iUTmS3QBSAQC0ndYk5BtfjhFheYemUNlnJnRLg=;
        b=cAbpjZ/4tVCv3n7BMLyiadeDQvU2sySikvoZGbdkrEEX+xXXkrUm7dTxyMEQQir6+B
         UrG6Z7PdvZ1Z5KgaaaO9Fp+kDgYcpbecFXoPc23bjhgLdmszka6f1G2avKoK0A+mLNNj
         Y2WcWRtr/VAdN3v78PCZt5stud+XA+3oGuAnpcWIiSyLCWFaC3WXhn2kN1gbTF4SaAek
         vewajEXULm8Mhl7xS77uSu/PseF8ojogYj3PoTkKS3H8zEMb+PA2e9FTKhEx2AU6OK1H
         268rNMvcufJhBN0esfPbT+WcIqgvpWnG3Gw+XHEZda26sipwVnriq2oB7/eXlYfbSdrp
         Q6Qg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=fTdSsyOW;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=fTdSsyOW;
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
	"David H . Gutteridge" <dhgutteridge@sympatico.ca>,
	jroedel@suse.de,
	joro@8bytes.org
Subject: [PATCH 26/37] x86/mm/pti: Clone CPU_ENTRY_AREA on PMD level on x86_32
Date: Mon, 23 Apr 2018 17:47:29 +0200
Message-Id: <1524498460-25530-27-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552516032649275?=
X-GMAIL-MSGID: =?utf-8?q?1598552516032649275?=
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
index f967b51..9cceae3 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -348,6 +348,7 @@ pti_clone_pmds(unsigned long start, unsigned long end, pmdval_t clear)
 	}
 }
 
+#ifdef CONFIG_X86_64
 /*
  * Clone a single p4d (i.e. a top-level entry on 4-level systems and a
  * next-level entry on 5-level systems.
@@ -371,6 +372,25 @@ static void __init pti_clone_user_shared(void)
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
+	pti_clone_pmds(start, end, 0);
+}
+#endif /* CONFIG_X86_64 */
+
 /*
  * Clone the ESPFIX P4D into the user space visible page table
  */
-- 
2.7.4
