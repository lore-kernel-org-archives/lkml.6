Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48+xcVTCuz/yhzky/IId2rr0Pbdx+0zOkSwQPLdLPu+7LXRPk3LuIudGc7eoVvc5lKCb/5A
ARC-Seal: i=1; a=rsa-sha256; t=1522168287; cv=none;
        d=google.com; s=arc-20160816;
        b=aRqVWjQeCis6En1fob9dKXVwgqNoRzDfpclqUJkrQm8MK+BAR2bOVVU5bdMld1xPfU
         VWIJiX4/IFA5Ajgwwbv3hOMhQrjO2m9m6HG9FPYY/aXTnPd8R97fXe5UDLzKA7LK6Qjd
         Y6UOgj77jSWcb0RG4UIjoyCUrMHJFF4YWlhO5hoqS3deOdHR7nZlYaSvfDOXe2uZr+yr
         Cy0LGd5T2ZNQ977tslh3T8dV4LoMJKYQ22ohPSGfSlAEAC7SnpPDJ+mf7LaiYTzOdnd+
         D0a8NLsVOPRvAMRIBa6gznOZ/iKcnMNZ8CN4kfd60mk+gmarE/+S4fr2gbs9VdFUxx9K
         j1qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=szdFIIAPTHsoGMIfcOCasvH1pBfu+QUJMST0B1mHOms=;
        b=rzn1yWoQ8CrZCBlzx1L59xNiRI20JGYxTHQRoipYh5Bx8u1WYZ8MzOmEyZHFohPO6/
         /LgO4xcS/0H7jAJP048Vrm/1sABwO1bz/5JYtkMsikL8j0/ceeQr7NAgVrS3q6z/7Der
         FrffmtqrjtfKyJpIIrN5earZWD6aVhrWWmQcKBWOrCV0Np30cLafWNf0zzcyF8KyGjtM
         13J77RuP1OHIv46OwMCWTJIHhAe+gYG3tZjCmRqzFEdyX+iplW6F1pKxtOc+ZxO3mB6t
         ZDzwD8SISP5nUWkhd+FXYXKxvxDfC/64rM8xv4yR7dPxuq+V/hU7ERWmvNzKKz6XclMn
         X+9w==
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
Subject: [PATCH 4.9 26/67] mm/khugepaged.c: convert VM_BUG_ON() to collapse fail
Date: Tue, 27 Mar 2018 18:27:18 +0200
Message-Id: <20180327162728.359297909@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109134052943557?=
X-GMAIL-MSGID: =?utf-8?q?1596109134052943557?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -528,7 +528,12 @@ static int __collapse_huge_page_isolate(
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
 		VM_BUG_ON_PAGE(!PageSwapBacked(page), page);
 
