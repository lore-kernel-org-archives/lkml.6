Return-Path: <joro@8bytes.org>
X-Google-Smtp-Source: AH8x2246C94oGt91XOfZ21K4/QCjCliieuHcctQMen9ZygXtmoJnJ7z2WDZoFJDSSFpDzcE1qKNw
ARC-Seal: i=1; a=rsa-sha256; t=1518168364; cv=none;
        d=google.com; s=arc-20160816;
        b=PvN52CbVFIvYi/FeY2AL+j/ZGo299Dr1uima6n8KeWLnDebiFlcHPeEfMTtXS6Wz4a
         smN4s+FPRvpmbjIDLNyFv/yMpkkf6CEyqk38A/6UrZBSD++ceFG1YsDacrjb6msTg2ek
         cQhLxfYT+/ud/QRPy6v+EGTOf/qirQwUdSLIddPMyGWxcwNTfkxExyyU9zsKmNxm9Yls
         WGJcs/b9kFluxvsEL1PKdbHLVbsdWC7n7nnmb0VrghMIEeTi6sGWz5Z6B11WLieBYvFd
         kzE4JlP/TbXVaHCu9DC6iwqlJ05BcFleopXYjf/ufB9IunRhuiGlF2EgxR+xH20f/R/P
         dRcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=RSY1WN7/qksWLFMQ3sD1qFl/qtSJ5fxfios+fq9yDg8=;
        b=UNKvL1PYq/yEA8lxrpzM0Viqi3WyX36HW8OhkZtUHKDwRqrjGfOhTkSoJro0YM2i7B
         9m5/mJZMYqwLkFnaSGf3F5/yilJ3rOqA74PnaO/egGu3pfVxhE/3wh8l5Ouf7SpnImQp
         ap898SWGDug4+bx2O4IZq+45sTTLnc8dEB3k5vpyaqhv49WpCHWkSRi+DEYhy9+HVK9p
         20CqQivktc2vkoD4syuDEqDMLKjC8IPHbEvrYSHnTjF6odpBeL/mUKEQKXovcQZLEbsK
         k0Mul+6DY3AUHtApUj41pQJq/H7rObepa57A2rPH6NFdqlAeCV8tQakxlDxLoZPZi030
         Ns3Q==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=kJAw4kZ6;
       spf=pass (google.com: domain of joro@8bytes.org designates 81.169.241.247 as permitted sender) smtp.mailfrom=joro@8bytes.org;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=8bytes.org
Authentication-Results: mx.google.com;
       dkim=pass (test mode) header.i=@8bytes.org header.s=mail-1 header.b=kJAw4kZ6;
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
Subject: [PATCH 20/31] x86/mm/pae: Populate the user page-table with user pgd's
Date: Fri,  9 Feb 2018 10:25:29 +0100
Message-Id: <1518168340-9392-21-git-send-email-joro@8bytes.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518168340-9392-1-git-send-email-joro@8bytes.org>
References: <1518168340-9392-1-git-send-email-joro@8bytes.org>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591914910930783866?=
X-GMAIL-MSGID: =?utf-8?q?1591914910930783866?=
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
index bc4af54..1a0661b 100644
--- a/arch/x86/include/asm/pgtable-3level.h
+++ b/arch/x86/include/asm/pgtable-3level.h
@@ -98,6 +98,9 @@ static inline void native_set_pmd(pmd_t *pmdp, pmd_t pmd)
 
 static inline void native_set_pud(pud_t *pudp, pud_t pud)
 {
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	pud.p4d.pgd = pti_set_user_pgd(&pudp->p4d.pgd, pud.p4d.pgd);
+#endif
 	set_64bit((unsigned long long *)(pudp), native_pud_val(pud));
 }
 
@@ -194,6 +197,10 @@ static inline pud_t native_pudp_get_and_clear(pud_t *pudp)
 {
 	union split_pud res, *orig = (union split_pud *)pudp;
 
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	pti_set_user_pgd(&pudp->p4d.pgd, __pgd(0));
+#endif
+
 	/* xchg acts as a barrier before setting of the high bits */
 	res.pud_low = xchg(&orig->pud_low, 0);
 	res.pud_high = orig->pud_high;
-- 
2.7.4
