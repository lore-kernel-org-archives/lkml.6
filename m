Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC568C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AB3F8214DB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:09:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ie+qF3ub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB3F8214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbeKVFo5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:44:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:39644 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732102AbeKVFo4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:44:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FEB52151B;
        Wed, 21 Nov 2018 19:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827363;
        bh=2YFwkuhScewqe8aBtyleyHBQTNGxa2yBKZ8rPd+7ZWA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ie+qF3ubEKWqSW1lsTRJDSJjwlHmER6FEn92abqSXdhvTuLez6mQPl7lBCfkMVFnt
         YfZ5BlXOx3WJPWQN6cBnXqLk0XugXPvRCB20KNO46GaP3+fy7bZ4qvjHS8Z4AIrtvL
         4jqIwiR0xbXDvOcj3xPI5HSODFMR6diModIivwpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Sabrina Dubroca <sd@queasysnail.net>,
        Stefano Brivio <sbrivio@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 03/21] ip_tunnel: dont force DF when MTU is locked
Date:   Wed, 21 Nov 2018 20:06:47 +0100
Message-Id: <20181121183422.241348200@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183422.103826775@linuxfoundation.org>
References: <20181121183422.103826775@linuxfoundation.org>
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

From: Sabrina Dubroca <sd@queasysnail.net>

[ Upstream commit 16f7eb2b77b55da816c4e207f3f9440a8cafc00a ]

The various types of tunnels running over IPv4 can ask to set the DF
bit to do PMTU discovery. However, PMTU discovery is subject to the
threshold set by the net.ipv4.route.min_pmtu sysctl, and is also
disabled on routes with "mtu lock". In those cases, we shouldn't set
the DF bit.

This patch makes setting the DF bit conditional on the route's MTU
locking state.

This issue seems to be older than git history.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
Reviewed-by: Stefano Brivio <sbrivio@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv4/ip_tunnel_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/ipv4/ip_tunnel_core.c
+++ b/net/ipv4/ip_tunnel_core.c
@@ -80,7 +80,7 @@ void iptunnel_xmit(struct sock *sk, stru
 
 	iph->version	=	4;
 	iph->ihl	=	sizeof(struct iphdr) >> 2;
-	iph->frag_off	=	df;
+	iph->frag_off	=	ip_mtu_locked(&rt->dst) ? 0 : df;
 	iph->protocol	=	proto;
 	iph->tos	=	tos;
 	iph->daddr	=	dst;


