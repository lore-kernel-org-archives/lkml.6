Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELsbBCMf5/TOm+0gT/jUvazF1Kva31JYsxmnXUDCeeVFmMNjqsj2molwU9jQjI9EH8/rqc3P
ARC-Seal: i=1; a=rsa-sha256; t=1521483480; cv=none;
        d=google.com; s=arc-20160816;
        b=Fx50mvuGH0ZDG3ugO/ZI3SL7vsu86BimxsyLiI0DBLB5LTYX7UY4TKv1MTdazRBV4q
         VxaxTEXQ2SnmA8M2TgCx2vKn9o4rXSh7b2oJsyuh1UmrfoqF37Ol1qJw/FycL7wOR0OC
         2CozzvhaTUPptOxZyc4MupxPOJI1CNhzevI0frFm5D+uLvXLIuZi+VexIOgjAthRxX9r
         eZPuRN2gUzG4V4C/qRRFl7rnTkry+iDBZVvYo0+GNN/lb6WUWDj6eSnp42dAYN0Tkf6N
         u/2RpxLNsvIvMWWJPrM1rt2Fs7Zrn4r0V1g9DFqu40y93280Jp/zwGuxfjbwmJq5khPA
         uLWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=4i37U53eyplVPdTuUIpaT7AW+G+IZomsidB1ZMcqOrc=;
        b=e0UxqBw+mF/pbTy4++5ygYCCX8k1TwO777NgaNcRWoJ6x06NTajGfEt0fBR2F4GO4y
         J6YUtggIbYgNU1GDBjtpwd6MbQBAdQeZTnC8m2ewDOENoL2eoby44TPsO0GEwwIS20SS
         CY+9gYnq9lsYBfN7q3oyoC1+xugDTQzy1WOcf593ameTqJKKco/4A7woDujqHQ1p1Dpr
         N7RSTHUI4hv4ZQKDxBx3XPPfxdW/uvkzEfZ1g72VtgsdWpIyhKjzDJdrDMBFMdXwjhQs
         LEK1Zbhv8OkI7s1IksA5LougFrTGgvzDgi3jMJll5Ma/b9Ju02NFyp7dmbsxlha6T9kY
         o1Rw==
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
Subject: [PATCH 4.4 115/134] x86/mm: Fix vmalloc_fault to use pXd_large
Date: Mon, 19 Mar 2018 19:06:38 +0100
Message-Id: <20180319171905.892026687@linuxfoundation.org>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180319171849.024066323@linuxfoundation.org>
References: <20180319171849.024066323@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1595391061057183549?=
X-GMAIL-MSGID: =?utf-8?q?1595391061057183549?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -287,7 +287,7 @@ static noinline int vmalloc_fault(unsign
 	if (!pmd_k)
 		return -1;
 
-	if (pmd_huge(*pmd_k))
+	if (pmd_large(*pmd_k))
 		return 0;
 
 	pte_k = pte_offset_kernel(pmd_k, address);
@@ -407,7 +407,7 @@ static noinline int vmalloc_fault(unsign
 	if (pud_none(*pud) || pud_pfn(*pud) != pud_pfn(*pud_ref))
 		BUG();
 
-	if (pud_huge(*pud))
+	if (pud_large(*pud))
 		return 0;
 
 	pmd = pmd_offset(pud, address);
@@ -418,7 +418,7 @@ static noinline int vmalloc_fault(unsign
 	if (pmd_none(*pmd) || pmd_pfn(*pmd) != pmd_pfn(*pmd_ref))
 		BUG();
 
-	if (pmd_huge(*pmd))
+	if (pmd_large(*pmd))
 		return 0;
 
 	pte_ref = pte_offset_kernel(pmd_ref, address);
