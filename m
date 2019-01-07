Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE65C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A185120651
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 12:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546865301;
	bh=msEz2+G0MAl9izrXLnGqCI1CfLSaTD8a1Vefw4CMrPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=XABQWPPJmHI6sJtIiUbRFwcsSCFLLdDeNpv8TCTyT1YHHlGvjIe0JWfgcf+c5JV8R
	 O3qZp5Gl7ohVnK70BOzxKS/s5cP4Jxr7O+GAtaugfPWMrXWkxplN2uPhBJRcRtCo1T
	 6Ah7EOYhM07HGY+9Asl671BTyvd46TwozTGDl5I0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729149AbfAGMsU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 07:48:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:38866 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbfAGMsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:48:17 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4E102089F;
        Mon,  7 Jan 2019 12:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865296;
        bh=msEz2+G0MAl9izrXLnGqCI1CfLSaTD8a1Vefw4CMrPc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K3yuCA1yApRUqtRokhBFGDuZPCg6OtalXtKapI7AI06GXjNDdzdoVnKJu2hO/EQk0
         ncAJu2p9KFZeNXOUgmGLIpmb25qhogHKxKvh8Dr0fqi1aZ/nkq6KrGEcfzspbIYL6R
         0RYVz2KtOdx7ZnkIin4iPgb445XSOMaRzG/lwkic=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jianlin Shi <jishi@redhat.com>,
        Stefano Brivio <sbrivio@redhat.com>,
        David Ahern <dsahern@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 047/170] ipv6: route: Fix return value of ip6_neigh_lookup() on neigh_create() error
Date:   Mon,  7 Jan 2019 13:31:14 +0100
Message-Id: <20190107104458.746734842@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107104452.953560660@linuxfoundation.org>
References: <20190107104452.953560660@linuxfoundation.org>
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

From: Stefano Brivio <sbrivio@redhat.com>

[ Upstream commit 7adf3246092f5e87ed0fa610e8088fae416c581f ]

In ip6_neigh_lookup(), we must not return errors coming from
neigh_create(): if creation of a neighbour entry fails, the lookup should
return NULL, in the same way as it's done in __neigh_lookup().

Otherwise, callers legitimately checking for a non-NULL return value of
the lookup function might dereference an invalid pointer.

For instance, on neighbour table overflow, ndisc_router_discovery()
crashes ndisc_update() by passing ERR_PTR(-ENOBUFS) as 'neigh' argument.

Reported-by: Jianlin Shi <jishi@redhat.com>
Fixes: f8a1b43b709d ("net/ipv6: Create a neigh_lookup for FIB entries")
Signed-off-by: Stefano Brivio <sbrivio@redhat.com>
Reviewed-by: David Ahern <dsahern@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/route.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -210,7 +210,9 @@ struct neighbour *ip6_neigh_lookup(const
 	n = __ipv6_neigh_lookup(dev, daddr);
 	if (n)
 		return n;
-	return neigh_create(&nd_tbl, daddr, dev);
+
+	n = neigh_create(&nd_tbl, daddr, dev);
+	return IS_ERR(n) ? NULL : n;
 }
 
 static struct neighbour *ip6_dst_neigh_lookup(const struct dst_entry *dst,


