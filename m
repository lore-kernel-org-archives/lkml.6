Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2D16ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD68020824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:21:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BrSupmvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD68020824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeJYIwJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:52:09 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:36462 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbeJYIwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:52:07 -0400
Received: by mail-pg1-f195.google.com with SMTP id l6-v6so3132478pgp.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 17:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0ssNiO0MzqiPCnTp2tXANa+4GzESnokP5rn/nFUKtI=;
        b=BrSupmvhqW1fQW2RUAKCzi+kpypHK3+NSFEWLIehXgWFFTwObdu4e+b5PCOiL0dXuI
         qaEliEtbIQIsrBJj4CIIn3c6dApKoOr7dDLQUlT6/ZvlChKm02YZRAzWdMhtCX+0frh7
         hsGkmDoUsLjZnUxURjTGbd57MudEpdZYFCNWk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0ssNiO0MzqiPCnTp2tXANa+4GzESnokP5rn/nFUKtI=;
        b=YKN1QEsn28ElTYC/GqWB8g7egSBlgILKh02IdL+4gkKorZkc2VnZW8/tBx4eKhVMNH
         tYUAHHRYQP0dJzKvtTp8lrDgwfHErdeDkIGtohBFwyhtG9F58tWr2+PX4jFiJ5tB56A3
         TredpYYVf8gzyTW+mGmpnDcmuKGzYVNxBYp3imBQbyrNN1VQyRr5goisi/XvF0CEAXbo
         75M159u4ZWqumHV/HUJ+g0/VyUlsqsIhTipv7WLrVq8GH65VkFltv4zCtip65jvPSzu2
         S27dR7bAD1eixcRnVJlGZbDkMlIPUT4dFrwQJdwDTULVw9HyrpV2lc/MAFVoJEs/86nO
         wqEw==
X-Gm-Message-State: AGRZ1gJmVdE4vhAVSpUwH3c1iRazXfYjSXdG1rlG+H+mi78Gg/ZUmxhy
        48URn0H3JQvfyUJHA6cJeGeCtg==
X-Google-Smtp-Source: AJdET5flEvb9tN6hbYZP/j+wB0ftlPlJ0ovDfZs6/+4xUBBZeaMwGki3dY7lAukGX+fOsueSSUWv9g==
X-Received: by 2002:a63:ae4d:: with SMTP id e13-v6mr4542771pgp.315.1540426910980;
        Wed, 24 Oct 2018 17:21:50 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id w2-v6sm8410181pfk.140.2018.10.24.17.21.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 17:21:50 -0700 (PDT)
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
Subject: [PATCH 1/2] Bluetooth: Add quirk for reading BD_ADDR from fwnode property
Date:   Wed, 24 Oct 2018 17:21:33 -0700
Message-Id: <20181025002134.256791-2-mka@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181025002134.256791-1-mka@chromium.org>
References: <20181025002134.256791-1-mka@chromium.org>
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
---
hci_dev_get_bd_addr_from_property() currently assumes that the
firmware node with 'local-bd-address' is from hdev->dev.parent, not
sure if this universally true. However if it is true for existing
device that might use this interface we can assume this for now
(unless there is a clear solution now), and cross the bridge of
finding an alternative when we actually encounter the situation.
One option could be to look for the first parent that has a fwnode.
---
 include/net/bluetooth/hci.h | 12 +++++++++++
 net/bluetooth/hci_core.c    | 42 +++++++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c        |  6 ++++--
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index cdd9f1fe7cfa..a5d748099752 100644
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
index 74b29c7d841c..97214262c4fb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -30,6 +30,7 @@
 #include <linux/rfkill.h>
 #include <linux/debugfs.h>
 #include <linux/crypto.h>
+#include <linux/property.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -1355,9 +1356,40 @@ int hci_inquiry(void __user *arg)
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
+	bool bd_addr_set = false;
 
 	BT_DBG("%s %p", hdev->name, hdev);
 
@@ -1422,6 +1454,16 @@ static int hci_dev_do_open(struct hci_dev *hdev)
 		if (hdev->setup)
 			ret = hdev->setup(hdev);
 
+		if (test_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks)) {
+			if (!hci_dev_get_bd_addr_from_property(hdev))
+				if (hdev->set_bdaddr &&
+				    !hdev->set_bdaddr(hdev, &hdev->public_addr))
+					bd_addr_set = true;
+
+			if (!bd_addr_set)
+				hci_dev_set_flag(hdev, HCI_UNCONFIGURED);
+		}
+
 		/* The transport driver can set these quirks before
 		 * creating the HCI device or in its setup callback.
 		 *
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3bdc8f3ca259..3d9edb752403 100644
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

