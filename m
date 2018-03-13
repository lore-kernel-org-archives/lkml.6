Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753257AbeCMU7e (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 16:59:34 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:32881 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751606AbeCMU7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 16:59:32 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: "David S. Miller" <davem@davemloft.net>
Cc: "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Arnd Bergmann <arnd@arndb.de>, Dmitry Safonov <dima@arista.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Eric Dumazet <edumazet@google.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] pktgen: use dynamic allocation for debug print buffer
Date: Tue, 13 Mar 2018 21:58:39 +0100
Message-Id: <20180313205856.3309750-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:gYPnWXSgfjW9oWtrgm3ai6EMJ+l6x8vwrYFPhfHrDIyB/3JMAHT
 EnJMnbGTwEQDBbeVNgkBmmZ9irwis6umRG7FWSb3qBxBn0ijHQXV1/pal/KYBbcw3SQqhnC
 DmdMNbJ5+ddONIM3Wyjv7S48dJXfDJ7iMzBTU/Bs6LSYvQYYOKf79kcincZ6RnksmCXl4qN
 VukMX/oe7sJO2Bs8MTo7w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:tMqcks/Hy3U=:6s5tbNLixJoAduYSOOQtnA
 9jJtesmpS78tWJ5BN+5OTszYvYQKO4lW8a9yMz/CRtHGZpH4rfYMC8t+JI/WpCxTqZ4quTL0p
 ONT9AsOvtzEPTq7CE8cb67JnZF3siRpQEBcvwKeSayrurDtYGbX7Sf5yFOSeXU5UrDhqWCZgD
 FLMTq0hExDk7GfevTlXG7jK4eN04joD5A06UGOzkeQe7kvbFfQAeTeUopER7W1Z6a3gZYLcaC
 T4pipcpuns8AS5H3+fhZVTqUfeGKWuxPYh08q2H9NN44dJzbJwHmU1pn7u+mmJMaguHMPJVmb
 /UT60Ff+0td9bzc0jc2SbAVR47L0/haEQacmbilePhQGu43rav2GwWB9IeHHWNZ9fwAg/5Fgy
 ylWMX58tfIHr9gS2E9NPr58Ygg3ZRbruEaiAKEMEMpC6l9E490tyPExMrlQMvlDP51qng0IkO
 mlW7Ck/1IyWJIcA7RhWisRsrGqGNhBD1cvLVFtLZGu2+fDmW/Iw13yAIzOlWHMydQqGPlMyYG
 j3ahcukKZza+JLNnfAF3LlnHQWlKqA6rYOtclJtPhYVINZSeyN6Mg/gvKqRH5lX1P+v2nPhzI
 +g/jbVwGR2QKcHUiqHs89XP1vKcAZuY29I7GhwgkKiYwFJ9vQodVei0jobBspw69ClpLc9lAQ
 20wmTeR/D63EDuuysvJcW4wmN0fhQxFXHQmzqcdJ7ruZS0Z9A1vEz5okCcq8Imm7CuIvJ9rf0
 fTO9Plj58yVLud5QaeAVB7k2L7qiVug/Ij2KyA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After the removal of the VLA, we get a harmless warning about a large
stack frame:

net/core/pktgen.c: In function 'pktgen_if_write':
net/core/pktgen.c:1710:1: error: the frame size of 1076 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

The function was previously shown to be safe despite hitting
the 1024 bye warning level. To get rid of the annoyging warning,
while keeping it readable, this changes it to use strndup_user().

Obviously this is not a fast path, so the kmalloc() overhead
can be disregarded.

Fixes: 35951393bbff ("pktgen: Remove VLA usage")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 net/core/pktgen.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/core/pktgen.c b/net/core/pktgen.c
index de17a9f3e1f6..9216cf99b5a0 100644
--- a/net/core/pktgen.c
+++ b/net/core/pktgen.c
@@ -906,13 +906,14 @@ static ssize_t pktgen_if_write(struct file *file,
 	i += len;
 
 	if (debug) {
-		size_t copy = min_t(size_t, count, 1023);
-		char tb[1024];
-		if (copy_from_user(tb, user_buffer, copy))
-			return -EFAULT;
-		tb[copy] = 0;
-		pr_debug("%s,%lu  buffer -:%s:-\n",
-			 name, (unsigned long)count, tb);
+		size_t copy = min_t(size_t, count + 1, 1024);
+		char *tp = strndup_user(user_buffer, copy);
+
+		if (IS_ERR(tp))
+			return PTR_ERR(tp);
+
+		pr_debug("%s,%zu  buffer -:%s:-\n", name, count, tp);
+		kfree(buf);
 	}
 
 	if (!strcmp(name, "min_pkt_size")) {
-- 
2.9.0
