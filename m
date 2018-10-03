Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5792C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86AF220835
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 07:36:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86AF220835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727268AbeJCOXU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 10:23:20 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:56144 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726672AbeJCOXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 10:23:19 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1g7bhW-00089F-9D; Wed, 03 Oct 2018 07:36:06 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND] [PATCH 2/3] Bluetooth: btusb: Load firmware exclusively for Intel BT
Date:   Wed,  3 Oct 2018 15:35:55 +0800
Message-Id: <20181003073556.28154-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181003073556.28154-1-kai.heng.feng@canonical.com>
References: <20181003073556.28154-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid the firmware loading race between Bluetooth and WiFi on Intel
8260, load firmware exclusively when IWLWIFI is enabled.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/btusb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 61cde1a7ec1b..060e3c6482f4 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2251,8 +2251,16 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 
 	set_bit(BTUSB_DOWNLOADING, &data->flags);
 
+#if IS_ENABLED(CONFIG_IWLWIFI)
+	btintel_firmware_lock();
+#endif
+
 	/* Start firmware downloading and get boot parameter */
 	err = btintel_download_firmware(hdev, fw, &boot_param);
+
+#if IS_ENABLED(CONFIG_IWLWIFI)
+	btintel_firmware_unlock();
+#endif
 	if (err < 0)
 		goto done;
 
-- 
2.17.1

