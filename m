Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/Zz3HylDmqI8s2AhQGia4UiLS5ITSVUri8YYU9d+rZuUBIpOASrJPGNQLoYp4gv5YxRZv/
ARC-Seal: i=1; a=rsa-sha256; t=1524405886; cv=none;
        d=google.com; s=arc-20160816;
        b=oyexrzIsTRVjhWlCxeRNSPJcu6Mg6kd8F4yfLcoWsDBQg5V9lQiYBUdYY92lJcINKT
         3fSOm01DUhNl9GWQuW4BKEq3NYWKTTKLHazWGe78URr9IfAHoOUsFtIkcUhWBmwx2Zd3
         Js+4FPyfyBzZd/37P9u5sGbZLyGQHVtySMAyVW/2rlOv0sN47kPNuYu8O7eG1UwtU1QQ
         eoNbrWa1yPWxc+4jz84s3Ubo7u0/zdlyf8lXuIC2/mKDUGePNlg2l+Y3r/5TfvLa+jXG
         0DjsXhGJaeZ9UcVsihXglOJowSjK4gbAoRS4pOzPF9kFVHUtPhM8Adb4u8+NbGtZepdc
         QTjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PGm6GeLm10yOnNPBWWCth9DWHhEUdzbCLyvCAFby6JU=;
        b=Zz/DxCAfFGfWBevUE231lkuG4UZNXl1JSIe97xF5oO7CqwWc7ACRXwsfz98zu+evWf
         /tyRCOrDBGH22K3J2wTXaVPOkPXQAeeBiu4FWl++7hLGNU1zAVh9gPoC1pMqeQHaEQ/+
         aFJTQcjtUkSNF864EsheDLRy7Pelzd+vaUeYemdXO16Mglwo5OxowxIhgCq7Z+aOwZl8
         /q40v/zqIUpwT2d9Jp9oOSFF58x1ygaL/IvGbPYHUzg73tdAIGvXO33+GrZnqXwbFshD
         hs1bhzX8ArRmeVVpZg3etx02XJWrklr/QrQPFtyInYE1bRixmzvoVGcZV8yrgeubngkq
         tt4Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrea Arcangeli <aarcange@redhat.com>,
	Minchan Kim <minchan@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Hugh Dickins <hughd@google.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	Gerald Schaefer <gerald.schaefer@de.ibm.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 007/164] mm/ksm.c: fix inconsistent accounting of zero pages
Date: Sun, 22 Apr 2018 15:51:14 +0200
Message-Id: <20180422135135.700220495@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
References: <20180422135135.400265110@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454868442656984?=
X-GMAIL-MSGID: =?utf-8?q?1598455427161148247?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>

commit a38c015f3156895b07e71d4e4414289f8a3b2745 upstream.

When using KSM with use_zero_pages, we replace anonymous pages
containing only zeroes with actual zero pages, which are not anonymous.
We need to do proper accounting of the mm counters, otherwise we will
get wrong values in /proc and a BUG message in dmesg when tearing down
the mm.

Link: http://lkml.kernel.org/r/1522931274-15552-1-git-send-email-imbrenda@linux.vnet.ibm.com
Fixes: e86c59b1b1 ("mm/ksm: improve deduplication of zero pages with colouring")
Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Reviewed-by: Andrew Morton <akpm@linux-foundation.org>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/ksm.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/mm/ksm.c
+++ b/mm/ksm.c
@@ -1133,6 +1133,13 @@ static int replace_page(struct vm_area_s
 	} else {
 		newpte = pte_mkspecial(pfn_pte(page_to_pfn(kpage),
 					       vma->vm_page_prot));
+		/*
+		 * We're replacing an anonymous page with a zero page, which is
+		 * not anonymous. We need to do proper accounting otherwise we
+		 * will get wrong values in /proc, and a BUG message in dmesg
+		 * when tearing down the mm.
+		 */
+		dec_mm_counter(mm, MM_ANONPAGES);
 	}
 
 	flush_cache_page(vma, addr, pte_pfn(*ptep));
