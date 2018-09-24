Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95426ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57482214C5
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:12:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57482214C5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731389AbeIXSOH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:14:07 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:54960 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731371AbeIXSOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:14:06 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id EC7821081;
        Mon, 24 Sep 2018 12:12:15 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Willem de Bruijn <willemb@google.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 011/173] tcp: really ignore MSG_ZEROCOPY if no SO_ZEROCOPY
Date:   Mon, 24 Sep 2018 13:50:45 +0200
Message-Id: <20180924113115.696440674@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113114.334025954@linuxfoundation.org>
References: <20180924113114.334025954@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Whitchurch <vincent.whitchurch@axis.com>

[ Upstream commit 5cf4a8532c992bb22a9ecd5f6d93f873f4eaccc2 ]

According to the documentation in msg_zerocopy.rst, the SO_ZEROCOPY
flag was introduced because send(2) ignores unknown message flags and
any legacy application which was accidentally passing the equivalent of
MSG_ZEROCOPY earlier should not see any new behaviour.

Before commit f214f915e7db ("tcp: enable MSG_ZEROCOPY"), a send(2) call
which passed the equivalent of MSG_ZEROCOPY without setting SO_ZEROCOPY
would succeed.  However, after that commit, it fails with -ENOBUFS.  So
it appears that the SO_ZEROCOPY flag fails to fulfill its intended
purpose.  Fix it.

Fixes: f214f915e7db ("tcp: enable MSG_ZEROCOPY")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/core/skbuff.c |    3 ---
 net/ipv4/tcp.c    |    2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -937,9 +937,6 @@ struct ubuf_info *sock_zerocopy_alloc(st
 
 	WARN_ON_ONCE(!in_task());
 
-	if (!sock_flag(sk, SOCK_ZEROCOPY))
-		return NULL;
-
 	skb = sock_omalloc(sk, 0, GFP_KERNEL);
 	if (!skb)
 		return NULL;
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -1177,7 +1177,7 @@ int tcp_sendmsg_locked(struct sock *sk,
 
 	flags = msg->msg_flags;
 
-	if (flags & MSG_ZEROCOPY && size) {
+	if (flags & MSG_ZEROCOPY && size && sock_flag(sk, SOCK_ZEROCOPY)) {
 		if (sk->sk_state != TCP_ESTABLISHED) {
 			err = -EINVAL;
 			goto out_err;


