Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB425C43142
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:40:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 752F225049
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:40:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 752F225049
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932242AbeFXPkC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:40:02 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:59874 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932203AbeFXPj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:39:59 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C6FD349F;
        Sun, 24 Jun 2018 15:39:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
        Dave Watson <davejwatson@fb.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 10/70] tls: fix waitall behavior in tls_sw_recvmsg
Date:   Sun, 24 Jun 2018 23:22:02 +0800
Message-Id: <20180624142741.104630205@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
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

From: Daniel Borkmann <daniel@iogearbox.net>

[ Upstream commit 06030dbaf3b6c5801dcdb7fe4fbab3b91c8da84a ]

Current behavior in tls_sw_recvmsg() is to wait for incoming tls
messages and copy up to exactly len bytes of data that the user
provided. This is problematic in the sense that i) if no packet
is currently queued in strparser we keep waiting until one has been
processed and pushed into tls receive layer for tls_wait_data() to
wake up and push the decrypted bits to user space. Given after
tls decryption, we're back at streaming data, use sock_rcvlowat()
hint from tcp socket instead. Retain current behavior with MSG_WAITALL
flag and otherwise use the hint target for breaking the loop and
returning to application. This is done if currently no ctx->recv_pkt
is ready, otherwise continue to process it from our strparser
backlog.

Fixes: c46234ebb4d1 ("tls: RX path for ktls")
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Dave Watson <davejwatson@fb.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tls/tls_sw.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -755,7 +755,7 @@ int tls_sw_recvmsg(struct sock *sk,
 	struct sk_buff *skb;
 	ssize_t copied = 0;
 	bool cmsg = false;
-	int err = 0;
+	int target, err = 0;
 	long timeo;
 
 	flags |= nonblock;
@@ -765,6 +765,7 @@ int tls_sw_recvmsg(struct sock *sk,
 
 	lock_sock(sk);
 
+	target = sock_rcvlowat(sk, flags & MSG_WAITALL, len);
 	timeo = sock_rcvtimeo(sk, flags & MSG_DONTWAIT);
 	do {
 		bool zc = false;
@@ -857,6 +858,9 @@ fallback_to_reg_recv:
 					goto recv_end;
 			}
 		}
+		/* If we have a new message from strparser, continue now. */
+		if (copied >= target && !ctx->recv_pkt)
+			break;
 	} while (len);
 
 recv_end:


