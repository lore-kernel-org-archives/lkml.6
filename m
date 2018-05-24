Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161467AbeEXVjd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 17:39:33 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:44659 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966304AbeEXVjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 17:39:31 -0400
X-Google-Smtp-Source: AB8JxZpStD8SxqKIjJo9hDSGOPJwvrPfrcaC88znUmcl1fK37euDjSmkgmX1maEOT7t3NmTg/AXZzw==
From: Jon Maxwell <jmaxwell37@gmail.com>
To: davem@davemloft.net
Cc: dsahern@gmail.com, mschiffer@universe-factory.net,
        zhangshengju@cmss.chinamobile.com, ktkhai@virtuozzo.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jmaxwell@redhat.com
Subject: [PATCH net-next] ifb: fix packets checksum
Date: Fri, 25 May 2018 07:38:29 +1000
Message-Id: <20180524213829.15208-1-jmaxwell37@gmail.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixup the checksum for CHECKSUM_COMPLETE when pulling skbs on RX path. 
Otherwise we get splats when tc mirred is used to redirect packets to ifb.

Before fix:

nic: hw csum failure

Signed-off-by: Jon Maxwell <jmaxwell37@gmail.com>
---
 drivers/net/ifb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ifb.c b/drivers/net/ifb.c
index 5f2897ec0edc..d345c61d476c 100644
--- a/drivers/net/ifb.c
+++ b/drivers/net/ifb.c
@@ -102,7 +102,7 @@ static void ifb_ri_tasklet(unsigned long _txp)
 		if (!skb->tc_from_ingress) {
 			dev_queue_xmit(skb);
 		} else {
-			skb_pull(skb, skb->mac_len);
+			skb_pull_rcsum(skb, skb->mac_len);
 			netif_receive_skb(skb);
 		}
 	}
-- 
2.13.6
