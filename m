Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx4/LUN1tKkbE5stSOq6/WNTPl///KBNectz5F9HfxcvK7nS0f5llkQvkngE9sL1f0NI4IZpQ
ARC-Seal: i=1; a=rsa-sha256; t=1524405353; cv=none;
        d=google.com; s=arc-20160816;
        b=XPOdbSiLzi7YK7zcZ33kXa1Ln4lUB7Wrgcgg7Qvq8QhkqX3bi35wORv7DvN5FU+K7E
         /TjNgZsG5PLEUHgT+bM13cKT7OuNxEBPy012pqzhw56cTOEpBBd64JaQFbyU2tbhgVBb
         91tyg3N8ZOONElEyor3geH6c7Wv4IGV2aQRMt0YRgAoGSkbxFI1fysG8GNrhjVr2+ddh
         XPdZ/Kg2/9oXkTtLpPLu4V1qa9m70MGp+u+wNTGSApklnh/eibCTQKk6TovGZAgohHzP
         aAh9bpL1ThlZHPf3nsrmvdBR0v7+ochfe7Z6LHanq4/MlWyrK4MuTUuyQFm5JYJGkMOH
         rmFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jLEs9OF0b2oyXvGVJtJjxOLz+8IlltuKuaib9B4xrbI=;
        b=aklMEcX9ud+G1+nrFr2M6G4pdoTYc50MA6RPzJglwrosy/6xp2ZJPTLNTnempR2PIX
         Myhxw8CcizDxqWZcBf4BOUQO6MMrQdkCeX1JoCuVli01NWpCTfN7Lw4tNTeXc4twatul
         W3w+An5h3QipAOTvOEwiW6XpcZdyzQrAYPtISbSwOF5/auyPUWjn4twWqAf/pTCPfY7u
         yGH86WdSzP6E3hhhbLiq7Onni6gNIaRbBiRbCSb3i/GMpjH+4hdbNTEXQfAonrw1NLx8
         KPnWjiYt+phPU6bxV5lhbVGruckIjaVHzlrxLF8geT6DrNjethXUgO0B5OAozigxRhcZ
         yT2w==
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
Subject: [PATCH 4.16 008/196] mm/ksm.c: fix inconsistent accounting of zero pages
Date: Sun, 22 Apr 2018 15:50:28 +0200
Message-Id: <20180422135104.636269827@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180422135104.278511750@linuxfoundation.org>
References: <20180422135104.278511750@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1598454868442656984?=
X-GMAIL-MSGID: =?utf-8?q?1598454868442656984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.16-stable review patch.  If anyone has any objections, please let me know.

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
@@ -1131,6 +1131,13 @@ static int replace_page(struct vm_area_s
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
