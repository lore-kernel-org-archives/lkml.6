Return-Path: <SRS0=TXK2=MH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 148A5C43382
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA612086E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Sep 2018 18:54:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hNmO/Ayu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACA612086E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbeIZBDB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Sep 2018 21:03:01 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44403 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727532AbeIZBCz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Sep 2018 21:02:55 -0400
Received: by mail-pg1-f196.google.com with SMTP id g2-v6so4208170pgu.11
        for <linux-kernel@vger.kernel.org>; Tue, 25 Sep 2018 11:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cf7Zkdmui+HZPa+8UHKZIVGjYeRkCegbuVk6pfRbj/E=;
        b=hNmO/Ayu4dz80bXTGt8U1L5e/y2uSmoCkc8L/fK1wK31rhMHt3kWmhE5U4XTDzbjzY
         hy2LYz4UI2uT85/wYeXKYmkN7mSjcTQJg1AvQnj9nVfVzFYnwJjwbPsjn0FdJI8w1ySn
         /1sdSZLQczwmYIwwzS0irRp942LHWAQj45bS8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cf7Zkdmui+HZPa+8UHKZIVGjYeRkCegbuVk6pfRbj/E=;
        b=ShkpGZwoosjY6BuZppanvPoKj2+AXopyOMlBfvik1U1hpmnYxqLDK3Ze0SjJXQvDCK
         Ovb5ltbUMXlXDj/u5boYF4LEoRLRVRq4uDmnawZ5hfH4Uqr5IkpzUBy9mzLUolnbfyXR
         hfzjIxIHqV5wwUmvvBTEDXATZzGBXABNl2utTkElP4lXt2v8UYXC0Ofl5JAJs6IpGP9J
         dDy1Iu5wdxRi8BGivJuQvcwBhiIlfuXJUZEpxxriIwwg9mAOK5mmu4GRN/O55SgPDLm2
         75Gvq2qdr3dSIbi/c7lMrq32+fJUTfjdd31xkIFHpsrij9k8loQVgmh5boDdxpBLFFQk
         nEiw==
X-Gm-Message-State: ABuFfojWAsNYCkRUoU8iDhPgC65zSQdT/Ffs2w/kqugOxw2VWpN8LyEb
        2BEfXECsn5DBqg8Cl2Ncm1MAIQ==
X-Google-Smtp-Source: ACcGV63lXNngEH/+cWZGc/UcpV0w5CCRa/m++8nqpsd3D9BCDeb6QBIssjJK4Ha8uoD4MN0uT/ZL7A==
X-Received: by 2002:a17:902:a716:: with SMTP id w22-v6mr2445587plq.334.1537901640496;
        Tue, 25 Sep 2018 11:54:00 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id p7-v6sm5208971pfb.101.2018.09.25.11.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:53:59 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 2/2] device property: Add device_get_bd_address() and fwnode_get_bd_address()
Date:   Tue, 25 Sep 2018 11:53:39 -0700
Message-Id: <20180925185339.80701-3-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
In-Reply-To: <20180925185339.80701-1-mka@chromium.org>
References: <20180925185339.80701-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an API for Bluetooth drivers to retrieve the Bluetooth Device
address (BD_ADDR) for a device. If the device node has a property
'local-bd-address' the BD address is read from this property.

The definition of bdaddr_t is moved to types.h to make it visible in
property.h without having to include (the mostly unrelated) bluetooth.h

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes in v3:
- move definition of bdaddr_t to types.h to avoid include of
  bluetooth.h from property.h
- add stubs for the new functions

Changes in v2:
- use bdaddr_t instead of byte pointer + len
- use EXPORT_SYMBOL_GPL for the new functions instead of EXPORT_SYMBOL
- put new functions inside #if IS_ENABLED(CONFIG_BT)
- some new line juggling in property.h
- added 'Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>' tag
---
 drivers/base/property.c           | 46 +++++++++++++++++++++++++++++++
 include/linux/property.h          | 18 ++++++++++++
 include/linux/types.h             |  5 ++++
 include/net/bluetooth/bluetooth.h |  5 ----
 4 files changed, 69 insertions(+), 5 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 240ab5230ff6..afe412133188 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -1315,6 +1315,52 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen)
 }
 EXPORT_SYMBOL(device_get_mac_address);
 
