Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49fIK+iACdEbThW6VngI0rwmWZQAilkG1XzY5OfZ0VLarONDjRzHOu94ywo12o+VVh79P/J
ARC-Seal: i=1; a=rsa-sha256; t=1522168839; cv=none;
        d=google.com; s=arc-20160816;
        b=0bovxsP47o8C36BdslNYwWvayN/PmtuyqI9QlEKl6djxhDmUUFafAR0B+W3BNc6Y/D
         Y1QtC0W6uUCDoTw0t249DOctpVl1UAwTYSF70Zvj/b1T4vGILtucHNm6peCCSamDeQnc
         xVFn7uGcYn62VD/zHUQhYED/dlv/lgLqX30HSrnflps2qpBcf1jwJ0ZCikDV+/6aWRiu
         43HHSwZ0WoUyCYFGbXRwzV3jLC7j3i4Ys8l5p/y7SpLEHWRqnMyOi3U8s6rkX4bu+0xV
         y9NobyiUwHnahDonBxDtJYXFWHf7Z66spQr5mTA5evAK7fGemDhEPAtK/sELnGd3FtKL
         EtPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=1IyFjCDAjcmMndcyadcnsR26vCg6b/5exbS4EZaB2P4=;
        b=EUe9JZ8QLSIHf947uztglWbZAiq2nIfCwoNz18HLcvC5ztv4K3zBF6icaUx/fvj7aJ
         oOKfjerTNEeyNTc2b+8d31EigUhFwSlt5Dio0J7DZFicX2N8ss+UlObXAwn35XGpxkty
         HNOSzUnSq73ze948+qOh6c49ZCuNn03DqVkl9B+iNdHm7bMlPh7vlHXKQlHcH/h1MzC0
         NBajXL91aT3equAgjkwbPi5shthjKv6z1ONrEqcPZ5vqlDbcrERRLvka+F8Db+IAuVYC
         BETM7o9HzehtXKiLzUh6Y7PL6JAa/5FK7kCLYwh+56cRbgKA7Eb0GcQatfntZE5JbUxx
         Uhqw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Laura Abbott <labbott@redhat.com>,
	Jerome Marchand <jmarchan@redhat.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.15 051/105] mm/khugepaged.c: convert VM_BUG_ON() to collapse fail
Date: Tue, 27 Mar 2018 18:27:31 +0200
Message-Id: <20180327162800.507511457@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109134052943557?=
X-GMAIL-MSGID: =?utf-8?q?1596109713020439601?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

commit fece2029a9e65b9a990831afe2a2b83290cbbe26 upstream.

khugepaged is not yet able to convert PTE-mapped huge pages back to PMD
mapped.  We do not collapse such pages.  See check
khugepaged_scan_pmd().

But if between khugepaged_scan_pmd() and __collapse_huge_page_isolate()
somebody managed to instantiate THP in the range and then split the PMD
back to PTEs we would have a problem --
VM_BUG_ON_PAGE(PageCompound(page)) will get triggered.

It's possible since we drop mmap_sem during collapse to re-take for
write.

Replace the VM_BUG_ON() with graceful collapse fail.

Link: http://lkml.kernel.org/r/20180315152353.27989-1-kirill.shutemov@linux.intel.com
Fixes: b1caa957ae6d ("khugepaged: ignore pmd tables with THP mapped with ptes")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Laura Abbott <labbott@redhat.com>
Cc: Jerome Marchand <jmarchan@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/khugepaged.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -530,7 +530,12 @@ static int __collapse_huge_page_isolate(
 			goto out;
 		}
 
-		VM_BUG_ON_PAGE(PageCompound(page), page);
+		/* TODO: teach khugepaged to collapse THP mapped with pte */
+		if (PageCompound(page)) {
+			result = SCAN_PAGE_COMPOUND;
+			goto out;
+		}
+
 		VM_BUG_ON_PAGE(!PageAnon(page), page);
 
 		/*
