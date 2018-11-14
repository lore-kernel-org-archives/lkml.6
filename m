Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24417C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:50:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E465F2086A
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 11:50:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E465F2086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732805AbeKNVxZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 16:53:25 -0500
Received: from imap1.codethink.co.uk ([176.9.8.82]:60562 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728015AbeKNVxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 16:53:24 -0500
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gMtge-000204-FW; Wed, 14 Nov 2018 11:50:24 +0000
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1gMtge-0002XS-6N; Wed, 14 Nov 2018 11:50:24 +0000
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     netdev@vger.kernel.org
Cc:     oneukum@suse.com, davem@davemloft.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, steve.glendinning@shawell.net,
        linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 3/4] usbnet: smsc95xx: fix memcpy for accessing rx-data
Date:   Wed, 14 Nov 2018 11:50:21 +0000
Message-Id: <20181114115022.9584-4-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181114115022.9584-1-ben.dooks@codethink.co.uk>
References: <20181114115022.9584-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the RX code to use get_unaligned_le32() instead of the combo
of memcpy and cpu_to_le32s(&var).

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 drivers/net/usb/smsc95xx.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 50e97a159500..8f7c473f3260 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -618,9 +618,7 @@ static void smsc95xx_status(struct usbnet *dev, struct urb *urb)
 		return;
 	}
 
-	memcpy(&intdata, urb->transfer_buffer, 4);
-	le32_to_cpus(&intdata);
-
+	intdata = get_unaligned_le32(urb->transfer_buffer);
 	netif_dbg(dev, link, dev->net, "intdata: 0x%08X\n", intdata);
 
 	if (intdata & INT_ENP_PHY_INT_)
@@ -1922,8 +1920,7 @@ static int smsc95xx_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		unsigned char *packet;
 		u16 size;
 
-		memcpy(&header, skb->data, sizeof(header));
-		le32_to_cpus(&header);
+		header = get_unaligned_le32(skb->data);
 		skb_pull(skb, 4 + NET_IP_ALIGN);
 		packet = skb->data;
 
-- 
2.19.1

