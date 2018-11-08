Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1637FC0044B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D038B20818
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:21:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="xvtowLEG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D038B20818
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731309AbeKIH7I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:59:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35516 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731762AbeKIHnO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:43:14 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C38162147D;
        Thu,  8 Nov 2018 22:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714743;
        bh=03GNyf3GBBiosE7DV3sKGJw7V/LoeMwV/YSckSln5+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xvtowLEGC5VS/c7VyFNNJIiEbtEMVcZUBPMmQ01roL024s1sHZMDR3RCcniOgbCrs
         yAl1asyNGXL/KPD9rRCDXQiUNEOnpC17s319EcEQHKxlB+xjheSQs9IeyVgehzxU4L
         4rmyYczo8GPUJsFxv48z0ywoFRZs9vMf1iB4DUNA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Peter Dawson <petedaws@gmail.com>,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>,
        Peter Dawson <peter.a.dawson@boeing.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 074/171] ip6_tunnel: Correct tos value in collect_md mode
Date:   Thu,  8 Nov 2018 13:50:44 -0800
Message-Id: <20181108215132.890765936@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
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

[ Upstream commit 46f8cd9d2fc1e4e8b82b53a0007f6c92e80c930b ]

Same as ip_gre, geneve and vxlan, use key->tos as traffic class value.

CC: Peter Dawson <petedaws@gmail.com>
Fixes: 0e9a709560db ("ip6_tunnel, ip6_gre: fix setting of DSCP on
encapsulated packets”)
Signed-off-by: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Acked-by: Peter Dawson <peter.a.dawson@boeing.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_tunnel.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index fd081a14064e..a499e585d018 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1258,7 +1258,7 @@ ip4ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev)
 		fl6.flowi6_proto = IPPROTO_IPIP;
 		fl6.daddr = key->u.ipv6.dst;
 		fl6.flowlabel = key->label;
-		dsfield = ip6_tclass(key->label);
+		dsfield =  key->tos;
 	} else {
 		if (!(t->parms.flags & IP6_TNL_F_IGN_ENCAP_LIMIT))
 			encap_limit = t->parms.encap_limit;
@@ -1329,7 +1329,7 @@ ip6ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev)
 		fl6.flowi6_proto = IPPROTO_IPV6;
 		fl6.daddr = key->u.ipv6.dst;
 		fl6.flowlabel = key->label;
-		dsfield = ip6_tclass(key->label);
+		dsfield = key->tos;
 	} else {
 		offset = ip6_tnl_parse_tlv_enc_lim(skb, skb_network_header(skb));
 		/* ip6_tnl_parse_tlv_enc_lim() might have reallocated skb->head */
-- 
2.17.1



