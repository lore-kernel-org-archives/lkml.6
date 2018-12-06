Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD48C04EB9
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:47:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72E0321479
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 09:47:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544089656;
	bh=d6frsl1WUEG3b4bsDXOrEnCpDqn8IdVqqQ7NLJDphb0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=LKmFsPvWosYJb7RDTkpuqJr8/nZ1FXw1OdPbpoc431GottKsxlOdjUfXavmype8nq
	 Z4m80gvyv8ynsAfSU8Shp5IKJ02una5T5dMA3fPZK/YrWI9/6jCysIHTt3bUQAMvpB
	 u/TZZqnLSoYbOhuALvhevL9k3UnR2oq6/4oQe5O8=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72E0321479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729255AbeLFJrf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 04:47:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:55394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727806AbeLFJre (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 04:47:34 -0500
Received: from PC-kkoz.proceq.com (unknown [213.160.61.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DF04F21479;
        Thu,  6 Dec 2018 09:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544089654;
        bh=d6frsl1WUEG3b4bsDXOrEnCpDqn8IdVqqQ7NLJDphb0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qa4PEAcYpmw8y+LTx1L/osU7RUyi5t/1EsCIFlB3E71ztWolvZtkKEjJC9NAapg1l
         PTIyUhucCIZIqF6foQs+AzeiQuM3gLuxhmweoR7ygdjjQUj3SOu8/Ei5C/2ytaNLwQ
         mPgkgqXSr1TEK3g538sFQx2GLPChKvLt6QYiRJBg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     stable@vger.kernel.org
Cc:     Milo Kim <milo.kim@ti.com>, linux-leds@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH stable v4.4+ 2/3] leds: turn off the LED and wait for completion on unregistering LED class device
Date:   Thu,  6 Dec 2018 10:47:01 +0100
Message-Id: <1544089622-23982-2-git-send-email-krzk@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544089622-23982-1-git-send-email-krzk@kernel.org>
References: <1544089622-23982-1-git-send-email-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 drivers/leds/led-class.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/led-class.c b/drivers/leds/led-class.c
index 7385f98dd54b..51a5b51ec467 100644
--- a/drivers/leds/led-class.c
+++ b/drivers/leds/led-class.c
@@ -247,12 +247,13 @@ void led_classdev_unregister(struct led_classdev *led_cdev)
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
-- 
2.7.4

