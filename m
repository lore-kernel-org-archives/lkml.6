Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AIpwx4+pDDQD7SjSANXfZGbGoVViTLOSgLOi8kPIM6OwewqUdlDQPxYzsdpDPaUQRjeRDHBJrclw
ARC-Seal: i=1; a=rsa-sha256; t=1524498474; cv=none;
        d=google.com; s=arc-20160816;
        b=rj6ziwOehLP+EKTrctgWGGwIZRKpyRjX/nj4l0yJHuSdRFVs5F8ISOHe1mZqC3RcVI
         8dTIolfzmTSkNL+azHsAAt7siY8Er7DR65cqHXzNllM13zIFhrLGFDSy8ZCGwvDrZdmd
         ZmOimLp10md1pAuo0SVPm7gdBsKTBNnKCdE3Ys14NBknvEuIbR0W/GPzotljFtYx/2k7
         LgVDgzXpxYdHgxdZyVYtxJNSBqUaXx4NXVf1+lRW57LvY57p39PDcV3Tzc1TjE7Nq01i
         N57UguYQnx+AvJbWwYB9EQ3JFQXv+8HM7xGyKiN33CrUffRYQyk+eYHvSswZMkhZznIH
         iLGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=YQx9cZdEuHeJE+gwrrn8Afu/0pGPh6Q3W4RpoMicy/s=;
        b=nBsZcld8IJLX0nyFP695St0rGaQ5z36K2BMDoybcPUblqVuab3Z4eMnQ4489cE93KJ
         H9nUPa2lhCo7Df8aYFKwWapqaDHR3WewFnoK4V4zx1dT0gUQAS53utpfaUNKm177Owmb
         REotdiWVxGTLQeicfWAE3Vuwo0yD8Do8gZZuFedfRJTrVGNZNBF3rxosBXCoI0NeiIQD
         SqP4jMhQxFgDXH1IYv0nryOCfnxu3/RSBk10lN9MlYOHSp/EM7SWCX80MXl5/LVVgWci
         Qt3EQz3kx7J3bl+bKqx+Ob/u2P7UCRnmi6FO3ByeVJTJMh+DiDD3WT31xmYkxFRfRSBw
         FSnw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Q/jOhaaL;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=Q/jOhaaL;
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
Subject: [PATCH 22/37] x86/mm/pae: Populate the user page-table with user pgd's
Date: Mon, 23 Apr 2018 17:47:25 +0200
Message-Id: <1524498460-25530-23-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1524498460-25530-1-git-send-email-joro@8bytes.org>
References: <1524498460-25530-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598552512391072402?=
X-GMAIL-MSGID: =?utf-8?q?1598552512391072402?=
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