+#if IS_ENABLED(CONFIG_BT)
+
+/**
+ * fwnode_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) from the
+ *                         firmware node
+ * @fwnode:	Pointer to the firmware node
+ * @bd_addr:	Pointer to struct to store the BD address in
+ *
+ * Search the firmware node for 'local-bd-address'.
+ *
+ * All-zero BD addresses are rejected, because those could be properties
+ * that exist in the firmware tables, but were not updated by the firmware. For
+ * example, the DTS could define 'local-bd-address', with zero BD addresses.
+ */
+int fwnode_get_bd_address(struct fwnode_handle *fwnode, bdaddr_t *bd_addr)
+{
+	bdaddr_t ba;
+	int ret;
+
+	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
+					    (u8 *)&ba, sizeof(bdaddr_t));
+	if (ret < 0)
+		return ret;
+	if (is_zero_ether_addr((u8 *)&ba))
+		return -ENODATA;
+
+	memcpy(bd_addr, &ba, sizeof(bdaddr_t));
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(fwnode_get_bd_address);
+
+/**
+ * device_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) for a
+ *                         given device
+ * @dev:	Pointer to the device
+ * @bd_addr:	Pointer to struct to store the BD address in
+ */
+int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr)
+{
+	return fwnode_get_bd_address(dev_fwnode(dev), bd_addr);
+}
+EXPORT_SYMBOL_GPL(device_get_bd_address);
+
+#endif
+
 /**
  * fwnode_irq_get - Get IRQ directly from a fwnode
  * @fwnode:	Pointer to the firmware node
diff --git a/include/linux/property.h b/include/linux/property.h
index ac8a1ebc4c1b..5df4e0bd8c83 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -286,10 +286,28 @@ const void *device_get_match_data(struct device *dev);
 int device_get_phy_mode(struct device *dev);
 
 void *device_get_mac_address(struct device *dev, char *addr, int alen);
+#if IS_ENABLED(CONFIG_BT)
+int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr);
+#else
+static inline int device_get_bd_address(struct device *dev,
+					bdaddr_t *bd_addr)
+{
+	return -ENOTSUPP;
+}
+#endif
 
 int fwnode_get_phy_mode(struct fwnode_handle *fwnode);
 void *fwnode_get_mac_address(struct fwnode_handle *fwnode,
 			     char *addr, int alen);
+#if IS_ENABLED(CONFIG_BT)
+int fwnode_get_bd_address(struct fwnode_handle *fwnode, bdaddr_t *bd_addr);
+#else
+static inline int fwnode_get_bd_address(struct fwnode_handle *fwnode,
+					bdaddr_t *bd_addr)
+{
+	return -ENOTSUPP;
+}
+#endif
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *
diff --git a/include/linux/types.h b/include/linux/types.h
index 9834e90aa010..ff6984a00a3b 100644
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -230,5 +230,10 @@ struct callback_head {
 typedef void (*rcu_callback_t)(struct rcu_head *head);
 typedef void (*call_rcu_func_t)(struct rcu_head *head, rcu_callback_t func);
 
+/* Bluetooth Device Address (BD_ADDR) */
+typedef struct {
+	__u8 b[6];
+} __packed bdaddr_t;
+
 #endif /*  __ASSEMBLY__ */
 #endif /* _LINUX_TYPES_H */
diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index ec9d6bc65855..9401c7431a8f 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -190,11 +190,6 @@ static inline const char *state_to_string(int state)
 	return "invalid state";
 }
 
-/* BD Address */
-typedef struct {
-	__u8 b[6];
-} __packed bdaddr_t;
-
 /* BD Address type */
 #define BDADDR_BREDR		0x00
 #define BDADDR_LE_PUBLIC	0x01
-- 
2.19.0.605.g01d371f741-goog

