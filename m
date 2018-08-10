Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3828C4646D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:04:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 54C98223D9
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 07:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54C98223D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727628AbeHJJdX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 05:33:23 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:41988 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726961AbeHJJdX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 05:33:23 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E916A84A94A8;
        Fri, 10 Aug 2018 15:04:48 +0800 (CST)
Received: from dessert.huawei.com (10.69.192.158) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.399.0; Fri, 10 Aug 2018 15:04:42 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <mathias.nyman@linux.intel.com>, <drinkcat@chromium.org>,
        <felipe.balbi@linux.intel.com>, <drake@endlessm.com>,
        <mike.looijmans@topic.nl>, <joe@perches.com>
CC:     Zeng Tao <prime.zeng@hisilicon.com>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] usb: hub: try old enumeration scheme first for high speed devices
Date:   Fri, 10 Aug 2018 23:01:42 +0800
Message-ID: <1533913304-15737-1-git-send-email-prime.zeng@hisilicon.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.158]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The new scheme is required just to support legacy low and full-speed
devices. For high speed devices, it will slower the enumeration speed.
So in this patch we try the "old" enumeration scheme first for high speed
devices.

Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 drivers/usb/core/hub.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 1fb2668..d265b19 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2661,10 +2661,13 @@ static bool use_new_scheme(struct usb_device *udev, int retry,
 	int old_scheme_first_port =
 		port_dev->quirks & USB_PORT_QUIRK_OLD_SCHEME;
 
+	int quick_enumeration = (udev->speed == USB_SPEED_HIGH);
+
 	if (udev->speed >= USB_SPEED_SUPER)
 		return false;
 
-	return USE_NEW_SCHEME(retry, old_scheme_first_port || old_scheme_first);
+	return USE_NEW_SCHEME(retry, old_scheme_first_port || old_scheme_first
+			      || quick_enumeration);
 }
 
 /* Is a USB 3.0 port in the Inactive or Compliance Mode state?
-- 
2.7.4

