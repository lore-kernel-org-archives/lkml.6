Return-Path: <SRS0=71UW=JV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D608AC6778A
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59BDF24170
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Jul 2018 11:05:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59BDF24170
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753808AbeGELF3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Jul 2018 07:05:29 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58959 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753533AbeGELF1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jul 2018 07:05:27 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1fb24k-0004aK-3Q; Thu, 05 Jul 2018 11:05:26 +0000
From:   Colin King <colin.king@canonical.com>
To:     "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][V2] net: ethernet: sun: remove redundant variables adv and lpa and mii_reads
Date:   Thu,  5 Jul 2018 12:05:25 +0100
Message-Id: <20180705110525.27231-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

Variables adv and lpa are being assigned but are never used hence they
are redundant and can be removed.  Also remove the unncessary mii_reads
too.

Cleans up clang warnings:
warning: variable 'lpa' set but not used [-Wunused-but-set-variable]
warning: variable 'adv' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---

V2: remove mii_reads as suggessted by Dan Carpenter and David Miller

---
 drivers/net/ethernet/sun/niu.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/net/ethernet/sun/niu.c b/drivers/net/ethernet/sun/niu.c
index 88c12474a0c3..9319d84bf49f 100644
--- a/drivers/net/ethernet/sun/niu.c
+++ b/drivers/net/ethernet/sun/niu.c
@@ -1225,25 +1225,9 @@ static int link_status_1g_rgmii(struct niu *np, int *link_up_p)
 
 	bmsr = err;
 	if (bmsr & BMSR_LSTATUS) {
-		u16 adv, lpa;
-
-		err = mii_read(np, np->phy_addr, MII_ADVERTISE);
-		if (err < 0)
-			goto out;
-		adv = err;
-
-		err = mii_read(np, np->phy_addr, MII_LPA);
-		if (err < 0)
-			goto out;
-		lpa = err;
-
-		err = mii_read(np, np->phy_addr, MII_ESTATUS);
-		if (err < 0)
-			goto out;
 		link_up = 1;
 		current_speed = SPEED_1000;
 		current_duplex = DUPLEX_FULL;
-
 	}
 	lp->active_speed = current_speed;
 	lp->active_duplex = current_duplex;
-- 
2.17.1

