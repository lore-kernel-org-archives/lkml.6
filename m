Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83022C04EB8
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4025F2082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 14:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="OQwdjQgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4025F2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbeLDOPl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 09:15:41 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34280 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbeLDOPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 09:15:37 -0500
Received: by mail-pg1-f196.google.com with SMTP id 17so7448509pgg.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 06:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1qTK7eo+F9woQYTaQMAKzg3EGdvHcywuYbLGRNZvzTY=;
        b=OQwdjQgVRBJwEyLrdYBj7mq8dYG/M6M/mznos1R0E01NL+Xjc5RwH+RHaIRpTC/j7d
         bKOR5AqgGy1llutSnc9qMySvd5wmNg81/BLLJ6TL3cH7UgZWmR6UEVKOfDmTwb/mJ5Ir
         iwn2jsBny66PzLYwIcraxCanEHUgO/WwH+aWw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1qTK7eo+F9woQYTaQMAKzg3EGdvHcywuYbLGRNZvzTY=;
        b=SGWkFpSiL7/P0XZapOziBdLIoP8abQUIa8LhMJ9DP9bw+VW4NrfuRyts/U+MfCH+wd
         1RBsQtnCtWBLPVQb2T5cJ9KqUB0G9IIEXWj8KvJw1OThxPiupP1UfEazW9GQTem84i19
         xTlh0TS4fk/W8jBqiJ6AexN9SrILAEnaI/qYwCPuY2LGKI64KbLMjYkFmU5Pzb8rKFSt
         /arP/u88w6amafZso5cLU2271DHZmCs5qudRBDVNZ/Wlk7VuKC9RmCUvMMPJQ3Rsf2mf
         jzCdb0ZUurCaislOvnpGnCmJ3hjzt3IQRdV99G9DJhzCbvyELwKJCxm414L1dRBXQv3Y
         nqdg==
X-Gm-Message-State: AA+aEWbO2zz6OtncbXBi53UVSB7eD9UJCxBe/CRJ3EOpVRsoknZW0w3U
        UUOn49W7xn9rxOW/L2s7Dv+/TA==
X-Google-Smtp-Source: AFSGD/XlTbkn1QZMkiZAg874zWUdUjjC7oNVYKUmbviUyg/u4n2/Cftx4+30ueC3nTYDnESVPqghSg==
X-Received: by 2002:a63:6ac5:: with SMTP id f188mr17018931pgc.165.1543932936468;
        Tue, 04 Dec 2018 06:15:36 -0800 (PST)
Received: from starnight.local ([150.116.248.145])
        by smtp.gmail.com with ESMTPSA id n66sm36975863pfk.19.2018.12.04.06.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 06:15:36 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        "David S . Miller" <davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Marcel Holtmann <marcel@holtmann.org>,
        Dollar Chen <dollar.chen@wtmec.com>,
        Ken Yu <ken.yu@rakwireless.com>, linux-wpan@vger.kernel.org,
        Stefan Schmidt <stefan@datenfreihafen.org>,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [PATCH V4 2/6] net: lorawan: Add LoRaWAN API declaration for LoRa devices
Date:   Tue,  4 Dec 2018 22:13:39 +0800
Message-Id: <20181204141341.4353-3-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
References: <CAC=mGzhs0smXzRxn1k9jDFsaLNAkpCd7rMs--E-SafQVTob7JQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add public LoRaWAN API for compatible LoRa device drivers.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
V2:
- Split the LoRaWAN class module patch in V1 into LoRaWAN socket and
  LoRaWAN Soft MAC modules
- Merge the lrw_operations: set_bw, set_mod, set_sf into set_dr
- Use SPDX license identifiers

V3:
- Remove the unused lrw_random_addr function

V4:
- Fix by coding style report from scripts/checkpatch.pl

 include/linux/lora/lorawan.h | 131 +++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 include/linux/lora/lorawan.h

