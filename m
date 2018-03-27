Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49La+2AzqqdwmA82X0E3Q+jGpsLWWEHR02fRqpYgkRi15nt323IprJdopkcRO3Q90aTdJ0/
ARC-Seal: i=1; a=rsa-sha256; t=1522168547; cv=none;
        d=google.com; s=arc-20160816;
        b=V37jv9UTw6FkAx563ANKv7r8m/R+b1wZzqxXDcwg4xHOF+LynGkX07TjFCVbtiUHC3
         Z5NqI8iYiQDq0BhOJ0k78Kf/RUv/vBNIvB2B9Fu1fmqSBnvdSSoWF7FhYMn6fT8GsvCV
         Urq/60EON4Fwaqqz8Oj+jA2AtZuHL3vjtpEcauy5CZ6V7430tg6bj3UfURH9GWkDr8Bh
         1iHmg+3Y2C0OJVEmV9P4FCQu2B0I/7306LV/+DPkpUPEmBfDTVu2ZOGVqnyiYIr7IRlE
         DL8m2Cd6KHTGT6QyhIhmGRywzfoxjouGt/xGUczUd0fhvTHRcc04OUs54Fb8lU5XRRS6
         fKxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=y15QJTofS7grVwKzCP1u2SWBrICxJwQd3Kitu0BRpmk=;
        b=skJFIkmDE9V+Yx++pOeKXOhx5i4E3zZt340Drgr9ixTpksg0MaTayYQfxxHqSaa0rd
         6piA0BqFWNFXZzRpiXKshBHwO5qTnetMRPZY9iIhtjFiGtqpse9oajWs6e/mSAugFCav
         kSgmjt0n6PcuWdaXFZe318Xk8+eV4jjuJmHLWKhbyR2n0a6oZTfq33N+23qZPOyQ3rt2
         mDzAU0YPwQUPFu94GwZ5v1TCcm2nK7dAiUIIjEPumYGxfBhB7qiy81/jqvsCDc5hMey2
         qZWZ0/9J43i7Ddcd7le9xN784W3vcPlrkiURZHtAllhIUybQfZ+0wCrleEoUXEW5FKWn
         k9ow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Toshi Kani <toshi.kani@hpe.com>,
	Lei Li <lious.lilei@hisilicon.com>,
	Michal Hocko <mhocko@suse.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Borislav Petkov <bp@suse.de>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 048/101] x86/mm: implement free pmd/pte page interfaces
Date: Tue, 27 Mar 2018 18:27:20 +0200
Message-Id: <20180327162752.983665316@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108991936577153?=
X-GMAIL-MSGID: =?utf-8?q?1596109406489896318?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshi Kani <toshi.kani@hpe.com>

commit 28ee90fe6048fa7b7ceaeb8831c0e4e454a4cf89 upstream.

Implement pud_free_pmd_page() and pmd_free_pte_page() on x86, which
clear a given pud/pmd entry and free up lower level page table(s).

The address range associated with the pud/pmd entry must have been
purged by INVLPG.

Link: http://lkml.kernel.org/r/20180314180155.19492-3-toshi.kani@hpe.com
Fixes: e61ce6ade404e ("mm: change ioremap to set up huge I/O mappings")
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Reported-by: Lei Li <lious.lilei@hisilicon.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Borislav Petkov <bp@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/pgtable.c |   28 ++++++++++++++++++++++++++--
 1 file changed, 26 insertions(+), 2 deletions(-)

--- a/arch/x86/mm/pgtable.c
+++ b/arch/x86/mm/pgtable.c
@@ -712,7 +712,22 @@ int pmd_clear_huge(pmd_t *pmd)
  */
 int pud_free_pmd_page(pud_t *pud)
 {
-	return pud_none(*pud);
+	pmd_t *pmd;
+	int i;
+
+	if (pud_none(*pud))
+		return 1;
+
+	pmd = (pmd_t *)pud_page_vaddr(*pud);
+
+	for (i = 0; i < PTRS_PER_PMD; i++)
+		if (!pmd_free_pte_page(&pmd[i]))
+			return 0;
+
+	pud_clear(pud);
+	free_page((unsigned long)pmd);
+
+	return 1;
 }
 
 /**
@@ -724,6 +739,15 @@ int pud_free_pmd_page(pud_t *pud)
  */
 int pmd_free_pte_page(pmd_t *pmd)
 {
-	return pmd_none(*pmd);
+	pte_t *pte;
+
+	if (pmd_none(*pmd))
+		return 1;
+
+	pte = (pte_t *)pmd_page_vaddr(*pmd);
+	pmd_clear(pmd);
+	free_page((unsigned long)pte);
+
+	return 1;
 }
 #endif	/* CONFIG_HAVE_ARCH_HUGE_VMAP */
