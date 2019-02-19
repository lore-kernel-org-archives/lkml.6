Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E7EC43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 516D32146E
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 14:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728416AbfBSOx3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 09:53:29 -0500
Received: from unicorn.mansr.com ([81.2.72.234]:37412 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725885AbfBSOx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 09:53:28 -0500
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id EC54B1630C; Tue, 19 Feb 2019 14:53:26 +0000 (GMT)
From:   Mans Rullgard <mans@mansr.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2] usb: core: skip interfaces disabled in devicetree
Date:   Tue, 19 Feb 2019 14:52:26 +0000
Message-Id: <20190219145226.3809-1-mans@mansr.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190216170452.10884-1-mans@mansr.com>
References: <20190216170452.10884-1-mans@mansr.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an interface has an associated devicetree node with status disabled,
do not register the device.  This is useful for boards with a built-in
multifunction USB device where some functions are broken or otherwise
undesired.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
Changed in v2:
- print message about skipped interfaces
---
 drivers/usb/core/message.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/core/message.c b/drivers/usb/core/message.c
index bfa5eda0cc26..46bf79bc03ad 100644
--- a/drivers/usb/core/message.c
+++ b/drivers/usb/core/message.c
@@ -2007,6 +2007,13 @@ int usb_set_configuration(struct usb_device *dev, int configuration)
 	for (i = 0; i < nintf; ++i) {
 		struct usb_interface *intf = cp->interface[i];
 
+		if (intf->dev.of_node &&
+		    !of_device_is_available(intf->dev.of_node)) {
+			dev_info(&dev->dev, "skipping disabled interface %d\n",
+				 intf->cur_altsetting->desc.bInterfaceNumber);
+			continue;
+		}
+
 		dev_dbg(&dev->dev,
 			"adding %s (config #%d, interface %d)\n",
 			dev_name(&intf->dev), configuration,
-- 
2.20.1

