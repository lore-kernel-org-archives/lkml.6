Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752782AbeCMQQi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 12:16:38 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:46347 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752281AbeCMQQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 12:16:36 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Arnd Bergmann <arnd@arndb.de>, Martin Sebor <msebor@gcc.gnu.org>,
        Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        Paul Blakey <paulb@mellanox.com>, Tom Herbert <tom@quantonium.net>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] test_rhashtable: avoid gcc-8 -Wformat-overflow warning
Date: Tue, 13 Mar 2018 17:15:57 +0100
Message-Id: <20180313161606.471699-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <CAK8P3a2mkLfkmEgg7GbeS=QkXvzjt86fNiUuuHGa54HyULkMng@mail.gmail.com>
References: <CAK8P3a2mkLfkmEgg7GbeS=QkXvzjt86fNiUuuHGa54HyULkMng@mail.gmail.com>
X-Provags-ID: V03:K0:nhNJXHvXCbgs5Ywo38egMkugqqGfU5pAXmeGU+fl5UzT4YagbO+
 ZQQb+twsw4YTuDM/p8EQpQWMk6gVw9yfbqUe5/77tyTPXATVkceawBQHLUnuRdcNTquNDh3
 CNM9oB6mSYCk2EidBeK68JoYPjyRcag+Yz+7wS+6y3z9jZKNrkMYAWYc44s7yMn3Enb5xOY
 qv7RckbxDEPsBgQeXQtjw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:N7PRzOSjRHo=:vmg4AkGA/iJcYmQgFCMJZC
 tlHKe15DpF67SGEpqGL1FB85psN3JeA24NM2/nyAVeFAcuQFePezjTg7zAw0F15dwVBio7uC4
 +x9AScSH7tmJdy0m552veW/qJQezq+MYFoI8szkox2Fn9kLmuwEzLuDKZ8bEC2SG0Ej9C7yL1
 Bh+JjSJ0457/HJuuMxQaPvcQFx1dBSAAps6WbuygrncOEjsldttRamnWv6Hs6FvnRagiFt2mQ
 apAGBfvcqVXgp8FcghwCjJk2LCssh4hEXaeTGa3iqs+Jan86M8N7BNm7ZIU4VeWAFIl1RCWYG
 dVvNTAfkOgdiXnvz9bZSPtUofFFI1eJaw8wzYwySaroMTaK1EWUAxlZcHjHjAo3wUQAA4vTCO
 COfpeSXaEEWmcwxB8Ler8E80+uCL83R/s7v+l6D+DG078pXulkCjheBRvL2NqXPgNjBlcDYCg
 +nf77YEJ/jDDD84pH1fnNPx4DRilUec4O0KGuvRy2NAZgSHre7WISAGRfGxHk7Um21QbpS/8r
 L9SjQPqSYAK7AxgLl5PzZ/8HYttaNdHxt4NjB+kZxWytznJDN4Rh0biG69t4NPnnX6cIxIQiZ
 jliT/p7rgeNP+dnt45+zDk8crauzuHTIEgwCQEU4T6/Lu3gpY2rs6tZqUduDH8g9C90w8XYEG
 3lQGYEOBAb8fM5M2MBqudYwwatoe1bMbwIgfloAI1yxpOd+x+4x6aPtPvYrFvhNnEIALv6Dkx
 YM+nUuQtFCasDZzLtJI1ichWKVd5J6i+BEcznA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

gcc-8 warns about a code pattern that is used in the newly added
test_rhashtable code:

lib/test_rhashtable.c: In function 'print_ht':
lib/test_rhashtable.c:511:21: error: '
bucket[' directive writing 8 bytes into a region of size between 1 and 512 [-Werror=format-overflow=]
    sprintf(buff, "%s\nbucket[%d] -> ", buff, i);
                     ^~~~~~~~~
lib/test_rhashtable.c:511:4: note: 'sprintf' output between 15 and 536 bytes into a destination of size 512
    sprintf(buff, "%s\nbucket[%d] -> ", buff, i);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The problem here is using the same fixed-length buffer as input and output
of snprintf(), which for an unbounded loop has an actual potential to
overflow the buffer. The '512' byte length was apparently chosen to
be "long enough" to prevent that in practice, but without any specific
guarantees of being the smallest safe size.

I can see three possible ways to avoid this warning:

- rewrite the code to use pointer arithmetic to forward the buffer,
  rather than copying the buffer itself. This is a more conventional
  use of sprintf(), and it avoids the warning, but is not any more
  safe than the original code.
- Rewrite the function in a safe way that avoids both the potential
  overflow and the warning.
- Ask the gcc developers to not warn for this pattern if we consider
  the warning to be inappropriate.

This patch implements the second of the above, using scnprintf()
as Rasmus suggested.

Fixes: 499ac3b60f65 ("test_rhashtable: add test case for rhltable with duplicate objects")
Cc: Martin Sebor <msebor@gcc.gnu.org>
Suggested-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
My patch is still untested, please try it out before applying.
---
 lib/test_rhashtable.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index f4000c137dbe..fa865a953176 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -496,6 +496,7 @@ static unsigned int __init print_ht(struct rhltable *rhlt)
 	struct rhashtable *ht;
 	const struct bucket_table *tbl;
 	char buff[512] = "";
+	size_t len = 0;
 	unsigned int i, cnt = 0;
 
 	ht = &rhlt->ht;
@@ -508,19 +509,19 @@ static unsigned int __init print_ht(struct rhltable *rhlt)
 		next = !rht_is_a_nulls(pos) ? rht_dereference(pos->next, ht) : NULL;
 
 		if (!rht_is_a_nulls(pos)) {
-			sprintf(buff, "%s\nbucket[%d] -> ", buff, i);
+			len += scnprintf(buff + len, sizeof(buff) - len, "\nbucket[%d] -> ", i);
 		}
 
 		while (!rht_is_a_nulls(pos)) {
 			struct rhlist_head *list = container_of(pos, struct rhlist_head, rhead);
-			sprintf(buff, "%s[[", buff);
+			len += scnprintf(buff + len, sizeof(buff) - len, "[[");
 			do {
 				pos = &list->rhead;
 				list = rht_dereference(list->next, ht);
 				p = rht_obj(ht, pos);
 
-				sprintf(buff, "%s val %d (tid=%d)%s", buff, p->value.id, p->value.tid,
-					list? ", " : " ");
+				len += scnprintf(buff + len, sizeof(buff) - len, " val %d (tid=%d)%s",
+						 p->value.id, p->value.tid, list? ", " : " ");
 				cnt++;
 			} while (list);
 
@@ -528,7 +529,8 @@ static unsigned int __init print_ht(struct rhltable *rhlt)
 			next = !rht_is_a_nulls(pos) ?
 				rht_dereference(pos->next, ht) : NULL;
 
-			sprintf(buff, "%s]]%s", buff, !rht_is_a_nulls(pos) ? " -> " : "");
+			len += scnprintf(buff + len, sizeof(buff) - len, "]]%s",
+					 !rht_is_a_nulls(pos) ? " -> " : "");
 		}
 	}
 	printk(KERN_ERR "\n---- ht: ----%s\n-------------\n", buff);
-- 
2.9.0
