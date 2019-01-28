Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92D5AC282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:44:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 61E6C2084C
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548693858;
	bh=docGBKSUYjYs1fqytRBJRL043K9NsNIgwjIYItyrVOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=tWGbniMVnRWbTJP8XdEooxA2DffOrxw0tMi6DEky2Oaw5jUwAGqeBuGqcWEHOg9Uc
	 FR1bpNMmuWPiVX67G1jhDKGVCDs3HKi0ucYr+c1M0GeBh71l/g46B6LS420c3hUekc
	 BU0i2osgTJgVSkbdzRkmWebIFQmMB0Sxi1Yksn+Y=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390026AbfA1QoQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:44:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:59340 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389371AbfA1QXJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:23:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B1AEF2147A;
        Mon, 28 Jan 2019 16:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548692588;
        bh=docGBKSUYjYs1fqytRBJRL043K9NsNIgwjIYItyrVOo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TNaqK552+9RkZSbKB9GUercQwttH+8o6+c0wUsdSst7QpkUgzgDfE5dH3uO0nvZdY
         TPII/dzrvIqfYNc8MtCKX2xI0Q/GzVbLHc2vU4cU7V7YSAD7qsHvC2pvmUL958lHvT
         BD02/2fIJQjPhr28sclde/s0a1zA2FIdQNndt5iA=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 080/107] pinctrl: meson: meson8: fix the GPIO function for the GPIOAO pins
Date:   Mon, 28 Jan 2019 11:19:20 -0500
Message-Id: <20190128161947.57405-80-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128161947.57405-1-sashal@kernel.org>
References: <20190128161947.57405-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 42f9b48cc5402be11d2364275eb18c257d2a79e8 ]

The GPIOAO pins (as well as the two exotic GPIO_BSD_EN and GPIO_TEST_N)
only belong to the pin controller in the AO domain. With the current
definition these pins cannot be referred to in .dts files as group
(which is possible on GXBB and GXL for example).

Add a separate "gpio_aobus" function to fix the mapping between the pin
controller and the GPIO pins in the AO domain. This is similar to how
the GXBB and GXL drivers implement this functionality.

Fixes: 9dab1868ec0db4 ("pinctrl: amlogic: Make driver independent from two-domain configuration")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pinctrl/meson/pinctrl-meson8.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8.c b/drivers/pinctrl/meson/pinctrl-meson8.c
index 07f1cb21c1b8..0de7fa414beb 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -736,7 +736,9 @@ static const char * const gpio_groups[] = {
 	"BOOT_5", "BOOT_6", "BOOT_7", "BOOT_8", "BOOT_9",
 	"BOOT_10", "BOOT_11", "BOOT_12", "BOOT_13", "BOOT_14",
 	"BOOT_15", "BOOT_16", "BOOT_17", "BOOT_18",
+};
 
+static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3",
 	"GPIOAO_4", "GPIOAO_5", "GPIOAO_6", "GPIOAO_7",
 	"GPIOAO_8", "GPIOAO_9", "GPIOAO_10", "GPIOAO_11",
@@ -908,6 +910,7 @@ static struct meson_pmx_func meson8_cbus_functions[] = {
 };
 
 static struct meson_pmx_func meson8_aobus_functions[] = {
+	FUNCTION(gpio_aobus),
 	FUNCTION(uart_ao),
 	FUNCTION(remote),
 	FUNCTION(i2c_slave_ao),
-- 
2.19.1

