Return-Path: <SRS0=fRGm=MU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ACDAC65C20
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0FA62064A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Oct 2018 18:41:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNbgL/Z0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0FA62064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730105AbeJIBy6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Oct 2018 21:54:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:42494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729388AbeJIBy6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Oct 2018 21:54:58 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 78F2121479;
        Mon,  8 Oct 2018 18:41:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539024113;
        bh=Qab+PAM/0dm6uH3gkHC7+DUQEFJIeRLUon07ofbF/ac=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RNbgL/Z0H6utPNRm3jH9QgxEHnDrCdDsj7r4jLjgb2v2rtJh/0SiDEWKqAdytjYQ3
         HVgxSD8tYA3tm6atEDwNJlcE7UG0iay0oY+StjHok5qG3sra1xYdAL6cRJV2DRznvN
         db4ZBM4Ap/aglwaGCptvQx3Bp3M6r5G6xx87l5J4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 24/94] gpio: Fix crash due to registration race
Date:   Mon,  8 Oct 2018 20:31:05 +0200
Message-Id: <20181008175606.184668294@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20181008175605.067676667@linuxfoundation.org>
References: <20181008175605.067676667@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vincent Whitchurch <vincent.whitchurch@axis.com>

[ Upstream commit d49b48f088c323dbacae44dfbe56d9c985c8a2a1 ]

gpiochip_add_data_with_key() adds the gpiochip to the gpio_devices list
before of_gpiochip_add() is called, but it's only the latter which sets
the ->of_xlate function pointer.  gpiochip_find() can be called by
someone else between these two actions, and it can find the chip and
call of_gpiochip_match_node_and_xlate() which leads to the following
crash due to a NULL ->of_xlate().

 Unhandled prefetch abort: page domain fault (0x01b) at 0x00000000
 Modules linked in: leds_gpio(+) gpio_generic(+)
 CPU: 0 PID: 830 Comm: insmod Not tainted 4.18.0+ #43
 Hardware name: ARM-Versatile Express
 PC is at   (null)
 LR is at of_gpiochip_match_node_and_xlate+0x2c/0x38
 Process insmod (pid: 830, stack limit = 0x(ptrval))
  (of_gpiochip_match_node_and_xlate) from  (gpiochip_find+0x48/0x84)
  (gpiochip_find) from  (of_get_named_gpiod_flags+0xa8/0x238)
  (of_get_named_gpiod_flags) from  (gpiod_get_from_of_node+0x2c/0xc8)
  (gpiod_get_from_of_node) from  (devm_fwnode_get_index_gpiod_from_child+0xb8/0x144)
  (devm_fwnode_get_index_gpiod_from_child) from  (gpio_led_probe+0x208/0x3c4 [leds_gpio])
  (gpio_led_probe [leds_gpio]) from  (platform_drv_probe+0x48/0x9c)
  (platform_drv_probe) from  (really_probe+0x1d0/0x3d4)
  (really_probe) from  (driver_probe_device+0x78/0x1c0)
  (driver_probe_device) from  (__driver_attach+0x120/0x13c)
  (__driver_attach) from  (bus_for_each_dev+0x68/0xb4)
  (bus_for_each_dev) from  (bus_add_driver+0x1a8/0x268)
  (bus_add_driver) from  (driver_register+0x78/0x10c)
  (driver_register) from  (do_one_initcall+0x54/0x1fc)
  (do_one_initcall) from  (do_init_module+0x64/0x1f4)
  (do_init_module) from  (load_module+0x2198/0x26ac)
  (load_module) from  (sys_finit_module+0xe0/0x110)
  (sys_finit_module) from  (ret_fast_syscall+0x0/0x54)

One way to fix this would be to rework the hairy registration sequence
in gpiochip_add_data_with_key(), but since I'd probably introduce a
couple of new bugs if I attempted that, simply add a check for a
non-NULL of_xlate function pointer in
of_gpiochip_match_node_and_xlate().  This works since the driver looking
for the gpio will simply fail to find the gpio and defer its probe and
be reprobed when the driver which is registering the gpiochip has fully
completed its probe.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib-of.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpio/gpiolib-of.c
+++ b/drivers/gpio/gpiolib-of.c
@@ -31,6 +31,7 @@ static int of_gpiochip_match_node_and_xl
 	struct of_phandle_args *gpiospec = data;
 
 	return chip->gpiodev->dev.of_node == gpiospec->np &&
+				chip->of_xlate &&
 				chip->of_xlate(chip, gpiospec, NULL) >= 0;
 }
 


