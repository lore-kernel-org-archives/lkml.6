Return-Path: <SRS0=2CM+=PD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7202CC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4052C218E2
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Dec 2018 22:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545864009;
	bh=HW8lEkfUmZwfrZAomhzBDrVvx7MkzYQRgyFEWCSnC5Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=jvuF7ai0raWXYKA0H/9paHWSBJP1IfbFWk1HKQR0J0zAE4Q73Xd7pCQ12F8Nme2Ae
	 8AoiEeAAlYM4YC8epXS4yog/X9w/5bAgtUHFfLefFttfCzc0j7CppUzXue3iBcQ5DP
	 wxG/5ZE+LOBjWRqT5ucADqJPVZOjdfOeQKA2u+Dg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728969AbeLZWkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Dec 2018 17:40:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:40100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726838AbeLZWkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Dec 2018 17:40:03 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 28B6820651;
        Wed, 26 Dec 2018 22:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545864002;
        bh=HW8lEkfUmZwfrZAomhzBDrVvx7MkzYQRgyFEWCSnC5Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBSaxQhzZv8TPSJmG0HgDaxCql1n8IF1SYKnaaK3mCQuRVMa3kLGTA9EevjQz6i9d
         yJ9gue1EHaIPZIMZ4MTabTlJYiXvSEsi/vuOFjC/JLT8Zm2lADAb0/ugn3hBdBshnI
         Uz9qVwByry4mZhKOxRAmTdQBU+PFLPlBwr68OTcs=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 04/59] HID: ite: Add USB id match for another ITE based keyboard rfkill key quirk
Date:   Wed, 26 Dec 2018 17:37:44 -0500
Message-Id: <20181226223839.150262-4-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181226223839.150262-1-sashal@kernel.org>
References: <20181226223839.150262-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit 4050207485e47e00353e87f2fe2166083e282688 ]

The 258a:6a88 keyboard-dock shipped with the Prowise PT301 tablet is
likely another ITE based design. The controller die is directly bonded
to the PCB with a blob of black glue on top so there are no markings and
the 258a vendor-id used is unknown anywhere. But the keyboard has the
exact same hotkeys mapped to Fn+F1 - F10 as the other ITE8595 keyboard
I have *and* it has the same quirky behavior wrt the rfkill hotkey.

Either way as said this keyboard has the same quirk for its rfkill /
airplane mode hotkey as the ITE 8595 chip, it only sends a single release
event when pressed and released, it never sends a press event.

This commit adds the 258a:6a88 USB id to the hid-ite id-table, fixing
the rfkill key not working on this keyboard.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h | 3 +++
 drivers/hid/hid-ite.c | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index fcc688df694c..28ae3dc57103 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -17,6 +17,9 @@
 #ifndef HID_IDS_H_FILE
 #define HID_IDS_H_FILE
 
+#define USB_VENDOR_ID_258A		0x258a
+#define USB_DEVICE_ID_258A_6A88		0x6a88
+
 #define USB_VENDOR_ID_3M		0x0596
 #define USB_DEVICE_ID_3M1968		0x0500
 #define USB_DEVICE_ID_3M2256		0x0502
diff --git a/drivers/hid/hid-ite.c b/drivers/hid/hid-ite.c
index 1882a4ab0f29..98b059d79bc8 100644
--- a/drivers/hid/hid-ite.c
+++ b/drivers/hid/hid-ite.c
@@ -42,6 +42,7 @@ static int ite_event(struct hid_device *hdev, struct hid_field *field,
 
 static const struct hid_device_id ite_devices[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ITE, USB_DEVICE_ID_ITE8595) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_258A, USB_DEVICE_ID_258A_6A88) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, ite_devices);
-- 
2.19.1

