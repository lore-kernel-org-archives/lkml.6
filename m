Return-Path: <SRS0=E8pv=NX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A6C0C43441
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DBEEB22507
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Nov 2018 23:46:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBEEB22507
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730330AbeKMJlY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Nov 2018 04:41:24 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59676 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725847AbeKMJlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Nov 2018 04:41:24 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1gMLu1-0006b6-AI; Mon, 12 Nov 2018 23:45:57 +0000
From:   Colin King <colin.king@canonical.com>
To:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][net-next] net: phy: check if advertising is zero using linkmode_empty
Date:   Mon, 12 Nov 2018 23:45:56 +0000
Message-Id: <20181112234556.5291-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

A recent change modified variable advertising from a u32 to a link mode
array and left the u32 zero comparison, so essential we now have an array
being compared to null which is not the intention. Fix this by using the
call to linkmode_empty to check if advertising is all zero.

Detected by CoverityScan, CID#1475424 ("Array compared against 0")

Fixes: 3c1bcc8614db ("net: ethernet: Convert phydev advertize and supported from u32 to link mode")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/phy/phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index d73873334e47..101b83d08864 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -328,7 +328,7 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 	if (autoneg != AUTONEG_ENABLE && autoneg != AUTONEG_DISABLE)
 		return -EINVAL;
 
-	if (autoneg == AUTONEG_ENABLE && advertising == 0)
+	if (autoneg == AUTONEG_ENABLE && linkmode_empty(advertising))
 		return -EINVAL;
 
 	if (autoneg == AUTONEG_DISABLE &&
-- 
2.19.1

