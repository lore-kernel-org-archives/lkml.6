Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47BC5C43143
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:27:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E789420878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:27:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E789420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727474AbeJBQJN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:09:13 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:50408 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727188AbeJBQJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:09:12 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1g7Gx6-0002zc-En; Tue, 02 Oct 2018 10:26:48 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1g7Gx6-0000Jk-6Z; Tue, 02 Oct 2018 10:26:48 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     netdev@vger.kernel.org
Cc:     oneukum@suse.com, davem@davemloft.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 4/4] usbnet: smsc95xx: fix rx packet alignment
Date:   Tue,  2 Oct 2018 10:26:45 +0100
Message-Id: <20181002092645.1115-5-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002092645.1115-1-ben.dooks@codethink.co.uk>
References: <20181002092645.1115-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The smsc95xx driver already takes into account the NET_IP_ALIGN
parameter when setting up the receive packet data, which means
we do not need to worry about aligning the packets in the usbnet
driver.

Adding the EVENT_NO_IP_ALIGN means that the IPv4 header is now
passed to the ip_rcv() routine with the start on an aligned address.

Tested on Raspberry Pi B3.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/usb/smsc95xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 46385a4b8b98..2b867523cd53 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -1296,6 +1296,7 @@ static int smsc95xx_bind(struct usbnet *dev, struct usb_interface *intf)
 		dev->net->features |= NETIF_F_RXCSUM;
 
 	dev->net->hw_features = NETIF_F_IP_CSUM | NETIF_F_RXCSUM;
+	set_bit(EVENT_NO_IP_ALIGN, &dev->flags);
 
 	smsc95xx_init_mac_address(dev);
 
-- 
2.19.0

