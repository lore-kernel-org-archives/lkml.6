Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1E58C04EBD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:23:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FA0720866
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="S7x0Opeh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA0720866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729705AbeJPMDu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:03:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:52448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728408AbeJPMDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:03:50 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 987272147E;
        Tue, 16 Oct 2018 04:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663327;
        bh=Pcr+PGRqcEZUSVhcGj28hKBeG6saDLHRe/GEvtapBSQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=S7x0Opeh5pZ/hi0H00SU7z4PSg/P4amEVzEOadhbWQNRZK/fv+/F6XaLnaKfVObh5
         k8Z9Slsl7ojf/J/pww6/ahDWfP4mrBmSJn8jBaeq/cHjRho/yC37j66BIc3Mo/RnIM
         52egoaSSoVwbmztPtLuooOBPg31vyFebShfb6OVI=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 02/38] xfrm6: call kfree_skb when skb is toobig
Date:   Tue, 16 Oct 2018 00:14:46 -0400
Message-Id: <20181016041522.135789-2-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041522.135789-1-sashal@kernel.org>
References: <20181016041522.135789-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>

[ Upstream commit 215ab0f021c9fea3c18b75e7d522400ee6a49990 ]

After commit d6990976af7c5d8f55903bfb4289b6fb030bf754 ("vti6: fix PMTU caching
and reporting on xmit"), some too big skbs might be potentially passed down to
__xfrm6_output, causing it to fail to transmit but not free the skb, causing a
leak of skb, and consequentially a leak of dst references.

After running pmtu.sh, that shows as failure to unregister devices in a namespace:

[  311.397671] unregister_netdevice: waiting for veth_b to become free. Usage count = 1

The fix is to call kfree_skb in case of transmit failures.

Fixes: dd767856a36e ("xfrm6: Don't call icmpv6_send on local error")
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/xfrm6_output.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv6/xfrm6_output.c b/net/ipv6/xfrm6_output.c
index 4d09ce6fa90e..64862c5084ee 100644
--- a/net/ipv6/xfrm6_output.c
+++ b/net/ipv6/xfrm6_output.c
@@ -165,9 +165,11 @@ static int __xfrm6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 	if (toobig && xfrm6_local_dontfrag(skb)) {
 		xfrm6_local_rxpmtu(skb, mtu);
+		kfree_skb(skb);
 		return -EMSGSIZE;
 	} else if (!skb->ignore_df && toobig && skb->sk) {
 		xfrm_local_error(skb, mtu);
+		kfree_skb(skb);
 		return -EMSGSIZE;
 	}
 
-- 
2.17.1

