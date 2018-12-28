Return-Path: <SRS0=Tl5R=PF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 361E2C43612
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:06:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 06E6F217F9
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Dec 2018 22:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbeL1WGK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Dec 2018 17:06:10 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41863 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726860AbeL1WGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Dec 2018 17:06:06 -0500
Received: by mail-pg1-f194.google.com with SMTP id m1so10518414pgq.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Dec 2018 14:06:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MPn8ZJ0vQgjmAQUwHF3FQDxNaCYZPeenRRP43CXyXBM=;
        b=ugPsPbvUQw22S46q6P/139Q1sZYokmouI7EdXbAq0dL+4gtzzBSRBB/+mVghJuH9sH
         tvGL6OixXZOtv0HCcltEts/cKSphP+o3PMu+w5zp4OmQQt2UcJ80xRhEYG9+eCYjsu2j
         phi57h980Zu/WsRJhmr4lnlUX0wHgVA3p2eBoyIaypWMcmO7LOz39zt9oXv9lyxhJJ7K
         Kpgw3LlITBSMyGtiZvMJ8yK1P5vpwuJKuEJcuS6+PvAv4QEH+cqPQdqspIebaW0Kczkh
         HfAdqgZ4HNOCRMjVfSUClKK69c/km4VM/adgZawXEbq/Pwf8xgy968h0YJ8vqy1CwPg6
         8MQA==
X-Gm-Message-State: AJcUukcHOiJ60HUIoZaSaWSJCKZmhUaVA+F+W8PNmRWcdkYRx5UzDX3o
        PbYe/fXz5F5mlIa7IyWN3xpUHw==
X-Google-Smtp-Source: ALg8bN4Cam9uBww04ohmJsgfOv6UatY+ao3ayo0wuKu3GUm1jVP49Gonpi0F/cPF9mqbnSPOPZrbSA==
X-Received: by 2002:a63:f201:: with SMTP id v1mr26158223pgh.232.1546034765171;
        Fri, 28 Dec 2018 14:06:05 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:75a:3f6e:21d:9374])
        by smtp.gmail.com with ESMTPSA id f62sm49333537pgc.67.2018.12.28.14.06.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 14:06:04 -0800 (PST)
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Loic Poulain <loic.poulain@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org,
        Balakrishna Godavarthi <bgodavar@codeaurora.org>,
        Brian Norris <briannorris@chromium.org>,
        Dmitry Grinberg <dmitrygr@google.com>,
        Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH v3 1/3] Bluetooth: Add quirk for reading BD_ADDR from fwnode property
Date:   Fri, 28 Dec 2018 14:05:44 -0800
Message-Id: <20181228220546.367-2-mka@chromium.org>
X-Mailer: git-send-email 2.20.1.415.g653613c723-goog
In-Reply-To: <20181228220546.367-1-mka@chromium.org>
References: <20181228220546.367-1-mka@chromium.org>
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
Tested-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>
---
Changes in v3:
- return no value from hci_dev_get_bd_addr_from_property() since
  currently nobody uses it anyway
- use bacpy() in hci_dev_get_bd_addr_from_property()
- return -EADDRNOTAVAIL if no BD_ADDR is configured or if the driver
  has no ->set_bdaddr

Changes in v2:
- added check for return value of ->setup()
- only read BD_ADDR from the property if it isn't assigned yet. This
  is needed to support configuration from user space
- refactored the branch of the new quirk to get rid of 'bd_addr_set'
- added 'Reviewed-by: Balakrishna Godavarthi <bgodavar@codeaurora.org>' tag
---
 include/net/bluetooth/hci.h | 12 +++++++++++
 net/bluetooth/hci_core.c    | 43 +++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c        |  6 ++++--
 3 files changed, 59 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c36dc1e20556a..fbba43e9bef5b 100644
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
index 7352fe85674be..3ccfa351b87bb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -30,6 +30,7 @@
 #include <linux/rfkill.h>
 #include <linux/debugfs.h>
 #include <linux/crypto.h>
+#include <linux/property.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -1355,6 +1356,32 @@ int hci_inquiry(void __user *arg)
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
+static void hci_dev_get_bd_addr_from_property(struct hci_dev *hdev)
+{
+	struct fwnode_handle *fwnode = dev_fwnode(hdev->dev.parent);
+	bdaddr_t ba;
+	int ret;
+
+	ret = fwnode_property_read_u8_array(fwnode, "local-bd-address",
+					    (u8 *)&ba, sizeof(ba));
+	if (ret < 0 || !bacmp(&ba, BDADDR_ANY))
+		return;
+
+	bacpy(&hdev->public_addr, &ba);
+}
+
 static int hci_dev_do_open(struct hci_dev *hdev)
 {
 	int ret = 0;
@@ -1422,6 +1449,22 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		if (hdev->setup)
 			ret = hdev->setup(hdev);
 
+		if (ret)
+			goto setup_failed;
+
+		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
+			if (!bacmp(&hdev->public_addr, BDADDR_ANY))
+				hci_dev_get_bd_addr_from_property(hdev);
+
+			if (bacmp(&hdev->public_addr, BDADDR_ANY) &&
+			    hdev->set_bdaddr)
+				ret = hdev->set_bdaddr(hdev,
+						       &hdev->public_addr);
+			else
+				ret = -EADDRNOTAVAIL;
+		}
+
+setup_failed:
 		/* The transport driver can set these quirks before
 		 * creating the HCI device or in its setup callback.
 		 *
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ccce954f81468..fae84353d030f 100644
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
2.20.1.415.g653613c723-goog

