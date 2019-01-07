Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2129AC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E533A217D4
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866335;
	bh=J5wwWkYINFrz0MufIa2xUbDPawq4m33S1IZ6J9pTGK8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rUnves40JS3IZ+z65cJyhqpj1EE9U58qF8CrklqmxSl/xYB5wtuTHNtVzAwQWzSYa
	 MOObh4r08TLI5cQ0vP13KWdaRA2XmCHKz9oRShZx1YK+8D78fF55owiHtB97SYajCW
	 WW1tJXjQgWcpKzr9b7xLz9+08YM4aIWGYPndRFTU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731488AbfAGNFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:05:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:53246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727994AbfAGNFc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:05:32 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C318B21736;
        Mon,  7 Jan 2019 13:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866332;
        bh=J5wwWkYINFrz0MufIa2xUbDPawq4m33S1IZ6J9pTGK8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fF7PmDZ3nsU5488Cu+ywc/gaUKMljkEvBD2p7E+REX7YTuT9TfZhGh/+DqI4jE7V2
         gNfyBsU4+TUf8+aOpcPYgIPu/8XhQ3koNbT3K7o7oZK6c99y++GMlYqI1BR+xhafMr
         3NlCoVmEZFGYht4hlwGNDkWVHIxmU+mZxEivPykU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ying Xue <ying.xue@windriver.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+eae585ba2cc2752d3704@syzkaller.appspotmail.com
Subject: [PATCH 4.9 19/71] tipc: fix a double kfree_skb()
Date:   Mon,  7 Jan 2019 13:32:48 +0100
Message-Id: <20190107105333.690200243@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.280153213@linuxfoundation.org>
References: <20190107105330.280153213@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Cong Wang <xiyou.wangcong@gmail.com>

[ Upstream commit acb4a33e9856d5fa3384b87d3d8369229be06d31 ]

tipc_udp_xmit() drops the packet on error, there is no
need to drop it again.

Fixes: ef20cd4dd163 ("tipc: introduce UDP replicast")
Reported-and-tested-by: syzbot+eae585ba2cc2752d3704@syzkaller.appspotmail.com
Cc: Ying Xue <ying.xue@windriver.com>
Cc: Jon Maloy <jon.maloy@ericsson.com>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/tipc/udp_media.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -243,10 +243,8 @@ static int tipc_udp_send_msg(struct net
 		}
 
 		err = tipc_udp_xmit(net, _skb, ub, src, &rcast->addr);
-		if (err) {
-			kfree_skb(_skb);
+		if (err)
 			goto out;
-		}
 	}
 	err = 0;
 out:


