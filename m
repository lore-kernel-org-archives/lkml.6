Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E597DC04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:27:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B039020869
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3Fku2rz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B039020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729112AbeJPMCi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:02:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:50586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729047AbeJPMCh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:02:37 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D11521471;
        Tue, 16 Oct 2018 04:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663255;
        bh=RMvZ2oHI6IKgAVTha4jgEKdyollZe6nSTQvhl3voPSI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Q3Fku2rzoQ+1/jxlqWLhrHE0ICG4pqjQEJrS1192XvqTOoYYnwpbO/vV5INYrb6FP
         9uxDO8CM02BWlLq/W81TBuxUBaPiDMkifqnrWIOsJeNAyfzFGlCNhLT2vjUVhE5ExZ
         LZqnKFjv66GgyGdSmMH3rZwXGWBN2LYQwHVVIDtE=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.14 11/61] xfrm: Fix NULL pointer dereference when skb_dst_force clears the dst_entry.
Date:   Tue, 16 Oct 2018 00:13:13 -0400
Message-Id: <20181016041403.135678-11-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041403.135678-1-sashal@kernel.org>
References: <20181016041403.135678-1-sashal@kernel.org>
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
index 35610cc881a9..c47660fba498 100644
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
index 2fb7a78308e1..37c32e73aaef 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2550,6 +2550,10 @@ int __xfrm_route_forward(struct sk_buff *skb, unsigned short family)
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

