Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A205ECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:32:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E07A2084E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 06:32:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E07A2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730003AbeGRHIj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 03:08:39 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:54081 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726245AbeGRHIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 03:08:39 -0400
Received: from stefan-Vostro-260.fritz.box ([109.104.32.110]) by
 mrelayeu.kundenserver.de (mreue102 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 0LZvn3-1gKX8A3kGj-00lmcW; Wed, 18 Jul 2018 08:32:20 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     "David S. Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH 2/3] net: qca_spi: Make sure the QCA7000 reset is triggered
Date:   Wed, 18 Jul 2018 08:31:44 +0200
Message-Id: <1531895505-26971-3-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1531895505-26971-1-git-send-email-stefan.wahren@i2se.com>
References: <1531895505-26971-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:7pL8SFbjMtCO7yuXtKQfn6UAFngKV1aJcG+QD0iqhHEFj1Mp8xG
 7/4QubX88LbwEDf5+G7iK9rfGicnWcDKdM8MhBGMHbc7wCvUYNCrWXTy9RRS1VNViLrFpmf
 g4kOtkCiH09zFtkF7uPas6xM18bDDHnQaphDEAP7rdpqH15QHF2tO254Cietb3znxWrBq2g
 rXUmyX0QDMiwVZyo6F3QQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KrCedn1C9Tw=:yVUMHUNW8eN+7WGnOoAo7A
 JALonmfNDfI+aa8ClNFEYXm+gzn2U099Gt9cLv4H30SPFML3Q6vI01in6hulbQV5RlIIYnK8U
 +oqHczkWJ1nSQ2Gj1rD85+VxTTFv4G17ZvncPQWNZNYbMKIfymbGC1ErFjKQqINWIafPxSEs9
 exoBWV6EznIs/sXoldPTAuu2nL6j1y5eIprJ0hQ8DVKkDyGpj/O0HeG5LbS+yw6KPolPm37NF
 otemjviwSwt1v0oEzVlR9QjH/5PfEikBN+1j/0miKt34GMi9mpjcR3HRqrHa70oQIKU1NBwv5
 zFrCHLH/yYCuCsndsDvmBC7RGBX/hPVbPUSn7mdzP08T41JT34eiKw6R95mISR8UOLIsl5dfv
 b3rNIYZfG0DPobawL8hQDtSCwlr1NJupA0u2uF9gTgrLmNo8zPRqZR+p0uJ/kDFgNPuofgjPX
 AWK7AVJbm0FufUMY3UNfT9w4B/BHKJpMm70azEe/KXrH7mACVammSgZNx9QOjBHoc3ORPsF8S
 buWKBPUdRzvUwpwx/GKy3Ot6THohCWDBn+iR2+XefZepxgL02FR68HBL0k/8uL2iOqOylt1Bv
 vNAWW5Q7xqUvO+8ljjf3CuIddtUaiJ8dEgjVsVUZ/Z5MqhSJp7IeM7IcopNm41OzZo1X6CWfN
 BXrTSm3wMlV14Lkya2jErGp7kzcn9xjw2SGOTzVPyKXjvucl3Qv0XRX/fEI9d9aVZzsU=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case the SPI thread is not running, a simple reset of sync
state won't fix the transmit timeout. We also need to wake up the kernel
thread.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Fixes: ed7d42e24eff ("net: qca_spi: fix transmit queue timeout handling")
---
 drivers/net/ethernet/qualcomm/qca_spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/qca_spi.c b/drivers/net/ethernet/qualcomm/qca_spi.c
index 7db149f..7fa815d 100644
--- a/drivers/net/ethernet/qualcomm/qca_spi.c
+++ b/drivers/net/ethernet/qualcomm/qca_spi.c
@@ -760,6 +760,9 @@ qcaspi_netdev_tx_timeout(struct net_device *dev)
 	qca->net_dev->stats.tx_errors++;
 	/* Trigger tx queue flush and QCA7000 reset */
 	qca->sync = QCASPI_SYNC_UNKNOWN;
+
+	if (qca->spi_thread)
+		wake_up_process(qca->spi_thread);
 }
 
 static int
-- 
2.7.4

