Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48khphZW8vKdUWBlwQmLZGFUPv2HsaMQHF17plcZVxQT/aqgUf0o1VE5/5zxQMYGBiBlI4r
ARC-Seal: i=1; a=rsa-sha256; t=1522168837; cv=none;
        d=google.com; s=arc-20160816;
        b=tEGHA+jnhDDXBUZxwkxt6W+K32m97WC76HN26cdrNjcv+WvP3fR/wvF+FQ3ShRs2qB
         FaJ/sYPAH8JnjDB6Des8W4Nn+LSpp683yJ7ZyxGDoGPYJ352DS9G3aJB7MES0X1GbjGA
         Li2kW2WlamwVfGI6Mx6ZqCkTbAlqieHZuhRP8+WpXn2M3D7OgfRoEKztoHhqR3pwpwXG
         y+jmuLEnkLRDd/yvgNIr7z+fTk3u78kHRIBFNn0qpmhs8pTDV6qAUw+ZHE4St/V+yWho
         fsUUkopzJzvUjLrcum1Bm98gDUL5WU6gMZ/GAMWEuUQvj6N5NagQdk7RPhuzb2TjMI6V
         U6MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=GZYg7+y3bI4NvOJ99DtI2I5odjl34issUEDyNQI3njU=;
        b=yrFBtdTaXRzZPFcqreQaXmLFIzqzDKC4lGochOJMHLapnhAgCs8AZUZLPeuOKZtqQ5
         FUTLTnKNN6YtQA4XuGVh0Jqc3AlTW7T6GZthbHRNeUZaMNXVa0mjN0e68jY4mxLQCmDu
         TodICPhgJCxuVANt4CN5+g0Pmd7xNUR2e2cX/iUb1L7+uWRMJBwuRXPO7O72/ZwqaCdY
         Tmz2UBmdhFWTBExhpho+jIv8Py1/nEmQ40eC4mIXmlvUZ7NK1vrSZtDTVH4pAAZlbtH5
         9u8cR8dCWH1zi1WgNaBYzbHFsjd8gMQGWJLOZE1KzLIcYTMcWDr/nqECfVZb2tgp63YP
         j5hg==
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
Subject: [PATCH 4.15 050/105] x86/mm: implement free pmd/pte page interfaces
Date: Tue, 27 Mar 2018 18:27:30 +0200
Message-Id: <20180327162800.427604374@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596108991936577153?=
X-GMAIL-MSGID: =?utf-8?q?1596109710086010175?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
