Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA44C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:28:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB04420675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 14:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g.ncu.edu.tw header.i=@g.ncu.edu.tw header.b="OUvfMAjw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393520AbfAPO2Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 09:28:25 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:39352 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393490AbfAPO2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 09:28:25 -0500
Received: by mail-pf1-f195.google.com with SMTP id r136so3145393pfc.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jan 2019 06:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g.ncu.edu.tw; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LkwCmAk0ZYfNjDokT65iazGLRf5oA0hVKPOU2YZw5hE=;
        b=OUvfMAjw+gXUX1ovtPr6jxjaZKa+q72zTZgpHNTIpCqwe7XUcjxGiz9RS7azzMaC9L
         3JS3KEnlvndXJl07N/N/UawF8FYI284ArlkDlz2wUrLf8gmDUk+dVUyJlpmZEzWnnL+X
         e4yRWs/1WldCvXte5CCISDo+cLgUdLH+f8Xfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LkwCmAk0ZYfNjDokT65iazGLRf5oA0hVKPOU2YZw5hE=;
        b=ogq172gAQyUO/DfvUE1k9Dj55lWmJIlCfHtYsR2bwvTG0imH+CVd6dGoncGAch7jY2
         ueY8fYjVn21FCiJm98Hc+MqvAYVC9mqlJ20IEP6rEM3/ysB+AEDklmfMT3/qMFuAKb6K
         EKnoSVxc5ZgoxhGQOESr1VKCfikGjAqmJ2fUA7EI3Z6J9UEbBMCstcAjPr6H26rCOGbj
         FaO1LjijpddhrS/fluOz12wYOkdhmKtlpmgtqc+TktZfcyv8+SdOkmPt+Zr3wIBDcr9c
         ie869EdgyW/64h/vZ+8NhfSY9jkpvoq+noxJXiO/sbwKswiAvEtwxhEwS6mEw69bRnfH
         Wj8g==
X-Gm-Message-State: AJcUukfMKdJJqN+9uL0eyLxNCodim6gEDIvYsdy1UBNWv7WxnKBCwzIf
        yxa2T9Zm5YQ4+JSr2ApCB3vLgg==
X-Google-Smtp-Source: ALg8bN7Eh2t2CDGkqmpnX2Fv2TnJOXoWkmEqfsZ1kD4WHzXYK89387Ds7c3wswe2aq2I10jVmVizOg==
X-Received: by 2002:a65:5bc4:: with SMTP id o4mr9187756pgr.426.1547648903805;
        Wed, 16 Jan 2019 06:28:23 -0800 (PST)
Received: from starnight.local ([150.116.255.181])
        by smtp.gmail.com with ESMTPSA id a17sm9211783pgm.26.2019.01.16.06.28.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 06:28:23 -0800 (PST)
From:   Jian-Hong Pan <starnight@g.ncu.edu.tw>
To:     =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc:     Ben Whitten <ben.whitten@lairdtech.com>,
        linux-lpwan@lists.infradead.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jian-Hong Pan <starnight@g.ncu.edu.tw>
Subject: [RFC PATCH 5/5] net: lorawan: Split skb definitions into another header
Date:   Wed, 16 Jan 2019 22:25:04 +0800
Message-Id: <20190116142458.19542-6-starnight@g.ncu.edu.tw>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
References: <20190116142048.19446-1-starnight@g.ncu.edu.tw>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Split LoRaWAN related skb definitions from lora/lorawan_netdev.h into
another header lora/lorawan_skb.h.

Signed-off-by: Jian-Hong Pan <starnight@g.ncu.edu.tw>
---
 include/linux/lora/lorawan_netdev.h | 20 -----------------
 include/linux/lora/lorawan_skb.h    | 33 +++++++++++++++++++++++++++++
 net/lorawan/socket.c                |  1 +
 3 files changed, 34 insertions(+), 20 deletions(-)
 create mode 100644 include/linux/lora/lorawan_skb.h

diff --git a/include/linux/lora/lorawan_netdev.h b/include/linux/lora/lorawan_netdev.h
index a6c94cb96bf4..e515ba1ab508 100644
--- a/include/linux/lora/lorawan_netdev.h
+++ b/include/linux/lora/lorawan_netdev.h
@@ -28,24 +28,4 @@ struct sockaddr_lorawan {
 	struct lrw_addr_in addr_in;
 };
 
-/**
- * lrw_mac_cb - This structure holds the control buffer (cb) of sk_buff
- *
- * @devaddr:	the LoRaWAN device address of this LoRaWAN hardware
- */
-struct lrw_mac_cb {
-	u32 devaddr;
-};
-
-/**
- * lrw_get_mac_cb - Get the LoRaWAN MAC control buffer of the sk_buff
- * @skb:	the exchanging sk_buff
- *
- * Return:	the pointer of LoRaWAN MAC control buffer
- */
-static inline struct lrw_mac_cb *lrw_get_mac_cb(struct sk_buff *skb)
-{
-	return (struct lrw_mac_cb *)skb->cb;
-}
-
 #endif
diff --git a/include/linux/lora/lorawan_skb.h b/include/linux/lora/lorawan_skb.h
new file mode 100644
index 000000000000..ea4f900b37be
--- /dev/null
+++ b/include/linux/lora/lorawan_skb.h
@@ -0,0 +1,33 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later OR BSD-3-Clause */
+/*
+ * LoRaWAN socket buffer related definitions
+ *
+ * Copyright (c) 2018 Jian-Hong Pan <starnight@g.ncu.edu.tw>
+ */
+
+#ifndef __LORAWAN_SKB_H__
+#define __LORAWAN_SKB_H__
+
+#include <linux/skbuff.h>
+
+/**
+ * lrw_mac_cb - This structure holds the control buffer (cb) of sk_buff
+ *
+ * @devaddr:	the LoRaWAN device address of this LoRaWAN hardware
+ */
+struct lrw_mac_cb {
+	u32 devaddr;
+};
+
+/**
+ * lrw_get_mac_cb - Get the LoRaWAN MAC control buffer of the sk_buff
+ * @skb:	the exchanging sk_buff
+ *
+ * Return:	the pointer of LoRaWAN MAC control buffer
+ */
+static inline struct lrw_mac_cb *lrw_get_mac_cb(struct sk_buff *skb)
+{
+	return (struct lrw_mac_cb *)skb->cb;
+}
+
+#endif
diff --git a/net/lorawan/socket.c b/net/lorawan/socket.c
index 7139fab63159..50559ba0c538 100644
--- a/net/lorawan/socket.c
+++ b/net/lorawan/socket.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/list.h>
 #include <linux/lora/lorawan_netdev.h>
+#include <linux/lora/lorawan_skb.h>
 #include <linux/module.h>
 #include <linux/net.h>
 #include <linux/termios.h>		/* For TIOCOUTQ/INQ */
-- 
2.20.1

