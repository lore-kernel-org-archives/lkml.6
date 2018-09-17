Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99992ECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:04:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5AAF1214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 23:04:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AAF1214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730925AbeIREeT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:34:19 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:49210 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730358AbeIREeT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:34:19 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 18601C03;
        Mon, 17 Sep 2018 23:04:49 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        "netdev@vger.kernel.org, stable@vger.kernel.org, edumazet@google.com,
        Nikolay Borisov" <kernel@kyup.com>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Nikolay Borisov <kernel@kyup.com>
Subject: [PATCH 4.14 098/126] ipv6: export ip6 fragments sysctl to unprivileged users
Date:   Tue, 18 Sep 2018 00:42:26 +0200
Message-Id: <20180917211710.344524676@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211703.481236999@linuxfoundation.org>
References: <20180917211703.481236999@linuxfoundation.org>
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

From: Eric Dumazet <edumazet@google.com>

IPv4 was changed in commit 52a773d645e9 ("net: Export ip fragment
sysctl to unprivileged users")

The only sysctl that is not per-netns is not used :
ip6frag_secret_interval

Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Nikolay Borisov <kernel@kyup.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
(cherry picked from commit 18dcbe12fe9fca0ab825f7eff993060525ac2503)
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/reassembly.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -649,10 +649,6 @@ static int __net_init ip6_frags_ns_sysct
 		table[1].data = &net->ipv6.frags.low_thresh;
 		table[1].extra2 = &net->ipv6.frags.high_thresh;
 		table[2].data = &net->ipv6.frags.timeout;
-
-		/* Don't export sysctls to unprivileged users */
-		if (net->user_ns != &init_user_ns)
-			table[0].procname = NULL;
 	}
 
 	hdr = register_net_sysctl(net, "net/ipv6", table);


