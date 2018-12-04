Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B1EEC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C7B0B20850
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 20:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hP1GQw0J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C7B0B20850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbeLDUQh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:16:37 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41283 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbeLDUQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 15:16:34 -0500
Received: by mail-pg1-f195.google.com with SMTP id 70so7871170pgh.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Dec 2018 12:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I1tczKbzPD84L0kVYxKySMQXoPeV0CfDlNT382/LJic=;
        b=hP1GQw0JwKJS7Ciy+fwn6OnuoPYPR9Z8LYKhDk77xfZgpi/0BeWt4hWWk2BVRRr4Hn
         rTx9v9HKJtqvi3otdnwLQPUX05//4TkTt9FFLWrMAy+qMCCLbIXgFvqwqM2p0jhRrI/Y
         22Se9XxE3eG3IjPh4YDtGkQUw5zKh+Z92VGgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I1tczKbzPD84L0kVYxKySMQXoPeV0CfDlNT382/LJic=;
        b=t2koQuIR1Pwd2AILuj/unLc/K8v/X2FCeo/dGCC4GeGqG5+yfs1I1Fs5lIEQyC76Lv
         Z22ml7uKG7THtnd4/Rrpg4sp9vykCClRD1TngYDfT9mWL2s5US+2GhpW1uTHU7NNb93j
         KYahoQzh93f+I5G5UYNiLK+LZI1c0fukkKFNP1d6spMLPhduUmKv9l+c04LMy/ijQC87
         TfRGBGZpiO1nNBt0uMnLnIyE2vLKJvtUsart/24xlCPIUY0IC0J7Z+GLqyq99KNv0gnO
         4fo2Y4t58gCWZ8caMj1dSDP47SgCXeSZproQ0jeMobZKGVD1lkux2VrhsZpo2Xn934BU
         j9sQ==
X-Gm-Message-State: AA+aEWZJS8YIRkK2A5SVQ1VpOb123xa0Tk/Tf3AtnHtCd53KSuxUyT+N
        eD7EeTGU8LRyMPYYKg7ysDvHNTv/R0A=
X-Google-Smtp-Source: AFSGD/VIFtyE7T3SR22rxcAbjL8JJg0l7yQ17a/WOQ/u6oAr8chC7FwNeMM7uEZ3i9P6IaNoCg5PWQ==
X-Received: by 2002:a63:6906:: with SMTP id e6mr17693080pgc.144.1543954593399;
        Tue, 04 Dec 2018 12:16:33 -0800 (PST)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id b185sm29499593pga.85.2018.12.04.12.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 12:16:32 -0800 (PST)
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
Subject: [PATCH RESEND v2 1/3] Bluetooth: Add quirk for reading BD_ADDR from fwnode property
Date:   Tue,  4 Dec 2018 12:16:13 -0800
Message-Id: <20181204201615.245574-2-mka@chromium.org>
X-Mailer: git-send-email 2.20.0.rc1.387.gf8505762e3-goog
In-Reply-To: <20181204201615.245574-1-mka@chromium.org>
References: <20181204201615.245574-1-mka@chromium.org>
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
index 7352fe85674be..d4149005a661e 100644
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
2.20.0.rc1.387.gf8505762e3-goog

