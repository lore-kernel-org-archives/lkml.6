Return-Path: <SRS0=LZPJ=LZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD23FC6778D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58FD12086E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Sep 2018 09:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58FD12086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codewreck.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727033AbeIKOUZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Sep 2018 10:20:25 -0400
Received: from nautica.notk.org ([91.121.71.147]:54637 "EHLO nautica.notk.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726563AbeIKOUZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Sep 2018 10:20:25 -0400
Received: by nautica.notk.org (Postfix, from userid 1001)
        id BF201C009; Tue, 11 Sep 2018 11:21:57 +0200 (CEST)
From:   Dominique Martinet <asmadeus@codewreck.org>
To:     Doron Roberts-Kedes <doronrk@fb.com>,
        Tom Herbert <tom@quantonium.net>,
        Dave Watson <davejwatson@fb.com>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] kcm: remove any offset before parsing messages
Date:   Tue, 11 Sep 2018 11:21:43 +0200
Message-Id: <1536657703-27577-1-git-send-email-asmadeus@codewreck.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: 1534855906-22870-1-git-send-email-asmadeus@codewreck.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current code assumes kcm users know they need to look for the
strparser offset within their bpf program, which is not documented
anywhere and examples laying around do not do.

The actual recv function does handle the offset well, so we can create a
temporary clone of the skb and pull that one up as required for parsing.

The pull itself has a cost if we are pulling beyond the head data,
measured to 2-3% latency in a noisy VM with a local client stressing
that path. The clone's impact seemed too small to measure.

This bug can be exhibited easily by implementing a "trivial" kcm parser
taking the first bytes as size, and on the client sending at least two
such packets in a single write().

Note that bpf sockmap has the same problem, both for parse and for recv,
so it would pulling twice or a real pull within the strparser logic if
anyone cares about that.

Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---

Hmm, while trying to benchmark this, I sometimes got hangs in
kcm_wait_data() for the last packet somehow?
The sender program was done (exited (zombie) so I assumed the sender
socket flushed), but the receiver was in kcm_wait_data in kcm_recvmsg
indicating it parsed a header but there was no skb to peek at?
But the sock is locked so this shouldn't be racy...

I can get it fairly often with this patch and small messages with an
offset, but I think it's just because the pull changes some timing - I
can't hit it with just the clone, and I can hit it with a pull without
clone as well.... And I don't see how pulling a cloned skb can impact
the original socket, but I'm a bit fuzzy on this.

(it's interesting that I didn't seem to hit this race when pulling in
strparser, that shouldn't be any different)


I'll look at that a bit more, but there have been no activity here for
a while and I don't have the energy to keep pushing in the strparser
direction, so take this patch more as a change of direction and a bit
as a 'bump' on the subject - I think it's important but I have too much
on my plate right now to keep pushing if there is no interest from the
authors.

 net/kcm/kcmsock.c | 26 +++++++++++++++++++++++++-
 1 file changed, 25 insertions(+), 1 deletion(-)

diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
index 571d824e4e24..36c438b95955 100644
--- a/net/kcm/kcmsock.c
+++ b/net/kcm/kcmsock.c
@@ -381,8 +381,32 @@ static int kcm_parse_func_strparser(struct strparser *strp, struct sk_buff *skb)
 {
 	struct kcm_psock *psock = container_of(strp, struct kcm_psock, strp);
 	struct bpf_prog *prog = psock->bpf_prog;
+	struct sk_buff *clone_skb = NULL;
+	struct strp_msg *stm;
+	int rc;
+
+	stm = strp_msg(skb);
+	if (stm->offset) {
+		skb = clone_skb = skb_clone(skb, GFP_ATOMIC);
+		if (!clone_skb)
+			return -ENOMEM;
+
+		if (!pskb_pull(clone_skb, stm->offset)) {
+			rc = -ENOMEM;
+			goto out;
+		}
+
+		/* reset cloned skb's offset for bpf programs using it */
+		stm = strp_msg(clone_skb);
+		stm->offset = 0;
+	}
+
+	rc = (*prog->bpf_func)(skb, prog->insnsi);
+out:
+	if (clone_skb)
+		kfree_skb(clone_skb);
 
-	return (*prog->bpf_func)(skb, prog->insnsi);
+	return rc;
 }
 
 static int kcm_read_sock_done(struct strparser *strp, int err)
-- 
2.17.1

