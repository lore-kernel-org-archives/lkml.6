Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A759DC282C5
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BE3121905
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358490;
	bh=msHuJtA5NLI7SP1HLT8+AwSODS6DKXzx8P82El5OTGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=zn+2HNVXqp5/r2Nr3dntyMUfiZhmGZb7DQMv8NZHb+JLRn+C0mraeS9akkNW5raf5
	 1Z4GMLQg9uyu+RDbEyjtv3E98yXKIbguTUAI4CjVY2yHLooY4mvmi6d+xOvwuo/gxg
	 iOyiqy39cLzoG2Cyt0QXdQLRYqZLGsGNMSh489a0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732261AbfAXTes (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:34:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:34582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731090AbfAXTep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:34:45 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB8D2218D4;
        Thu, 24 Jan 2019 19:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358484;
        bh=msHuJtA5NLI7SP1HLT8+AwSODS6DKXzx8P82El5OTGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WZG3ONuYW0da2eXxHJKoE+6Pu9kxfKqpdt3SXSq4Hyu8LijJVVYjE53bcWhCmf9vQ
         jakyxdtiQ5cR47QCJKXW4mNFKonNJQApaqQGu8hUnm2Fd9MCVuOKDPRYEz6Jufu6DZ
         LG2rAK4hqOu3i/UIqInx/W5OZpUkve2X1xJCnWxM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 008/106] ipv6: Take rcu_read_lock in __inet6_bind for mapped addresses
Date:   Thu, 24 Jan 2019 20:19:25 +0100
Message-Id: <20190124190206.924370525@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190206.342411005@linuxfoundation.org>
References: <20190124190206.342411005@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

[ Upstream commit d4a7e9bb74b5aaf07b89f6531c080b1130bdf019 ]

I realized the last patch calls dev_get_by_index_rcu in a branch not
holding the rcu lock. Add the calls to rcu_read_lock and rcu_read_unlock.

Fixes: ec90ad334986 ("ipv6: Consider sk_bound_dev_if when binding a socket to a v4 mapped address")
Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/af_inet6.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -320,17 +320,20 @@ static int __inet6_bind(struct sock *sk,
 			goto out;
 		}
 
+		rcu_read_lock();
 		if (sk->sk_bound_dev_if) {
 			dev = dev_get_by_index_rcu(net, sk->sk_bound_dev_if);
 			if (!dev) {
 				err = -ENODEV;
-				goto out;
+				goto out_unlock;
 			}
 		}
 
 		/* Reproduce AF_INET checks to make the bindings consistent */
 		v4addr = addr->sin6_addr.s6_addr32[3];
 		chk_addr_ret = inet_addr_type_dev_table(net, dev, v4addr);
+		rcu_read_unlock();
+
 		if (!inet_can_nonlocal_bind(net, inet) &&
 		    v4addr != htonl(INADDR_ANY) &&
 		    chk_addr_ret != RTN_LOCAL &&


