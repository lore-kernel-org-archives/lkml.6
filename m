Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0049C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85FD120844
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:17:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85FD120844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404814AbeHATEf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:04:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46542 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403856AbeHATEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:04:34 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A5095C96;
        Wed,  1 Aug 2018 17:17:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 123/246] rtc: vr41xx: fix possible race condition
Date:   Wed,  1 Aug 2018 18:50:33 +0200
Message-Id: <20180801165017.606022247@linuxfoundation.org>
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

[ Upstream commit 9a99247c9c1d1c95c6e8153d013979aac6111c6e ]

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
 drivers/rtc/rtc-vr41xx.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/drivers/rtc/rtc-vr41xx.c
+++ b/drivers/rtc/rtc-vr41xx.c
@@ -292,13 +292,14 @@ static int rtc_probe(struct platform_dev
 		goto err_rtc1_iounmap;
 	}
 
-	rtc = devm_rtc_device_register(&pdev->dev, rtc_name, &vr41xx_rtc_ops,
-					THIS_MODULE);
+	rtc = devm_rtc_allocate_device(&pdev->dev);
 	if (IS_ERR(rtc)) {
 		retval = PTR_ERR(rtc);
 		goto err_iounmap_all;
 	}
 
+	rtc->ops = &vr41xx_rtc_ops;
+
 	rtc->max_user_freq = MAX_PERIODIC_RATE;
 
 	spin_lock_irq(&rtc_lock);
@@ -340,6 +341,10 @@ static int rtc_probe(struct platform_dev
 
 	dev_info(&pdev->dev, "Real Time Clock of NEC VR4100 series\n");
 
+	retval = rtc_register_device(rtc);
+	if (retval)
+		goto err_iounmap_all;
+
 	return 0;
 
 err_iounmap_all:


