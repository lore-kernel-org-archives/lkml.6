Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx49FuGcPD7PAYMIdcJe1hWPkKEhhW/da15zGdZjK7qFiUh4BMjLnBTtLR1eW02h4YftDjQhP
ARC-Seal: i=1; a=rsa-sha256; t=1522168553; cv=none;
        d=google.com; s=arc-20160816;
        b=QlaTL45h8HlW0ZvvX7bf9oZ9OwtscFvGvQIuVzZ3tJ1Kti7wkzOdSC6Ey/V7E2ErFR
         G/f/AnV7TqUTMeO9GUNlHRlAEzXnywS5iXvNKv8HdGvBBt03n6BL/5qybGE1597BV1pR
         2yz2hANCYIRGBcqbY8vy/sljfhZHUeguHX1gUnjLbHc0YB9nuofSGV2A5Tj5cYQmE7vj
         rDXgHE0pGrhtANbuVxmEA0tL30KBSesrOIg1TkRPnSBPZpXoMar4Cxw+rNQSX9r6Ylax
         2hiy284afpWQKPTZRmdzWID1QUxTe5i9MqOFtS20yjj4lL7CpNrm4+Ld2c3TrT+8Qsnl
         J97Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=FsAtSxSS3cV73QK9XpCHNvYsl49U1BN11rT9CIrywUU=;
        b=ghBI71SYd50pDGLKofta+121SmSDdFBVn2uIHA0zjE1NUM18RTFmZj9/1MkDy66q7O
         fEafL4F/0XMsaAby13V462MffZboy7x8oYQcIK6dKBehCcZfeDjvANL0902I6RwPiUrb
         oaxrkL4YTs/pyEYWe+8mvF9ga/Ped7y1tnp2cTqH9NCA3buxFMIpUx3fQ5R/i8minxZw
         OWcjfLkt+P8u/61t6y4e54jfAfwjq+yJyXP/jKSCT5i9pzlLzlNhatnBA0ZO4+ocIe6I
         PXGtqoj6Yfq8cLGkK+unRODFLtqWFyIdkcC+C8/lOdLl55zB9VJJWsyku49AXlwsYhld
         Dfrg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.61.202 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.14 050/101] mm/thp: do not wait for lock_page() in deferred_split_scan()
Date: Tue, 27 Mar 2018 18:27:22 +0200
Message-Id: <20180327162753.098054548@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109136831019412?=
X-GMAIL-MSGID: =?utf-8?q?1596109413318595225?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

commit fa41b900c30b45fab03783724932dc30cd46a6be upstream.

deferred_split_scan() gets called from reclaim path.  Waiting for page
lock may lead to deadlock there.

Replace lock_page() with trylock_page() and skip the page if we failed
to lock it.  We will get to the page on the next scan.

Link: http://lkml.kernel.org/r/20180315150747.31945-1-kirill.shutemov@linux.intel.com
Fixes: 9a982250f773 ("thp: introduce deferred_split_huge_page()")
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 mm/huge_memory.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2739,11 +2739,13 @@ static unsigned long deferred_split_scan
 
 	list_for_each_safe(pos, next, &list) {
 		page = list_entry((void *)pos, struct page, mapping);
-		lock_page(page);
+		if (!trylock_page(page))
+			goto next;
 		/* split_huge_page() removes page from list on success */
 		if (!split_huge_page(page))
 			split++;
 		unlock_page(page);
+next:
 		put_page(page);
 	}
 
