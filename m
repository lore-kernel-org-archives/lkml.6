Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51A01C04EB9
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:53:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18134213A2
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 09:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6GfXbc/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18134213A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbeLEJxr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 04:53:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:60418 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727434AbeLEJxo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 04:53:44 -0500
Received: from sasha-vm.mshome.net (unknown [213.57.143.11])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 72C1D20850;
        Wed,  5 Dec 2018 09:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544003624;
        bh=UCDdO9h1KohGhNAwllgyllIgKtP+5DElIEwLxowhks0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6GfXbc/kHYIAueSETZLJvtCll9jvYnTYY6VBY/UEmj+x3diRG0ieQtEXWa04JyO+
         fYjWAHkBKZRdKeg5vbGyE6VCvrTpt9D8WwjDb74EqB1jAYGsBcpp9xU44uIt0ByWeT
         JPhvncmGgE8uE4PiZlZYyrKMW+kmv3Tf99KetBIM=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Pan Bian <bianpan2016@163.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.4 21/33] rapidio/rionet: do not free skb before reading its length
Date:   Wed,  5 Dec 2018 04:51:19 -0500
Message-Id: <20181205095131.7685-21-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181205095131.7685-1-sashal@kernel.org>
References: <20181205095131.7685-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pan Bian <bianpan2016@163.com>

[ Upstream commit cfc435198f53a6fa1f656d98466b24967ff457d0 ]

skb is freed via dev_kfree_skb_any, however, skb->len is read then. This
may result in a use-after-free bug.

Fixes: e6161d64263 ("rapidio/rionet: rework driver initialization and removal")
Signed-off-by: Pan Bian <bianpan2016@163.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/rionet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/rionet.c b/drivers/net/rionet.c
index e7034c55e796..6ef9188384ce 100644
--- a/drivers/net/rionet.c
+++ b/drivers/net/rionet.c
@@ -215,9 +215,9 @@ static int rionet_start_xmit(struct sk_buff *skb, struct net_device *ndev)
 			 * it just report sending a packet to the target
 			 * (without actual packet transfer).
 			 */
-			dev_kfree_skb_any(skb);
 			ndev->stats.tx_packets++;
 			ndev->stats.tx_bytes += skb->len;
+			dev_kfree_skb_any(skb);
 		}
 	}
 
-- 
2.17.1

