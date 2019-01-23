Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1309C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794EB20449
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 16:00:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbfAWQAM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 11:00:12 -0500
Received: from mail.bootlin.com ([62.4.15.54]:42218 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726095AbfAWP7H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 10:59:07 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 04E3E207B6; Wed, 23 Jan 2019 16:59:05 +0100 (CET)
Received: from localhost (aaubervilliers-681-1-87-206.w90-88.abo.wanadoo.fr [90.88.29.206])
        by mail.bootlin.com (Postfix) with ESMTPSA id C8D1E2084E;
        Wed, 23 Jan 2019 16:58:54 +0100 (CET)
From:   Antoine Tenart <antoine.tenart@bootlin.com>
To:     davem@davemloft.net, sd@queasysnail.net, andrew@lunn.ch,
        f.fainelli@gmail.com, hkallweit1@gmail.com
Cc:     Antoine Tenart <antoine.tenart@bootlin.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        thomas.petazzoni@bootlin.com, alexandre.belloni@bootlin.com,
        quentin.schulz@bootlin.com, allan.nielsen@microchip.com
Subject: [PATCH net-next 04/10] net: macsec: introduce the netdev_macsec structure
Date:   Wed, 23 Jan 2019 16:56:32 +0100
Message-Id: <20190123155638.13852-5-antoine.tenart@bootlin.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190123155638.13852-1-antoine.tenart@bootlin.com>
References: <20190123155638.13852-1-antoine.tenart@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces the netdev_macsec structure. It will be used
in the kernel to exchange information between the common MACsec
implementation (macsec.c) and the MACsec hardware offloading
implementations. This structure contains a command (struct
netdev_macsec_command) and pointers to MACsec specific structures which
contain the actual MACsec configuration.

Signed-off-by: Antoine Tenart <antoine.tenart@bootlin.com>
---
 include/net/macsec.h | 45 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/include/net/macsec.h b/include/net/macsec.h
index 15ff331dd670..1e4d37c190ed 100644
--- a/include/net/macsec.h
+++ b/include/net/macsec.h
@@ -175,4 +175,49 @@ struct macsec_secy {
 	struct macsec_rx_sc __rcu *rx_sc;
 };
 
+enum netdev_macsec_command {
+	/* Device wide */
+	MACSEC_DEV_OPEN,
+	MACSEC_DEV_STOP,
+
+	/* SecY */
+	MACSEC_ADD_SECY,
+	MACSEC_UPD_SECY,
+	MACSEC_DEL_SECY,
+
+	/* Security channels */
+	MACSEC_ADD_RXSC,
+	MACSEC_UPD_RXSC,
+	MACSEC_DEL_RXSC,
+
+	/* Security associations */
+	MACSEC_ADD_RXSA,
+	MACSEC_UPD_RXSA,
+	MACSEC_DEL_RXSA,
+	MACSEC_ADD_TXSA,
+	MACSEC_UPD_TXSA,
+	MACSEC_DEL_TXSA,
+};
+
+struct netdev_macsec {
+	enum netdev_macsec_command command;
+	u8 prepare:1;
+
+	union {
+		/* MACSEC_*_SECY */
+		const struct macsec_secy *secy;
+		/* MACSEC_*_RXSC */
+		const struct macsec_rx_sc *rx_sc;
+		/* MACSEC_*_RXSA/TXSA */
+		struct {
+			unsigned char assoc_num;
+			u8 key[MACSEC_KEYID_LEN];
+			union {
+				const struct macsec_rx_sa *rx_sa;
+				const struct macsec_tx_sa *tx_sa;
+			};
+		} sa;
+	};
+};
+
 #endif /* _NET_MACSEC_H_ */
-- 
2.20.1

