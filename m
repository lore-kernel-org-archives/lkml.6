Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4+m02GVfJD0PpTnIluoF/J8Sfi46C1HxBIJYC+Vz5TMpYZupV0bfy3MW4memXCzci/f6brn
ARC-Seal: i=1; a=rsa-sha256; t=1522168284; cv=none;
        d=google.com; s=arc-20160816;
        b=x/TjlG71yfQifNxH7Y9dvfTDWjc3Si2hkFQsDtiw9C27rx27epQAyAFTTU9RNRRHv0
         3Oygani5ct75pEmqJtaufKcyEpjrQ8RXobg1RDxqg5DVhneZSo+LGXxrcpiUlY0Gr+5D
         VTeNqryNo99xLh25Tt9hEc+78YeCb4olndtU49oqGm5OTn0wlLVfnU2EH3ziqmdlyQ7/
         9vdKKbnmh7p5dQWY11w0YOvTcqwIckFrMal4cDsr6tLUDgbBASo4HR02rLYI9B+8PB4C
         Mh52ExNTLw9mtRdY1m9MOSg114WPTvUwy727qhbE1lTCu1ssrj1UW/NSWAghy5k8jwDa
         T59Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=aGjR5YMjp1ieq7FdTbFkqCuEUCPl13M+WLWuTE1kU2k=;
        b=ubVewzjO9I8MNuGnMK8XERLRgeJ8fFnEfKAjjvcx0/PguuiyIzp6saY9dSXPzj1vJ8
         MjqgF/7jRnBC5SflguMuAMxvV1gVD2YcnJVG1nBvKtiOik9hBLnokEF6VgDSwst/dqep
         psBdRTF1Be2rVOfH/m2pLCUqSqiQ7OWgo4+hOMHifijp8HE7S0ec8ygt6tSMZPpa5MAK
         0NdNIluUS/Mcz99pH3REZc4eML7lHBdX/bq2xqvQxsRqaDjsaukI4IFHHzgePcOA+3fT
         Fcsw9LU0bpwKc/eCafEWEgP1+5uMKyXskeVhSfGex+c+zc5pG5W12EH1pe40YCr7ezHQ
         0E0w==
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
Subject: [PATCH 4.9 25/67] x86/mm: implement free pmd/pte page interfaces
Date: Tue, 27 Mar 2018 18:27:17 +0200
Message-Id: <20180327162728.298358483@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108991936577153?=
X-GMAIL-MSGID: =?utf-8?q?1596109131645064442?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -653,7 +653,22 @@ int pmd_clear_huge(pmd_t *pmd)
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
@@ -665,6 +680,15 @@ int pud_free_pmd_page(pud_t *pud)
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
