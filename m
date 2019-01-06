Return-Path: <SRS0=QMhl=PO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E10C43612
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 03:35:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD8321908
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Jan 2019 03:35:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=synology.com header.i=@synology.com header.b="aRG3hRVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbfAFDf3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 5 Jan 2019 22:35:29 -0500
Received: from mail.synology.com ([211.23.38.101]:33937 "EHLO synology.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726070AbfAFDf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Jan 2019 22:35:29 -0500
X-Greylist: delayed 356 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Jan 2019 22:35:28 EST
From:   kchen <kchen@synology.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synology.com; s=123;
        t=1546745366; bh=OqURPaXDX3NaCD71T1pSksMGmTtYDeCPRxX2W8fKqJI=;
        h=From:To:Cc:Subject:Date;
        b=aRG3hRVOAZXTJSQMU8zeX9lZFbXI1ZoZcVlhGEvNCx2Rdsg0D3LHIoTDCazIwRFZL
         jdyccR3nMQJIgp85xQMxqvUahHRV6JIAahng5LDU6JdL8YMMPN2lAZInQwEDt1W9fZ
         w5D0eII+qiKUsGL7N5xIJVN77xwhn6zx2a7LkLCE=
To:     nikolay@cumulusnetworks.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        JianJhen Chen <kchen@synology.com>
Subject: [PATCH 1/1] net: bridge: fix a bug on using a neighbour cache entry without checking its state
Date:   Sun,  6 Jan 2019 11:28:13 +0800
Message-Id: <1546745293-5678-1-git-send-email-kchen@synology.com>
X-Synology-MCP-Status: no
X-Synology-Spam-Flag: no
X-Synology-Spam-Status: score=0, required 6, WHITELIST_FROM_ADDRESS 0
X-Synology-Virus-Status: no
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: JianJhen Chen <kchen@synology.com>

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
---
 net/bridge/br_netfilter_hooks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index b1b5e85..ed683e5 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -278,7 +278,7 @@ int br_nf_pre_routing_finish_bridge(struct net *net, struct sock *sk, struct sk_
 		struct nf_bridge_info *nf_bridge = nf_bridge_info_get(skb);
 		int ret;
 
-		if (neigh->hh.hh_len) {
+		if ((neigh->nud_state & NUD_CONNECTED) && neigh->hh.hh_len) {
 			neigh_hh_bridge(&neigh->hh, skb);
 			skb->dev = nf_bridge->physindev;
 			ret = br_handle_frame_finish(net, sk, skb);
-- 
2.7.4

