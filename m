Return-Path: <SRS0=kg8+=LP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45EA4C433F5
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:55:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E81612083C
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Sep 2018 09:55:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E81612083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeIAOG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 1 Sep 2018 10:06:57 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:59041 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeIAOG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Sep 2018 10:06:57 -0400
Received: from localhost.localdomain ([37.4.249.97]) by
 mrelayeu.kundenserver.de (mreue005 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 0MWvfk-1gRrGS011o-00VvQg; Sat, 01 Sep 2018 11:55:24 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Minas Harutyunyan <hminas@synopsys.com>
Cc:     Grigor Tovmasyan <Grigor.Tovmasyan@synopsys.com>,
        Doug Anderson <dianders@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH RFC] usb: dwc2: power off during shutdown
Date:   Sat,  1 Sep 2018 11:54:43 +0200
Message-Id: <1535795683-3788-1-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
X-Provags-ID: V03:K1:lhWb0c7tRDlcd5BUqoleY7Hm7WY8JzIMmtTEZGl82jExTQ1iLMg
 h9lp6N0x2vWgppAE/GZpnwmXvuBLo4pY9pVD+iZtzbzNP9OqHAS+5RnIcQDTqg06bODx8Zn
 EIaARlgBZGGEsof/I4ogQE1YrgWE7ezNgh8z+snWVRqiAxu9dyqmnpFkO0Tb2iOYdDrzz4J
 sQQ2ywp+ztdFwfQO3YJ1Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:xu9gm5u9V/s=:2hQu1ob2D9LIlkrPUxlJWv
 eauCUBfcGgmSJx74WOKvqNplDBwyhQS2Xq4zasulkC8KyR8jg9w1ihJVSRU4f+q+XeUJESbjt
 fQ3LyAT5/zuQJNmY2ZPYcxIu/QFe64dAwYuK68Bc1OWFI7BoiviofcBPnHeg1f93vxqON+kne
 de3FcI+krsRNYXdXok3kSy0FV51Y21cfSg4cM7nD5BJd17qy0q6Zjp61XIkha47f3DtD6EnjD
 KdPmyyaj5hLddp626I+xudUCeKu8yt0YAxPWX1BQ43C93/vkwJP+PjO26oBVgqGBx352+v49m
 wPLaBQJcgiTJB2/zfmOAdAqY67mQCIY1hwZwwK6ygvQ2KZcFwEAhD2DdiD9uuKuO4sK+52T/B
 N30gmek6SqfpgrgD9FTXADRQOP6oDF/18FLMp5e99dSzmQLtWolNtzv9Raiq4UObTwGFoJr4s
 OJ87YSof6ndoG9ugrn9aFF/mY3jEz8GJ7prWuD28+3LwyWDDffVGDVOqCn0YNK58s1OYck3T9
 5uET9R9fG9/GmmVAGgitdegIDeLNJbX1Tv5mPqblP4bBrVig/004d2GUk4kV0lCafwefc4FUY
 oGKjxSju1N/nw9ygm7QK74sC1SgrH3k0rDZggCYIZCGDaiBsUlRJx57tRqhNUKeFlAjmrYizG
 RFsXCpeT7h5PEBU/bzxF/SzYPRbbRUYV+ORSudDx2K4JtlPQ3qfM7YYd6Zy/Kk/Nvd4U=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently USB consumes a lot of power after shutting down a Raspberry Pi 3
(example setup with Ethernet and a keyboard connected). So power off
USB on shutdown.

Measured on Raspberry Pi 3B with 4.19rc1/multi_v7_defconfig (HDMI, Ethernet
and a keyboard connected)

Before patch: 2.450 W
After patch:  2.090 W

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
---
 drivers/usb/dwc2/platform.c | 31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 9a53a58..eeba40a 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -304,17 +304,11 @@ static int dwc2_lowlevel_hw_init(struct dwc2_hsotg *hsotg)
 }
 
 /**
- * dwc2_driver_remove() - Called when the DWC_otg core is unregistered with the
- * DWC_otg driver
+ * dwc2_driver_shutdown() - Called on device shutdown
  *
  * @dev: Platform device
- *
- * This routine is called, for example, when the rmmod command is executed. The
- * device may or may not be electrically present. If it is present, the driver
- * stops device processing. Any resources used on behalf of this device are
- * freed.
  */
-static int dwc2_driver_remove(struct platform_device *dev)
+static void dwc2_driver_shutdown(struct platform_device *dev)
 {
 	struct dwc2_hsotg *hsotg = platform_get_drvdata(dev);
 
@@ -329,27 +323,24 @@ static int dwc2_driver_remove(struct platform_device *dev)
 
 	reset_control_assert(hsotg->reset);
 	reset_control_assert(hsotg->reset_ecc);
-
-	return 0;
 }
 
 /**
- * dwc2_driver_shutdown() - Called on device shutdown
+ * dwc2_driver_remove() - Called when the DWC_otg core is unregistered with the
+ * DWC_otg driver
  *
  * @dev: Platform device
  *
- * In specific conditions (involving usb hubs) dwc2 devices can create a
- * lot of interrupts, even to the point of overwhelming devices running
- * at low frequencies. Some devices need to do special clock handling
- * at shutdown-time which may bring the system clock below the threshold
- * of being able to handle the dwc2 interrupts. Disabling dwc2-irqs
- * prevents reboots/poweroffs from getting stuck in such cases.
+ * This routine is called, for example, when the rmmod command is executed. The
+ * device may or may not be electrically present. If it is present, the driver
+ * stops device processing. Any resources used on behalf of this device are
+ * freed.
  */
-static void dwc2_driver_shutdown(struct platform_device *dev)
+static int dwc2_driver_remove(struct platform_device *dev)
 {
-	struct dwc2_hsotg *hsotg = platform_get_drvdata(dev);
+	dwc2_driver_shutdown(dev);
 
-	disable_irq(hsotg->irq);
+	return 0;
 }
 
 /**
-- 
2.7.4

