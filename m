Return-Path: <SRS0=AJhT=QD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C1D5C282C0
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 561A2214C6
	for <linux-kernel@archiver.kernel.org>; Sun, 27 Jan 2019 08:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbfA0IeJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 27 Jan 2019 03:34:09 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:55287 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726327AbfA0IeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Jan 2019 03:34:08 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gnftE-0002dU-6L; Sun, 27 Jan 2019 08:34:04 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     marcel@holtmann.org, johan.hedberg@gmail.com
Cc:     drake@endlessm.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH v2] Bluetooth: btrtl: Restore old logic to assume firmware is already loaded
Date:   Sun, 27 Jan 2019 16:33:59 +0800
Message-Id: <20190127083359.17833-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Realtek bluetooth may not work after reboot:
[   12.446130] Bluetooth: hci0: RTL: rtl: unknown IC info, lmp subver a99e, hci rev 826c, hci ver 0008

This is a regression introduced by commit 26503ad25de8 ("Bluetooth:
btrtl: split the device initialization into smaller parts"). The new
logic errors out early when no matching IC info can be found, in this
case it means the firmware is already loaded.

So let's assume the firmware is already loaded when we can't find
matching IC info, like the old logic did.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=201921
Fixes: 26503ad25de8 ("Bluetooth: btrtl: split the device initialization into smaller parts")
Cc: stable@vger.kernel.org # 4.19+
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/bluetooth/btrtl.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
index 41405de27d66..c91bba00df4e 100644
--- a/drivers/bluetooth/btrtl.c
+++ b/drivers/bluetooth/btrtl.c
@@ -552,10 +552,9 @@ struct btrtl_device_info *btrtl_initialize(struct hci_dev *hdev,
 					    hdev->bus);
 
 	if (!btrtl_dev->ic_info) {
-		rtl_dev_err(hdev, "rtl: unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
+		rtl_dev_info(hdev, "rtl: unknown IC info, lmp subver %04x, hci rev %04x, hci ver %04x",
 			    lmp_subver, hci_rev, hci_ver);
-		ret = -EINVAL;
-		goto err_free;
+		return btrtl_dev;
 	}
 
 	if (btrtl_dev->ic_info->has_rom_version) {
@@ -610,6 +609,11 @@ int btrtl_download_firmware(struct hci_dev *hdev,
 	 * standard btusb. Once that firmware is uploaded, the subver changes
 	 * to a different value.
 	 */
+	if (!btrtl_dev->ic_info) {
+		rtl_dev_info(hdev, "rtl: assuming no firmware upload needed\n");
+		return 0;
+	}
+
 	switch (btrtl_dev->ic_info->lmp_subver) {
 	case RTL_ROM_LMP_8723A:
 	case RTL_ROM_LMP_3499:
-- 
2.17.1

