Return-Path: <SRS0=A5JR=LD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA353C4321D
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78A1620C09
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Aug 2018 02:01:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78A1620C09
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hisilicon.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726274AbeHTFOw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Aug 2018 01:14:52 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43351 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725805AbeHTFOv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Aug 2018 01:14:51 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id E25339D6B7804;
        Mon, 20 Aug 2018 10:01:10 +0800 (CST)
Received: from dessert.huawei.com (10.69.192.158) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.399.0; Mon, 20 Aug 2018 10:01:02 +0800
From:   Zeng Tao <prime.zeng@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <stern@rowland.harvard.edu>,
        <mathias.nyman@linux.intel.com>, <drinkcat@chromium.org>,
        <felipe.balbi@linux.intel.com>, <drake@endlessm.com>,
        <ravisadineni@chromium.org>, <joe@perches.com>
CC:     <prime.zeng@hisilicon.com>, Jonathan Corbet <corbet@lwn.net>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Thymo van Beers <thymovanbeers@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-usb@vger.kernel.org>
Subject: [PATCH v3] usb: hub: try old enumeration scheme first for high speed devices
Date:   Mon, 20 Aug 2018 18:04:39 +0800
Message-ID: <1534759484-44744-1-git-send-email-prime.zeng@hisilicon.com>
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
devices, and this is what Windows does since Windows 8.

Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
Changes in v2:
1. As suggested by Alan, mention in the commit log that this change is
follow what the Window does.
2. As suggested by Roger, update the kernel-parameter description.

Changes in v3:
1. Remove the blank line suggested by Alan.
2. Tag applied.

Acked-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Zeng Tao <prime.zeng@hisilicon.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ++-
 drivers/usb/core/hub.c                          | 4 +++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 533ff5c..95db23c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4453,7 +4453,8 @@
 
 	usbcore.old_scheme_first=
 			[USB] Start with the old device initialization
-			scheme (default 0 = off).
+			scheme,  applies only to low and full-speed devices
+			 (default 0 = off).
 
 	usbcore.usbfs_memory_mb=
 			[USB] Memory limit (in MB) for buffers allocated by
diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
index 1fb2668..003fac0 100644
--- a/drivers/usb/core/hub.c
+++ b/drivers/usb/core/hub.c
@@ -2660,11 +2660,13 @@ static bool use_new_scheme(struct usb_device *udev, int retry,
 {
 	int old_scheme_first_port =
 		port_dev->quirks & USB_PORT_QUIRK_OLD_SCHEME;
+	int quick_enumeration = (udev->speed == USB_SPEED_HIGH);
 
 	if (udev->speed >= USB_SPEED_SUPER)
 		return false;
 
-	return USE_NEW_SCHEME(retry, old_scheme_first_port || old_scheme_first);
+	return USE_NEW_SCHEME(retry, old_scheme_first_port || old_scheme_first
+			      || quick_enumeration);
 }
 
 /* Is a USB 3.0 port in the Inactive or Compliance Mode state?
-- 
2.7.4

