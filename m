Return-Path: <SRS0=wzyR=PL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E5DC43387
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACA002073D
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Jan 2019 07:36:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730021AbfACHgI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Jan 2019 02:36:08 -0500
Received: from mga17.intel.com ([192.55.52.151]:37686 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfACHgH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Jan 2019 02:36:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Jan 2019 23:36:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,434,1539673200"; 
   d="scan'208";a="103571346"
Received: from rfried-ivm1.ger.corp.intel.com (HELO [10.185.130.184]) ([10.185.130.184])
  by orsmga007.jf.intel.com with ESMTP; 02 Jan 2019 23:36:05 -0800
To:     linus.walleij@linaro.org, bgolaszewski@baylibre.com,
        linux-gpio@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, vladimir.kondratiev@linux.intel.com
From:   "Fried, Ramon" <ramon.fried@linux.intel.com>
Subject: RFC: gpio: mmio: add support for 3 direction regs
Message-ID: <32edfd70-95dc-26a1-2ea6-143344cb2384@linux.intel.com>
Date:   Thu, 3 Jan 2019 09:36:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.3
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

I'm working on a driver for STA2X11 GPIO controller who seems to fit best to the generic mmio driver,
the only problem I have is with the dir register case.
The STA2X11 has 3 registers for dir, one for data, one for set and one for clear.
The generic-mmio driver has support for this fashion for the dat & set & clear registers but not for dirout/dirin registers.

I wonder if support for this is generic enough to deserve a patch, if so I'm willing to quickly add this support, if not, adding a flag such as below, will allow partly using the generic mmio driver only for set/get and the direction can be handled outside the driver.

Thanks,
Ramon

diff --git a/include/linux/gpio/driver.h b/include/linux/gpio/driver.h
index a4d5eb3..4f91526 100644
--- a/include/linux/gpio/driver.h
+++ b/include/linux/gpio/driver.h
@@ -435,6 +435,7 @@ int bgpio_init(struct gpio_chip *gc, struct device *dev,
 #define BGPIOF_BIG_ENDIAN_BYTE_ORDER   BIT(3)
 #define BGPIOF_READ_OUTPUT_REG_SET     BIT(4) /* reg_set stores output value */
 #define BGPIOF_NO_OUTPUT               BIT(5) /* only input */
+#define BGPIOF_NO_DIRECTION            BIT(6)
 
 #endif

diff --git a/drivers/gpio/gpio-mmio.c b/drivers/gpio/gpio-mmio.c
index 935292a..66f6448 100644
--- a/drivers/gpio/gpio-mmio.c
+++ b/drivers/gpio/gpio-mmio.c
@@ -554,6 +554,8 @@ static int bgpio_setup_direction(struct gpio_chip *gc,
                gc->direction_input = bgpio_dir_in;
                gc->get_direction = bgpio_get_dir;
                gc->bgpio_dir_inverted = true;
+       } else if (flags & BGPIOF_NO_DIRECTION) {
+               return 0;
        } else {
                if (flags & BGPIOF_NO_OUTPUT)
                        gc->direction_output = bgpio_dir_out_err;
@@ -638,7 +640,7 @@ int bgpio_init(struct gpio_chip *gc, struct device *dev,
        if (gc->set == bgpio_set_set &&
                        !(flags & BGPIOF_UNREADABLE_REG_SET))
                gc->bgpio_data = gc->read_reg(gc->reg_set);
-       if (gc->reg_dir && !(flags & BGPIOF_UNREADABLE_REG_DIR))
+       if (gc->reg_dir && !(flags & (BGPIOF_UNREADABLE_REG_DIR | BGPIOF_NO_DIRECTION)))
                gc->bgpio_dir = gc->read_reg(gc->reg_dir);
 
        return ret;

