Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9E10C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:03:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B82422419
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 16:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="V2OPREry"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B82422419
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=g.ncu.edu.tw
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387709AbeKOCHO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 21:07:14 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:44815 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387679AbeKOCHO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 21:07:14 -0500
Received: by mail-pl1-f195.google.com with SMTP id s5-v6so7978999plq.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Nov 2018 08:03:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=277RPT5lwNcNZWinXpJrMFYhtW+VvY0zxQBKtONzPUQ=;
        b=V2OPRErysQ57p91Fvn/SO8ZwsgGss/3BTvGz7oo7MwTCrdiknZjUwET60ZLJoUTola
         Tbz0ZA/9+X+O/MlYIVPtddAufUyE4DD+qWVBKj1weEUTwbvMiGNQyoQf7Wk9OPwcD0h4
         6x730O2xuNjbxT7Hc8TYhWEZbEdXwvtwLCK08=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=277RPT5lwNcNZWinXpJrMFYhtW+VvY0zxQBKtONzPUQ=;
        b=k87q6yTMCsi2muAfdZxVwW41tMyz96DUVhI7mJd2oSFMTXvPcAd1n/jKmohdXL2JcR
         P7PlJwePfPSbi1o7PVbnt36crJW438QsU4ZIy5+TJakd2AEJGH8l/Q/4lIhz/wxpkOfX
         z3hYE7WfPrqT2Rg+V/KobfdW+YC/DJv4WXAPGV3W8yZQQHqE7+yfyd5JgcfwVYtFhOAf
         0lgNNzKNC+YuWn/V7U7r58744eIThkv9r7klfrVAXNmmfeGwh7MjM2SFjGwoSxwMr106
         Zeu2diFtZUc3DjT8VVbuxWZ/nA5LRW+RnRJvHciXgf6R8FDoE8bW8cXrCth0iOT9IG7q
         3v9g==
X-Gm-Message-State: AGRZ1gKpfLF8m0kYMKVhqLqYRuK5K979H154QnKfaCklGx7l9Ml4EA95
        KDtg9b4E7WhNM5+oJ2TcRC2QgQ==
X-Google-Smtp-Source: AJdET5fehHAeWRy4GBqVrmAtIXvfv2JslMurWFpk5xiGG+2oXM6Zpy/t3Ls1sR4lFfFeGTRXU5NTmA==
X-Received: by 2002:a17:902:ab83:: with SMTP id f3-v6mr2400993plr.122.1542211404094;
        Wed, 14 Nov 2018 08:03:24 -0800 (PST)
Received: from starnight.local ([150.116.248.145])
        by smtp.gmail.com with ESMTPSA id s2-v6sm53449854pfk.133.2018.11.14.08.03.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 14 Nov 2018 08:03:23 -0800 (PST)
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
Subject: [PATCH V3 3/7] net: lorawan: Add LoRaWAN API declaration for LoRa devices
Date:   Thu, 15 Nov 2018 00:01:24 +0800
Message-Id: <20181114160126.4445-4-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105.101610.1437737564548154497.davem@davemloft.net>
References: <20181105.101610.1437737564548154497.davem@davemloft.net>
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

 include/linux/lora/lorawan.h | 131 +++++++++++++++++++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 include/linux/lora/lorawan.h

diff --git a/include/linux/lora/lorawan.h b/include/linux/lora/lorawan.h
new file mode 100644
index 000000000000..cdeb280b2261
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
+ * 	Bandwidth in Hz
+ *
+ * @sf:
+ * 	Spread factor of CSS modulation used by LoRa mode
+ *
+ * @mode:
+ * 	LoRa or FSK mode
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
+ * 	points to the private data of the LoRa device
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
+	int (*start)(struct lrw_hw *);
+	void (*stop)(struct lrw_hw *);
+
+	int (*xmit_async)(struct lrw_hw *, struct sk_buff *);
+	int (*set_txpower)(struct lrw_hw *, s32);
+	int (*set_frq)(struct lrw_hw *, u32);
+	int (*set_dr)(struct lrw_hw *, struct lrw_dr *);
+	int (*start_rx_window)(struct lrw_hw *, u32);
+	int (*set_state)(struct lrw_hw *, u8);
+};
+
+struct lrw_hw *lrw_alloc_hw(size_t, struct lrw_operations *);
+void lrw_free_hw(struct lrw_hw *);
+int lrw_register_hw(struct lrw_hw *);
+void lrw_unregister_hw(struct lrw_hw *);
+void lrw_rx_irqsave(struct lrw_hw *, struct sk_buff *);
+void lrw_xmit_complete(struct lrw_hw *, struct sk_buff *);
+
+void lrw_set_deveui(struct lrw_hw *, u64);
+u64 lrw_get_deveui(struct lrw_hw *);
+void lrw_set_appeui(struct lrw_hw *, u64);
+u64 lrw_get_appeui(struct lrw_hw *);
+void lrw_set_devaddr(struct lrw_hw *, u32);
+u32 lrw_get_devaddr(struct lrw_hw *);
+
+enum {
+	LRW_APPKEY,
+	LRW_NWKSKEY,
+	LRW_APPSKEY,
+};
+
+#define	LRW_KEY_LEN		16
+
+int lrw_set_key(struct lrw_hw *, u8, u8 *, size_t);
+
+#endif
-- 
2.19.1

