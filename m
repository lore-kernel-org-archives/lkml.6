Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90F95C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6290B20833
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1EAFkt3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6290B20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbeKCDrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:47:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:41140 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728028AbeKCDrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:47:11 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C4C62082D;
        Fri,  2 Nov 2018 18:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541183940;
        bh=M/0DrshPbypXOxFA7fHC04JY3YNXwEqNJgJd+R7nj8A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1EAFkt3eQMrZTMIHX7gb7sNnalUS8K8wNg3uRuQRkdfG+J7p0ar8E30k4TftKDfo
         n1Yxv5UokQJjbOTrQHKfeM/hhhr6f4wuVaoBU/Sm2zu7MRxVPqyDudrhpVUOwQTckt
         ddFPrEKbREddxdfP+S0lY0aMX0K7wXpyF0OJYAt8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Tobias Hommel <netdev-list@genoetigt.de>,
        Kristian Evensen <kristian.evensen@gmail.com>,
        Wolfgang Walter <linux@stwm.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 011/150] xfrm: Fix NULL pointer dereference when skb_dst_force clears the dst_entry.
Date:   Fri,  2 Nov 2018 19:32:53 +0100
Message-Id: <20181102182903.432633549@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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



