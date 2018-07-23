Return-Path: <SRS0=ZsYk=KH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F330CECDE5F
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:28:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF7E020846
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Jul 2018 10:28:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF7E020846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388347AbeGWL2v (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Jul 2018 07:28:51 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:38550 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387906AbeGWL2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jul 2018 07:28:51 -0400
Received: from 1-161-144-158.dynamic-ip.hinet.net ([1.161.144.158] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1fhY4f-0002V4-Mb; Mon, 23 Jul 2018 10:28:18 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     arnd@arndb.de, gregkh@linuxfoundation.org
Cc:     ulf.hansson@linaro.org, stern@rowland.harvard.edu,
        bauer.chen@realtek.com, ricky_wu@realtek.com,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 5/5] misc: rtsx_usb: / memstick: rtsx_usb_ms: Avoid long delay before system suspend
Date:   Mon, 23 Jul 2018 18:27:44 +0800
Message-Id: <20180723102744.15140-6-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180723102744.15140-1-kai.heng.feng@canonical.com>
References: <20180723102744.15140-1-kai.heng.feng@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's a long power-on delay at the end of rtsx_usb_ms_set_param().
This delay is noticeable right before system suspend.

To prevent already suspended memstick host from getting powered on by PM
core, use DPM_FLAG_SMART_SUSPEND to avoid the situation.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/memstick/host/rtsx_usb_ms.c | 4 ++++
 drivers/misc/cardreader/rtsx_usb.c  | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/memstick/host/rtsx_usb_ms.c b/drivers/memstick/host/rtsx_usb_ms.c
index 622497554a5a..85eaf688962f 100644
--- a/drivers/memstick/host/rtsx_usb_ms.c
+++ b/drivers/memstick/host/rtsx_usb_ms.c
@@ -772,6 +772,10 @@ static int rtsx_usb_ms_drv_probe(struct platform_device *pdev)
 	msh->set_param = rtsx_usb_ms_set_param;
 	msh->caps = MEMSTICK_CAP_PAR4;
 
+	/* DPM_FLAG_LEAVE_SUSPENDED is not needed, the parent device will wake
+	 * up memstick host.
+	 */
+	dev_pm_set_driver_flags(&pdev->dev, DPM_FLAG_SMART_SUSPEND);
 	pm_runtime_set_active(ms_dev(host));
 	pm_runtime_enable(ms_dev(host));
 
diff --git a/drivers/misc/cardreader/rtsx_usb.c b/drivers/misc/cardreader/rtsx_usb.c
index fed83453e5c5..3c1942f9653f 100644
--- a/drivers/misc/cardreader/rtsx_usb.c
+++ b/drivers/misc/cardreader/rtsx_usb.c
@@ -671,6 +671,7 @@ static int rtsx_usb_probe(struct usb_interface *intf,
 		goto out_init_fail;
 
 #ifdef CONFIG_PM
+	dev_pm_set_driver_flags(&intf->dev, DPM_FLAG_SMART_SUSPEND | DPM_FLAG_LEAVE_SUSPENDED);
 	intf->needs_remote_wakeup = 1;
 	usb_enable_autosuspend(usb_dev);
 #endif
-- 
2.17.1

