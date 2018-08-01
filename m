Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2964C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:17:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7570920844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:17:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7570920844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404799AbeHATEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:04:31 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46526 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404073AbeHATEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:04:31 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A16DBC96;
        Wed,  1 Aug 2018 17:17:50 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 122/246] rtc: tps6586x: fix possible race condition
Date:   Wed,  1 Aug 2018 18:50:32 +0200
Message-Id: <20180801165017.557005824@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165011.700991984@linuxfoundation.org>
References: <20180801165011.700991984@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

[ Upstream commit 63d22063073b0ab46d1e06fe633fb5de8f5c58e1 ]

The probe function is not allowed to fail after the RTC is registered
because the following may happen:

CPU0:                                CPU1:
sys_load_module()
 do_init_module()
  do_one_initcall()
   cmos_do_probe()
    rtc_device_register()
     __register_chrdev()
     cdev->owner = struct module*
                                     open("/dev/rtc0")
    rtc_device_unregister()
  module_put()
  free_module()
   module_free(mod->module_core)
   /* struct module *module is now
      freed */
                                      chrdev_open()
                                       spin_lock(cdev_lock)
                                       cdev_get()
                                        try_module_get()
                                         module_is_live()
                                         /* dereferences already
                                            freed struct module* */

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/rtc/rtc-tps6586x.c |   14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

--- a/drivers/rtc/rtc-tps6586x.c
+++ b/drivers/rtc/rtc-tps6586x.c
@@ -276,14 +276,15 @@ static int tps6586x_rtc_probe(struct pla
 	device_init_wakeup(&pdev->dev, 1);
 
 	platform_set_drvdata(pdev, rtc);
-	rtc->rtc = devm_rtc_device_register(&pdev->dev, dev_name(&pdev->dev),
-				       &tps6586x_rtc_ops, THIS_MODULE);
+	rtc->rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc->rtc)) {
 		ret = PTR_ERR(rtc->rtc);
-		dev_err(&pdev->dev, "RTC device register: ret %d\n", ret);
+		dev_err(&pdev->dev, "RTC allocate device: ret %d\n", ret);
 		goto fail_rtc_register;
 	}
 
+	rtc->rtc->ops = &tps6586x_rtc_ops;
+
 	ret = devm_request_threaded_irq(&pdev->dev, rtc->irq, NULL,
 				tps6586x_rtc_irq,
 				IRQF_ONESHOT,
@@ -294,6 +295,13 @@ static int tps6586x_rtc_probe(struct pla
 		goto fail_rtc_register;
 	}
 	disable_irq(rtc->irq);
+
+	ret = rtc_register_device(rtc->rtc);
+	if (ret) {
+		dev_err(&pdev->dev, "RTC device register: ret %d\n", ret);
+		goto fail_rtc_register;
+	}
+
 	return 0;
 
 fail_rtc_register:


