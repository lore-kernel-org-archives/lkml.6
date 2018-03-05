Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AG47ELvCe7VM9AI36n7wuc83Ag/I6A3Qm4q0VEHgCiOMK7xmpSleEYQKFzwo5mfbBc0l+l7iFUmK
ARC-Seal: i=1; a=rsa-sha256; t=1520245578; cv=none;
        d=google.com; s=arc-20160816;
        b=j8n89QfJao+YOyh/JJXUbnX/KhfVdmZclEDkr/jaB38Cbgtdxqb9dhZLY06JzICkxS
         aVzNBHV0V4I24+LARO0ulc4jkZBy9jjxXTZKuDguQjTkobnmPbk6UprH439StSuaEMY7
         N6+1mPNYGVzypHqn8b9VqATvc2FRHbazOL/e5Y3aSa6HTnt16c6S0/orSleVdIK5wmsB
         J7hdZfmalyOtDYfxiNhpV4NQ/VZbtME4vworlgRuBSJrusiosuSvT7vRGAmeppKiXuCt
         5f677U1sScVPxcHcKmr6lsbVlTlU3UrraWlnX9TzUc6EMlxyrp8Jr/kdADJARG8zOWUK
         o6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=4x3jaKCTpOjd7aP6kGef2VaGv6jG5TscCsECPMsIZvU=;
        b=q8ZTpLsoucuL7EUj+QO1a3MYVvMTSLv5cMg5Ur8HV2lrCnhclCVipRXezB8d5SpM+S
         SgzSchRdGEF9ZXreSsMZ5cPrHlhpvZ6s6eWDcB0GPW9QMfLTMxLnIeVevsnuBnCGqwZu
         rlsY+Hv9ITZLI6f4S8gbtRttKoU6bN3L6rtGNpJ3JQglb6AFvBF94fKwvbz3psDyKm5+
         vNCH21sS7aupn8fTebq7iDWOAoHjIVT2YIZ/3kOqT/XDi7plEd7a2+XXECuzcSyAC40H
         g/5PFo2PIoEEYhfGO0S7wdCIXSMCpNAt5m4T9r5KfuK0gHX8QC4dNIBuGYnQ9mOMXOiX
         jHpA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=RX62EDQy;
       spf=pass (google.com: domain of joro@8bytes.org designates 2a01:238:4383:600:38bc:a715:4b6d:a889 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=RX62EDQy;
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
Subject: [PATCH 22/34] x86/mm/pae: Populate the user page-table with user pgd's
Date: Mon,  5 Mar 2018 11:25:51 +0100
Message-Id: <1520245563-8444-23-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1520245563-8444-1-git-send-email-joro@8bytes.org>
References: <1520245563-8444-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594093027870782202?=
X-GMAIL-MSGID: =?utf-8?q?1594093027870782202?=
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
