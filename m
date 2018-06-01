Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbeFAH7y (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 03:59:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41572 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbeFAH7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 03:59:49 -0400
Date: Fri, 1 Jun 2018 10:59:25 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Harsh Jain <harsh@chelsio.com>, Atul Gupta <atul.gupta@chelsio.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Atul Gupta <atul.gupta@chelsio.com>,
        Michael Werner <werner@chelsio.com>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] crypto: chtls - use after free in chtls_pt_recvmsg()
Message-ID: <20180601075852.fn5hongkasesi2ep@kili.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8910 signatures=668702
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=2 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=704
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1805220000 definitions=main-1806010090
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We call chtls_free_skb() but then we dereference it on the next lines.
Also "skb" can't be NULL, we just dereferenced it on the line before.

I have moved the free down a couple lines to fix this issue.

Fixes: 17a7d24aa89d ("crypto: chtls - generic handling of data and hdr")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/crypto/chelsio/chtls/chtls_io.c b/drivers/crypto/chelsio/chtls/chtls_io.c
index 51fc6821cbbf..708e232e3cdf 100644
--- a/drivers/crypto/chelsio/chtls/chtls_io.c
+++ b/drivers/crypto/chelsio/chtls/chtls_io.c
@@ -1548,15 +1548,14 @@ static int chtls_pt_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 			tp->urg_data = 0;
 
 		if ((avail + offset) >= skb->len) {
-			if (likely(skb))
-				chtls_free_skb(sk, skb);
-			buffers_freed++;
 			if (ULP_SKB_CB(skb)->flags & ULPCB_FLAG_TLS_HDR) {
 				tp->copied_seq += skb->len;
 				hws->rcvpld = skb->hdr_len;
 			} else {
 				tp->copied_seq += hws->rcvpld;
 			}
+			chtls_free_skb(sk, skb);
+			buffers_freed++;
 			hws->copied_seq = 0;
 			if (copied >= target &&
 			    !skb_peek(&sk->sk_receive_queue))
