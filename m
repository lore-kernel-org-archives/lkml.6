Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83F7ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:34:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74EF321533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 22:34:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="LjyeqTHb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74EF321533
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727643AbeIUEUk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 00:20:40 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:34911 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbeIUEUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 00:20:39 -0400
Received: by mail-pg1-f196.google.com with SMTP id 205-v6so4141157pgd.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Sep 2018 15:34:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h6v2/vuxEEWTMx6PfDK3VPQ9ZCygHcXsIDeAvC0JqPw=;
        b=LjyeqTHbilK1rGjx6TtVy7XkiG8cIEF8/NxA/Wk5Yj74QLAw3j+eGU6LRcvEeSSXYh
         V59D7NwNQjUL7Ddl8yxt3bP+vgt00HwxH1ROj8V8VrmCd55ZOY0vvTWrJHRSQohaWJCq
         U1QiViIazlKy9BW7E3svNtNYuQtjKPCu9NtmU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h6v2/vuxEEWTMx6PfDK3VPQ9ZCygHcXsIDeAvC0JqPw=;
        b=D6AVaKgPMG1NvJxawoHMgdnraWrTmyRt1h66KzH7WsQR9ZzAPCMLmyuiLpxDp6+hbO
         cwUnDAjFMZD4iSPC46orTw08Pmsg8y+wlrd4CgefcKCggvNMpJ7uVvfECRtYCaAp7jJM
         AP+N0DgU8egVujSFn06j1j2g3LUVwgu4vRpH+cK+0SfbCFx7JFiCwvA3M49huYiuDeJ8
         iLHpxLz/DjyRrzGrKGaBWB/myVet234/xMU8LIhp48rHKaTjhpFPKGgaXzl0iuUPOeC/
         1IskC6AQ5oqBMltZsREmGkVBZWsLeS5CnbjQPkzzessr7cj9e94D5lL3CCPRt9jZybNp
         +bSA==
X-Gm-Message-State: APzg51DPWqUPQJGNQWifXAV7ivoILXBYYhluj4Am+UvHtzhWhNOrudct
        r9X2EvahZLdH95w/RyI6j1BxHA==
X-Google-Smtp-Source: ANB0Vdak4sMDM/JKMPnzYgYT24kFHzMTpxMMoiTsPjW9QKTczQdLoNYR9vpEfgMTWAM9+e9rJ94tGQ==
X-Received: by 2002:a63:a441:: with SMTP id c1-v6mr39082518pgp.182.1537482895038;
        Thu, 20 Sep 2018 15:34:55 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id g11-v6sm31366696pgi.90.2018.09.20.15.34.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Sep 2018 15:34:54 -0700 (PDT)
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
Subject: [PATCH 1/2] device property: Add device_get_bd_address() and fwnode_get_bd_address()
Date:   Thu, 20 Sep 2018 15:34:35 -0700
Message-Id: <20180920223436.202454-2-mka@chromium.org>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
In-Reply-To: <20180920223436.202454-1-mka@chromium.org>
References: <20180920223436.202454-1-mka@chromium.org>
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
---
 drivers/base/property.c  | 49 ++++++++++++++++++++++++++++++++++++++++
 include/linux/property.h |  4 ++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 240ab5230ff6..8fe546b9805a 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -18,6 +18,8 @@
 #include <linux/etherdevice.h>
 #include <linux/phy.h>
 
+#define BD_ADDR_LEN	6
+
 struct property_set {
 	struct device *dev;
 	struct fwnode_handle fwnode;
@@ -1315,6 +1317,53 @@ void *device_get_mac_address(struct device *dev, char *addr, int alen)
 }
 EXPORT_SYMBOL(device_get_mac_address);
 
+/**
+ * fwnode_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) from the
+ *                         firmware node
+ * @fwnode:	Pointer to the firmware node
+ * @addr:	Address of buffer to store the BD address in
+ * @alen:	Length of the buffer pointed to by addr, should be BD_ADDR_LEN
+ *
+ * Search the firmware node for 'local-bd-address'.
+ *
+ * All-zero BD addresses are rejected, because those could be properties
+ * that exist in the firmware tables, but were not updated by the firmware. For
+ * example, the DTS could define 'local-bd-address', with zero BD addresses.
+ */
+int fwnode_get_bd_address(struct fwnode_handle *fwnode, u8 *addr, int alen)
+{
+	u8 buf[BD_ADDR_LEN];
+	int ret;
+
+	if (alen != BD_ADDR_LEN)
+		return -EINVAL;
+
+	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
+					    buf, alen);
+	if (ret < 0)
+		return ret;
+	if (is_zero_ether_addr(buf))
+		return -ENODATA;
+
+	memcpy(addr, buf, BD_ADDR_LEN);
+
+	return 0;
+}
+EXPORT_SYMBOL(fwnode_get_bd_address);
+
+/**
+ * device_get_bd_address - Get the Bluetooth Device Address (BD_ADDR) for a
+ *                         given device
+ * @dev:	Pointer to the device
+ * @addr:	Address of buffer to store the BD address in
+ * @alen:	Length of the buffer pointed to by addr, should be BD_ADDR_LEN
+ */
+int device_get_bd_address(struct device *dev, u8 *addr, int alen)
+{
+	return fwnode_get_bd_address(dev_fwnode(dev), addr, alen);
+}
+EXPORT_SYMBOL(device_get_bd_address);
+
 /**
  * fwnode_irq_get - Get IRQ directly from a fwnode
  * @fwnode:	Pointer to the firmware node
diff --git a/include/linux/property.h b/include/linux/property.h
index ac8a1ebc4c1b..4e2f1b276f4f 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -287,9 +287,13 @@ int device_get_phy_mode(struct device *dev);
 
 void *device_get_mac_address(struct device *dev, char *addr, int alen);
 
+int device_get_bd_address(struct device *dev, u8 *addr, int alen);
+
 int fwnode_get_phy_mode(struct fwnode_handle *fwnode);
 void *fwnode_get_mac_address(struct fwnode_handle *fwnode,
 			     char *addr, int alen);
+int fwnode_get_bd_address(struct fwnode_handle *fwnode,
+			  u8 *addr, int alen);
 struct fwnode_handle *fwnode_graph_get_next_endpoint(
 	const struct fwnode_handle *fwnode, struct fwnode_handle *prev);
 struct fwnode_handle *
-- 
2.19.0.444.g18242da7ef-goog

