Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEC5AC07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 75AFF2146E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:54:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543661;
	bh=krmnVy+6opTSsB873KZOiHu9N4rmMBDdaBpg2/JToXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yR8OMWkwpW4EF/ikfdK2h2LobCDqPxgiN4QEjyeNBwcXAuq+YAaHBFqZ9YyTaA2Z8
	 ykDWMsYOlR2tB3fJUJoB/kPjnuk+8d/db9IZGlerNHN4aJ0p8BjfB6GtKASU6RkjLL
	 M9ODm/ZOR8QJ8AoSX8moCxsoQaXzEVjB+hDEA0iw=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75AFF2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbeLKPyU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:54:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:42884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729442AbeLKPyP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:54:15 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4805C20855;
        Tue, 11 Dec 2018 15:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543654;
        bh=krmnVy+6opTSsB873KZOiHu9N4rmMBDdaBpg2/JToXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DfTht0JLLq748MpEgdv0QCWjityrqf88ow6N5T+w3jeqe+dilQsZqguurL9I62MNN
         Z/fvdVj2OWkXGojG6FoFy9SpqjPWsUnhf29SaJ9FzQ3evLUBE2sBPRjk80Jz+lSwdP
         Ku4xsMNAxDJJmUsprc5AeNerRdmvv+sVWwwXq7fo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Benson Leung <bleung@chromium.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 013/118] HID: input: Ignore battery reported by Symbol DS4308
Date:   Tue, 11 Dec 2018 16:40:32 +0100
Message-Id: <20181211151644.768341756@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151644.216668863@linuxfoundation.org>
References: <20181211151644.216668863@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 501c05cbec7e..a2d25055cd7f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1038,6 +1038,7 @@
 #define USB_VENDOR_ID_SYMBOL		0x05e0
 #define USB_DEVICE_ID_SYMBOL_SCANNER_1	0x0800
 #define USB_DEVICE_ID_SYMBOL_SCANNER_2	0x1300
+#define USB_DEVICE_ID_SYMBOL_SCANNER_3	0x1200
 
 #define USB_VENDOR_ID_SYNAPTICS		0x06cb
 #define USB_DEVICE_ID_SYNAPTICS_TP	0x0001
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index a481eaf39e88..a3916e58dbf5 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -325,6 +325,9 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
 		USB_DEVICE_ID_ELECOM_BM084),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_SYMBOL,
+		USB_DEVICE_ID_SYMBOL_SCANNER_3),
+	  HID_BATTERY_QUIRK_IGNORE },
 	{}
 };
 
-- 
2.19.1



