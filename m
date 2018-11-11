Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A61C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A293D20869
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 23:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFTL88rZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A293D20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389433AbeKLJN0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Nov 2018 04:13:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:47214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732997AbeKLIU5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Nov 2018 03:20:57 -0500
Received: from localhost (unknown [206.108.79.134])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A7D152154B;
        Sun, 11 Nov 2018 22:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541975460;
        bh=4ox2pdzwi/YgtRuqv/EVs6suGYe/+od/lL1bOt922GE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HFTL88rZ1g8I2Yv14rF34QK3GT+6yG4VHxQeo49InSS2RXn3ILxoxIpLoG5Cm5zMs
         VBrUikfKShhJLRSnPCcYBT0glvRVgAIfeRptACJFilLpyim54BkwACLzzSnHmmD+H/
         TznDmffVEsa6lBJy2zbB3GwFPhuOwnVhroSFIZ3M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
        "Shuah Khan (Samsung OSG)" <shuah@kernel.org>
Subject: [PATCH 4.18 204/350] usbip:vudc: BUG kmalloc-2048 (Not tainted): Poison overwritten
Date:   Sun, 11 Nov 2018 14:21:08 -0800
Message-Id: <20181111221716.572436851@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181111221707.043394111@linuxfoundation.org>
References: <20181111221707.043394111@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Shuah Khan (Samsung OSG) <shuah@kernel.org>

commit e28fd56ad5273be67d0fae5bedc7e1680e729952 upstream.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/usb/usbip/vudc_main.c |   10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

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


