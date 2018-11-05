Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2538C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5482B2085B
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 21:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DC0QAZM/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5482B2085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388119AbeKFGyp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 01:54:45 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:46560 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387628AbeKFGyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 01:54:45 -0500
Received: by mail-pf1-f193.google.com with SMTP id r64-v6so5032080pfb.13;
        Mon, 05 Nov 2018 13:33:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XHS8gkOFUvy4AC3AC6pIxVYKXEuWaPsDgcn2703bFBQ=;
        b=DC0QAZM/2Jdtxp2zcyXnvv9+42P0RU902rz3nU5/ClWbpRwMwydX/m5ma4YdgLtZi7
         oOcg/F8kLkN9ql1GHB98UbirWYVoPfkwPED9PwnTab3FWEcaDl/wC6eZ9GVGSxZSTIdA
         ipT6FUTScNbhu3E2U+keUbWkX6VYXRKGoRFnbADSvYdWrViQ5PLVaAcPOPE4gFpQUtXq
         iPGQnl/qYjp8AT0FmX5kb9QE4n8nTMUBkUsgvcxgeNA2iBbkDcRaT10+BjR7CPyst8Aa
         BCbIdO1X+tSpHX8oSWwOrPlasxksbNbHUOGra9EyyKfsXZS6JTaKjGsGM9O5RXO5iArM
         Egcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XHS8gkOFUvy4AC3AC6pIxVYKXEuWaPsDgcn2703bFBQ=;
        b=iQSEnR8cmPQKKvKQ3hZ5U6lBmRhLDIqg6xveTwPlv2ssYFtyC9ODt1z3a6sbJkUaRm
         RKGbk7FHtCYglruIVa83UzvoL5QXq7l8uMYXwO9p4U5aPRBaOzAwKyzgCqnXjEA8F390
         pgKW+1w63Cq2p33mr4uq58u6UOt58I3imqHPKsuY06Fs1l13r4ecPscNakHGGo3LaA8p
         b1Naq7VeXasWNjSvd9n0Py8Wd52JValgtFAMWyT2rJe9oTQcpKEBucUVmK58ZoGVJgRm
         INGkkfmj1wv7RtfCsPEKF03Be48OUmIBLssDDOO3WvOSqrANM2/jyGbmWais+bRbfbKC
         0lVQ==
X-Gm-Message-State: AGRZ1gKlo6IB+O3I71UnSSIGIinkC4WBqZsPMyit4bigvVUgdTKmmcvu
        8wGTm38/KMXCCCtxk7wMQyh/Usix9jc=
X-Google-Smtp-Source: AJdET5enw5kTkw2w/oWlBrr32UcYqcbdDxChR4Yu1FtUwaLpbANaXE0ZIxqCOWOd/zi4M+KsiYkXmQ==
X-Received: by 2002:a63:151f:: with SMTP id v31mr10637738pgl.34.1541453582643;
        Mon, 05 Nov 2018 13:33:02 -0800 (PST)
Received: from stbsrv-and-3.and.broadcom.com ([192.19.231.250])
        by smtp.gmail.com with ESMTPSA id m129-v6sm14328440pfm.78.2018.11.05.13.32.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Nov 2018 13:33:02 -0800 (PST)
From:   Al Cooper <alcooperx@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Al Cooper <alcooperx@gmail.com>,
        Alan Stern <stern@rowland.harvard.edu>,
        Alban Bedel <albeu@free.fr>, Alex Elder <elder@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Avi Fishman <avifishman70@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, Dmitry Osipenko <digetx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Hans de Goede <hdegoede@redhat.com>,
        James Hogan <jhogan@kernel.org>,
        Jianguo Sun <sunjianguo1@huawei.com>,
        Johan Hovold <johan@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-usb@vger.kernel.org,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Rishabh Bhatnagar <rishabhb@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>, Roger Quadros <rogerq@ti.com>
