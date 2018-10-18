Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E939DC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:19:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BAE9D208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 16:19:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAE9D208E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728471AbeJSAVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 20:21:25 -0400
Received: from mailout.easymail.ca ([64.68.200.34]:58112 "EHLO
        mailout.easymail.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727473AbeJSAVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 20:21:25 -0400
Received: from localhost (localhost [127.0.0.1])
        by mailout.easymail.ca (Postfix) with ESMTP id 00367C1A8F;
        Thu, 18 Oct 2018 16:19:42 +0000 (UTC)
Received: from mailout.easymail.ca ([127.0.0.1])
        by localhost (emo01-pco.easydns.vpn [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CcEtXGpUy1YU; Thu, 18 Oct 2018 16:19:41 +0000 (UTC)
Received: from localhost.localdomain (c-24-9-64-241.hsd1.co.comcast.net [24.9.64.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mailout.easymail.ca (Postfix) with ESMTPSA id B5D9AC0DDD;
        Thu, 18 Oct 2018 16:19:31 +0000 (UTC)
From:   "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
To:     shuah@kernel.org, valentina.manea.m@gmail.com,
        gregkh@linuxfoundation.org, rdunlap@infradead.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH] usbip:vudc: BUG kmalloc-2048 (Not tainted): Poison overwritten
Date:   Thu, 18 Oct 2018 10:19:29 -0600
Message-Id: <20181018161929.9330-1-shuah@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In rmmod path, usbip_vudc does platform_device_put() twice once from
platform_device_unregister() and then from put_vudc_device().

The second put results in:

BUG kmalloc-2048 (Not tainted): Poison overwritten error or
BUG: KASAN: use-after-free in kobject_put+0x1e/0x230 if KASAN is
enabled.

[  169.042156] calling  init+0x0/0x1000 [usbip_vudc] @ 1697
[  169.042396] =============================================================================
[  169.043678] probe of usbip-vudc.0 returned 1 after 350 usecs
[  169.044508] BUG kmalloc-2048 (Not tainted): Poison overwritten
[  169.044509] -----------------------------------------------------------------------------
...
[  169.057849] INFO: Freed in device_release+0x2b/0x80 age=4223 cpu=3 pid=1693
[  169.057852] 	kobject_put+0x86/0x1b0
[  169.057853] 	0xffffffffc0c30a96
[  169.057855] 	__x64_sys_delete_module+0x157/0x240

Fix it to call platform_device_del() instead and let put_vudc_device() do
the platform_device_put().

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Shuah Khan (Samsung OSG) <shuah@kernel.org>
Cc: <stable@vger.kernel.org>
---
 drivers/usb/usbip/vudc_main.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/usbip/vudc_main.c b/drivers/usb/usbip/vudc_main.c
index 3fc22037a82f..390733e6937e 100644
--- a/drivers/usb/usbip/vudc_main.c
+++ b/drivers/usb/usbip/vudc_main.c
@@ -73,6 +73,10 @@ static int __init init(void)
 cleanup:
 	list_for_each_entry_safe(udc_dev, udc_dev2, &vudc_devices, dev_entry) {
 		list_del(&udc_dev->dev_entry);
+		/*
+		 * Just do platform_device_del() here, put_vudc_device()
+		 * calls the platform_device_put()
+		 */
 		platform_device_del(udc_dev->pdev);
 		put_vudc_device(udc_dev);
 	}
@@ -89,7 +93,11 @@ static void __exit cleanup(void)
 
 	list_for_each_entry_safe(udc_dev, udc_dev2, &vudc_devices, dev_entry) {
 		list_del(&udc_dev->dev_entry);
-		platform_device_unregister(udc_dev->pdev);
+		/*
+		 * Just do platform_device_del() here, put_vudc_device()
+		 * calls the platform_device_put()
+		 */
+		platform_device_del(udc_dev->pdev);
 		put_vudc_device(udc_dev);
 	}
 	platform_driver_unregister(&vudc_driver);
-- 
2.17.0

