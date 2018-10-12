Return-Path: <SRS0=REtU=MY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D111C6783C
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 090952087D
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Oct 2018 08:34:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 090952087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=codethink.co.uk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbeJLQGQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Oct 2018 12:06:16 -0400
Received: from imap1.codethink.co.uk ([176.9.8.82]:48205 "EHLO
        imap1.codethink.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727786AbeJLQFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Oct 2018 12:05:33 -0400
Received: from [148.252.241.226] (helo=rainbowdash)
        by imap1.codethink.co.uk with esmtpsa (Exim 4.84_2 #1 (Debian))
        id 1gAstc-0005Tb-Qw; Fri, 12 Oct 2018 09:34:08 +0100
Received: from ben by rainbowdash with local (Exim 4.91)
        (envelope-from <ben@rainbowdash.codethink.co.uk>)
        id 1gAstc-00052h-8A; Fri, 12 Oct 2018 09:34:08 +0100
From:   Ben Dooks <ben.dooks@codethink.co.uk>
To:     netdev@vger.kernel.org
Cc:     oneukum@suse.com, davem@davemloft.net, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kernel@lists.codethink.co.uk,
        Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH 5/8] usbnet: smsc95xx: align tx-buffer to word
Date:   Fri, 12 Oct 2018 09:34:02 +0100
Message-Id: <20181012083405.19246-6-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181012083405.19246-1-ben.dooks@codethink.co.uk>
References: <20181012083405.19246-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The tegra EHCI driver requires alignment of the buffer, so try and
make this better by pushing the buffer start back to an word
aligned address. At the worst this makes memcpy() easier as
it is word aligned, at best it makes sure the usb can directly
map the buffer.

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
Changes since v1:
- Removed the module parameter
- Reworked the tx code to ensure retry if alignment changed
- Explicitly mention the EHCI in the tegra
- Deal with new simpler tx code
---
 drivers/net/usb/Kconfig    | 12 ++++++++++++
 drivers/net/usb/smsc95xx.c | 22 +++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index c3ebc43a6582..1af6fb0cadb1 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -364,6 +364,18 @@ config USB_NET_SMSC95XX_TURBO
 	  soft-irq load, thus making it useful to default the option
 	  off for these.
 
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
index 19e71fe15f6c..8ce190da8be0 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -2017,28 +2017,43 @@ static bool smsc95xx_can_tx_checksum(struct sk_buff *skb)
        return skb->csum_offset < (len - (4 + 1));
 }
 
+static inline u32 tx_align(struct sk_buff *skb)
+{
+#ifdef CONFIG_USB_NET_SMSC95XX_TXALIGN
+	return ((u32)skb->data) & 3;
+#else
+	return 0;
+#endif
+}
+
 static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 					 struct sk_buff *skb, gfp_t flags)
 {
 	bool csum = skb->ip_summed == CHECKSUM_PARTIAL;
 	int overhead = csum ? SMSC95XX_TX_OVERHEAD_CSUM : SMSC95XX_TX_OVERHEAD;
 	u32 tx_cmd_a, tx_cmd_b;
+	u32 align;
 	void *ptr;
 
 	/* We do not advertise SG, so skbs should be already linearized */
 	BUG_ON(skb_shinfo(skb)->nr_frags);
 
+retry_align:
+	align = tx_align(skb);
+
 	/* Make writable and expand header space by overhead if required */
-	if (skb_cow_head(skb, overhead)) {
+	if (skb_cow_head(skb, overhead + align)) {
 		/* Must deallocate here as returning NULL to indicate error
 		 * means the skb won't be deallocated in the caller.
 		 */
 		dev_kfree_skb_any(skb);
 		return NULL;
-	}
+	} else if (tx_align(skb) != align)
+		goto retry_align;
 
 	tx_cmd_b = (u32)skb->len;
 	tx_cmd_a = tx_cmd_b | TX_CMD_A_FIRST_SEG_ | TX_CMD_A_LAST_SEG_;
+	tx_cmd_a |= align << 16;
 
 	if (csum) {
 		if (!smsc95xx_can_tx_checksum(skb)) {
@@ -2062,7 +2077,8 @@ static struct sk_buff *smsc95xx_tx_fixup(struct usbnet *dev,
 		}
 	}
 
-	ptr = skb_push(skb, 8);
+	/* TX command format is in section 5.4 of SMSC95XX datasbook */
+	ptr = skb_push(skb, 8 + align);
 	put_unaligned_le32(tx_cmd_a, ptr);
 	put_unaligned_le32(tx_cmd_b, ptr+4);
 
-- 
2.19.1

