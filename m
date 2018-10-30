Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC2BC0044C
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:45:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1C2B52082D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 00:45:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="II9Zf+bF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C2B52082D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726679AbeJ3JgO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 05:36:14 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:39768 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725913AbeJ3JgN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 05:36:13 -0400
Received: by mail-pf1-f193.google.com with SMTP id c25-v6so4882157pfe.6
        for <linux-kernel@vger.kernel.org>; Mon, 29 Oct 2018 17:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eNQOUFPI9Y0rNeNqFZdJ5eqGDJZY2UjuI4Vs7v440Lw=;
        b=II9Zf+bFEX4BkUG0PaJ+3fes5T88Gbjqf1FNOyEG4hv3gd7dgaihiQmw7vmh9OMVH1
         +55NV5eNlXdsgiGVuBZTMgyI46JgzlimasCidkbrv4F+FRW035s/rthZKnkS9hkAQLsX
         Z3sPnH3U4JTHLWdjaa1z1ETy9Esi/yGXoW4wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eNQOUFPI9Y0rNeNqFZdJ5eqGDJZY2UjuI4Vs7v440Lw=;
        b=CgXgqCuqhGqrPXhCQAAFwVV1JG0tGrc2nBVNEAXr0NENwx9KE81OZnqtTStRgyJldE
         WXir2zietyv6ioXJIk9IA7UOVRZTA+0cWkqJZiiA6BsKg18Ji6TqalSkpItR6PRWrhEF
         /tt3BKYpBzFl5uoeUR+Ui/Otjinw7n11ARuRXt4DolqtJBosWcWOpqJ3Bdt0pn04sJYt
         8qInVF9tApWsqajYLOYmvoq2uK6br9iE/LC15z6TSYVv7IPW/JsHI+64iR9wpH5n3f0d
         NodQRyCQWnmW7Bs6VWeTmYisiRzUevZpAiBbl/6CVfpVmabyk7ot2TP4znTtePskr9l+
         GiIQ==
X-Gm-Message-State: AGRZ1gLkC5Vf3CPN6LUcOucYgDoHLHkAJsH9u4iTeD6xfSP5Ugk58vpo
        MCT2cnPfDTswjeipiW/VXxjYTQ==
X-Google-Smtp-Source: AJdET5d+06qIMTD/4d71T+Ui3VoTj+qGTN0fBuQ5wTjprYb3GB1WuijGquPM61ddS6826bHhr5wQvQ==
X-Received: by 2002:a62:f715:: with SMTP id h21-v6mr630762pfi.169.1540860300727;
        Mon, 29 Oct 2018 17:45:00 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id y1-v6sm24289644pfy.89.2018.10.29.17.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Oct 2018 17:45:00 -0700 (PDT)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v2 1/3] Bluetooth: Add quirk for reading BD_ADDR from fwnode property
Date:   Mon, 29 Oct 2018 17:44:13 -0700
Message-Id: <20181030004415.237101-2-mka@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181030004415.237101-1-mka@chromium.org>
References: <20181030004415.237101-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add HCI_QUIRK_USE_BDADDR_PROPERTY to allow controllers to retrieve
the public Bluetooth address from the firmware node property
'local-bd-address'. If quirk is set and the property does not exist
or is invalid the controller is marked as unconfigured.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v2:
- added check for return value of ->setup()
- only read BD_ADDR from the property if it isn't assigned yet. This
  is needed to support configuration from user space
- refactored the branch of the new quirk to get rid of 'bd_addr_set'
- added 'Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>' tag
---
 include/net/bluetooth/hci.h | 12 ++++++++++
 net/bluetooth/hci_core.c    | 45 +++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c        |  6 +++--
 3 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c36dc1e20556..fbba43e9bef5 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -158,6 +158,18 @@ enum {
 	 */
 	HCI_QUIRK_INVALID_BDADDR,
 
+	/* When this quirk is set, the public Bluetooth address
+	 * initially reported by HCI Read BD Address command
+	 * is considered invalid. The public BD Address can be
+	 * specified in the fwnode property 'local-bd-address'.
+	 * If this property does not exist or is invalid controller
+	 * configuration is required before this device can be used.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_USE_BDADDR_PROPERTY,
+
 	/* When this quirk is set, the duplicate filtering during
 	 * scanning is based on Bluetooth devices addresses. To allow
 	 * RSSI based updates, restart scanning if needed.
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 7352fe85674b..d4149005a661 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -30,6 +30,7 @@
 #include <linux/rfkill.h>
 #include <linux/debugfs.h>
 #include <linux/crypto.h>
+#include <linux/property.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -1355,6 +1356,36 @@ int hci_inquiry(void __user *arg)
 	return err;
 }
 
+/**
+ * hci_dev_get_bd_addr_from_property - Get the Bluetooth Device Address
+ *				       (BD_ADDR) for a HCI device from
+ *				       a firmware node property.
+ * @hdev:	The HCI device
+ *
+ * Search the firmware node for 'local-bd-address'.
+ *
+ * All-zero BD addresses are rejected, because those could be properties
+ * that exist in the firmware tables, but were not updated by the firmware. For
+ * example, the DTS could define 'local-bd-address', with zero BD addresses.
+ */
+static int hci_dev_get_bd_addr_from_property(struct hci_dev *hdev)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(hdev->dev.parent);
+	bdaddr_t ba;
+	int ret;
+
+	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
+					    (u8 *)&ba, sizeof(ba));
+	if (ret < 0)
+		return ret;
+	if (!bacmp(&ba, BDADDR_ANY))
+		return -ENODATA;
+
+	hdev->public_addr = ba;
+
+	return 0;
+}
+
 static int hci_dev_do_open(struct hci_dev *hdev)
 {
 	int ret = 0;
@@ -1422,6 +1453,20 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		if (hdev->setup)
 			ret = hdev->setup(hdev);
 
+		if (ret)
+			goto setup_failed;
+
+		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
+			if (!bacmp(&hdev->public_addr, BDADDR_ANY))
+				hci_dev_get_bd_addr_from_property(hdev);
+
+			if (!bacmp(&hdev->public_addr, BDADDR_ANY) ||
+			    !hdev->set_bdaddr ||
+			    hdev->set_bdaddr(hdev, &hdev->public_addr))
+				hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
+		}
+
+setup_failed:
 		/* The transport driver can set these quirks before
 		 * creating the HCI device or in its setup callback.
 		 *
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ccce954f8146..fae84353d030 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -551,7 +551,8 @@ static bool is_configured(struct hci_dev *hdev)
 	    !hci_dev_test_flag(hdev, HCI_EXT_CONFIGURED))
 		return false;
 
-	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
+	if ((test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) ||
+	     test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) &&
 	    !bacmp(&hdev->public_addr, BDADDR_ANY))
 		return false;
 
@@ -566,7 +567,8 @@ static __le32 get_missing_options(struct hci_dev *hdev)
 	    !hci_dev_test_flag(hdev, HCI_EXT_CONFIGURED))
 		options |= MGMT_OPTION_EXTERNAL_CONFIG;
 
-	if (test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) &&
+	if ((test_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks) ||
+	     test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) &&
 	    !bacmp(&hdev->public_addr, BDADDR_ANY))
 		options |= MGMT_OPTION_PUBLIC_ADDRESS;
 
-- 
2.19.1.568.g152ad8e336-goog

