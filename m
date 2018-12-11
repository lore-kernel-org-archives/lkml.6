Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01D8AC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC8EF205C9
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 15:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544543823;
	bh=qrFPrihLgfMIrNqWZ6zsEbo6RJ7KsnG55jysSoi6FTw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=WSxUB0iseCkWE22zCej+Pi6qKlCU6K7PLSx7JeoUje+7Ky0g78Mm+QNHsTFXWOfB2
	 1qG6XK67sDDLX2r4BP8YET2asFaWJSz3HrM+dTFgz5oID2bGkvga9EC3gWnZ7RnMGk
	 cgp/wMsef3GSShpjUE7MPTVUcUbu1zl4qZC02tAE=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC8EF205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730720AbeLKP5C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:57:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:45820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730259AbeLKP45 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:56:57 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F1D820855;
        Tue, 11 Dec 2018 15:56:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543816;
        bh=qrFPrihLgfMIrNqWZ6zsEbo6RJ7KsnG55jysSoi6FTw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EE/HSqDf0rkkNsQI0DCh4oPJuPZNBOx9yfo2BzrDF0aSNoIgoWN44jl/b8pQhT9t5
         AoxQpAYi0v6gm1AG+eQHVDsgtveud4MAr4vaK/qpQUV69mJTSkREyNrEzKUSfapHZI
         JuTJOFORKwka0UPgAgauiIMa/PAzRdX1dBzY8Qzo=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 040/118] HID: multitouch: Add pointstick support for Cirque Touchpad
Date:   Tue, 11 Dec 2018 16:40:59 +0100
Message-Id: <20181211151645.856345649@linuxfoundation.org>
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

[ Upstream commit 12d43aacf9a74d0eb66fd0ea54ebeb79ca28940f ]

Cirque Touchpad/Pointstick combo is similar to Alps devices, it requires
MT_CLS_WIN_8_DUAL to expose its pointstick as a mouse.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ids.h        | 3 +++
 drivers/hid/hid-multitouch.c | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index a2d25055cd7f..b71c3600f470 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -271,6 +271,9 @@
 
 #define USB_VENDOR_ID_CIDC		0x1677
 
+#define I2C_VENDOR_ID_CIRQUE		0x0488
+#define I2C_PRODUCT_ID_CIRQUE_121F	0x121F
+
 #define USB_VENDOR_ID_CJTOUCH		0x24b8
 #define USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0020	0x0020
 #define USB_DEVICE_ID_CJTOUCH_MULTI_TOUCH_0040	0x0040
diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index da954f3f4da7..2faf5421fdd0 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -1822,6 +1822,12 @@ static const struct hid_device_id mt_devices[] = {
 		MT_USB_DEVICE(USB_VENDOR_ID_CHUNGHWAT,
 			USB_DEVICE_ID_CHUNGHWAT_MULTITOUCH) },
 
+	/* Cirque devices */
+	{ .driver_data = MT_CLS_WIN_8_DUAL,
+		HID_DEVICE(BUS_I2C, HID_GROUP_MULTITOUCH_WIN_8,
+			I2C_VENDOR_ID_CIRQUE,
+			I2C_PRODUCT_ID_CIRQUE_121F) },
+
 	/* CJTouch panels */
 	{ .driver_data = MT_CLS_NSMU,
 		MT_USB_DEVICE(USB_VENDOR_ID_CJTOUCH,
-- 
2.19.1



