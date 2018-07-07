Return-Path: <SRS0=3LFY=JX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB9DC6778A
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 09:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53F4A21A6F
	for <linux-kernel@archiver.kernel.org>; Sat,  7 Jul 2018 09:30:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53F4A21A6F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mediatek.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753605AbeGGJaS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 7 Jul 2018 05:30:18 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:8603 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751964AbeGGJaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jul 2018 05:30:15 -0400
X-UUID: 0f6443ad69ed4103b5c3f84fedec6092-20180707
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jun.gao@mediatek.com>)
        (mhqrelay.mediatek.com ESMTP with TLS)
        with ESMTP id 2078717432; Sat, 07 Jul 2018 17:30:07 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs03n1.mediatek.inc (172.21.101.181) with Microsoft SMTP Server (TLS) id
 15.0.1210.3; Sat, 7 Jul 2018 17:30:06 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1210.3 via Frontend
 Transport; Sat, 7 Jul 2018 17:30:05 +0800
From:   Jun Gao <jun.gao@mediatek.com>
To:     Wolfram Sang <wsa@the-dreams.de>
CC:     <srv_heupstream@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-i2c@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Jun Gao <jun.gao@mediatek.com>
Subject: [PATCH v2 2/3] i2c: Add helper to ease DMA handling
Date:   Sat, 7 Jul 2018 17:29:54 +0800
Message-ID: <1530955795-17714-3-git-send-email-jun.gao@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
References: <1530955795-17714-1-git-send-email-jun.gao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jun Gao <jun.gao@mediatek.com>

This function is needed by i2c_get_dma_safe_msg_buf() potentially.
It is used to free DMA safe buffer when DMA operation fails.

Signed-off-by: Jun Gao <jun.gao@mediatek.com>
---
 drivers/i2c/i2c-core-base.c | 14 ++++++++++++++
 include/linux/i2c.h         |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/i2c/i2c-core-base.c b/drivers/i2c/i2c-core-base.c
index 31d16ad..2b518ea 100644
--- a/drivers/i2c/i2c-core-base.c
+++ b/drivers/i2c/i2c-core-base.c
@@ -2288,6 +2288,20 @@ void i2c_release_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf)
 }
 EXPORT_SYMBOL_GPL(i2c_release_dma_safe_msg_buf);
 
+/**
+ * i2c_free_dma_safe_msg_buf - free DMA safe buffer
+ * @msg: the message related to DMA safe buffer
+ * @buf: the buffer obtained from i2c_get_dma_safe_msg_buf(). May be NULL.
+ */
+void i2c_free_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf)
+{
+	if (!buf || buf == msg->buf)
+		return;
+
+	kfree(buf);
+}
+EXPORT_SYMBOL_GPL(i2c_free_dma_safe_msg_buf);
+
 MODULE_AUTHOR("Simon G. Vogl <simon@tk.uni-linz.ac.at>");
 MODULE_DESCRIPTION("I2C-Bus main module");
 MODULE_LICENSE("GPL");
diff --git a/include/linux/i2c.h b/include/linux/i2c.h
index 254cd34..6d62f93 100644
--- a/include/linux/i2c.h
+++ b/include/linux/i2c.h
@@ -860,6 +860,7 @@ static inline u8 i2c_8bit_addr_from_msg(const struct i2c_msg *msg)
 
 u8 *i2c_get_dma_safe_msg_buf(struct i2c_msg *msg, unsigned int threshold);
 void i2c_release_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf);
+void i2c_free_dma_safe_msg_buf(struct i2c_msg *msg, u8 *buf);
 
 int i2c_handle_smbus_host_notify(struct i2c_adapter *adap, unsigned short addr);
 /**
-- 
1.8.1.1

