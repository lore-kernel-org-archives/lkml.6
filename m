Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A65C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:49:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FACC21872
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 05:49:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfAXFtM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 00:49:12 -0500
Received: from out1.zte.com.cn ([202.103.147.172]:50512 "EHLO mxct.zte.com.cn"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725290AbfAXFtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 00:49:12 -0500
Received: from mse01.zte.com.cn (unknown [10.30.3.20])
        by Forcepoint Email with ESMTPS id E824089BF63EEAB668D2;
        Thu, 24 Jan 2019 13:49:07 +0800 (CST)
Received: from notes_smtp.zte.com.cn ([10.30.1.239])
        by mse01.zte.com.cn with ESMTP id x0O5n1F8028796;
        Thu, 24 Jan 2019 13:49:01 +0800 (GMT-8)
        (envelope-from zhang.run@zte.com.cn)
Received: from fox-host8.localdomain ([10.74.120.8])
          by szsmtp06.zte.com.cn (Lotus Domino Release 8.5.3FP6)
          with ESMTP id 2019012413493064-23886391 ;
          Thu, 24 Jan 2019 13:49:30 +0800 
From:   Zhang Run <zhang.run@zte.com.cn>
To:     davem@davemloft.net
Cc:     marcel.ziswiler@toradex.com, lynxis@fe80.eu,
        linux-usb@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn,
        wang.yi59@zte.com.cn, Zhang Run <zhang.run@zte.com.cn>
Subject: [PATCH] net: usb: asix: ax88772_bind return error when hw_reset fail
Date:   Thu, 24 Jan 2019 13:48:49 +0800
Message-Id: <1548308929-7727-1-git-send-email-zhang.run@zte.com.cn>
X-Mailer: git-send-email 1.8.3.1
X-MIMETrack: Itemize by SMTP Server on SZSMTP06/server/zte_ltd(Release 8.5.3FP6|November
 21, 2013) at 2019-01-24 13:49:30,
        Serialize by Router on notes_smtp/zte_ltd(Release 9.0.1FP7|August  17, 2016) at
 2019-01-24 13:48:50,
        Serialize complete at 2019-01-24 13:48:50
X-MAIL: mse01.zte.com.cn x0O5n1F8028796
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ax88772_bind() should return error code immediately when the PHY
was not reset properly through ax88772a_hw_reset().
Otherwise, The asix_get_phyid() will block when get the PHY 
Identifier from the PHYSID1 MII registers through asix_mdio_read() 
due to the PHY isn't ready. Furthermore, it will produce a lot of 
error message cause system crash.As follows:
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to write
 reg index 0x0000: -71
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to send
 software reset: ffffffb9
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to write
 reg index 0x0000: -71
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to enable
 software MII access
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to read
 reg index 0x0000: -71
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to write
 reg index 0x0000: -71
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to enable
 software MII access
asix 1-1:1.0 (unnamed net_device) (uninitialized): Failed to read
 reg index 0x0000: -71
... 

Signed-off-by: Zhang Run <zhang.run@zte.com.cn>
Reviewed-by: Yang Wei <yang.wei9@zte.com.cn>
---
 drivers/net/usb/asix_devices.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/asix_devices.c b/drivers/net/usb/asix_devices.c
index b654f05..3d93993 100644
--- a/drivers/net/usb/asix_devices.c
+++ b/drivers/net/usb/asix_devices.c
@@ -739,8 +739,13 @@ static int ax88772_bind(struct usbnet *dev, struct usb_interface *intf)
 	asix_read_cmd(dev, AX_CMD_STATMNGSTS_REG, 0, 0, 1, &chipcode, 0);
 	chipcode &= AX_CHIPCODE_MASK;
 
-	(chipcode == AX_AX88772_CHIPCODE) ? ax88772_hw_reset(dev, 0) :
-					    ax88772a_hw_reset(dev, 0);
+	ret = (chipcode == AX_AX88772_CHIPCODE) ? ax88772_hw_reset(dev, 0) :
+						  ax88772a_hw_reset(dev, 0);
+
+	if (ret < 0) {
+		netdev_dbg(dev->net, "Failed to reset AX88772: %d\n", ret);
+		return ret;
+	}
 
 	/* Read PHYID register *AFTER* the PHY was reset properly */
 	phyid = asix_get_phyid(dev);
-- 
2.7.4

