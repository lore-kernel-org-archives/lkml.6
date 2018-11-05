Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B2D4ECDE44
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:45:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BEAE20854
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 08:45:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BEAE20854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbeKESD4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 5 Nov 2018 13:03:56 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34918 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbeKESD4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Nov 2018 13:03:56 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1gJaVa-0002Nv-Dl; Mon, 05 Nov 2018 08:45:18 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     ulf.hansson@linaro.org, stern@rowland.harvard.edu,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 2/5 v7] misc: rtsx_usb: Use USB remote wakeup signaling for card insertion detection
Date:   Mon,  5 Nov 2018 16:45:03 +0800
Message-Id: <20181105084506.6476-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181105084506.6476-1-kai.heng.feng@canonical.com>
References: <20181105084506.6476-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Although rtsx_usb doesn't support card removal detection, card insertion
will resume rtsx_usb by USB remote wakeup signaling.

When rtsx_usb gets resumed, also resumes its child devices,
rtsx_usb_sdmmc and rtsx_usb_ms, to notify them there's a card in its
slot.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/misc/cardreader/rtsx_usb.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index b97903ff1a72..f7a66f614085 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -723,8 +723,15 @@ static int rtsx_usb_suspend(struct usb_interface *intf, pm_message_t message)
 	return 0;
 }
 
+static int rtsx_usb_resume_child(struct device *dev, void *data)
+{
+	pm_request_resume(dev);
+	return 0;
+}
+
 static int rtsx_usb_resume(struct usb_interface *intf)
 {
+	device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
 	return 0;
 }
 
@@ -734,6 +741,7 @@ static int rtsx_usb_reset_resume(struct usb_interface *intf)
 		(struct rtsx_ucr *)usb_get_intfdata(intf);
 
 	rtsx_usb_reset_chip(ucr);
+	device_for_each_child(&intf->dev, NULL, rtsx_usb_resume_child);
 	return 0;
 }
 
-- 
2.19.1

