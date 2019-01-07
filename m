Return-Path: <SRS0=PvM2=PP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A3CC43387
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A44642089F
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Jan 2019 13:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546866460;
	bh=S6z9Hmr8PNVA9OadlFnQbAcYOXeIo6U9pAGffWFPQpI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=YHAFZVyFHNX7Xv1s0rUsUYzKneVJuPmfMRmmEsK88S+JgsPobdlJp/BkDB3WPKLWq
	 ZZJtyPdzxONi+NHgZbSVYTzZX7cOONP+g/2jbL4quuAfCUYJ6W60iw6+aGz527SSHb
	 iNH6sd6P6U8IlYNPaSQ4HhjgiELclEMTR+ZoXH14=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbfAGNHj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Jan 2019 08:07:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:54686 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731131AbfAGNHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jan 2019 08:07:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 975972147C;
        Mon,  7 Jan 2019 13:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546866456;
        bh=S6z9Hmr8PNVA9OadlFnQbAcYOXeIo6U9pAGffWFPQpI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ql+hHYA4e34AvIaW8Cdbe9IKAL/jkGtAR//+yv/ItNaqEpacKUCsnzz4l+WQDGX9n
         uWFChALOzQSh92GfrazENtQMzYvn36p9eG9X2uvn2wJZnbwSw8dhONTIwopUze6A3y
         m38nbgxgiqtFZzrKleArC/XOJIdGu2KXUVNI55bE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>,
        Juergen Gross <jgross@suse.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 22/71] xen/netfront: tolerate frags with no data
Date:   Mon,  7 Jan 2019 13:32:51 +0100
Message-Id: <20190107105334.074271771@linuxfoundation.org>
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

From: Juergen Gross <jgross@suse.com>

[ Upstream commit d81c5054a5d1d4999c7cdead7636b6cd4af83d36 ]

At least old Xen net backends seem to send frags with no real data
sometimes. In case such a fragment happens to occur with the frag limit
already reached the frontend will BUG currently even if this situation
is easily recoverable.

Modify the BUG_ON() condition accordingly.

Tested-by: Dietmar Hahn <dietmar.hahn@ts.fujitsu.com>
Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/xen-netfront.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -903,7 +903,7 @@ static RING_IDX xennet_fill_frags(struct
 		if (skb_shinfo(skb)->nr_frags == MAX_SKB_FRAGS) {
 			unsigned int pull_to = NETFRONT_SKB_CB(skb)->pull_to;
 
-			BUG_ON(pull_to <= skb_headlen(skb));
+			BUG_ON(pull_to < skb_headlen(skb));
 			__pskb_pull_tail(skb, pull_to - skb_headlen(skb));
 		}
 		if (unlikely(skb_shinfo(skb)->nr_frags >= MAX_SKB_FRAGS)) {


