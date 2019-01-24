Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E1EC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:11:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA15218D0
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548360661;
	bh=xrdeE7+G5NxFGihwCcrHlwJn3lIcpHzEY5dv+OgmZoE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Vgxo0NaDe0g+g7XtuhLzHDdH1xC4UQ9LCV18vtjIBXRil5VNl3CC+8e2xEHjIw984
	 t9tnPX7d/Yg3LgFqNHp+c4XTiGDJDGL0nZAULXeH3TuoLPyiZC6ddLLbhzE9LfTC2k
	 tYFAmfKNYm91Eq8aVuWsjKvYKHeqRBWtA6hSDjdA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730154AbfAXULA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 15:11:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:53528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730733AbfAXT1R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:27:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0ABF218A6;
        Thu, 24 Jan 2019 19:27:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358037;
        bh=xrdeE7+G5NxFGihwCcrHlwJn3lIcpHzEY5dv+OgmZoE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KTodpGok7MpFIGdWvDZ7K8KEB8Nvy8+gqfjJfnYMQ5dZG7yxnVrGm31vqaLClqxlA
         Z9rn99raARWrcPpt4GvOHY8cqiaCyyV7f23hW3Vufzm4n/En+SHm7AgsPkxXAwiM/g
         Q7uiHonYcIVrBii7d0srjzS5I/3XmJtD02Bj1ggU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 074/104] ipv6: Consider sk_bound_dev_if when binding a socket to a v4 mapped address
Date:   Thu, 24 Jan 2019 20:20:03 +0100
Message-Id: <20190124190203.672814583@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190154.968308875@linuxfoundation.org>
References: <20190124190154.968308875@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Ahern <dsahern@gmail.com>

[ Upstream commit ec90ad334986fa5856d11dd272f7f22fa86c55c4 ]

Similar to c5ee066333eb ("ipv6: Consider sk_bound_dev_if when binding a
socket to an address"), binding a socket to v4 mapped addresses needs to
consider if the socket is bound to a device.

This problem also exists from the beginning of git history.

Signed-off-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/af_inet6.c |   11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -292,6 +292,7 @@ int inet6_bind(struct socket *sock, stru
 
 	/* Check if the address belongs to the host. */
 	if (addr_type == IPV6_ADDR_MAPPED) {
+		struct net_device *dev = NULL;
 		int chk_addr_ret;
 
 		/* Binding to v4-mapped address on a v6-only socket
@@ -302,9 +303,17 @@ int inet6_bind(struct socket *sock, stru
 			goto out;
 		}
 
+		if (sk->sk_bound_dev_if) {
+			dev = dev_get_by_index_rcu(net, sk->sk_bound_dev_if);
+			if (!dev) {
+				err = -ENODEV;
+				goto out;
+			}
+		}
+
 		/* Reproduce AF_INET checks to make the bindings consistent */
 		v4addr = addr->sin6_addr.s6_addr32[3];
-		chk_addr_ret = inet_addr_type(net, v4addr);
+		chk_addr_ret = inet_addr_type_dev_table(net, dev, v4addr);
 		if (!net->ipv4.sysctl_ip_nonlocal_bind &&
 		    !(inet->freebind || inet->transparent) &&
 		    v4addr != htonl(INADDR_ANY) &&


