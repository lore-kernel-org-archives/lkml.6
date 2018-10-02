Return-Path: <SRS0=iNRz=MO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682BCC004D2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B40420878
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Oct 2018 09:27:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B40420878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbeJBQJM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Oct 2018 12:09:12 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:50405 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbeJBQJM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Oct 2018 12:09:12 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1g7Gx6-0002za-CP; Tue, 02 Oct 2018 10:26:48 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1g7Gx6-0000Jd-4b; Tue, 02 Oct 2018 10:26:48 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     netdev@vger.kernel.org
Cc:     oneukum@suse.com, davem@davemloft.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 2/4] usbnet: smsc95xx: align tx-buffer to word
Date:   Tue,  2 Oct 2018 10:26:43 +0100
Message-Id: <20181002092645.1115-3-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181002092645.1115-1-ben.dooks@codethink.co.uk>
References: <20181002092645.1115-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tegra driver requires alignment of the buffer, so try and
make this better by pushing the buffer start back to an word
aligned address. At the worst this makes memcpy() easier as
it is word aligned, at best it makes sure the usb can directly
map the buffer.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
[todo - make this configurable]
---
 drivers/net/usb/Kconfig    | 12 ++++++++++++
 drivers/net/usb/smsc95xx.c | 22 ++++++++++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index a32f1a446ce9..35bad8bd2e2a 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -360,6 +360,18 @@ config USB_NET_SMSC95XX_TURBO
 	  driver's receive path. These can also be altered by the
 	  turbo_mode module parameter.
 
+config USB_NET_SMSC95XX_TXALIGN
+	bool "Add bytes to align transmit buffers"
+	depends on USB_NET_SMSC95XX
+	default n
+	help
+	  This option makes the tx buffers 32 bit aligned which might
+	  help with systems that want tx data aligned to a 32 bit
+	  boundary.
+
+	  Using this option will mean there may be up to 3 bytes of
+	  data per packet sent.
+
 config USB_NET_GL620A
 	tristate "GeneSys GL620USB-A based cables"
 	depends on USB_USBNET
diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index fe13bef9579e..d244357bf1ad 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -78,6 +78,10 @@ struct smsc95xx_priv {
 	struct usbnet *dev;
 };
 
+static bool align_tx = IS_ENABLED(CONFIG_USB_NET_SMSC95XX_TXALIGN);
+module_param(align_tx, bool, 0644);
+MODULE_PARM_DESC(align_tx, "Align TX buffers to word boundaries");
+
 static bool turbo_mode = IS_ENABLED(CONFIG_USB_NET_SMSC95XX_TURBO);
 module_param(turbo_mode, bool, 0644);
 MODULE_PARM_DESC(turbo_mode, "Enable multiple frames per Rx transaction");
@@ -2005,10 +2009,18 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 	bool csum = skb->ip_summed == CHECKSUM_PARTIAL;
 	int overhead = csum ? SMSC95XX_TX_OVERHEAD_CSUM : SMSC95XX_TX_OVERHEAD;
 	u32 tx_cmd_a, tx_cmd_b;
+	u32 data_len;
+	uintptr_t align = 0;
 
 	/* We do not advertise SG, so skbs should be already linearized */
 	BUG_ON(skb_shinfo(skb)->nr_frags);
 
+	if (IS_ENABLED(CONFIG_USB_NET_SMSC95XX_TXALIGN) && align_tx) {
+		align = (uintptr_t)skb->data & 3;
+		if (align)
+			overhead += 4 - align;
+	}
+
 	/* Make writable and expand header space by overhead if required */
 	if (skb_cow_head(skb, overhead)) {
 		/* Must deallocate here as returning NULL to indicate error
@@ -2037,16 +2049,22 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 		}
 	}
 
+	data_len = skb->len;
+	if (align)
+		skb_push(skb, 4 - align);
+
 	skb_push(skb, 4);
-	tx_cmd_b = (u32)(skb->len - 4);
+	tx_cmd_b = (u32)(data_len);
 	if (csum)
 		tx_cmd_b |= TX_CMD_B_CSUM_ENABLE;
 	cpu_to_le32s(&tx_cmd_b);
 	memcpy(skb->data, &tx_cmd_b, 4);
 
 	skb_push(skb, 4);
-	tx_cmd_a = (u32)(skb->len - 8) | TX_CMD_A_FIRST_SEG_ |
+	tx_cmd_a = (u32)(data_len) | TX_CMD_A_FIRST_SEG_ |
 		TX_CMD_A_LAST_SEG_;
+	if (align)
+		tx_cmd_a |= (4 - align) << 16;
 	cpu_to_le32s(&tx_cmd_a);
 	memcpy(skb->data, &tx_cmd_a, 4);
 
-- 
2.19.0

