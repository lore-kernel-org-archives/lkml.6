Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELuhoOH0avxf40o8C9ovgnFK0yslqFYCfiRwvKMCEWq1JAFO8/NMu9NLs7tGtssM/5cV7mC4
ARC-Seal: i=1; a=rsa-sha256; t=1521484136; cv=none;
        d=google.com; s=arc-20160816;
        b=ukRYeLCVzfb3OzHA5fKAHW7H0QcYZjBBvpjiBOQSwk7BIL4OFfNRVH23UPgnqddlxD
         ZKhlN5xmdIXIL4oD4U8kQQKtMwhzDJsooz2+CNVPnLMUwBFOvJn1npHl0Cwh29GdvFS+
         TSos9Cn0L6y9pzaR0y34dpuUATt86ErTlroJXY0vmjHBOC3sy+qwcrSz959gejWenx8e
         txHaUTMPsc8y/t+1w/FF8s36YXIlDTilVUl/CBSEycPWiyt3RgzzSk7McymkkG+DLrCC
         1bgikDDvkhM583S0hz+3FWsgYuVUwkEnOQzX8cLx0sEeHQstLm2V9G+GKQtnAyEIdrVX
         X5kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=XgKZb0fM4/p6HJuXCbHMORKu9Mopv4fzqB1yu/CeGSM=;
        b=zVxcAUd/VBX7umJ8KGGzIw9S7EXXBEKej5LLeUsbMBbTZ9nDmbIWqM7hArAKDQw+F/
         tm2x3js6FMRtJxnW5xZP7139sikazKA3k68/bERiZHtL32rN9HEzGnBMhRABQSR6ZGFg
         tzuZbXjo8w6MlY7qocw0dBQIqbGXvWkgP/rA5eoPlbj5005cYlPi3VRUe5QSQ31h5Dw2
         NPPaU/Qm8ZW+E4bQ/26e14W4e7gwA8ZASc/w/K6qFh7c0a3/1ct7cr3r3CfCgj6b3Rfy
         KxNFZfipTSJcTVScSTJ9c8lvFyjjqSGUD+3Xqa7nSRCWwUHCrk4R/xqnyK9Ai2ZLWajz
         eg6Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Gratian Crisan <gratian.crisan@ni.com>,
	Toshi Kani <toshi.kani@hpe.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-mm@kvack.org,
	Borislav Petkov <bp@alien8.de>,
	Andy Lutomirski <luto@kernel.org>
Subject: [PATCH 4.9 220/241] x86/mm: Fix vmalloc_fault to use pXd_large
Date: Mon, 19 Mar 2018 19:08:05 +0100
Message-Id: <20180319180800.282731338@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319180751.172155436@linuxfoundation.org>
References: <20180319180751.172155436@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391061057183549?=
X-GMAIL-MSGID: =?utf-8?q?1595391750336272784?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Toshi Kani <toshi.kani@hpe.com>

commit 18a955219bf7d9008ce480d4451b6b8bf4483a22 upstream.

Gratian Crisan reported that vmalloc_fault() crashes when CONFIG_HUGETLBFS
is not set since the function inadvertently uses pXn_huge(), which always
return 0 in this case.  ioremap() does not depend on CONFIG_HUGETLBFS.

Fix vmalloc_fault() to call pXd_large() instead.

Fixes: f4eafd8bcd52 ("x86/mm: Fix vmalloc_fault() to handle large pages properly")
Reported-by: Gratian Crisan <gratian.crisan@ni.com>
Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: stable@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Link: https://lkml.kernel.org/r/20180313170347.3829-2-toshi.kani@hpe.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/x86/mm/fault.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -343,7 +343,7 @@ static noinline int vmalloc_fault(unsign
 	if (!pmd_k)
 		return -1;
 
-	if (pmd_huge(*pmd_k))
+	if (pmd_large(*pmd_k))
 		return 0;
 
 	pte_k = pte_offset_kernel(pmd_k, address);
@@ -463,7 +463,7 @@ static noinline int vmalloc_fault(unsign
 	if (pud_none(*pud) || pud_pfn(*pud) != pud_pfn(*pud_ref))
 		BUG();
 
-	if (pud_huge(*pud))
+	if (pud_large(*pud))
 		return 0;
 
 	pmd = pmd_offset(pud, address);
@@ -474,7 +474,7 @@ static noinline int vmalloc_fault(unsign
 	if (pmd_none(*pmd) || pmd_pfn(*pmd) != pmd_pfn(*pmd_ref))
 		BUG();
 
-	if (pmd_huge(*pmd))
+	if (pmd_large(*pmd))
 		return 0;
 
 	pte_ref = pte_offset_kernel(pmd_ref, address);
