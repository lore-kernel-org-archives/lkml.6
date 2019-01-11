Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92E33C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5882D2084C
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 15:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547219017;
	bh=p4xdUA2Uyga92EcNP3vjOGVj90OyhNcD49FbC5Yr+IY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OvzWaKcq6Crag0Kt0Exv0mA0FE5bcECllJUiXIlPoir+Fw0eSa40MoaBjwf667R4i
	 sGHAO4N+yc14AysB4sE17NQjeakK4XDyj54GVUiTkjhE/jvPrWhdPBuKQ/vUGurv2t
	 3Yil+LhmbSjPuDHHsknwYCoyOUd5CGaqJm7EMbDw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391772AbfAKPDg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 10:03:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:50330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389040AbfAKOau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 09:30:50 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3ACC2063F;
        Fri, 11 Jan 2019 14:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547217050;
        bh=p4xdUA2Uyga92EcNP3vjOGVj90OyhNcD49FbC5Yr+IY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pb0gPM47z23USNCPObv70hXCVshQG5Fq+1JQQnWgXExgCtoQOHmLdsZ2kf4wpFF8i
         an8IWgRcrpEj51x/H6fy8eDJoSnE+YNCIsDerW8IG+4eruvM/olzguWL3anmcxSXes
         K/xA0KvZHDcLT2A2PqO0UcZg9s5VM+sd/4OhC1Eg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.14 004/105] HID: ite: Add USB id match for another ITE based keyboard rfkill key quirk
Date:   Fri, 11 Jan 2019 15:13:35 +0100
Message-Id: <20190111131103.364329631@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190111131102.899065735@linuxfoundation.org>
References: <20190111131102.899065735@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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



