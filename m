Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753277AbeDCUJQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 16:09:16 -0400
Received: from gateway32.websitewelcome.com ([192.185.145.107]:21545 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752246AbeDCUJO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 16:09:14 -0400
Date: Tue, 3 Apr 2018 15:09:12 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Atul Gupta <atul.gupta@chelsio.com>, Harsh Jain <harsh@chelsio.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>
Cc: linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] crypto : chtls_cm - Fix potential NULL pointer dereferences
Message-ID: <20180403200912.GA25976@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f3SEy-003tTy-U7
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.54.187]:52958
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 6
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add null checks on lookup_tid() return value in order to prevent
null pointer dereferences.

Addresses-Coverity-ID: 1467422 ("Dereference null return value")
Addresses-Coverity-ID: 1467443 ("Dereference null return value")
Addresses-Coverity-ID: 1467445 ("Dereference null return value")
Addresses-Coverity-ID: 1467449 ("Dereference null return value")
Fixes: cc35c88ae4db ("crypto : chtls - CPL handler definition")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/crypto/chelsio/chtls/chtls_cm.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/crypto/chelsio/chtls/chtls_cm.c b/drivers/crypto/chelsio/chtls/chtls_cm.c
index 82a473a..23c43b8 100644
--- a/drivers/crypto/chelsio/chtls/chtls_cm.c
+++ b/drivers/crypto/chelsio/chtls/chtls_cm.c
@@ -1537,6 +1537,10 @@ static int chtls_rx_data(struct chtls_dev *cdev, struct sk_buff *skb)
 	struct sock *sk;
 
 	sk = lookup_tid(cdev->tids, hwtid);
+	if (unlikely(!sk)) {
+		pr_err("can't find conn. for hwtid %u.\n", hwtid);
+		return -EINVAL;
+	}
 	skb_dst_set(skb, NULL);
 	process_cpl_msg(chtls_recv_data, sk, skb);
 	return 0;
@@ -1585,6 +1589,10 @@ static int chtls_rx_pdu(struct chtls_dev *cdev, struct sk_buff *skb)
 	struct sock *sk;
 
 	sk = lookup_tid(cdev->tids, hwtid);
+	if (unlikely(!sk)) {
+		pr_err("can't find conn. for hwtid %u.\n", hwtid);
+		return -EINVAL;
+	}
 	skb_dst_set(skb, NULL);
 	process_cpl_msg(chtls_recv_pdu, sk, skb);
 	return 0;
@@ -1646,6 +1654,10 @@ static int chtls_rx_cmp(struct chtls_dev *cdev, struct sk_buff *skb)
 	struct sock *sk;
 
 	sk = lookup_tid(cdev->tids, hwtid);
+	if (unlikely(!sk)) {
+		pr_err("can't find conn. for hwtid %u.\n", hwtid);
+		return -EINVAL;
+	}
 	skb_dst_set(skb, NULL);
 	process_cpl_msg(chtls_rx_hdr, sk, skb);
 
@@ -2105,6 +2117,10 @@ static int chtls_wr_ack(struct chtls_dev *cdev, struct sk_buff *skb)
 	struct sock *sk;
 
 	sk = lookup_tid(cdev->tids, hwtid);
+	if (unlikely(!sk)) {
+		pr_err("can't find conn. for hwtid %u.\n", hwtid);
+		return -EINVAL;
+	}
 	process_cpl_msg(chtls_rx_ack, sk, skb);
 
 	return 0;
-- 
2.7.4
