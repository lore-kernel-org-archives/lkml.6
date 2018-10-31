Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6393DC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B55F62080A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 21:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=as-electronics.de header.i=@as-electronics.de header.b="ELu9BL15"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B55F62080A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kontron.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726242AbeKAGwg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Nov 2018 02:52:36 -0400
Received: from mo4-p05-ob.smtp.rzone.de ([85.215.255.131]:26051 "EHLO
        mo4-p05-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbeKAGwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Nov 2018 02:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1541022759;
        s=strato-dkim-0002; d=as-electronics.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=9Y1RtC7a//bD6nhJAolmd7KfQi0hetRzg8L+qGggbco=;
        b=ELu9BL15qZpLL7uG59LPHLPORzOE5jyZctqRMWsolkM/KYIm5po/eljoaesQvytyYw
        KmsMCzQS0fOVaUBk0PA3G5WuV8MQXE1ph1cLQ4AuJdRRn7nU7uuRGm1GW8Ddo+0r3ykI
        B7c6wD6g60HG20sOzrslo7zEMrt0WSqkg6De7dvnyZwpB/Y/pglAkdj2OSwmZcPUyW5r
        SG52AqcW5s1tpB5kyZV9mQCYAr7bcHjA1IdwJOzBdUKuIhLd+XUliaNvTBC6FleWKlan
        5OPIAbTqM61AOJj70HO9S/JEtqFCSiHbqEHOgP67LwUixwmRmbfhBXCCCAh2YprC+9x9
        N+qQ==
X-RZG-AUTH: ":LX8JdEmkW/4tAFwMkcNJIloh1hrA5u3owhPk7bdT5Fx22AatU+eLaHfutoZdl+X9BETxn4/4+IVqx+QKE8uPUyz7H84id4F0yi4r+BiOwjaTFJDezg=="
X-RZG-CLASS-ID: mo05
Received: from fs-work.fritz.box
        by smtp.strato.de (RZmta 44.3 AUTH)
        with ESMTPSA id j097e4u9VLqb3bC
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (curve secp521r1 with 521 ECDH bits, eq. 15360 bits RSA))
        (Client did not present a certificate);
        Wed, 31 Oct 2018 22:52:37 +0100 (CET)
From:   Frieder Schrempf <frieder.schrempf@kontron.de>
To:     steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com
Cc:     davem@davemloft.net, netdev@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        stable@vger.kernel.org
Subject: [PATCH v2] usbnet: smsc95xx: disable carrier check while suspending
Date:   Wed, 31 Oct 2018 22:52:19 +0100
Message-Id: <1541022739-24678-1-git-send-email-frieder.schrempf@kontron.de>
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
Changes in v2:
 * move cancel_delayed_work_sync() to correct error path

 drivers/net/usb/smsc95xx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 262e7a3..2d17f3b 100644
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
2.7.4

