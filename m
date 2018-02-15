Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226AHhkZE0UgBPLPrHKv0swIM1DdYzeGG70gHcji2evR7eYsbMyhz6a5AXuo1eauMRBaghSP
ARC-Seal: i=1; a=rsa-sha256; t=1518708574; cv=none;
        d=google.com; s=arc-20160816;
        b=DZWkyMdRUMAbARG6p2LV5l5x7rlt37PGqzq0kH0IiehaTPPWKnrDQvUB4JL64F5wPq
         q0qkYgJrVBWymEhPBtnO4t253jKuTUtTdKDAZWfV7JPT0+S3SFJNY168WViMouVlpCy0
         Kqu7B/kOPMHBJpCBcDvLI8UhALmapHd4iQIau9ppF9r2ERXP+PJrJgPwlpvrqteA45zN
         gI57gpEiVPlo8VAHLB5h3fWVa7zWzUEGlpJfxJqp1k2VmUlJBogP5pF1atsomh/bgC0s
         g+OEuDSkqGx/JruY4UZ+NhFZsqIRoRZTlLYuqfU3zHzsw2FVNUaRGW8jZ7AvdFPotepB
         ZYbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=OTHVWvCGfinJ0xkhfmKeObnqZlyWMfZQLVfhPICK9S8=;
        b=dqynZ/ovOPNPlWs7xEWS4Y7pamaegPg+rw0u9eWzkbKIEzEYUzUraApU+n2huJxiR4
         IUx3Rw7X38ESx4IjBfOLkN3pedF/mFryudW0NG0qIuqfSrVr97QXjGgvxUTGwSoL36iA
         LKgek62RKQSYvsnwkDHzs81jYyGvtANl/Ku2WBLS3YbQeeHsk6wfpTN/vY53HPtKnvFE
         dtbO7rn6Ut0yfvhc3VMC5elZweaVffZOE3a32aO8ak18ocgGytRZtFWHWNJeWk8Kb0JP
         SnfDD/a2T8s304/L3oTN2AYXzK6urCTu8dRHacibX7EN4GpBRMeQNgEohO40z1emk3EA
         913g==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
Authentication-Results: mx.google.com;
       spf=softfail (google.com: domain of transitioning gregkh@linuxfoundation.org does not designate 90.92.71.90 as permitted sender) smtp.mailfrom=gregkh@linuxfoundation.org
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Tejun Heo <tj@kernel.org>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Adam Wallis <awallis@codeaurora.org>,
	Lai Jiangshan <laijs@cn.fujitsu.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: [PATCH 4.9 62/88] kernel/async.c: revert "async: simplify lowest_in_progress()"
Date: Thu, 15 Feb 2018 16:17:29 +0100
Message-Id: <20180215151231.220913443@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215151222.437136975@linuxfoundation.org>
References: <20180215151222.437136975@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480752826931669?=
X-GMAIL-MSGID: =?utf-8?q?1592481362938448353?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Rasmus Villemoes <linux@rasmusvillemoes.dk>

commit 4f7e988e63e336827f4150de48163bed05d653bd upstream.

This reverts commit 92266d6ef60c ("async: simplify lowest_in_progress()")
which was simply wrong: In the case where domain is NULL, we now use the
wrong offsetof() in the list_first_entry macro, so we don't actually
fetch the ->cookie value, but rather the eight bytes located
sizeof(struct list_head) further into the struct async_entry.

On 64 bit, that's the data member, while on 32 bit, that's a u64 built
from func and data in some order.

I think the bug happens to be harmless in practice: It obviously only
affects callers which pass a NULL domain, and AFAICT the only such
caller is

  async_synchronize_full() ->
  async_synchronize_full_domain(NULL) ->
  async_synchronize_cookie_domain(ASYNC_COOKIE_MAX, NULL)

and the ASYNC_COOKIE_MAX means that in practice we end up waiting for
the async_global_pending list to be empty - but it would break if
somebody happened to pass (void*)-1 as the data element to
async_schedule, and of course also if somebody ever does a
async_synchronize_cookie_domain(, NULL) with a "finite" cookie value.

Maybe the "harmless in practice" means this isn't -stable material.  But
I'm not completely confident my quick git grep'ing is enough, and there
might be affected code in one of the earlier kernels that has since been
removed, so I'll leave the decision to the stable guys.

Link: http://lkml.kernel.org/r/20171128104938.3921-1-linux@rasmusvillemoes.dk
Fixes: 92266d6ef60c "async: simplify lowest_in_progress()"
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Acked-by: Tejun Heo <tj@kernel.org>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: Adam Wallis <awallis@codeaurora.org>
Cc: Lai Jiangshan <laijs@cn.fujitsu.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 kernel/async.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

--- a/kernel/async.c
+++ b/kernel/async.c
@@ -84,20 +84,24 @@ static atomic_t entry_count;
 
 static async_cookie_t lowest_in_progress(struct async_domain *domain)
 {
-	struct list_head *pending;
+	struct async_entry *first = NULL;
 	async_cookie_t ret = ASYNC_COOKIE_MAX;
 	unsigned long flags;
 
 	spin_lock_irqsave(&async_lock, flags);
 
-	if (domain)
-		pending = &domain->pending;
-	else
-		pending = &async_global_pending;
+	if (domain) {
+		if (!list_empty(&domain->pending))
+			first = list_first_entry(&domain->pending,
+					struct async_entry, domain_list);
+	} else {
+		if (!list_empty(&async_global_pending))
+			first = list_first_entry(&async_global_pending,
+					struct async_entry, global_list);
+	}
 
-	if (!list_empty(pending))
-		ret = list_first_entry(pending, struct async_entry,
-				       domain_list)->cookie;
+	if (first)
+		ret = first->cookie;
 
 	spin_unlock_irqrestore(&async_lock, flags);
 	return ret;
