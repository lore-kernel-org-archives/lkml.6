Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28276C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:11:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E32E02175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695491;
	bh=fDc2F4IluctCFREreD9HEoOujKnzfNxxqkUVymgUkME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=FMPPe/an75mjOJQsHfs9yOTME1FOcpiABtTcsRsTi3cCeqzoDCfLMfcGBRAk+iS+y
	 udBHMVStVr644LTdHU6sbtXByabMt1y6Z4wDjPAgP2cwaGt0/DGB+q1OvIHbPTSXx9
	 dcUV93K0dmBdLHEuP5w6+3RMeq5TZTjhZEoU8rSw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732654AbfA1QJo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:09:44 -0500
Received: from mail.kernel.org ([198.145.29.99]:34646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732634AbfA1QJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:09:39 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 24FEE2173C;
        Mon, 28 Jan 2019 16:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691778;
        bh=fDc2F4IluctCFREreD9HEoOujKnzfNxxqkUVymgUkME=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=In8P6Z/lKAr6o2LscDamn3jOfaYEsGLeblKW0TGaqvBQX72SIiB+em81BQ2Uki5Mz
         wWaW+Ra+l92AtBEBBqQ+paa+bo4lOrNcATiukVkSFMmrCJWCknqYixiWxMHk4Zv8nO
         fuYse/gsFfQ6RVY9LomqfCnKhYCbjlYsOlXLUT4Q=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 214/258] pinctrl: meson: meson8b: fix the GPIO function for the GPIOAO pins
Date:   Mon, 28 Jan 2019 10:58:40 -0500
Message-Id: <20190128155924.51521-214-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit 2b745ac3cceb8fc1d9985990c8241a821ea97e53 ]

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
 drivers/pinctrl/meson/pinctrl-meson8b.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/pinctrl/meson/pinctrl-meson8b.c b/drivers/pinctrl/meson/pinctrl-meson8b.c
index 647ad15d5c3c..91cffc051055 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8b.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8b.c
@@ -646,16 +646,18 @@ static const char * const gpio_groups[] = {
 	"BOOT_10", "BOOT_11", "BOOT_12", "BOOT_13", "BOOT_14",
 	"BOOT_15", "BOOT_16", "BOOT_17", "BOOT_18",
 
-	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3",
-	"GPIOAO_4", "GPIOAO_5", "GPIOAO_6", "GPIOAO_7",
-	"GPIOAO_8", "GPIOAO_9", "GPIOAO_10", "GPIOAO_11",
-	"GPIOAO_12", "GPIOAO_13", "GPIO_BSD_EN", "GPIO_TEST_N",
-
 	"DIF_0_P", "DIF_0_N", "DIF_1_P", "DIF_1_N",
 	"DIF_2_P", "DIF_2_N", "DIF_3_P", "DIF_3_N",
 	"DIF_4_P", "DIF_4_N"
 };
 
+static const char * const gpio_aobus_groups[] = {
+	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3",
+	"GPIOAO_4", "GPIOAO_5", "GPIOAO_6", "GPIOAO_7",
+	"GPIOAO_8", "GPIOAO_9", "GPIOAO_10", "GPIOAO_11",
+	"GPIOAO_12", "GPIOAO_13", "GPIO_BSD_EN", "GPIO_TEST_N"
+};
+
 static const char * const sd_a_groups[] = {
 	"sd_d0_a", "sd_d1_a", "sd_d2_a", "sd_d3_a", "sd_clk_a",
 	"sd_cmd_a"
@@ -871,6 +873,7 @@ static struct meson_pmx_func meson8b_cbus_functions[] = {
 };
 
 static struct meson_pmx_func meson8b_aobus_functions[] = {
+	FUNCTION(gpio_aobus),
 	FUNCTION(uart_ao),
 	FUNCTION(uart_ao_b),
 	FUNCTION(i2c_slave_ao),
-- 
2.19.1

