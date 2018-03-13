Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752736AbeCMNWo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 09:22:44 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60299 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbeCMNW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 09:22:26 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "David S. Miller" <davem@davemloft.net>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Paul Blakey <paulb@mellanox.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Martin Sebor <msebor@gcc.gnu.org>,
        Florian Westphal <fw@strlen.de>, Phil Sutter <phil@nwl.cc>,
        Tom Herbert <tom@quantonium.net>, linux-kernel@vger.kernel.org
Subject: [PATCH] test_rhashtable: avoid gcc-8 -Wformat-overflow warning
Date: Tue, 13 Mar 2018 14:21:39 +0100
Message-Id: <20180313132155.203220-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:1zKOjzsUv79byOvmpf64nc+Ek6WuDIX6rI/9E45P4+hpLloQk2K
 Ys3FuRkxQn59yWOuNnTe3gT0ReJEff5Hbz1pNAfy85bmwT7o790bG6X4jO38FFtYLjPoPLw
 0NL8BwjF4oZRTMB3Lva2HFfXJLdeJGyzBVOcIbIncCOh25bxJUuqCM2LukEWtWUg+WomTKR
 Bqp0l6HY4TkKX6ErwleAw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tmR+yglkwmc=:UruXE+MAfKYkRSG7bGZuoF
 82Jr2ojl4WuRBH0vcyBg2x5bw0ZcvkFtKmzfI68u+dtPE9IU/ud7fL6oRLqapFeyzS6jYafh5
 T/NAKUEH1C3PG8GwPwyOPuC8iDVcsUPN/V/1J6DSp4nsV1V04aWr3EBwdlC/f9oogN+whZbN0
 D3Ej2MqhCsk8DoTv5HwqhVpn7HMIZ9U2Tml3vh21wXocrIDpUs6SlCOYHseZyAT6OC7xsisBB
 DTlvZZ2IwnOjDNYZY+oop14kCRmtpp7Rqq9fr1B7Kz6pVysdOxYZhOmG89MZ7hVpWTT7s7Zle
 XCobmIurGzULMWYSn3aOTA/6xNeXQqPAp1x4OmECqxXtuFc2/+PoM4qzzliRNYEU/R/xeLYrs
 r3vXvAQBBJvDTHYfOkiqoQOnuJW5KCFSuVckPz/zR+bo32v+dxbjrNsnh4nQejIYP/R0zj0mY
 lGm5kY11ssV0Rb7Ijrsl5/ioEzLla6BUa/+Tg4CyCT4LJE6yoEDmSy6IePb2EfyTo7eq+sY6c
 ngVef1Iz8PbKaQ7aZ/dV8/mONtTWLDz6S2yfl62v+su9RKdaDbDGZIHJOFnXBQZ8FtBOp2COO
 EA7WGZ6eImp1xBm6jCQBX9c+Jl3Hy3WY6+tYXJdSxGXRs3Kkp/tx6dpIe18bIRmrwMPyODcVp
 8XL9eU3geKyWbOZRJY4MfaFM+pOsNGNWmeTwW6iSEDIoIm1wJ/YIR+pZdJ10MBO2RSWQySMIU
 7YmGaXZa7lRLSoQR5vED01DcsZj0GjyVdK9OBg==
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

This patch implements the first of the above, as an illustration of
the problem, and the simplest workaround.

Fixes: 499ac3b60f65 ("test_rhashtable: add test case for rhltable with duplicate objects")
Cc: Martin Sebor <msebor@gcc.gnu.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
My patch is untested, please try it out before applying.
---
 lib/test_rhashtable.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/test_rhashtable.c b/lib/test_rhashtable.c
index f4000c137dbe..a0f4fb03d2de 100644
--- a/lib/test_rhashtable.c
+++ b/lib/test_rhashtable.c
@@ -496,6 +496,7 @@ static unsigned int __init print_ht(struct rhltable *rhlt)
 	struct rhashtable *ht;
 	const struct bucket_table *tbl;
 	char buff[512] = "";
+	char *buffp = buff;
 	unsigned int i, cnt = 0;
 
 	ht = &rhlt->ht;
@@ -508,18 +509,18 @@ static unsigned int __init print_ht(struct rhltable *rhlt)
 		next = !rht_is_a_nulls(pos) ? rht_dereference(pos->next, ht) : NULL;
 
 		if (!rht_is_a_nulls(pos)) {
-			sprintf(buff, "%s\nbucket[%d] -> ", buff, i);
+			buffp += sprintf(buffp, "\nbucket[%d] -> ", i);
 		}
 
 		while (!rht_is_a_nulls(pos)) {
 			struct rhlist_head *list = container_of(pos, struct rhlist_head, rhead);
-			sprintf(buff, "%s[[", buff);
+			buffp += sprintf(buffp, "[[");
 			do {
 				pos = &list->rhead;
 				list = rht_dereference(list->next, ht);
 				p = rht_obj(ht, pos);
 
-				sprintf(buff, "%s val %d (tid=%d)%s", buff, p->value.id, p->value.tid,
+				buffp += sprintf(buffp, "val %d (tid=%d)%s", p->value.id, p->value.tid,
 					list? ", " : " ");
 				cnt++;
 			} while (list);
@@ -528,7 +529,7 @@ static unsigned int __init print_ht(struct rhltable *rhlt)
 			next = !rht_is_a_nulls(pos) ?
 				rht_dereference(pos->next, ht) : NULL;
 
-			sprintf(buff, "%s]]%s", buff, !rht_is_a_nulls(pos) ? " -> " : "");
+			buffp += sprintf(buffp, "]]%s", !rht_is_a_nulls(pos) ? " -> " : "");
 		}
 	}
 	printk(KERN_ERR "\n---- ht: ----%s\n-------------\n", buff);
-- 
2.9.0
