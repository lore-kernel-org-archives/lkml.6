Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EC8FC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE8012054F
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:29:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE8012054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726123AbeKAG3Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:29:25 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.135]:29927 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725736AbeKAG3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:29:24 -0400
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx+QKE8uPUyz7H84id4F0yi4r+BiOwjaTFJDezg=="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 44.3 AUTH)
        with ESMTPSA id j097e4u9VLTT3ZI
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 31 Oct 2018 22:29:29 +0100 (CET)
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        stable@vger.kernel.org
Subject: [PATCH] usbnet: smsc95xx: disable carrier check while suspending
Date:   Wed, 31 Oct 2018 22:27:01 +0100
Message-Id: <1541021221-337-1-git-send-email-frieder.schrempf@kontron.de>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We need to make sure, that the carrier check polling is disabled
while suspending. Otherwise we can end up with usbnet_read_cmd()
being issued when only usbnet_read_cmd_nopm() is allowed. If this
happens, read operations lock up.

Fixes: d69d169493 ("usbnet: smsc95xx: fix link detection for disabled autonegotiation")
Cc: <stable@vger.kernel.org>
Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
---
 drivers/net/usb/smsc95xx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 262e7a3..3bc9633 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1592,6 +1592,8 @@ static int smsc95xx_suspend(struct usb_interface *intf, pm_message_t message)
 	u32 val, link_up;
 	int ret;
 
+	cancel_delayed_work_sync(&pdata->carrier_check);
+
 	ret = usbnet_suspend(intf, message);
 	if (ret < 0) {
 		netdev_warn(dev->net, "usbnet_suspend error\n");
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
2.7.4

