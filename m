Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48CnmbXlcQYioZTFAvkcEoD2UTm0FuZDzLWrl2W0f+1LGvgcXX5EFSOQBFe45BG4RMyKi/5
ARC-Seal: i=1; a=rsa-sha256; t=1522168548; cv=none;
        d=google.com; s=arc-20160816;
        b=DCVrC/xNbzVfsWubFrYeMNSoFjNZZiRemPLRBTQJ2hkNfT9X6YOw5TVs6lpct6Zjyf
         U+wAcuQlVhucZw87SQzfXiCazDv33Fdg762aXOs1thiIwrE4lnIagF8v3aAn2L2n9t7p
         P3uGcJVwt0nj8uEBM44DUkg6SCxMZN9nGnHdOb4TETZrXWz0mDPHt8zOn8En+Eji24dS
         VFeSJfIbO+Ec2PJ9omf62Y9/Bq58L/MR80BfocsZ5rZ7U5FGPXTcyIKMoiUwTqs+89Tf
         Q1HGlgcOkqBfQYJ/iCJxbjX9gskbxNqBimGWkWKPeFMsElyVJYtOe3VP/WGrBamy8Mzn
         w0hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=jp81KnXk541V0C6/jcSQoDzvGhxvPSGBRW3kP7/6KRc=;
        b=F5RjtlmusEtgfTOLIDu3sWmPr8D1DqGUbeMtqlphlLHd8YFQklXPitdTwy7kx5tDSF
         r/xxJB3j2rrQBSL/TcvfbpzqEMaiStMkxpUSfsZ057KEVOppP9G4v288GRDcMYM2oQLv
         JyiwmDtgnJ8rCBgCq2/m5f1OWk2qcM0J/BYMVxqYwr3jsnBy+lZfTAJZeKGV87xf2uWF
         rFYE20FfQy28tNlHKn4P0Tny3sG1LHbpy6HtuURgDjxqWqw+pDXzmQFioDbHsf9m35OK
         w0+CVfv4DeRqAdBlO6b2c5OVaMw7mu7laa1SwXp/Zx90j6yOrQ1YzWqea1O254fXWBxv
         Rt+g==
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
Subject: [PATCH 4.14 049/101] mm/khugepaged.c: convert VM_BUG_ON() to collapse fail
Date: Tue, 27 Mar 2018 18:27:21 +0200
Message-Id: <20180327162753.037315086@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109134052943557?=
X-GMAIL-MSGID: =?utf-8?q?1596109408053950414?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

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
