Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78596C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A86A2082E
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQab4DPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A86A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729026AbeKCDrQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:47:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:41212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728545AbeKCDrO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:47:14 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 762032082E;
        Fri,  2 Nov 2018 18:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183943;
        bh=udaYxjfwaR/xRc6Faq+xls7M26bDL1X3OBSCNcPdEnY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WQab4DPZyLYAJYvsABXbF7zWL7RbYIwj84zGRaAGX+T1QWmSibq9xghKxDwZ2mf13
         ewxNj4bS/GDKdMkPmmb9bcSYYVfCMWgbn0bI7oHKr8C58+AoMDh4fejVqysIpvLLaN
         7AqjbyB2ScM0GumgyXNn1zevsRaP6BKplfDBiedA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Sabrina Dubroca <sd@queasysnail.net>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 002/150] xfrm6: call kfree_skb when skb is toobig
Date:   Fri,  2 Nov 2018 19:32:44 +0100
Message-Id: <20181102182902.472465401@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

[ Upstream commit 215ab0f021c9fea3c18b75e7d522400ee6a49990 ]

After commit d6990976af7c5d8f55903bfb4289b6fb030bf754 ("vti6: fix PMTU caching
and reporting on xmit"), some too big skbs might be potentially passed down to
__xfrm6_output, causing it to fail to transmit but not free the skb, causing a
leak of skb, and consequentially a leak of dst references.

After running pmtu.sh, that shows as failure to unregister devices in a namespace:

[  311.397671] unregister_netdevice: waiting for veth_b to become free. Usage count = 1

The fix is to call kfree_skb in case of transmit failures.

Fixes: dd767856a36e ("xfrm6: Don't call icmpv6_send on local error")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/xfrm6_output.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
index 5959ce9620eb..6a74080005cf 100644
--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -170,9 +170,11 @@ static int __xfrm6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	if (toobig && xfrm6_local_dontfrag(skb)) {
 		xfrm6_local_rxpmtu(skb, mtu);
+		kfree_skb(skb);
 		return -EMSGSIZE;
 	} else if (!skb->ignore_df && toobig && skb->sk) {
 		xfrm_local_error(skb, mtu);
+		kfree_skb(skb);
 		return -EMSGSIZE;
 	}
 
-- 
2.17.1



