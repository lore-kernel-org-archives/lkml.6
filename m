Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5DADC5CFFE
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 686712084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545122;
	bh=FaOTbTADZxDrgIPfhUlRIj+iHdFPaOBFueU/Zkf0Eyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yR5B/CGjP2MzkLnF7K932FM+OXcsC4LbV3Nm0bbp8ANEq3QPdWoDD/muNO/boaWzJ
	 mqgy0YcxbvwgDs1Ag/jfaBqVbjdktV5Xte15iyERRbXNlCXYdbVES3juj+xsAJeZNc
	 Em/4k6i3IMAtrsWXWJFbUZuZ2uIzmI46QNxHdmyc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 686712084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729308AbeLKQSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 11:18:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:34820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727512AbeLKPqY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:46:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4626D2087F;
        Tue, 11 Dec 2018 15:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543183;
        bh=FaOTbTADZxDrgIPfhUlRIj+iHdFPaOBFueU/Zkf0Eyg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AK3RK4dG1pxuRN4fC4uT1jpdvR4nzvmJIQNjCd0wt0c4BUEQRNnSlU9Ize4Vz5DgM
         LxlFo52RQtB7sbiCYSLa+C3hogLEZjwgxaG34is+4pEanUiiGU2SLiEIPQn8B4Yfa/
         op4nag52f5faD7qruscMnfic0tWJWNz0NegNLd4w=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, linux-leds@vger.kernel.org,
        Milo Kim <milo.kim@ti.com>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4.4 43/91] leds: turn off the LED and wait for completion on unregistering LED class device
Date:   Tue, 11 Dec 2018 16:41:02 +0100
Message-Id: <20181211151609.493252715@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151606.026852373@linuxfoundation.org>
References: <20181211151606.026852373@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Milo Kim <milo.kim@ti.com>

commit d1aa577f5e191d77d3ad62da93729b5af9532bb4 upstream.

Workqueue, 'set_brightness_work' is used for scheduling brightness control.
This workqueue is canceled when the LED class device is unregistered.
Currently, LED subsystem handles like below.

  cancel_work_sync(&led_cdev->set_brightness_work)
  led_set_brightness(led_cdev, LED_OFF)

However, this could be a problem.
Workqueue is going to be canceled but LED device needs to be off.
The worst case is null pointer access due to scheduling a workqueue.

LED module is loaded.
  LED driver private data is allocated by using devm_zalloc().

LED module is unloaded.
  led_classdev_unregister() is called.
    cancel_work_sync()
      led_set_brightness(led_cdev, LED_OFF)
        schedule_work() if LED driver uses brightness_set_blocking()
        In the meantime, driver private data will be freed.

        ..scheduling..

        brightness_set_blocking() callback is invoked.
          For the brightness control, LED driver tries to access private
          data but resource is removed!

To avoid this problem, LED subsystem should turn off the brightness first
and wait for completion.

  led_set_brightness(led_cdev, LED_OFF)
  flush_work(&led_cdev->set_brightness_work)

It guarantees that LED driver turns off the brightness prior to
resource management.

Cc: linux-leds@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Milo Kim <milo.kim@ti.com>
Signed-off-by: Jacek Anaszewski <j.anaszewski@samsung.com>
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/leds/led-class.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -247,12 +247,13 @@ void led_classdev_unregister(struct led_
 	up_write(&led_cdev->trigger_lock);
 #endif
 
-	cancel_work_sync(&led_cdev->set_brightness_work);
-
 	/* Stop blinking */
 	led_stop_software_blink(led_cdev);
+
 	led_set_brightness(led_cdev, LED_OFF);
 
+	flush_work(&led_cdev->set_brightness_work);
+
 	device_unregister(led_cdev->dev);
 
 	down_write(&leds_list_lock);