Subject: [PATCH V3 2/6] usb: core: Add ability to skip phy exit on suspend and init on resume
Date:   Mon,  5 Nov 2018 16:31:29 -0500
Message-Id: <1541453493-34981-3-git-send-email-alcooperx@gmail.com>
X-Mailer: git-send-email 1.9.0.138.g2de3478
In-Reply-To: <1541453493-34981-1-git-send-email-alcooperx@gmail.com>
References: <1541453493-34981-1-git-send-email-alcooperx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the ability to skip calling the PHY's exit routine on suspend
and the PHY's init routine on resume. This is to handle a USB PHY
that should have it's power_off function called on suspend but cannot
have it's exit function called because on exit it will disable the
PHY to the point where register accesses to the Host Controllers
using the PHY will be disabled and the host drivers will crash.

This is enabled with the HCD flag "suspend_without_phy_exit" which
can be set from any HCD driver.

Signed-off-by: Al Cooper <alcooperx@gmail.com>
---
 drivers/usb/core/hcd.c  |  8 ++++----
 drivers/usb/core/phy.c  | 18 ++++++++++++------
 drivers/usb/core/phy.h  |  9 ++++++---
 include/linux/usb/hcd.h |  3 +++
 4 files changed, 25 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index 487025d31d44..5ebc82a69403 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -2249,7 +2249,7 @@ int hcd_bus_suspend(struct usb_device *rhdev, pm_message_t msg)
 		hcd->state = HC_STATE_SUSPENDED;
 
 		if (!PMSG_IS_AUTO(msg))
