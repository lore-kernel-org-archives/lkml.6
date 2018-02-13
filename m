Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965860AbeBMUl5 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 15:41:57 -0500
Received: from mail-qk0-f194.google.com ([209.85.220.194]:37361 "EHLO
        mail-qk0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752344AbeBMUl4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 15:41:56 -0500
X-Google-Smtp-Source: AH8x227c6kjLhFTbRv83mDVRx+s7XFfz5blsppj4CbyjHGEciI78fHcTxsGE98YmzyPpeTFz3AbSTw==
From: Markus Mayer <mmayer@broadcom.com>
To: Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>
Cc: Markus Mayer <mmayer@broadcom.com>,
        Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 3/3] memory: brcmstb: dpfe: support new way of passing data from the DCPU
Date: Tue, 13 Feb 2018 12:40:40 -0800
Message-Id: <1518554440-21805-4-git-send-email-mmayer@broadcom.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1518554440-21805-1-git-send-email-mmayer@broadcom.com>
References: <1518554440-21805-1-git-send-email-mmayer@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DCPU can now send message data in two ways:
  - via the data RAM, as before (this is now message type 0)
  - via the message RAM (this is message type 1)

In order to support both methods, we check the message type of the
response (bits 31:28) and then treat the offset (bits 27:0)
accordingly.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 65 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 55 insertions(+), 10 deletions(-)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index 2013a91217a9..e9c1485c32b9 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -45,8 +45,16 @@
 #define REG_TO_DCPU_MBOX	0x10
 #define REG_TO_HOST_MBOX	0x14
 
+/* Macros to process offsets returned by the DCPU */
+#define DRAM_MSG_ADDR_OFFSET	0x0
+#define DRAM_MSG_TYPE_OFFSET	0x1c
+#define DRAM_MSG_ADDR_MASK	((1UL << DRAM_MSG_TYPE_OFFSET) - 1)
+#define DRAM_MSG_TYPE_MASK	((1UL << \
+				 (BITS_PER_LONG - DRAM_MSG_TYPE_OFFSET)) - 1)
+
 /* Message RAM */
-#define DCPU_MSG_RAM(x)		(0x100 + (x) * sizeof(u32))
+#define DCPU_MSG_RAM_START	0x100
+#define DCPU_MSG_RAM(x)		(DCPU_MSG_RAM_START + (x) * sizeof(u32))
 
 /* DRAM Info Offsets & Masks */
 #define DRAM_INFO_INTERVAL	0x0
@@ -255,6 +263,40 @@ static unsigned int get_msg_chksum(const u32 msg[])
 	return sum;
 }
 
+static void __iomem *get_msg_ptr(struct private_data *priv, u32 response,
+				 char *buf, ssize_t *size)
+{
+	unsigned int msg_type;
+	unsigned int offset;
+	void __iomem *ptr = NULL;
+
+	msg_type = (response >> DRAM_MSG_TYPE_OFFSET) & DRAM_MSG_TYPE_MASK;
+	offset = (response >> DRAM_MSG_ADDR_OFFSET) & DRAM_MSG_ADDR_MASK;
+
+	/*
+	 * msg_type == 1: the offset is relative to the message RAM
+	 * msg_type == 0: the offset is relative to the data RAM (this is the
+	 *                previous way of passing data)
+	 * msg_type is anything else: there's critical hardware problem
+	 */
+	switch (msg_type) {
+	case 1:
+		ptr = priv->regs + DCPU_MSG_RAM_START + offset;
+		break;
+	case 0:
+		ptr = priv->dmem + offset;
+		break;
+	default:
+		dev_emerg(priv->dev, "invalid message reply from DCPU: %#x\n",
+			response);
+		if (buf && size)
+			*size = sprintf(buf,
+				"FATAL: communication error with DCPU\n");
+	}
+
+	return ptr;
+}
+
 static int __send_command(struct private_data *priv, unsigned int cmd,
 			  u32 result[])
 {
@@ -528,7 +570,6 @@ static ssize_t show_refresh(struct device *dev,
 	u32 response[MSG_FIELD_MAX];
 	void __iomem *info;
 	struct private_data *priv;
-	unsigned int offset;
 	u8 refresh, sr_abort, ppre, thermal_offs, tuf;
 	u32 mr4;
 	ssize_t ret;
@@ -538,8 +579,10 @@ static ssize_t show_refresh(struct device *dev,
 		return ret;
 
 	priv = dev_get_drvdata(dev);
-	offset = response[MSG_ARG0];
-	info = priv->dmem + offset;
+
+	info = get_msg_ptr(priv, response[MSG_ARG0], buf, &ret);
+	if (!info)
+		return ret;
 
 	mr4 = readl_relaxed(info + DRAM_INFO_MR4) & DRAM_INFO_MR4_MASK;
 
@@ -561,7 +604,6 @@ static ssize_t store_refresh(struct device *dev, struct device_attribute *attr,
 	u32 response[MSG_FIELD_MAX];
 	struct private_data *priv;
 	void __iomem *info;
-	unsigned int offset;
 	unsigned long val;
 	int ret;
 
@@ -574,8 +616,10 @@ static ssize_t store_refresh(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	offset = response[MSG_ARG0];
-	info = priv->dmem + offset;
+	info = get_msg_ptr(priv, response[MSG_ARG0], NULL, NULL);
+	if (!info)
+		return -EIO;
+
 	writel_relaxed(val, info + DRAM_INFO_INTERVAL);
 
 	return count;
@@ -587,16 +631,17 @@ static ssize_t show_vendor(struct device *dev, struct device_attribute *devattr,
 	u32 response[MSG_FIELD_MAX];
 	struct private_data *priv;
 	void __iomem *info;
-	unsigned int offset;
 	ssize_t ret;
 
 	ret = generic_show(DPFE_CMD_GET_VENDOR, response, dev, buf);
 	if (ret)
 		return ret;
 
-	offset = response[MSG_ARG0];
 	priv = dev_get_drvdata(dev);
-	info = priv->dmem + offset;
+
+	info = get_msg_ptr(priv, response[MSG_ARG0], buf, &ret);
+	if (!info)
+		return ret;
 
 	return sprintf(buf, "%#x %#x %#x %#x %#x\n",
 		       readl_relaxed(info + DRAM_VENDOR_MR5) & DRAM_VENDOR_MASK,
-- 
2.7.4
