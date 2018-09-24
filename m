Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC2AECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:35:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B9F42087A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 19:35:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="mVjlVRxb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B9F42087A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbeIYBiv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 21:38:51 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:37994 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728585AbeIYBiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 21:38:50 -0400
Received: by mail-pg1-f195.google.com with SMTP id r77-v6so4535598pgr.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Sep 2018 12:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NXpmg20QuLqWP75jfrLJ+PMzF2QwBQp+cpay/7Q8QBE=;
        b=mVjlVRxb4fA6Wv9uNMsrHDyuzoH2fzGVAHdIhuUAoMxeUeiiojBnzGKEQ4/BtB2IoA
         nJVl1Y9/lVrLpp+8pnknMVLhYeMnR7SMBTaAh2appoL30bknsYLDehjPlE7+0BhNz/tp
         yBs+CRrOTBsrR1tACN3TtRf7/xJCXbAIsfqDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NXpmg20QuLqWP75jfrLJ+PMzF2QwBQp+cpay/7Q8QBE=;
        b=qspCRFjllHFlYYDF1WhI8AsL410k+GjvHRrDbGKtowWPaVNKISp8YihwzwB/evOfFQ
         05w/KLEmxEsBD/ykbQL3RUuXQdMT/rKikJ7gA1ejBMKbYakn5W3bbmtFy7YqHavvp1Gc
         hqj9fPI8q4MdoyFlsE8w+5dK7A1RVbSPrEVNO9fhGiZ7o+ZGF6tfWS75vHYGBGQxax1M
         VMzYWDiDHt8cqCEaN7Q8tdniB2kgzMj9/Buq7hZqgG0blOXMwRo5sQlq1drpHyLanaNy
         qz221xgFcDs5KWy+gxcoqfDhK3LFQTOccSzzfWuoLQx3sb9WlqPKqEab2lkELb1jsD78
         Fq6A==
X-Gm-Message-State: ABuFfogOojua+aMNLfrwh9lg2QDw4tBIIf5239RfmnaOBcNkFzovkR6f
        YPFM2ZBs7RhedtfJY5IhasMLhA==
X-Google-Smtp-Source: ACcGV61FF7BbIiNF145Uxm6UioSwMo5HlBW1alTHhbVpn6fma1GfLQ5Se8784oXge7ZzOL+KIVXEXg==
X-Received: by 2002:a62:fcd8:: with SMTP id e207-v6mr266866pfh.132.1537817704280;
        Mon, 24 Sep 2018 12:35:04 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id 77-v6sm112234pfw.159.2018.09.24.12.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 12:35:03 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Brian Norris <briannorris@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 1/2] device property: Add device_get_bd_address() and fwnode_get_bd_address()
Date:   Mon, 24 Sep 2018 12:33:51 -0700
Message-Id: <20180924193352.96335-2-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <20180924193352.96335-1-mka@chromium.org>
References: <20180924193352.96335-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide an API for Bluetooth drivers to retrieve the Bluetooth Device
address (BD_ADDR) for a device. If the device node has a property
'local-bd-address' the BD address is read from this property.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
Changes in v2:
- use bdaddr_t instead of byte pointer + len
- use EXPORT_SYMBOL_GPL for the new functions instead of EXPORT_SYMBOL
- put new functions inside #if IS_ENABLED(CONFIG_BT)
- some new line juggling in property.h
- added 'Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>' tag
---
 drivers/base/property.c  | 46 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  3 +++
 2 files changed, 49 insertions(+)

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
index ac8a1ebc4c1b..8926cf95d27e 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -15,6 +15,7 @@
 
 #include <linux/fwnode.h>
 #include <linux/types.h>
+#include <net/bluetooth/bluetooth.h>
 
 struct device;
 
@@ -286,10 +287,12 @@ const void *device_get_match_data(struct device *dev);
 int device_get_phy_mode(struct device *dev);
 
 void *device_get_mac_address(struct device *dev, char *addr, int alen);
+int device_get_bd_address(struct device *dev, bdaddr_t *bd_addr);
 
 int fwnode_get_phy_mode(struct fwnode_handle *fwnode);
 void *fwnode_get_mac_address(struct fwnode_handle *fwnode,
 			     char *addr, int alen);
+int fwnode_get_bd_address(struct fwnode_handle *fwnode, bdaddr_t *bd_addr);
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *
-- 
2.19.0.444.g18242da7ef-goog

