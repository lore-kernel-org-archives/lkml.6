Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELtjO8ebTfi4woORvZ1YRX851XGsJ4OwZ5pROrdhDuP+Kz2CIALVwvz1TuE0YpGTKHYyjUyj
ARC-Seal: i=1; a=rsa-sha256; t=1521228607; cv=none;
        d=google.com; s=arc-20160816;
        b=jYK5UIiqh1Kf+DZPmvHcXK7DUpD17Tibe6MU6AtxaoG4SquaspMX8YrOHyLdTY2wql
         lDjKgPiLKJvF0WJqGR9dqUg0U9bd+plkUaUQZfwNLwqrtq/DUeYAK/CWqxJmFy0IQb1m
         RArjuX7iu0GEEgfQtvJT4mk5VLfav7eeS04F134nqahded0zDtPSTsdQ0r1T2w0c0u4T
         TucZtpcgIfm1lHTW/K9GkRiroj1VafAwwfvMQ/LyoVZREzmID61Uinp0+Sr2JvAy60ex
         O+3x61NKwgj4Cs4jmBlzqFn0cY65FFVN/vBv9Uvrha0dSW0B5Y61qaUBuzIAvxCpBJpE
         RABA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=4x3jaKCTpOjd7aP6kGef2VaGv6jG5TscCsECPMsIZvU=;
        b=PMUg+7zdrPziqodNOca1ntsOogsFTkv2JdrFSDzUHgiPmmDK7IGHYfnGT1F6o2rjUm
         rSeF/L8Yhb5GV7kmVI+pEui1747KyeU0eHwDN9EEH2x5IGN6B6iumBC8FtjXbAuaYV8V
         AgjYd1jPRmHXfTPmw0elns1IdUwB2JNVbeSgJRr3GNMkskPZpuqui9TLQNxWqUbESMoB
         APGByfpxEGokBV8hJao9dzLycvkRb6w97Zd6IR5o73lYqTkke06RwLTXITM0W+slAmRY
         29Xq0npwjvgE8iObHV4oJHQl5wR6m4gIrMOEyoFNdJX2YoybQvQrAlaoGh5GaMKCKDBH
         FOMQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=qnWbDljl;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=qnWbDljl;
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
Subject: [PATCH 22/35] x86/mm/pae: Populate the user page-table with user pgd's
Date: Fri, 16 Mar 2018 20:29:40 +0100
Message-Id: <1521228593-3820-23-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1521228593-3820-1-git-send-email-joro@8bytes.org>
References: <1521228593-3820-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595123808400466918?=
X-GMAIL-MSGID: =?utf-8?q?1595123808400466918?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Joerg Roedel <jroedel@suse.de>

When we populate a PGD entry, make sure we populate it in
the user page-table too.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/include/asm/pgtable-3level.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/include/asm/pgtable-3level.h b/arch/x86/include/asm/pgtable-3level.h
index bc4af54..ab2aa44 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -98,6 +98,9 @@ static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 
 static inline void native_set_pud(pud_t *pudp, pud_t pud)
 {
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	pud.p4d.pgd = pti_set_user_pgtbl(&pudp->p4d.pgd, pud.p4d.pgd);
+#endif
 	set_64bit((unsigned long long *)(pudp), native_pud_val(pud));
 }
 
@@ -194,6 +197,10 @@ static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
 {
 	union split_pud res, *orig = (union split_pud *)pudp;
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	pti_set_user_pgtbl(&pudp->p4d.pgd, __pgd(0));
+#endif
+
 	/* xchg acts as a barrier before setting of the high bits */
 	res.pud_low = xchg(&orig->pud_low, 0);
 	res.pud_high = orig->pud_high;
-- 
2.7.4
