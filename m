Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4957eBxNypc5hazcYkTIgT1/VXVEHXx/ptjm0ECNyWduP9dROpW6S3f+EfWckWdM4UX8Dau
ARC-Seal: i=1; a=rsa-sha256; t=1523892346; cv=none;
        d=google.com; s=arc-20160816;
        b=dbSMBLrvkdv3uNK3sHqXXUlzZPdhUoVO9MB9zX1PT9GQem/7qkLQJ5fmqloxrCWcSQ
         GOkEwbTBtSxMVUoUaEkobvNUx7ELQ0Qx86vXbYXF3ftNXiWdiZVOQQrqYdqWzeqU/0pd
         wwq5jPfWrYSFkFQ6r22vyaxLq5yKVKq6uQWXQUr/ig1bKf8bTjlQ/Rlk7LdGITfVA7/O
         HQ3xMYy1u+bNmVvEf8gC+zl8ohPnIPOXRFpHeciNvytQj8nziYggkM8sjrIQypLs99cV
         bPhZXWJoq1d20JJBJzEpSNQMp+SyMGCj2lSl1eNaKX4z8IbF1VLgVbOCgoywxBzBZbb5
         q24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=oozxANMdWBcdwALT2WlhLJ6jhio16x9xwtmQfgR2FgM=;
        b=lCl2YuZV8WVJ1Zy5EDph7+40B/mwvGjRkh4sg6rLLHjmr4K3IM7FMuo1enCKcCzJRN
         08qc/UJu3sITTrqP8VeqbHQW3PsX2oCIfABLimOvSzo6fY3vEQ1DydmNplsjjqX6aBjb
         hq8x/mNeyR3Bt+KpwIZVRAryD48lPb+fUfnWVBtWeLYAuGeEGPHqUWmFwXNEg58bNA6e
         pbHEaur4bUSlx9ssLBf6VTLJIjAeWR/OoVub3qBb3KDzSwVxWlLvf1CHGznv7bDoJLfM
         p0+cPsgBwc5IIdAUK3cYAHjk02XSKU3+4O+IH4j1SGGro3AOeoBqPgY9TL5LPIeIuQD2
         CDyQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=bq6sOx/v;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=bq6sOx/v;
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
Subject: [PATCH 18/35] x86/pgtable: Move pgdp kernel/user conversion functions to pgtable.h
Date: Mon, 16 Apr 2018 17:25:06 +0200
Message-Id: <1523892323-14741-19-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916941283338914?=
X-GMAIL-MSGID: =?utf-8?q?1597916941283338914?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

Make them available on 32 bit and clone_pgd_range() happy.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable.h    | 49 +++++++++++++++++++++++++++++++++++++++
 arch/x86/include/asm/pgtable_64.h | 49 ---------------------------------------
 2 files changed, 49 insertions(+), 49 deletions(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 5f49b4f..3055c77 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1150,6 +1150,55 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
 }
 #endif
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+/*
+ * All top-level PAGE_TABLE_ISOLATION page tables are order-1 pages
+ * (8k-aligned and 8k in size).  The kernel one is at the beginning 4k and
+ * the user one is in the last 4k.  To switch between them, you
+ * just need to flip the 12th bit in their addresses.
+ */
+#define PTI_PGTABLE_SWITCH_BIT	PAGE_SHIFT
+
+/*
+ * This generates better code than the inline assembly in
+ * __set_bit().
+ */
+static inline void *ptr_set_bit(void *ptr, int bit)
+{
+	unsigned long __ptr = (unsigned long)ptr;
+
+	__ptr |= BIT(bit);
+	return (void *)__ptr;
+}
+static inline void *ptr_clear_bit(void *ptr, int bit)
+{
+	unsigned long __ptr = (unsigned long)ptr;
+
+	__ptr &= ~BIT(bit);
+	return (void *)__ptr;
+}
+
+static inline pgd_t *kernel_to_user_pgdp(pgd_t *pgdp)
+{
+	return ptr_set_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
+}
+
+static inline pgd_t *user_to_kernel_pgdp(pgd_t *pgdp)
+{
+	return ptr_clear_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
+}
+
+static inline p4d_t *kernel_to_user_p4dp(p4d_t *p4dp)
+{
+	return ptr_set_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
+}
+
+static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
+{
+	return ptr_clear_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
+}
+#endif /* CONFIG_PAGE_TABLE_ISOLATION */
+
 /*
  * clone_pgd_range(pgd_t *dst, pgd_t *src, int count);
  *
diff --git a/arch/x86/include/asm/pgtable_64.h b/arch/x86/include/asm/pgtable_64.h
index c863816..9934115 100644
--- a/arch/x86/include/asm/pgtable_64.h
+++ b/arch/x86/include/asm/pgtable_64.h
@@ -132,55 +132,6 @@ static inline pud_t native_pudp_get_and_clear(pud_t *xp)
 #endif
 }
 
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-/*
- * All top-level PAGE_TABLE_ISOLATION page tables are order-1 pages
- * (8k-aligned and 8k in size).  The kernel one is at the beginning 4k and
- * the user one is in the last 4k.  To switch between them, you
- * just need to flip the 12th bit in their addresses.
- */
-#define PTI_PGTABLE_SWITCH_BIT	PAGE_SHIFT
-
-/*
- * This generates better code than the inline assembly in
- * __set_bit().
- */
-static inline void *ptr_set_bit(void *ptr, int bit)
-{
-	unsigned long __ptr = (unsigned long)ptr;
-
-	__ptr |= BIT(bit);
-	return (void *)__ptr;
-}
-static inline void *ptr_clear_bit(void *ptr, int bit)
-{
-	unsigned long __ptr = (unsigned long)ptr;
-
-	__ptr &= ~BIT(bit);
-	return (void *)__ptr;
-}
-
-static inline pgd_t *kernel_to_user_pgdp(pgd_t *pgdp)
-{
-	return ptr_set_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
-}
-
-static inline pgd_t *user_to_kernel_pgdp(pgd_t *pgdp)
-{
-	return ptr_clear_bit(pgdp, PTI_PGTABLE_SWITCH_BIT);
-}
-
-static inline p4d_t *kernel_to_user_p4dp(p4d_t *p4dp)
-{
-	return ptr_set_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
-}
-
-static inline p4d_t *user_to_kernel_p4dp(p4d_t *p4dp)
-{
-	return ptr_clear_bit(p4dp, PTI_PGTABLE_SWITCH_BIT);
-}
-#endif /* CONFIG_PAGE_TABLE_ISOLATION */
-
 /*
  * Page table pages are page-aligned.  The lower half of the top
  * level is used for userspace and the top half for the kernel.
-- 
2.7.4
