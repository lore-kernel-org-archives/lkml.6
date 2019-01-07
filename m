Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D278FC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:20:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A200721736
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867232;
	bh=AWd6CBtVlDJx8mrqTPH3hyeFGxAwCwHg+0IiYzyIYhk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=h0WfgVucUTf9BH4VJvhKv2ISL653+0eZfATgjViHkm1uNe5sZkAr3jP0TDUJX946s
	 fdKkRzhY8xxFNOkQLyVNcIJAIAuA/WTDZlMmemlGkxvgt08niPicNYhwGxZL8X8Afg
	 e+hq+1KoiO2P+beB+A4y87z0tLK3No2Txq7XQ3L0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730108AbfAGNUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:20:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:37852 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728685AbfAGMre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 07:47:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4A1220651;
        Mon,  7 Jan 2019 12:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546865254;
        bh=AWd6CBtVlDJx8mrqTPH3hyeFGxAwCwHg+0IiYzyIYhk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Tmp57l7WvoY4kxCCxkZ/xUmxSvvWR0InSCTEAM4f7/gEIPNv+4QsuawnrPqgdauD+
         e62GmrilyQ9NbJKNN7X+mMQMy4X0KtcueIAoPENokjnjv0cuAm/SJE0HsgXd4Pr4Ja
         suJhoV9myxFFxTq/X/Yh8kZ+Xavdk8TJra+kWuVU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        syzbot+b981acf1fb240c0c128b@syzkaller.appspotmail.com,
        Ying Xue <ying.xue@windriver.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 035/170] tipc: fix a double free in tipc_enable_bearer()
Date:   Mon,  7 Jan 2019 13:31:02 +0100
Message-Id: <20190107104457.369588513@linuxfoundation.org>
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

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit dc4501ff287547dea7ca10f1c580c741291a8760 ]

bearer_disable() already calls kfree_rcu() to free struct tipc_bearer,
we don't need to call kfree() again.

Fixes: cb30a63384bc ("tipc: refactor function tipc_enable_bearer()")
Reported-by: syzbot+b981acf1fb240c0c128b@syzkaller.appspotmail.com
Cc: Ying Xue <ying.xue@windriver.com>
Cc: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/bearer.c |    1 -
 1 file changed, 1 deletion(-)

--- a/net/tipc/bearer.c
+++ b/net/tipc/bearer.c
@@ -317,7 +317,6 @@ static int tipc_enable_bearer(struct net
 	res = tipc_disc_create(net, b, &b->bcast_addr, &skb);
 	if (res) {
 		bearer_disable(net, b);
-		kfree(b);
 		errstr = "failed to create discoverer";
 		goto rejected;
 	}


