Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3519AECDFBB
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:40:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8C320652
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 12:40:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8C320652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389845AbeGTN2y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 09:28:54 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:50524 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388500AbeGTN2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 09:28:53 -0400
Received: from localhost (LFbn-1-12238-233.w90-92.abo.wanadoo.fr [90.92.53.233])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C7E8DCB4;
        Fri, 20 Jul 2018 12:37:20 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Doron Roberts-Kedes <doronrk@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 041/101] strparser: Remove early eaten to fix full tcp receive buffer stall
Date:   Fri, 20 Jul 2018 14:13:47 +0200
Message-Id: <20180720121424.745084421@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180720121422.837870592@linuxfoundation.org>
References: <20180720121422.837870592@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Doron Roberts-Kedes <doronrk@fb.com>

[ Upstream commit 977c7114ebda2e746a114840d3a875e0cdb826fb ]

On receving an incomplete message, the existing code stores the
remaining length of the cloned skb in the early_eaten field instead of
incrementing the value returned by __strp_recv. This defers invocation
of sock_rfree for the current skb until the next invocation of
__strp_recv, which returns early_eaten if early_eaten is non-zero.

This behavior causes a stall when the current message occupies the very
tail end of a massive skb, and strp_peek/need_bytes indicates that the
remainder of the current message has yet to arrive on the socket. The
TCP receive buffer is totally full, causing the TCP window to go to
zero, so the remainder of the message will never arrive.

Incrementing the value returned by __strp_recv by the amount otherwise
stored in early_eaten prevents stalls of this nature.

Signed-off-by: Doron Roberts-Kedes <doronrk@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/strparser/strparser.c |   17 +----------------
 1 file changed, 1 insertion(+), 16 deletions(-)

--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -35,7 +35,6 @@ struct _strp_msg {
 	 */
 	struct strp_msg strp;
 	int accum_len;
-	int early_eaten;
 };
 
 static inline struct _strp_msg *_strp_msg(struct sk_buff *skb)
@@ -115,20 +114,6 @@ static int __strp_recv(read_descriptor_t
 	head = strp->skb_head;
 	if (head) {
 		/* Message already in progress */
-
-		stm = _strp_msg(head);
-		if (unlikely(stm->early_eaten)) {
-			/* Already some number of bytes on the receive sock
-			 * data saved in skb_head, just indicate they
-			 * are consumed.
-			 */
-			eaten = orig_len <= stm->early_eaten ?
-				orig_len : stm->early_eaten;
-			stm->early_eaten -= eaten;
-
-			return eaten;
-		}
-
 		if (unlikely(orig_offset)) {
 			/* Getting data with a non-zero offset when a message is
 			 * in progress is not expected. If it does happen, we
@@ -297,9 +282,9 @@ static int __strp_recv(read_descriptor_t
 				}
 
 				stm->accum_len += cand_len;
+				eaten += cand_len;
 				strp->need_bytes = stm->strp.full_len -
 						       stm->accum_len;
-				stm->early_eaten = cand_len;
 				STRP_STATS_ADD(strp->stats.bytes, cand_len);
 				desc->count = 0; /* Stop reading socket */
 				break;


