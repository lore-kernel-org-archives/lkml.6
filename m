Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4712C2F3BE
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A10820861
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 13:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548078880;
	bh=fN4TaM6hqFVNK8aphgKCOEdAyCH5xfEWR8EEOOq18GM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xZI88tWMFMPcvKGpqFN3iX7PlQI1qsmt0cLCXgKXOpEaay5ga/L1VXP2KbxGcIoyO
	 WMFMkc9fIaVqKUR0uZUZebPINQRQLtuGd85vkrRfizmCE9OqJ/s0gB9ITloOTJC/k8
	 BUBwabkXkyp6RS/Z7Ss4x41f709Y8f6jHhgtp6kU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbfAUNyi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 08:54:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38794 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731522AbfAUNyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 08:54:35 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 005F420879;
        Mon, 21 Jan 2019 13:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548078874;
        bh=fN4TaM6hqFVNK8aphgKCOEdAyCH5xfEWR8EEOOq18GM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ltjRWlO/b6HTEBmSeN6m1p3cExEfolzvtIRT6Az6pdNoBiMRpbrpZhHj/h9HsxKuz
         eBvAsQZNGauRwNvKHSrGtouDqwZPSK30hb8zNSC/VGj5hxlEjVmuVaX7+23T3BBKl1
         f2SFVZ7vD42CRvD0fzuAZtfP9Jpfh3fUeBiSYykg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, JianJhen Chen <kchen@synology.com>,
        JinLin Chen <jlchen@synology.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.9 14/51] net: bridge: fix a bug on using a neighbour cache entry without checking its state
Date:   Mon, 21 Jan 2019 14:44:10 +0100
Message-Id: <20190121122454.815452105@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190121122453.700446926@linuxfoundation.org>
References: <20190121122453.700446926@linuxfoundation.org>
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

From: JianJhen Chen <kchen@synology.com>

[ Upstream commit 4c84edc11b76590859b1e45dd676074c59602dc4 ]

When handling DNAT'ed packets on a bridge device, the neighbour cache entry
from lookup was used without checking its state. It means that a cache entry
in the NUD_STALE state will be used directly instead of entering the NUD_DELAY
state to confirm the reachability of the neighbor.

This problem becomes worse after commit 2724680bceee ("neigh: Keep neighbour
cache entries if number of them is small enough."), since all neighbour cache
entries in the NUD_STALE state will be kept in the neighbour table as long as
the number of cache entries does not exceed the value specified in gc_thresh1.

This commit validates the state of a neighbour cache entry before using
the entry.

Signed-off-by: JianJhen Chen <kchen@synology.com>
Reviewed-by: JinLin Chen <jlchen@synology.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bridge/br_netfilter_hooks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -275,7 +275,7 @@ int br_nf_pre_routing_finish_bridge(stru
 		struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 		int ret;
 
-		if (neigh->hh.hh_len) {
+		if ((neigh->nud_state & NUD_CONNECTED) && neigh->hh.hh_len) {
 			neigh_hh_bridge(&neigh->hh, skb);
 			skb->dev = nf_bridge->physindev;
 			ret = br_handle_frame_finish(net, sk, skb);


