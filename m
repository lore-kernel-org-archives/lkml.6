Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3149AC282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:18:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 010FB217D7
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 20:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548361135;
	bh=JWO5hhDLj89orgeepFxkHwIKH+nT19g/nDbJNY7QkYw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=kKDvCeX1rEifCTuVygloe8DHwOm9HI54JUVEly01tWrZBN0XDbPRv/jLLJXPn8z6R
	 BGrE4VDJcWDuH6IjJymu7VGCJWeqnMq97waV0gXvDfGZDZ8Aqm8tgyamceFwfx2j8E
	 fswbZ5vsPiyZHHHKyrITPIl6qMsVmLBQCZuieK6I=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729385AbfAXTWD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:22:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:46514 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729336AbfAXTWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:22:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7EC8B218D2;
        Thu, 24 Jan 2019 19:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548357721;
        bh=JWO5hhDLj89orgeepFxkHwIKH+nT19g/nDbJNY7QkYw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ylwt923KqGQv2Eek/rXU95BR3Q+zJK7WiZpZc48NkzI7CadrWj2cqATaZMtZ+iemt
         deC2ulVQh/cn2iF30eJfDsXQrUk2uM+hTbl/aWewou2uOacnSYR+nwNXb+nvA5TCSQ
         h6A2CvYyma2Id0bQWRJL8SoVQGASxaJygD/m7PVg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, JianJhen Chen <kchen@synology.com>,
        JinLin Chen <jlchen@synology.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 17/52] net: bridge: fix a bug on using a neighbour cache entry without checking its state
Date:   Thu, 24 Jan 2019 20:19:41 +0100
Message-Id: <20190124190143.919451812@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190140.879495253@linuxfoundation.org>
References: <20190124190140.879495253@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
 net/bridge/br_netfilter.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/net/bridge/br_netfilter.c
+++ b/net/bridge/br_netfilter.c
@@ -287,7 +287,7 @@ static int br_nf_pre_routing_finish_brid
 	if (neigh) {
 		int ret;
 
-		if (neigh->hh.hh_len) {
+		if ((neigh->nud_state & NUD_CONNECTED) && neigh->hh.hh_len) {
 			neigh_hh_bridge(&neigh->hh, skb);
 			skb->dev = nf_bridge->physindev;
 			ret = br_handle_frame_finish(skb);


