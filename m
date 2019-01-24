Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E3FC282C6
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0703A218AE
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 15:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728577AbfAXPX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 10:23:26 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:57123 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728305AbfAXPXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 10:23:25 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gmgqg-0000kg-HC; Thu, 24 Jan 2019 15:23:23 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     drake@endlessm.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 3/3] Bluetooth: btrtl: Skip initialization if firmware is already loaded
Date:   Thu, 24 Jan 2019 23:23:10 +0800
Message-Id: <20190124152310.29717-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190124152310.29717-1-kai.heng.feng@canonical.com>
References: <20190124152310.29717-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realtek bluetooth may not work after reboot:
[   12.446130] Bluetooth: hci0: RTL: rtl: unknown IC info, lmp subver a99e, hci rev 826c, hci ver 0008

The power is not cut during system reboot, so the firmware is kept in
Bluetooth controller.

Realtek bluetooth doesn't have the ability to check firmware loading
status. but the version queried by HCI_OP_READ_LOCAL_VERSION will be
different if firmware is already loaded. Realtek's own fork, rtk_btusb
also use this method to detect the loading status.

So let's assume the firmware is already loaded when we can't find
matching IC info.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201921
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/btrtl.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index c36f500d8313..e2f89d57dd14 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -546,9 +546,10 @@ int btrtl_initialize(struct hci_dev *hdev,
 					    hdev->bus);
 
 	if (!btrtl_dev->ic_info) {
-		rtl_dev_err(hdev, "rtl: unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
-			    lmp_subver, hci_rev, hci_ver);
-		return -EINVAL;
+		rtl_dev_info(hdev, "rtl: unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
+			     lmp_subver, hci_rev, hci_ver);
+		rtl_dev_info(hdev, "rtl: firmware may be already loaded, or it's an unsupported IC.");
+		return 0;
 	}
 
 	if (btrtl_dev->ic_info->has_rom_version) {
@@ -621,7 +622,8 @@ int btrtl_setup_realtek(struct hci_dev *hdev)
 	if (ret)
 		return ret;
 
-	ret = btrtl_download_firmware(hdev, &btrtl_dev);
+	if (btrtl_dev.ic_info)
+		ret = btrtl_download_firmware(hdev, &btrtl_dev);
 
 	return ret;
 }
-- 
2.17.1

