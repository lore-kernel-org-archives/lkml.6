Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ADDCECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:22:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A200A20824
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 00:22:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ODZMYPBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A200A20824
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727206AbeJYIwR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 04:52:17 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38127 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbeJYIwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 04:52:07 -0400
Received: by mail-pf1-f193.google.com with SMTP id b11-v6so1609668pfi.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Oct 2018 17:21:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQX6LKgKdC8OvywWT+VY2Ui0n/vqYgFMzYtK6VSniiA=;
        b=ODZMYPBzXNTFKe71LEzUrrmYF5qEWY+A8gut3P6z6AzqQ67WiCyLjyjxtOPbuZhLMj
         7WBelvXoHrAZ9Oa8zvXG6zg+ZEIASBltKHgTnKGlIFvLi4klYYlLIW8dTL6koaQ6O9Bk
         4uHbyFFUzlR9LpZb3mdTfgdZ+5mJyfSZfzvIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQX6LKgKdC8OvywWT+VY2Ui0n/vqYgFMzYtK6VSniiA=;
        b=EoTxXB6JcPQDyxnWKkPLH/N1k98zil0XskOlFTbTzFXazXgpuoPt4qFZVT7GTPg9Z5
         HsCLh7l3Srr8E2Klz9UqnvRhpat+U1+/LI/+RFFc60LKEnJSMssT8x8C/cCQI1do7SA4
         YK6za3cdWx8430KjJanbm8Pc2XQgHaAMZIZwe27G7Tj0tzM/bjdTwaSjwoInL7bvYx50
         kgNswyZn/2VI0Cx+RlV5cUgfYDEHciIgw+x1qbV1mNLL+UR0IPYDj8c0XVg9jKIq6NZQ
         CHMV5LqhJpnJnGmT4IBr7jXtC5RF/PULzExUIx65zO3cvRecoGe2SJLVpZlwUvolnf98
         Lt9g==
X-Gm-Message-State: AGRZ1gIeFagUj0lwvkY49NZh+06jzq0Gk81jvLNobZwJrrSlvitktG80
        DNQu474Tmhm/ozs4ZaRulExnyw==
X-Google-Smtp-Source: AJdET5dKU/jBSt01k1Y8jgAcyFkrrw2hjVq2Z+WBXhw56uYmzzE6MyadPOpKwssm6+LU4G38jM95gQ==
X-Received: by 2002:a63:e40e:: with SMTP id a14-v6mr4553523pgi.28.1540426911952;
        Wed, 24 Oct 2018 17:21:51 -0700 (PDT)
Received: from mka.mtv.corp.google.com ([2620:15c:202:1:b6af:f85:ed6c:ac6a])
        by smtp.gmail.com with ESMTPSA id w2-v6sm8410181pfk.140.2018.10.24.17.21.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Oct 2018 17:21:51 -0700 (PDT)
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
Subject: [PATCH 2/2] Bluetooth: btqcomsmd: use HCI_QUIRK_USE_BDADDR_PROPERTY
Date:   Wed, 24 Oct 2018 17:21:34 -0700
Message-Id: <20181025002134.256791-3-mka@chromium.org>
X-Mailer: git-send-email 2.19.1.568.g152ad8e336-goog
In-Reply-To: <20181025002134.256791-1-mka@chromium.org>
References: <20181025002134.256791-1-mka@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the HCI_QUIRK_USE_BDADDR_PROPERTY quirk to let the HCI
core handle the reading of 'local-bd-address'. With this there
is no need to set HCI_QUIRK_INVALID_BDADDR, the case of a
non-existing or invalid fwnode property is handled by the core
code.

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
I couldn't actually test the changes in this driver since I
don't have a device with this controller. Could someone
from Qualcomm help with this?
---
 drivers/bluetooth/btqcomsmd.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/drivers/bluetooth/btqcomsmd.c b/drivers/bluetooth/btqcomsmd.c
index 7df3eed1ef5e..e5841602c4f1 100644
--- a/drivers/bluetooth/btqcomsmd.c
+++ b/drivers/bluetooth/btqcomsmd.c
@@ -125,23 +125,10 @@ static int btqcomsmd_setup(struct hci_dev *hdev)
 		return PTR_ERR(skb);
 	kfree_skb(skb);
 
-	/* Devices do not have persistent storage for BD address. If no
-	 * BD address has been retrieved during probe, mark the device
-	 * as having an invalid BD address.
+	/* Devices do not have persistent storage for BD address. Retrieve
+	 * it from the firmware node property.
 	 */
-	if (!bacmp(&btq->bdaddr, BDADDR_ANY)) {
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-		return 0;
-	}
-
-	/* When setting a configured BD address fails, mark the device
-	 * as having an invalid BD address.
-	 */
-	err = qca_set_bdaddr_rome(hdev, &btq->bdaddr);
-	if (err) {
-		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
-		return 0;
-	}
+	set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
 
 	return 0;
 }
@@ -169,15 +156,6 @@ static int btqcomsmd_probe(struct platform_device *pdev)
 	if (IS_ERR(btq->cmd_channel))
 		return PTR_ERR(btq->cmd_channel);
 
-	/* The local-bd-address property is usually injected by the
-	 * bootloader which has access to the allocated BD address.
-	 */
-	if (!of_property_read_u8_array(pdev->dev.of_node, "local-bd-address",
-				       (u8 *)&btq->bdaddr, sizeof(bdaddr_t))) {
-		dev_info(&pdev->dev, "BD address %pMR retrieved from device-tree",
-			 &btq->bdaddr);
-	}
-
 	hdev = hci_alloc_dev();
 	if (!hdev)
 		return -ENOMEM;
-- 
2.19.1.568.g152ad8e336-goog