diff --git a/include/linux/lora/lorawan.h b/include/linux/lora/lorawan.h
new file mode 100644
index 000000000000..201f27521655
--- /dev/null
+++ b/include/linux/lora/lorawan.h
@@ -0,0 +1,131 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
+/*-
+ * LoRaWAN compatible hardware's definitions
+ *
+ * Copyright (c) 2018 Jian-Hong, Pan <starnight@g.ncu.edu.tw>
+ *
+ */
+
+#ifndef __LORAWAN_H__
+#define __LORAWAN_H__
+
+#include <linux/skbuff.h>
+
+/* List the role of the LoRaWAN hardware */
+enum {
+	LRW_GATEWAY,
+	LRW_CLASS_A_NODE,
+	LRW_CLASS_B_NODE,
+	LRW_CLASS_C_NODE,
+};
+
+/* List the RF modes */
+enum {
+	LRW_LORA,
+	LRW_FSK,
+};
+
+/**
+ * lrw_dr - This structure holds the RF related configuration of the data rate.
+ * @bw:
+ *	Bandwidth in Hz
+ *
+ * @sf:
+ *	Spread factor of CSS modulation used by LoRa mode
+ *
+ * @mode:
+ *	LoRa or FSK mode
+ */
+struct lrw_dr {
+	u32 bw;
+	u8 sf;
+	u8 mode;
+};
+
+#define	LRW_DEVADDR_LEN		(sizeof(__le32))
+
+/* List the LoRa device's states of LoRaWAN hardware */
+enum {
+	LRW_STOP,
+	LRW_START,
+	LRW_STATE_IDLE,
+	LRW_STATE_TX,
+	LRW_STATE_RX,
+};
+
+/**
+ * lrw_hw - This structure holds the LoRa device of LoRaWAN hardware.
+ * @priv:
+ *	points to the private data of the LoRa device
+ */
+struct lrw_hw {
+	void *priv;
+};
+
+/**
+ * lrw_operations - Lists the LoRaWAN device/interface's operations.
+ * These are callback functions for the LoRaWAN module.  Compatible LoRa device
+ * driver should implement some of them according to the usage.  The
+ * unimplemented callback functions must be assigned as NULL.
+ *
+ * @start:
+ *	called when the interface is being up state
+ *
+ * @stop:
+ *	called when the interface is being down state
+ *
+ * @xmit_async:
+ *	called to xmit the data through the interface asynchronously
+ *
+ * @set_txpower:
+ *	called to set xmitting RF power in mBm of the interface
+ *
+ * @set_frq:
+ *	called to set carrier frequency in Hz of the interface
+ *
+ * @set_dr:
+ *	called to set related RF configuration of the LoRaWAN data rate
+ *
+ * @start_rx_window:
+ *	called to ask the LoRa device open a receiving window
+ *
+ * @set_state:
+ *	called to set the LoRa device's working state
+ */
+struct lrw_operations {
+	int (*start)(struct lrw_hw *hw);
+	void (*stop)(struct lrw_hw *hw);
+
+	int (*xmit_async)(struct lrw_hw *hw, struct sk_buff *skb);
+	int (*set_txpower)(struct lrw_hw *hw, s32 pwr);
+	int (*set_frq)(struct lrw_hw *hw, u32 frq);
+	int (*set_dr)(struct lrw_hw *hw, struct lrw_dr *dr);
+	int (*start_rx_window)(struct lrw_hw *hw, u32 delay);
+	int (*set_state)(struct lrw_hw *hw, u8 state);
+};
+
+struct lrw_hw *lrw_alloc_hw(size_t priv_data_len, struct lrw_operations *ops);
+void lrw_free_hw(struct lrw_hw *hw);
+int lrw_register_hw(struct lrw_hw *hw);
+void lrw_unregister_hw(struct lrw_hw *hw);
+void lrw_rx_irqsave(struct lrw_hw *hw, struct sk_buff *skb);
+void lrw_xmit_complete(struct lrw_hw *hw, struct sk_buff *skb);
+
+void lrw_set_deveui(struct lrw_hw *hw, u64 eui);
+u64 lrw_get_deveui(struct lrw_hw *hw);
+void lrw_set_appeui(struct lrw_hw *hw, u64 eui);
+u64 lrw_get_appeui(struct lrw_hw *hw);
+void lrw_set_devaddr(struct lrw_hw *hw, u32 eui);
+u32 lrw_get_devaddr(struct lrw_hw *hw);
+
+enum {
+	LRW_APPKEY,
+	LRW_NWKSKEY,
+	LRW_APPSKEY,
+};
+
+#define	LRW_KEY_LEN		16
+
+int lrw_set_key(struct lrw_hw *hw, u8 type, u8 *key, size_t key_len);
+
+#endif
-- 
2.19.2

