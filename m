Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E1D2C4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0561B214C4
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 12:52:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0561B214C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbeHUQME (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 12:12:04 -0400
Received: from nautica.notk.org ([91.121.71.147]:46875 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727386AbeHUQMD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 12:12:03 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id 437E2C009; Tue, 21 Aug 2018 14:52:00 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Doron Roberts-Kedes <doronrk@fb.com>,
        Tom Herbert <tom@quantonium.net>,
        Dave Watson <davejwatson@fb.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] strparser: remove any offset before parsing messages
Date:   Tue, 21 Aug 2018 14:51:46 +0200
Message-Id: <1534855906-22870-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1533854411-28184-1-git-send-email-asmadeus@codewreck.org>
References: <1533854411-28184-1-git-send-email-asmadeus@codewreck.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Offset is not well handled by strparser users right now.

Out of the current strparser users, we have:
 - tls, that handles offset properly in parse and rcv callbacks
 - kcm, that handles offset in rcv but not in parse
 - bpf sockmap, that does not seem to handle offset anywhere

Calling pskb_pull() on new skb ensures that the offset will be 0
everywhere in practice, and in particular for the parse function,
unless the user modifies it themselves like tls does.

This fixes a bug which can be exhibited by implementing a simple kcm
parser that looks for the packet size in the first word of the packet,
and sending two such packets in a single write() call on the other side:
the second message will be cut at the length of the first message.
Since this is a stream protocol, all the following messages will also
be corrupt since it will start looking for the next offset at a wrong
position.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---

I haven't had any comment on v0, so here is what I had planned as
refactoring anyawy, but I'd *really* like some opinion on this as a
whole...

Also note that compiling bpf programs with libbcc is currently broken in
linus' master, see the fix thread here:
https://lkml.kernel.org/r/1534834088-15835-1-git-send-email-yamada.masahiro@socionext.com
You can likely just revert cafa0010cd51 ("Raise the minimum required gcc
version to 4.6") localy meanwhile, or base the patch off 4.18.

 net/strparser/strparser.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index da1a676860ca..d7fb30b1bcfc 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -201,7 +201,17 @@ static int __strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
 			strp->skb_nextp = NULL;
 			stm = _strp_msg(head);
 			memset(stm, 0, sizeof(*stm));
-			stm->strp.offset = orig_offset + eaten;
+
+			/* Can only parse if there is no offset */
+			if (unlikely(orig_offset + eaten)) {
+				if (!pskb_pull(skb, orig_offset + eaten)) {
+					STRP_STATS_INCR(strp->stats.mem_fail);
+					strp_parser_err(strp, -ENOMEM, desc);
+					break;
+				}
+				orig_len -= eaten;
+				orig_offset = eaten = 0;
+			}
 		} else {
 			/* Unclone if we are appending to an skb that we
 			 * already share a frag_list with.
@@ -253,8 +263,7 @@ static int __strp_recv(read_descriptor_t *desc, struct sk_buff *orig_skb,
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

