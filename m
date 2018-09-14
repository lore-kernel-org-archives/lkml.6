Return-Path: <SRS0=Jh2l=L4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 949A8FC6182
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:40:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3268320833
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Sep 2018 16:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3268320833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728236AbeINVzO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Sep 2018 17:55:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:36689 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726902AbeINVzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Sep 2018 17:55:14 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <colin.king@canonical.com>)
        id 1g0r8M-0006PN-6l; Fri, 14 Sep 2018 16:39:54 +0000
From:   Colin King <colin.king@canonical.com>
To:     Jaroslav Kysela <perex@perex.cz>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: hp100: fix always-true check for link up state
Date:   Fri, 14 Sep 2018 17:39:53 +0100
Message-Id: <20180914163953.20734-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The operation ~(p100_inb(VG_LAN_CFG_1) & HP100_LINK_UP) returns a value
that is always non-zero and hence the wait for the link to drop always
terminates prematurely.  Fix this by using a logical not operator instead
of a bitwise complement.  This issue has been in the driver since
pre-2.6.12-rc2.

Detected by CoverityScan, CID#114157 ("Logical vs. bitwise operator")

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/net/ethernet/hp/hp100.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/hp/hp100.c b/drivers/net/ethernet/hp/hp100.c
index c8c7ad2eff77..9b5a68b65432 100644
--- a/drivers/net/ethernet/hp/hp100.c
+++ b/drivers/net/ethernet/hp/hp100.c
@@ -2634,7 +2634,7 @@ static int hp100_login_to_vg_hub(struct net_device *dev, u_short force_relogin)
 		/* Wait for link to drop */
 		time = jiffies + (HZ / 10);
 		do {
-			if (~(hp100_inb(VG_LAN_CFG_1) & HP100_LINK_UP_ST))
+			if (!(hp100_inb(VG_LAN_CFG_1) & HP100_LINK_UP_ST))
 				break;
 			if (!in_interrupt())
 				schedule_timeout_interruptible(1);
-- 
2.17.1

