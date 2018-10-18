Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A33C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D18621479
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qm7ZFC+f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D18621479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbeJSCHk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:07:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:56408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726599AbeJSCHj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:07:39 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39D9B2145D;
        Thu, 18 Oct 2018 18:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885931;
        bh=WHdFFb6gLB3GVdQd2zP5WRuRnDjpKP6JBvfOiN2ql6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qm7ZFC+f1xaNoymiCWYt7RrRVuWCaWLbxehcCDcUmBrAFzfARRft12M3N5Gpfa+1g
         VlFWQfdblWsRS/F2Rmzry2W3iZ5dBbBXjRVSJXOV+WX4h5hhHGo6NHA0C7I/t3PE6/
         7NzsWdSp9y3p2emJmlAEjirstbr1etYSToPmsoa4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 21/48] ipv4: fix use-after-free in ip_cmsg_recv_dstaddr()
Date:   Thu, 18 Oct 2018 19:54:56 +0200
Message-Id: <20181018175429.154522584@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175427.133690306@linuxfoundation.org>
References: <20181018175427.133690306@linuxfoundation.org>
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

[ Upstream commit 64199fc0a46ba211362472f7f942f900af9492fd ]

Caching ip_hdr(skb) before a call to pskb_may_pull() is buggy,
do not do it.

Fixes: 2efd4fca703a ("ip: in cmsg IP(V6)_ORIGDSTADDR call pskb_may_pull")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Willem de Bruijn <willemb@google.com>
Reported-by: syzbot <syzkaller@googlegroups.com>
Acked-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_sockglue.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/net/ipv4/ip_sockglue.c
+++ b/net/ipv4/ip_sockglue.c
@@ -134,7 +134,6 @@ static void ip_cmsg_recv_security(struct
 static void ip_cmsg_recv_dstaddr(struct msghdr *msg, struct sk_buff *skb)
 {
 	struct sockaddr_in sin;
-	const struct iphdr *iph = ip_hdr(skb);
 	__be16 *ports;
 	int end;
 
@@ -149,7 +148,7 @@ static void ip_cmsg_recv_dstaddr(struct
 	ports = (__be16 *)skb_transport_header(skb);
 
 	sin.sin_family = AF_INET;
-	sin.sin_addr.s_addr = iph->daddr;
+	sin.sin_addr.s_addr = ip_hdr(skb)->daddr;
 	sin.sin_port = ports[1];
 	memset(sin.sin_zero, 0, sizeof(sin.sin_zero));
 


