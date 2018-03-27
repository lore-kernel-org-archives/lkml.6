Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AG47ELso9obnwn66zPop0Hqn+9K1xZBuHaiVR8neATBBevPeGxzQXSYXmSzXJJpO1g7n5LsChG59
ARC-Seal: i=1; a=rsa-sha256; t=1522168290; cv=none;
        d=google.com; s=arc-20160816;
        b=F/EAjkDAkWQ+hB9AAMgGaN6dsvN/oh8OPDNzVAHXdWOQSb4gtVLxPzao2DPjyOFszs
         YdnncQj1cRfeQ2FLRx4XItl1PeqMO3eMIZX3oRPQ5FXhtwHmQLEOsQUkZSxhZGBtzlfr
         VAF4T3QFGFcxB7iFHH0dsdr+e1cu6ZVs9AwueBuvpEoecH+zoll/CdLwrIWQFkaTBXIw
         k373Wz64a/Cc1PsEH6KnGaWAUbz6hSN/8D4uxK6+VvYd5Jzl2EzdycyXn6p/KQaCzC1D
         T1l5q20/coQBR+F8dszQKjfgwMmiSt4niSLbiyr3VK18NoyMQjG20MfPdPYIUReIKqRT
         yYYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=CnkDmPjOozNKv8m6+FPqn/NCqEI+bWW5iTV15aJUsEU=;
        b=UcNBpDaQRnqkCim2PiWY+xdlxotuwWqwY8zPz3lJss36Hmb8BlGuTqbogp8KXvAVKJ
         4iQ7QLr848Y4yAHNWbQKihPJ/42zfJXrra9OYWw0GLZjk0AyTk0xbymb+v98upl1GEDh
         v5PghpfgWMAhSvJQwOxB7a/5BMqlQihKw8LrqFzlxCsMqyizhE8tB8x3X8c3o+PwkZ41
         aV2HFKbfSb80io9msszl5agwthhHIjXZQAPEX/079LftsFQLWAL0R+pzm07frn9NGRRZ
         9IJUHJU5KYhFdCNPWhXZBvFnn93kwEEfCTDFCPRy6g6OYp3yqPcfvGft506HLGgSEeXx
         13WQ==
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
Subject: [PATCH 4.9 27/67] mm/thp: do not wait for lock_page() in deferred_split_scan()
Date: Tue, 27 Mar 2018 18:27:19 +0200
Message-Id: <20180327162728.445589081@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162726.702411083@linuxfoundation.org>
References: <20180327162726.702411083@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1596109136831019412?=
X-GMAIL-MSGID: =?utf-8?q?1596109136831019412?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -2279,11 +2279,13 @@ static unsigned long deferred_split_scan
 
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
 
