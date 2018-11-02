Return-Path: <SRS0=zRJA=NN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBE74C65C22
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2B802084D
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Nov 2018 18:42:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDCL/oR/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2B802084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbeKCDuc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Nov 2018 23:50:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:45568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728033AbeKCDuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Nov 2018 23:50:32 -0400
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFFD120847;
        Fri,  2 Nov 2018 18:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541184139;
        bh=useNEBlnSyPDuFcxlgutFp/7Sqs9+3TG8NHPs8EfRl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PDCL/oR/myVKTf8sfeUXF5AuyWCt0KCCSbNzEUL13xThSqi6qRRGDBawI97ldv3rZ
         B2joWhN1HLKmEJ7tYMaI7HCW1FVwD2FHW2cddiXr0reLj1X7+3zbEc6Ah5Z5JrF1Yw
         u2YMJhC9KDHu1/Ow+mNO7rGms/M2Ei4XwLSng500=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Evan Green <evgreen@chromium.org>,
        Thierry Reding <treding@nvidia.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.18 091/150] gpio: Assign gpio_irq_chip::parents to non-stack pointer
Date:   Fri,  2 Nov 2018 19:34:13 +0100
Message-Id: <20181102182909.816176244@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181102182902.250560510@linuxfoundation.org>
References: <20181102182902.250560510@linuxfoundation.org>
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

[ Upstream commit 3e779a2e7f909015f21428b66834127496110b6d ]

gpiochip_set_cascaded_irqchip() is passed 'parent_irq' as an argument
and then the address of that argument is assigned to the gpio chips
gpio_irq_chip 'parents' pointer shortly thereafter. This can't ever
work, because we've just assigned some stack address to a pointer that
we plan to dereference later in gpiochip_irq_map(). I ran into this
issue with the KASAN report below when gpiochip_irq_map() tried to setup
the parent irq with a total junk pointer for the 'parents' array.

BUG: KASAN: stack-out-of-bounds in gpiochip_irq_map+0x228/0x248
Read of size 4 at addr ffffffc0dde472e0 by task swapper/0/1

CPU: 7 PID: 1 Comm: swapper/0 Not tainted 4.14.72 #34
Call trace:
[<ffffff9008093638>] dump_backtrace+0x0/0x718
[<ffffff9008093da4>] show_stack+0x20/0x2c
[<ffffff90096b9224>] __dump_stack+0x20/0x28
[<ffffff90096b91c8>] dump_stack+0x80/0xbc
[<ffffff900845a350>] print_address_description+0x70/0x238
[<ffffff900845a8e4>] kasan_report+0x1cc/0x260
[<ffffff900845aa14>] __asan_report_load4_noabort+0x2c/0x38
[<ffffff900897e098>] gpiochip_irq_map+0x228/0x248
[<ffffff900820cc08>] irq_domain_associate+0x114/0x2ec
[<ffffff900820d13c>] irq_create_mapping+0x120/0x234
[<ffffff900820da78>] irq_create_fwspec_mapping+0x4c8/0x88c
[<ffffff900820e2d8>] irq_create_of_mapping+0x180/0x210
[<ffffff900917114c>] of_irq_get+0x138/0x198
[<ffffff9008dc70ac>] spi_drv_probe+0x94/0x178
[<ffffff9008ca5168>] driver_probe_device+0x51c/0x824
[<ffffff9008ca6538>] __device_attach_driver+0x148/0x20c
[<ffffff9008ca14cc>] bus_for_each_drv+0x120/0x188
[<ffffff9008ca570c>] __device_attach+0x19c/0x2dc
[<ffffff9008ca586c>] device_initial_probe+0x20/0x2c
[<ffffff9008ca18bc>] bus_probe_device+0x80/0x154
[<ffffff9008c9b9b4>] device_add+0x9b8/0xbdc
[<ffffff9008dc7640>] spi_add_device+0x1b8/0x380
[<ffffff9008dcbaf0>] spi_register_controller+0x111c/0x1378
[<ffffff9008dd6b10>] spi_geni_probe+0x4dc/0x6f8
[<ffffff9008cab058>] platform_drv_probe+0xdc/0x130
[<ffffff9008ca5168>] driver_probe_device+0x51c/0x824
[<ffffff9008ca59cc>] __driver_attach+0x100/0x194
[<ffffff9008ca0ea8>] bus_for_each_dev+0x104/0x16c
[<ffffff9008ca58c0>] driver_attach+0x48/0x54
[<ffffff9008ca1edc>] bus_add_driver+0x274/0x498
[<ffffff9008ca8448>] driver_register+0x1ac/0x230
[<ffffff9008caaf6c>] __platform_driver_register+0xcc/0xdc
[<ffffff9009c4b33c>] spi_geni_driver_init+0x1c/0x24
[<ffffff9008084cb8>] do_one_initcall+0x240/0x3dc
[<ffffff9009c017d0>] kernel_init_freeable+0x378/0x468
[<ffffff90096e8240>] kernel_init+0x14/0x110
[<ffffff9008086fcc>] ret_from_fork+0x10/0x18

The buggy address belongs to the page:
page:ffffffbf037791c0 count:0 mapcount:0 mapping:          (null) index:0x0
flags: 0x4000000000000000()
raw: 4000000000000000 0000000000000000 0000000000000000 00000000ffffffff
raw: ffffffbf037791e0 ffffffbf037791e0 0000000000000000 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffffffc0dde47180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffc0dde47200: f1 f1 f1 f1 f8 f8 f8 f8 f8 f8 f8 f8 f8 f8 f2 f2
>ffffffc0dde47280: f2 f2 00 00 00 00 00 00 00 00 00 00 f3 f3 f3 f3
                                                       ^
 ffffffc0dde47300: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
 ffffffc0dde47380: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00

Let's leave around one unsigned int in the gpio_irq_chip struct for the
single parent irq case and repoint the 'parents' array at it. This way
code is left mostly intact to setup parents and we waste an extra few
bytes per structure of which there should be only a handful in a system.

Cc: Evan Green <evgreen@chromium.org>
Cc: Thierry Reding <treding@nvidia.com>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>
Fixes: e0d897289813 ("gpio: Implement tighter IRQ chip integration")
Signed-off-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib.c      | 3 ++-
 include/linux/gpio/driver.h | 7 +++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 06dce16e22bb..70f0dedca59f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1675,7 +1675,8 @@ static void gpiochip_set_cascaded_irqchip(struct gpio_chip *gpiochip,
 		irq_set_chained_handler_and_data(parent_irq, parent_handler,
 						 gpiochip);
 
-		gpiochip->irq.parents = &parent_irq;
+		gpiochip->irq.parent_irq = parent_irq;
+		gpiochip->irq.parents = &gpiochip->irq.parent_irq;
 		gpiochip->irq.num_parents = 1;
 	}
 
diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index 5382b5183b7e..82a953ec5ef0 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -94,6 +94,13 @@ struct gpio_irq_chip {
 	 */
 	unsigned int num_parents;
 
+	/**
+	 * @parent_irq:
+	 *
+	 * For use by gpiochip_set_cascaded_irqchip()
+	 */
+	unsigned int parent_irq;
+
 	/**
 	 * @parents:
 	 *
-- 
2.17.1



