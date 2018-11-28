Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1B2C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:21:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CEF62081C
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 09:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="FWEMTPvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CEF62081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=163.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbeK1UWC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 28 Nov 2018 15:22:02 -0500
Received: from m12-14.163.com ([220.181.12.14]:47214 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727616AbeK1UWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Nov 2018 15:22:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=CbfxdGke0HEMBGu+So
        pRdrIaYtU/j5g7rmGw+u6eV8c=; b=FWEMTPvj27bgJYepzGR7cao/na0jLP8Q+8
        NaQrbg+eWeZoBchJE0gzdHje85sQgXmvYFuN8vnmHwc8LjM5tGJ2UzUMTt7T4Ulv
        62KKMrmfl2+89vVy6JkK1lwIypHmD/aG4ndtNN3AjPB8SKgLi8yjwVRmhtLoAKCj
        UCrLDBRnI=
Received: from bp.localdomain (unknown [106.120.213.96])
        by smtp10 (Coremail) with SMTP id DsCowAD3W8j0Xf5bV1xACQ--.53578S3;
        Wed, 28 Nov 2018 17:20:54 +0800 (CST)
From:   Pan Bian <bianpan2016@163.com>
To:     Jose Abreu <Jose.Abreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Pan Bian <bianpan2016@163.com>
Subject: [PATCH] net: dwc-xlgmac: set skb to NULL after freeing it
Date:   Wed, 28 Nov 2018 17:20:53 +0800
Message-Id: <1543396853-35188-1-git-send-email-bianpan2016@163.com>
X-Mailer: git-send-email 2.7.4
X-CM-TRANSID: DsCowAD3W8j0Xf5bV1xACQ--.53578S3
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cw1DKw1rJF4fWr13Xry5Jwb_yoW8Jw15pa
        yUJ3yUXrn3Jr42qaykXw4rZF15Gan8JFZ5Gr9rCw13X3ZIyr1a9r1qqa4YyFWUCFZ3uaya
        qw4Y9rn7WFn8XFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j1Ap5UUUUU=
X-Originating-IP: [106.120.213.96]
X-CM-SenderInfo: held01tdqsiiqw6rljoofrz/1tbiQAMNclSIYVNlRgAAsx
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buffer skb is freed via dev_kfree_skb in a loop. After freeing skb,
the value of packet_count is updated via packet_count++. If packet_count
happens to equal the upper bound (i.e., budget), the loop will be broken
and skb may be assigned to desc_data->state.skb. Resulting that
desc_data->state.skb may point to a freed memory chunk. To fix this, the
patch sets skb to NULL after dev_kfree_skb(skb).

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/net/ethernet/synopsys/dwc-xlgmac-net.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c b/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c
index 1f8e960..a0d28c4 100644
--- a/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c
+++ b/drivers/net/ethernet/synopsys/dwc-xlgmac-net.c
@@ -1180,6 +1180,7 @@ static int xlgmac_rx_poll(struct xlgmac_channel *channel, int budget)
 				netif_err(pdata, rx_err, netdev,
 					  "error in received packet\n");
 			dev_kfree_skb(skb);
+			skb = NULL;
 			goto next_packet;
 		}
 
@@ -1227,6 +1228,7 @@ static int xlgmac_rx_poll(struct xlgmac_channel *channel, int budget)
 			netif_err(pdata, rx_err, netdev,
 				  "packet length exceeds configured MTU\n");
 			dev_kfree_skb(skb);
+			skb = NULL;
 			goto next_packet;
 		}
 
-- 
2.7.4


