Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560C6C46464
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:40:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF4C821EF8
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 22:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF4C821EF8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbeHJBHX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 21:07:23 -0400
Received: from nautica.notk.org ([91.121.71.147]:35296 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727380AbeHJBHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 21:07:23 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 88426C009; Fri, 10 Aug 2018 00:40:21 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Doron Roberts-Kedes <doronrk@fb.com>,
        Tom Herbert <tom@quantonium.net>,
        Dave Watson <davejwatson@fb.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v0] strparser: remove any offset before parsing messages
Date:   Fri, 10 Aug 2018 00:40:11 +0200
Message-Id: <1533854411-28184-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Offset is not well handled by strparser users right now.

Out of the current strparser users, we have:
 - tls, that handles offset properly in parse and rcv callbacks
 - kcm, that handles offset in rcv but not in parse
 - bpf sockmap, that does not seem to handle offset anywhere

Calling pskb_pull() on the skb before parsing ensures that the offset
will be 0 everywhere in practice unless the user modifies it themselves
like tls, as a workaround for the other two protocols.

This fixes a bug whilch can be exhibited by implementing a simpe kcm
parser that looks for the packet size in the first word of the packet,
and sending two such packets in a single write() call on the other side: 
the second message will be cut at the length of the first message.
Since this is a stream protocol, all the following messages will also
be corrupt since it will start looking for the next offset at a wrong
position.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---

Discussions on the bug along with a (bad) reproducer can be found here:
http://lkml.kernel.org/m/20180803182830.GB29193@nautica
(now the problem is better understood though it's much simpler to send
two messages at once than to spam and wait for tcp aggregation to do it)


Two notes:
 - I've marked this patch v0 as we could move the pskb_pull() up to
where strp.offset is set, and just always leave it at 0 in the strparser
code.
This will let applications that are fine dealing with a non-zero offset
deal with it as they seem fit (tls writes into the offset and full_len
fields behind the back of the stream parser), while still being safe for
kcm/sockmap

 - Even with that modification I'm not totally happy with
single-handedly eating the offset for strparser users which could handle
it, but I'm not really familiar with the cost this really has in
practice...
A better fix would be to handle the offset properly in the callbacks,
but frankly at least for kcm I don't see how (maybe because I'm not
familiar with how bpf programs work)

Another idea I had would be to write flags when registering the protocol
e.g. strp->cb.flags & STRP_CAN_PARSE_WITH_OFFSET or something like that,
but without an idea of the cost of that pull I don't know if it's worth
doing.


Anyway, comments welcome.


 net/strparser/strparser.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index 625acb27efcc..d7a3b81c3481 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -222,6 +222,16 @@ static int __strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
 		if (!stm->strp.full_len) {
 			ssize_t len;
 
+			/* Can only parse if there is no offset */
+			if (unlikely(stm->strp.offset)) {
+				if (!pskb_pull(skb, stm->strp.offset)) {
+					STRP_STATS_INCR(strp->stats.mem_fail);
+					strp_parser_err(strp, -ENOMEM, desc);
+					break;
+				}
+				stm->strp.offset = 0;
+			}
+
 			len = (*strp->cb.parse_msg)(strp, head);
 
 			if (!len) {
@@ -249,8 +259,7 @@ static int __strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
 				STRP_STATS_INCR(strp->stats.msg_too_big);
 				strp_parser_err(strp, -EMSGSIZE, desc);
 				break;
-			} else if (len <= (ssize_t)head->len -
-					  skb->len - stm->strp.offset) {
+			} else if (len <= (ssize_t)head->len - skb->len) {
 				/* Length must be into new skb (and also
 				 * greater than zero)
 				 */
-- 
2.17.1

