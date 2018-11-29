Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0F6EC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5F49520834
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:04:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqJtRPxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F49520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730001AbeK2RIL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:08:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:46586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728038AbeK2RIK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:08:10 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8966720834;
        Thu, 29 Nov 2018 06:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471438;
        bh=q5MAXwSgVRbDONfxx34OaX4GywgY4499J3axyfCl+Kg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qqJtRPxXlSkY3vag7c3N5ofUS2J9cWo4IM+tagVR++jtJVoY8uVsbFm0qDAt5wVFP
         AmBKI4wi3KlxM9nm3vrIISmUzyqVrXrtQrtejW2R/r/Vl87Yet/uu3Cv4ixMSn9aTu
         bI0d7NWF5r8KSlNUXu5OqgeV9sa4HsKIi/4KfqnU=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Benson Leung <bleung@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 06/18] HID: input: Ignore battery reported by Symbol DS4308
Date:   Thu, 29 Nov 2018 01:03:18 -0500
Message-Id: <20181129060331.160224-6-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060331.160224-1-sashal@kernel.org>
References: <20181129060331.160224-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benson Leung <bleung@chromium.org>

[ Upstream commit 0fd791841a6d67af1155a9c3de54dea51220721e ]

The Motorola/Zebra Symbol DS4308-HD is a handheld USB barcode scanner
which does not have a battery, but reports one anyway that always has
capacity 2.

Let's apply the IGNORE quirk to prevent it from being treated like a
power supply so that userspaces don't get confused that this
accessory is almost out of power and warn the user that they need to charge
their wired barcode scanner.

Reported here: https://bugs.chromium.org/p/chromium/issues/detail?id=804720

Signed-off-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h   | 1 +
 drivers/hid/hid-input.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 8913f357e78f..6f4c84d824e6 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -965,6 +965,7 @@
 #define USB_VENDOR_ID_SYMBOL		0x05e0
 #define USB_DEVICE_ID_SYMBOL_SCANNER_1	0x0800
 #define USB_DEVICE_ID_SYMBOL_SCANNER_2	0x1300
+#define USB_DEVICE_ID_SYMBOL_SCANNER_3	0x1200
 
 #define USB_VENDOR_ID_SYNAPTICS		0x06cb
 #define USB_DEVICE_ID_SYNAPTICS_TP	0x0001
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 5ff6dd8147b6..fc7ada26457e 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -324,6 +324,9 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
 		USB_DEVICE_ID_ELECOM_BM084),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SYMBOL,
+		USB_DEVICE_ID_SYMBOL_SCANNER_3),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{}
 };
 
-- 
2.17.1

