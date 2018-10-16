Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A05FC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1F1C920866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gyq03Ark"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F1C920866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbeJPMA6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:00:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:47612 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727553AbeJPMA5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:00:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BC66C2098A;
        Tue, 16 Oct 2018 04:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663155;
        bh=mEYU4rbwyEbGyPpbqjY480h/bv8YrxtWz9L/UTI0Ze4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gyq03Ark8wnOB7pU0eY3rRvkRLjLpKfCMf37wgD5pmG+YYfUxkqUs3XqNqBewcSg9
         xDfSt3Bqw7lW7XHFheelwNqNpyQCywoPTaeNFPFWr3F4AXGd72oTHmbUZbkOVCGsHq
         YP9R+H79IcrjxKL1IK1EEej73m9wadmLLckHFLFA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 011/100] xfrm: Fix NULL pointer dereference when skb_dst_force clears the dst_entry.
Date:   Tue, 16 Oct 2018 00:10:52 -0400
Message-Id: <20181016041221.135528-11-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steffen Klassert <steffen.klassert@secunet.com>

[ Upstream commit 9e1437937807b0122e8da1ca8765be2adca9aee6 ]

Since commit 222d7dbd258d ("net: prevent dst uses after free")
skb_dst_force() might clear the dst_entry attached to the skb.
The xfrm code don't expect this to happen, so we crash with
a NULL pointer dereference in this case. Fix it by checking
skb_dst(skb) for NULL after skb_dst_force() and drop the packet
in cast the dst_entry was cleared.

Fixes: 222d7dbd258d ("net: prevent dst uses after free")
Reported-by: Tobias Hommel <netdev-list@genoetigt.de>
Reported-by: Kristian Evensen <kristian.evensen@gmail.com>
Reported-by: Wolfgang Walter <linux@stwm.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_output.c | 4 ++++
 net/xfrm/xfrm_policy.c | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index 89b178a78dc7..36d15a38ce5e 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -101,6 +101,10 @@ static int xfrm_output_one(struct sk_buff *skb, int err)
 		spin_unlock_bh(&x->lock);
 
 		skb_dst_force(skb);
+		if (!skb_dst(skb)) {
+			XFRM_INC_STATS(net, LINUX_MIB_XFRMOUTERROR);
+			goto error_nolock;
+		}
 
 		if (xfrm_offload(skb)) {
 			x->type_offload->encap(x, skb);
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index a94983e03a8b..526e6814ed4b 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2551,6 +2551,10 @@ int __xfrm_route_forward(struct sk_buff *skb, unsigned short family)
 	}
 
 	skb_dst_force(skb);
+	if (!skb_dst(skb)) {
+		XFRM_INC_STATS(net, LINUX_MIB_XFRMFWDHDRERROR);
+		return 0;
+	}
 
 	dst = xfrm_lookup(net, skb_dst(skb), &fl, NULL, XFRM_LOOKUP_QUEUE);
 	if (IS_ERR(dst)) {
-- 
2.17.1

