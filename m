Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B8AC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:23:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FCF420866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:23:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="as5PFs1r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FCF420866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731428AbeJQBO5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:33448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730397AbeJQBO4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:14:56 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40E9D20866;
        Tue, 16 Oct 2018 17:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710610;
        bh=8VMKZVl1XUnG4zde9geNPLXtx6U+GmWBRA5HkspuBBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=as5PFs1r5C0ZrKCyt2LQ+wryAiPeCjDiQ1qA6BE1IXGRkSDq1303U7mrdXEuyFg5/
         Gb72vvkHYPAb5ZC1Ya5ucNeP/NVIGbP+pIYh3i0n7x+fwENRS4AHsa0BMzzxoP2DqT
         g9oleLftVU0hKHcJD5rOf1RoZZD0XqjgoznVlRj4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
        Willem de Bruijn <willemb@google.com>,
        syzbot <syzkaller@googlegroups.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 26/71] ipv4: fix use-after-free in ip_cmsg_recv_dstaddr()
Date:   Tue, 16 Oct 2018 19:09:23 +0200
Message-Id: <20181016170540.711499782@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170539.315587743@linuxfoundation.org>
References: <20181016170539.315587743@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

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
 


