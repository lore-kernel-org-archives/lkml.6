Return-Path: <SRS0=cuzA=KE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB6CECDFB8
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 970A320673
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Jul 2018 18:07:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 970A320673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388305AbeGTS5I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Jul 2018 14:57:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34754 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388097AbeGTS5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jul 2018 14:57:08 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fgZoa-0007d9-O6; Fri, 20 Jul 2018 18:07:40 +0000
From:   Colin King <colin.king@canonical.com>
To:     Kalle Valo <kvalo@codeaurora.org>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ray_cs: remove redundant pointer 'p'
Date:   Fri, 20 Jul 2018 19:07:40 +0100
Message-Id: <20180720180740.21018-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Pointer 'p' is being assigned but is never used hence it is
redundant and can be removed. Also re-work if statement to remove
redundant assignment of p.

Cleans up clang warning:
warning: variable 'p' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/wireless/ray_cs.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ray_cs.c b/drivers/net/wireless/ray_cs.c
index a7e0a17aa7e8..08c607c031bc 100644
--- a/drivers/net/wireless/ray_cs.c
+++ b/drivers/net/wireless/ray_cs.c
@@ -470,7 +470,6 @@ static inline struct rcs __iomem *rcs_base(ray_dev_t *dev)
 static int ray_init(struct net_device *dev)
 {
 	int i;
-	UCHAR *p;
 	struct ccs __iomem *pccs;
 	ray_dev_t *local = netdev_priv(dev);
 	struct pcmcia_device *link = local->finder;
@@ -513,12 +512,9 @@ static int ray_init(struct net_device *dev)
 	init_startup_params(local);
 
 	/* copy mac address to startup parameters */
-	if (parse_addr(phy_addr, local->sparm.b4.a_mac_addr)) {
-		p = local->sparm.b4.a_mac_addr;
-	} else {
+	if (!parse_addr(phy_addr, local->sparm.b4.a_mac_addr)) {
 		memcpy(&local->sparm.b4.a_mac_addr,
 		       &local->startup_res.station_addr, ADDRLEN);
-		p = local->sparm.b4.a_mac_addr;
 	}
 
 	clear_interrupt(local);	/* Clear any interrupt from the card */
-- 
2.17.1

