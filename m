Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbeEPRs6 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 13:48:58 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:51224 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751225AbeEPRs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 13:48:56 -0400
From: Matt Mullins <mmullins@fb.com>
To: "David S. Miller" <davem@davemloft.net>
CC: Matt Mullins <mmullins@fb.com>, Ilya Lesokhin <ilyal@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Dave Watson <davejwatson@fb.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH net] tls: don't use stack memory in a scatterlist
Date: Wed, 16 May 2018 10:48:40 -0700
Message-ID: <20180516174841.2119-1-mmullins@fb.com>
X-Mailer: git-send-email 2.14.1
X-FB-Internal: Safe
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-16_09:,,
 signatures=0
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scatterlist code expects virt_to_page() to work, which fails with
CONFIG_VMAP_STACK=y.

Fixes: c46234ebb4d1e ("tls: RX path for ktls")
Signed-off-by: Matt Mullins <mmullins@fb.com>
---
 include/net/tls.h | 3 +++
 net/tls/tls_sw.c  | 9 ++++-----
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/net/tls.h b/include/net/tls.h
index b400d0bb7448..f5fb16da3860 100644
--- a/include/net/tls.h
+++ b/include/net/tls.h
@@ -97,6 +97,9 @@ struct tls_sw_context {
 	u8 control;
 	bool decrypted;
 
+	char rx_aad_ciphertext[TLS_AAD_SPACE_SIZE];
+	char rx_aad_plaintext[TLS_AAD_SPACE_SIZE];
+
 	/* Sending context */
 	char aad_space[TLS_AAD_SPACE_SIZE];
 
diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 71e79597f940..e1c93ce74e0f 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -680,7 +680,6 @@ static int decrypt_skb(struct sock *sk, struct sk_buff *skb,
 	struct scatterlist *sgin = &sgin_arr[0];
 	struct strp_msg *rxm = strp_msg(skb);
 	int ret, nsg = ARRAY_SIZE(sgin_arr);
-	char aad_recv[TLS_AAD_SPACE_SIZE];
 	struct sk_buff *unused;
 
 	ret = skb_copy_bits(skb, rxm->offset + TLS_HEADER_SIZE,
@@ -698,13 +697,13 @@ static int decrypt_skb(struct sock *sk, struct sk_buff *skb,
 	}
 
 	sg_init_table(sgin, nsg);
-	sg_set_buf(&sgin[0], aad_recv, sizeof(aad_recv));
+	sg_set_buf(&sgin[0], ctx->rx_aad_ciphertext, TLS_AAD_SPACE_SIZE);
 
 	nsg = skb_to_sgvec(skb, &sgin[1],
 			   rxm->offset + tls_ctx->rx.prepend_size,
 			   rxm->full_len - tls_ctx->rx.prepend_size);
 
-	tls_make_aad(aad_recv,
+	tls_make_aad(ctx->rx_aad_ciphertext,
 		     rxm->full_len - tls_ctx->rx.overhead_size,
 		     tls_ctx->rx.rec_seq,
 		     tls_ctx->rx.rec_seq_size,
@@ -803,12 +802,12 @@ int tls_sw_recvmsg(struct sock *sk,
 			if (to_copy <= len && page_count < MAX_SKB_FRAGS &&
 			    likely(!(flags & MSG_PEEK)))  {
 				struct scatterlist sgin[MAX_SKB_FRAGS + 1];
-				char unused[21];
 				int pages = 0;
 
 				zc = true;
 				sg_init_table(sgin, MAX_SKB_FRAGS + 1);
-				sg_set_buf(&sgin[0], unused, 13);
+				sg_set_buf(&sgin[0], ctx->rx_aad_plaintext,
+					   TLS_AAD_SPACE_SIZE);
 
 				err = zerocopy_from_iter(sk, &msg->msg_iter,
 							 to_copy, &pages,
-- 
2.14.1
