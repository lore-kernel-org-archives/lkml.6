Return-Path: <gregkh@linuxfoundation.org>
X-Google-Smtp-Source: AH8x226n6Q2lpvILxNysXmyESdkpjjRpcl4nC3NSGU+LI2RwAFYEIubGk7L7MtQs5xPzZCOBdOwh
ARC-Seal: i=1; a=rsa-sha256; t=1518707993; cv=none;
        d=google.com; s=arc-20160816;
        b=0RXcfdZGvL9IsnzG1BUESjSckRNhxcgUtUCAfyHFIhpllYbRmJ3xgWv6NoAmr22k5C
         kEqtO4HxbLJ+iXP7p6lUlpGGYBZi2PBTAvS8WxkCfCKupn9ZpgNnTQ+kRUrJU6HuW7mY
         nac5RLzgTUQoG3/wXo4OqEzSTEiah6Si65RFoiuJ5+oOWNau8xWWmy41+cJGVhSsHScL
         sqR0vQarfrjMpH5UlAGGX15h/kA7XxIR27XedDjiDXYdEi4H2iwnJEKOMsxeNRBCsxek
         Ymafp5mS+gyMJMCIj4NlS0I6o5S7l4ZGsjqUBfLGMXejWdxWOrwfTpj0T1/kTvZKrbTV
         dh0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:user-agent:references:in-reply-to:message-id:date
         :subject:cc:to:from:arc-authentication-results;
        bh=5wqc9am1tyOwAbz3g4ALsOX88eSmuP2xZN7Rr0c0jl4=;
        b=wuH7ujLNqwViiqZnqQZ/4iTjC76PmviC/Av3d/ddDfrLToHwCfqc2ngEYJYI9wwRQ+
         u1l8m/qU0Dp1Pj1E3xVWBZdoWadBixEmGYBmmhdnRRnjDAapT02QjOCnH0ZFevxtthlL
         1a5gRk8qRfPL7IcqL2wuCBP1cWHWgKMzUYZKrJ5rvUOK2cAeUwx+g/bbgYxKd4JjjWLy
         s1S6UzAQ77SFoeb5mxQHCcz51/fltnMQCH9Z15vp6Kl8QXG8nC+idMPvCKS3z3lxrLmQ
         2Qdz2mUoUK20pFsgWTu01PgFlctwAhhjlehSK7Pomf5jHbl7amDUSDWAtX2BW0AsM2ga
         txbQ==
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
Subject: [PATCH 3.18 36/45] kernel/async.c: revert "async: simplify lowest_in_progress()"
Date: Thu, 15 Feb 2018 16:17:27 +0100
Message-Id: <20180215144123.622093447@linuxfoundation.org>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180215144115.863307741@linuxfoundation.org>
References: <20180215144115.863307741@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-LABELS: =?utf-8?b?IlxcU2VudCI=?=
X-GMAIL-THRID: =?utf-8?q?1592480752826931669?=
X-GMAIL-MSGID: =?utf-8?q?1592480752826931669?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

3.18-stable review patch.  If anyone has any objections, please let me know.

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
