Return-Path: <SRS0=bA34=MX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED0B9C32788
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3F702075C
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Oct 2018 15:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PPCdUxWH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3F702075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728592AbeJKXDm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Oct 2018 19:03:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:57822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726562AbeJKXDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Oct 2018 19:03:40 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4409C2087A;
        Thu, 11 Oct 2018 15:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539272158;
        bh=sT3zZ6fbgUp2uKX8qCgtHfUKp/SG7ZZxBkyQN1Kq2zk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PPCdUxWHjibF6MHmRSB+NEaDdEeGEQQCO0dVaqENpr3YlcDK10avSCGyxwIOGILPK
         N4iU3xJJkMC0enLLAeZn84H2DSBfXffemkvK8GBnfJQq1GGhaKisK1d9Y8x+1L3NYc
         Ezgm4eRoUIGT88F8arFGIzMdxFey7TQ7eLSk+0zg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 010/120] ipv6: fix possible use-after-free in ip6_xmit()
Date:   Thu, 11 Oct 2018 17:33:11 +0200
Message-Id: <20181011152549.957231822@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181011152549.500488630@linuxfoundation.org>
References: <20181011152549.500488630@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

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
 net/ipv6/ip6_output.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -183,9 +183,10 @@ int ip6_xmit(struct sock *sk, struct sk_
 				kfree_skb(skb);
 				return -ENOBUFS;
 			}
+			if (skb->sk)
+				skb_set_owner_w(skb2, skb->sk);
 			consume_skb(skb);
 			skb = skb2;
-			skb_set_owner_w(skb, sk);
 		}
 		if (opt->opt_flen)
 			ipv6_push_frag_opts(skb, opt, &proto);


