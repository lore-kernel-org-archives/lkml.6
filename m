Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DC6C43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ECF7C2089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546867003;
	bh=nMuzbzMe/17TEeFCXRc/9oNbvVHa7eDdHRIB9ar5BYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=SSIWvlv2kbdAbcjWtjhO5Y01pb6gHJYaOLE2BYxflqArYXG7u7Gcub9F05mKWNWQE
	 2bb5X6E6mnP/4+FFY4WA9bxtKHt13JsMBxZDAeibCmZx/b1ooNJlyBM8WWHaWUJlp9
	 dfuc5Bj/e+GbBi4R3tlnccUwIC4ya2jW5+RuYdDc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730215AbfAGNAi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:00:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:48070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729992AbfAGNAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:00:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55CE62089F;
        Mon,  7 Jan 2019 13:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866033;
        bh=nMuzbzMe/17TEeFCXRc/9oNbvVHa7eDdHRIB9ar5BYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B1Wgp2wEx/m6Cr94YZz2fE2MPyIMy+1YRrqHXXd9gglye2fzQ/ZpE/fYMfuzin1r3
         0wN8JMK5HiUPsoGEZAVUCLzqBttubf2X15UWKRHldczqYWfwkIQuuHTbonRnTQtA3M
         qpEZgIBPpmvPqy1+0PJfOENTYW86BDeMj7taAsFs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ying Xue <ying.xue@windriver.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        syzbot+eae585ba2cc2752d3704@syzkaller.appspotmail.com
Subject: [PATCH 4.14 023/101] tipc: fix a double kfree_skb()
Date:   Mon,  7 Jan 2019 13:32:11 +0100
Message-Id: <20190107105334.213273968@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190107105330.372621917@linuxfoundation.org>
References: <20190107105330.372621917@linuxfoundation.org>
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

4.14-stable review patch.  If anyone has any objections, please let me know.

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


