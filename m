Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx486v6lzIRxbNe/tLTX+srhsB06p0kvf93RDQICZnBOF2wde5jijMc6oIH1gpM6J/BUGqz61
ARC-Seal: i=1; a=rsa-sha256; t=1523892347; cv=none;
        d=google.com; s=arc-20160816;
        b=fA+WkxGJdyU0wyN94sCcMbl8VrrZ6fcpgNo5LtZR1Pmp8vNwzB09v+tWqlQfWn/xHU
         2CNePglPhid0/5nXDqDQVbA8R/l+McLGOTZsR1AZNQka5lVrKbvpyrCGfa+3UFkQzkyp
         AKYpGQWR6zhvfTh9k9QN7qDwspEZjS+AW0l9Z9o4hC+CnE0ZscnWVnhaBLN/IXN3V8HI
         /gmPK2R/iYha1hYPHT/CR3ngNBhU2EOAhooNUVL5FyMJ/soaEmebsUA3YcEBf3m3mq4h
         OR7TGCEzAhGKTT5A3XbnQGmzGu9bHj/waM0llNMJIhjOOHTT6czMIVWwi/eFZybrx5Sh
         V7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=YQx9cZdEuHeJE+gwrrn8Afu/0pGPh6Q3W4RpoMicy/s=;
        b=jCZx1D2iTwjXl1IKgILt2/q/itwy+8vKP1bSNkw/gDiT4wdBse+RR2sOa7r6MvYB2P
         MN54Hu6FJDPwEbJlLtYVtY8mz7bQg4PHiIw9Lsn85gUsbX1hZuax5GWx30Ji9Q6Op1dA
         bqTgZj8IxZLMfwOBgIMmtlCUkdztZYbwYEXAn3MrjrVdS/Efp8dz+VNGjbnhy4bOTRki
         GFP2Cps56oIar+Ku+iaJgXIs2VHJcL9aRBfYTZ2BrdMNV7ItEXqGojZ8ArzcCFeSq8Jo
         V6LPl7C+rs2YJXi1A2TaMs/pduDGhYkvCuPE6HoBXK21LD38r6K55AO7ih9W3mfAuiG8
         upRA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Z7Y/saWu;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Z7Y/saWu;
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
Subject: [PATCH 22/35] x86/mm/pae: Populate the user page-table with user pgd's
Date: Mon, 16 Apr 2018 17:25:10 +0200
Message-Id: <1523892323-14741-23-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1523892323-14741-1-git-send-email-joro@8bytes.org>
References: <1523892323-14741-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597916942344753532?=
X-GMAIL-MSGID: =?utf-8?q?1597916942344753532?=
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
index f24df59..f2ca313 100644
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
 
@@ -229,6 +232,10 @@ static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
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
