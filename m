Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AIpwx48ayMTj08SuE5/ZycdMX3mn1rcl7h+8EQD1k5XPRhP16KQWI5LTOEUqn+uoRSGuiBrYyNT5
ARC-Seal: i=1; a=rsa-sha256; t=1522168842; cv=none;
        d=google.com; s=arc-20160816;
        b=KcwKu/30SMkSr7zrZnwNTBc9Id+K9p2RKnbYVsojMtQpkvJjQvSEjm32E4eoiwtBoM
         WRzVhlBzFQ/W0ahHJn2gpeirsOSwPH4pBb69hSNox3wNyMllYD/JZ7podKC6aVS4GToD
         Ee7k+vHaHpvKZHS1Y2MM/DnK6yHLbW/2QbKcwByHGS6wifAKD/RJ0Gqzbb8MgxlE2GeJ
         FhuJandsBxujD0AZu+ulXCe8nCU2yZmnwt2tl6nnRWT1fEGl97sWK+FID4WOPnSVMSHp
         Gi+MLrgDwMxQKUYfnKZiroCnFnL0qUwsSiFVFhc3r5gGBIMJgq3X9h6eIUC1r89UO8kn
         2RXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=PJEpd8jQ5VBP0dUagOq+xOjbH44RtDV4uYiCXjcS2Os=;
        b=SroiWzvI/kcypR6pP35F/wIL7zrpRbPIq5FpsFdaElxVhJnU8abq7B5hKNRY0YwyI2
         FY3BOUU04huWMYwPTE9IXVaPGXsNptG4mB/mcBmJ7NQzQmf4MgW7OW4AJL05rGTZCKcq
         Z2ZDZaMRplDfssYuF69btLCgThip42NOMoBtiotFnROg72bGNWC2go+eS0/8tvhvgPDu
         9vWw2o6dU7oDhDuwD1B2ka2uq2mNOX+tO1DThOFZp27TGjFrfT75PeZm5gaBhqGgoqB2
         qJG2HfhSkvp4TKNXbImIZNvyfbQseZBiEzsHXDffep9EYUycBxvbbTiseXgfI+kaXZTl
         dGVg==
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
Subject: [PATCH 4.15 052/105] mm/thp: do not wait for lock_page() in deferred_split_scan()
Date: Tue, 27 Mar 2018 18:27:32 +0200
Message-Id: <20180327162800.587962167@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162757.813009222@linuxfoundation.org>
References: <20180327162757.813009222@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109136831019412?=
X-GMAIL-MSGID: =?utf-8?q?1596109716078627496?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.15-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2791,11 +2791,13 @@ static unsigned long deferred_split_scan
 
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
 
