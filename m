Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F02BC43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:32:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 038DC21533
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 09:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038DC21533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbeI0PuP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 11:50:15 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:57198 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727255AbeI0PuP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 11:50:15 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B1D3A1120;
        Thu, 27 Sep 2018 09:32:51 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 12/28] ipv6: fix possible use-after-free in ip6_xmit()
Date:   Thu, 27 Sep 2018 11:06:36 +0200
Message-Id: <20180927090638.203524297@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180927090637.687829444@linuxfoundation.org>
References: <20180927090637.687829444@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit bbd6528d28c1b8e80832b3b018ec402b6f5c3215 ]

In the unlikely case ip6_xmit() has to call skb_realloc_headroom(),
we need to call skb_set_owner_w() before consuming original skb,
otherwise we risk a use-after-free.

Bring IPv6 in line with what we do in IPv4 to fix this.

Fixes: 1da177e4c3f41 ("Linux-2.6.12-rc2")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ip6_output.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -193,12 +193,10 @@ int ip6_xmit(const struct sock *sk, stru
 				kfree_skb(skb);
 				return -ENOBUFS;
 			}
+			if (skb->sk)
+				skb_set_owner_w(skb2, skb->sk);
 			consume_skb(skb);
 			skb = skb2;
-			/* skb_set_owner_w() changes sk->sk_wmem_alloc atomically,
-			 * it is safe to call in our context (socket lock not held)
-			 */
-			skb_set_owner_w(skb, (struct sock *)sk);
 		}
 		if (opt->opt_flen)
 			ipv6_push_frag_opts(skb, opt, &proto);


