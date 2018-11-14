Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BED8BC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:39:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EDA6223DD
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:39:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="P9VUCyyd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDA6223DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387827AbeKOIod (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:44:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:36012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388055AbeKOI3M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:12 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6265622529;
        Wed, 14 Nov 2018 22:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234248;
        bh=si/mIBL5d3llWewWh6Oh3CSuKQxpprvfTIUatG1mryQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=P9VUCyydfnddGnCN95dZ/6T8zLUcnezro8i84X7kk5drHbGRf1Gmo/t9NaFo3Msdx
         PXbBManmPMvpLzYb2x/lUlaY3ku6ItWNngbuRp6Y+BqZ3TK4itwbSPjCYwPq8x6W1H
         YiP2pu9VfvF4kPLfTYu9b8fiGMC12r8z8I88BU/I=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 11/59] usbnet: smsc95xx: disable carrier check while suspending
Date:   Wed, 14 Nov 2018 17:22:43 -0500
Message-Id: <20181114222335.99339-11-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

[ Upstream commit 7b900ead6cc66b2ee873cb042dfba169aa68b56c ]

We need to make sure, that the carrier check polling is disabled
while suspending. Otherwise we can end up with usbnet_read_cmd()
being issued when only usbnet_read_cmd_nopm() is allowed. If this
happens, read operations lock up.

Fixes: d69d169493 ("usbnet: smsc95xx: fix link detection for disabled autonegotiation")
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Reviewed-by: Raghuram Chary J <RaghuramChary.Jallipalli@microchip.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/usb/smsc95xx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 262e7a3c23cb..2d17f3b9bb16 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1598,6 +1598,8 @@ static int smsc95xx_suspend(struct usb_interface *intf, pm_message_t message)
 		return ret;
 	}
 
+	cancel_delayed_work_sync(&pdata->carrier_check);
+
 	if (pdata->suspend_flags) {
 		netdev_warn(dev->net, "error during last resume\n");
 		pdata->suspend_flags = 0;
@@ -1840,6 +1842,11 @@ static int smsc95xx_suspend(struct usb_interface *intf, pm_message_t message)
 	 */
 	if (ret && PMSG_IS_AUTO(message))
 		usbnet_resume(intf);
+
+	if (ret)
+		schedule_delayed_work(&pdata->carrier_check,
+				      CARRIER_CHECK_DELAY);
+
 	return ret;
 }
 
-- 
2.17.1