-			usb_phy_roothub_suspend(hcd->self.sysdev,
+			usb_phy_roothub_suspend(hcd,
 						hcd->phy_roothub);
 
 		/* Did we race with a root-hub wakeup event? */
@@ -2290,7 +2290,7 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
 	}
 
 	if (!PMSG_IS_AUTO(msg)) {
-		status = usb_phy_roothub_resume(hcd->self.sysdev,
+		status = usb_phy_roothub_resume(hcd,
 						hcd->phy_roothub);
 		if (status)
 			return status;
@@ -2333,7 +2333,7 @@ int hcd_bus_resume(struct usb_device *rhdev, pm_message_t msg)
 		}
 	} else {
 		hcd->state = old_state;
-		usb_phy_roothub_suspend(hcd->self.sysdev, hcd->phy_roothub);
+		usb_phy_roothub_suspend(hcd, hcd->phy_roothub);
 		dev_dbg(&rhdev->dev, "bus %s fail, err %d\n",
 				"resume", status);
 		if (status != -ESHUTDOWN)
@@ -2730,7 +2730,7 @@ int usb_add_hcd(struct usb_hcd *hcd,
 	struct usb_device *rhdev;
 
 	if (!hcd->skip_phy_initialization && usb_hcd_is_primary_hcd(hcd)) {
-		hcd->phy_roothub = usb_phy_roothub_alloc(hcd->self.sysdev);
+		hcd->phy_roothub = usb_phy_roothub_alloc(hcd);
 		if (IS_ERR(hcd->phy_roothub))
 			return PTR_ERR(hcd->phy_roothub);
 
diff --git a/drivers/usb/core/phy.c b/drivers/usb/core/phy.c
index 38b2c776c4b4..308d716304da 100644
--- a/drivers/usb/core/phy.c
+++ b/drivers/usb/core/phy.c
@@ -46,10 +46,11 @@ static int usb_phy_roothub_add_phy(struct device *dev, int index,
 	return 0;
 }
 
-struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev)
+struct usb_phy_roothub *usb_phy_roothub_alloc(struct usb_hcd *hcd)
 {
 	struct usb_phy_roothub *phy_roothub;
 	int i, num_phys, err;
+	struct device *dev = hcd->self.sysdev;
 
 	if (!IS_ENABLED(CONFIG_GENERIC_PHY))
 		return NULL;
@@ -162,26 +163,30 @@ void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub)
 }
 EXPORT_SYMBOL_GPL(usb_phy_roothub_power_off);
 
-int usb_phy_roothub_suspend(struct device *controller_dev,
+int usb_phy_roothub_suspend(struct usb_hcd *hcd,
 			    struct usb_phy_roothub *phy_roothub)
 {
+	struct device *controller_dev = hcd->self.sysdev;
+
 	usb_phy_roothub_power_off(phy_roothub);
 
 	/* keep the PHYs initialized so the device can wake up the system */
-	if (device_may_wakeup(controller_dev))
+	if (device_may_wakeup(controller_dev) || hcd->suspend_without_phy_exit)
 		return 0;
 
 	return usb_phy_roothub_exit(phy_roothub);
 }
 EXPORT_SYMBOL_GPL(usb_phy_roothub_suspend);
 
-int usb_phy_roothub_resume(struct device *controller_dev,
+int usb_phy_roothub_resume(struct usb_hcd *hcd,
 			   struct usb_phy_roothub *phy_roothub)
 {
+	struct device *controller_dev = hcd->self.sysdev;
 	int err;
 
 	/* if the device can't wake up the system _exit was called */
-	if (!device_may_wakeup(controller_dev)) {
+	if (!device_may_wakeup(controller_dev) &&
+	    !hcd->suspend_without_phy_exit) {
 		err = usb_phy_roothub_init(phy_roothub);
 		if (err)
 			return err;
@@ -190,7 +195,8 @@ int usb_phy_roothub_resume(struct device *controller_dev,
 	err = usb_phy_roothub_power_on(phy_roothub);
 
 	/* undo _init if _power_on failed */
-	if (err && !device_may_wakeup(controller_dev))
+	if (err && !device_may_wakeup(controller_dev)
+	    && !hcd->suspend_without_phy_exit)
 		usb_phy_roothub_exit(phy_roothub);
 
 	return err;
diff --git a/drivers/usb/core/phy.h b/drivers/usb/core/phy.h
index 88a3c037e9df..34293e11a917 100644
--- a/drivers/usb/core/phy.h
+++ b/drivers/usb/core/phy.h
@@ -5,13 +5,16 @@
  * Copyright (C) 2018 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
  */
 
+#include <linux/usb.h>
+#include <linux/usb/hcd.h>
+
 #ifndef __USB_CORE_PHY_H_
 #define __USB_CORE_PHY_H_
 
 struct device;
 struct usb_phy_roothub;
 
-struct usb_phy_roothub *usb_phy_roothub_alloc(struct device *dev);
+struct usb_phy_roothub *usb_phy_roothub_alloc(struct usb_hcd *hcd);
 
 int usb_phy_roothub_init(struct usb_phy_roothub *phy_roothub);
 int usb_phy_roothub_exit(struct usb_phy_roothub *phy_roothub);
@@ -19,9 +22,9 @@
 int usb_phy_roothub_power_on(struct usb_phy_roothub *phy_roothub);
 void usb_phy_roothub_power_off(struct usb_phy_roothub *phy_roothub);
 
-int usb_phy_roothub_suspend(struct device *controller_dev,
+int usb_phy_roothub_suspend(struct usb_hcd *hcd,
 			    struct usb_phy_roothub *phy_roothub);
-int usb_phy_roothub_resume(struct device *controller_dev,
+int usb_phy_roothub_resume(struct usb_hcd *hcd,
 			   struct usb_phy_roothub *phy_roothub);
 
 #endif /* __USB_CORE_PHY_H_ */
diff --git a/include/linux/usb/hcd.h b/include/linux/usb/hcd.h
index 97e2ddec18b1..87a104055b5e 100644
--- a/include/linux/usb/hcd.h
+++ b/include/linux/usb/hcd.h
@@ -157,6 +157,9 @@ struct usb_hcd {
 	 */
 	unsigned		skip_phy_initialization:1;
 
+	/* Some phys don't want the phy's exit/init called on suspend/resume */
+	unsigned		suspend_without_phy_exit:1;
+
 	/* The next flag is a stopgap, to be removed when all the HCDs
 	 * support the new root-hub polling mechanism. */
 	unsigned		uses_new_polling:1;
-- 
1.9.0.138.g2de3478

