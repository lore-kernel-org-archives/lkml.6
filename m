Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD28AC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF7121903
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 14:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550498409;
	bh=ZiLYm00Y9WbTe6RWU/9F+/Xl5JToCuaSPKpCwtonAXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=NlWRow685/V1H9JGvKVrkPMXEuSb47EXsY4Cab1ni1LfKfcgCsEcXQdF6RfLYT0os
	 rHpHJUyzy7xzo6AknivrZCAhbCYP5HTMRMLqjHcUCuLDZhxQyPZ6rZQxfV7bqVx+p2
	 +K0NidpQ9vj/avWWt0XQ3Y04fQKie1wQKJlSrJQo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388752AbfBROAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 09:00:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:41100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388014AbfBROAC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 09:00:02 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7DA432173C;
        Mon, 18 Feb 2019 14:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550498401;
        bh=ZiLYm00Y9WbTe6RWU/9F+/Xl5JToCuaSPKpCwtonAXg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M/DhlIqsGoyHLCBaJhLMjFPoQbDnG/bffI3ayUkLllfl3nhBTtirwc1vsi/8qqf8Z
         xSyAxmgfwpTHUFGwbMS3rHZqPi/jjvN9I5JsvfrWg9xilUDqrWhtohSV8iJbOMAPrL
         MLRaXXZcOwfJWJuuoEdc9XcPrB7BeEumNKprkRdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Sven Eckelmann <sven.eckelmann@openmesh.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Christian Lamparter <chunkeey@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.9 57/58] pinctrl: msm: fix gpio-hog related boot issues
Date:   Mon, 18 Feb 2019 14:44:18 +0100
Message-Id: <20190218133512.764287176@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190218133508.567416115@linuxfoundation.org>
References: <20190218133508.567416115@linuxfoundation.org>
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Christian Lamparter <chunkeey@gmail.com>

commit a86caa9ba5d70696ceb35d1d39caa20d8b641387 upstream.

Sven Eckelmann reported an issue with the current IPQ4019 pinctrl.
Setting up any gpio-hog in the device-tree for his device would
"kill the bootup completely":

| [    0.477838] msm_serial 78af000.serial: could not find pctldev for node /soc/pinctrl@1000000/serial_pinmux, deferring probe
| [    0.499828] spi_qup 78b5000.spi: could not find pctldev for node /soc/pinctrl@1000000/spi_0_pinmux, deferring probe
| [    1.298883] requesting hog GPIO enable USB2 power (chip 1000000.pinctrl, offset 58) failed, -517
| [    1.299609] gpiochip_add_data: GPIOs 0..99 (1000000.pinctrl) failed to register
| [    1.308589] ipq4019-pinctrl 1000000.pinctrl: Failed register gpiochip
| [    1.316586] msm_serial 78af000.serial: could not find pctldev for node /soc/pinctrl@1000000/serial_pinmux, deferring probe
| [    1.322415] spi_qup 78b5000.spi: could not find pctldev for node /soc/pinctrl@1000000/spi_0_pinmux, deferri

This was also verified on a RT-AC58U (IPQ4018) which would
no longer boot, if a gpio-hog was specified. (Tried forcing
the USB LED PIN (GPIO0) to high.).

The problem is that Pinctrl+GPIO registration is currently
peformed in the following order in pinctrl-msm.c:
	1. pinctrl_register()
	2. gpiochip_add()
	3. gpiochip_add_pin_range()

The actual error code -517 == -EPROBE_DEFER is coming from
pinctrl_get_device_gpio_range(), which is called through:
        gpiochip_add
            of_gpiochip_add
                of_gpiochip_scan_gpios
                    gpiod_hog
                        gpiochip_request_own_desc
                            __gpiod_request
                                chip->request
                                    gpiochip_generic_request
                                       pinctrl_gpio_request
                                          pinctrl_get_device_gpio_range

pinctrl_get_device_gpio_range() is unable to find any valid
pin ranges, since nothing has been added to the pinctrldev_list yet.
so the range can't be found, and the operation fails with -EPROBE_DEFER.

This patch fixes the issue by adding the "gpio-ranges" property to
the pinctrl device node of all upstream Qcom SoC. The pin ranges are
then added by the gpio core.

In order to remain compatible with older, existing DTs (and ACPI)
a check for the "gpio-ranges" property has been added to
msm_gpio_init(). This prevents the driver of adding the same entry
to the pinctrldev_list twice.

Reported-by: Sven Eckelmann <sven.eckelmann@openmesh.com>
Tested-by: Sven Eckelmann <sven.eckelmann@openmesh.com> [ipq4019]
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/pinctrl/qcom/pinctrl-msm.c |   23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

--- a/drivers/pinctrl/qcom/pinctrl-msm.c
+++ b/drivers/pinctrl/qcom/pinctrl-msm.c
@@ -803,11 +803,24 @@ static int msm_gpio_init(struct msm_pinc
 		return ret;
 	}
 
-	ret = gpiochip_add_pin_range(&pctrl->chip, dev_name(pctrl->dev), 0, 0, chip->ngpio);
-	if (ret) {
-		dev_err(pctrl->dev, "Failed to add pin range\n");
-		gpiochip_remove(&pctrl->chip);
-		return ret;
+	/*
+	 * For DeviceTree-supported systems, the gpio core checks the
+	 * pinctrl's device node for the "gpio-ranges" property.
+	 * If it is present, it takes care of adding the pin ranges
+	 * for the driver. In this case the driver can skip ahead.
+	 *
+	 * In order to remain compatible with older, existing DeviceTree
+	 * files which don't set the "gpio-ranges" property or systems that
+	 * utilize ACPI the driver has to call gpiochip_add_pin_range().
+	 */
+	if (!of_property_read_bool(pctrl->dev->of_node, "gpio-ranges")) {
+		ret = gpiochip_add_pin_range(&pctrl->chip,
+			dev_name(pctrl->dev), 0, 0, chip->ngpio);
+		if (ret) {
+			dev_err(pctrl->dev, "Failed to add pin range\n");
+			gpiochip_remove(&pctrl->chip);
+			return ret;
+		}
 	}
 
 	ret = gpiochip_irqchip_add(chip,


