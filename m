Return-Path: <SRS0=lWsm=I7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 3EFC4C004E4
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:04:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E10F220891
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Jun 2018 06:04:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E10F220891
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754531AbeFMGEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Jun 2018 02:04:16 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53806 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754463AbeFMGEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jun 2018 02:04:12 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fSyt9-0005JO-3B; Wed, 13 Jun 2018 06:04:11 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] WAN: LMC: ensure lmc_trace is reporting return from lmc_proto_type
Date:   Wed, 13 Jun 2018 07:04:10 +0100
Message-Id: <20180613060410.735-2-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180613060410.735-1-colin.king@canonical.com>
References: <20180613060410.735-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Currently the lmc tracing is not reporting the return from function
lmc_proto_type and this tracing statement is never executed. Fix
this by returning through the end of the function.  Also fix a typo
in the function name lmc_proto_type in the trace message.

Detected by CoverityScan, CID#710539 ("Structurally dead code")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wan/lmc/lmc_proto.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wan/lmc/lmc_proto.c b/drivers/net/wan/lmc/lmc_proto.c
index 5a6c87bce1bf..b98c1ee860de 100644
--- a/drivers/net/wan/lmc/lmc_proto.c
+++ b/drivers/net/wan/lmc/lmc_proto.c
@@ -99,23 +99,27 @@ void lmc_proto_close(lmc_softc_t *sc)
 
 __be16 lmc_proto_type(lmc_softc_t *sc, struct sk_buff *skb) /*FOLD00*/
 {
+	__be16 ret;
+
 	lmc_trace(sc->lmc_device, "lmc_proto_type in");
 	switch (sc->if_type) {
 	case LMC_PPP:
-		return hdlc_type_trans(skb, sc->lmc_device);
+		ret = hdlc_type_trans(skb, sc->lmc_device);
 		break;
 	case LMC_NET:
-		return htons(ETH_P_802_2);
+		ret = htons(ETH_P_802_2);
 		break;
 	case LMC_RAW: /* Packet type for skbuff kind of useless */
-		return htons(ETH_P_802_2);
+		ret = htons(ETH_P_802_2);
 		break;
 	default:
 		printk(KERN_WARNING "%s: No protocol set for this interface, assuming 802.2 (which is wrong!!)\n", sc->name);
-		return htons(ETH_P_802_2);
+		ret = htons(ETH_P_802_2);
 		break;
 	}
-	lmc_trace(sc->lmc_device, "lmc_proto_tye out");
+	lmc_trace(sc->lmc_device, "lmc_proto_type out");
+
+	return ret;
 }
 
 void lmc_proto_netif(lmc_softc_t *sc, struct sk_buff *skb) /*FOLD00*/
-- 
2.17.0

