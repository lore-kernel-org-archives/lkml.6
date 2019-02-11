Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D9F7C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:40:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 09C46222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549899638;
	bh=e8986UNJgErYfRJTvl/OMdxIieU8rdQEE6PsLIU6w4U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=hZ3abFhMml6GMxn4+4v5eiw++QJeXBDEOQynrAOQPZVtjrgm8DlHx7bkDITA4Z2al
	 i/2G5Mwz1BLxRf9GjazFczCy08n0DYO0oUbhNGkhDPtegIyHlMo1jiIMOQZh0q2ycp
	 ULvzG4O401FPp5h+cYB+my3KQZPJ1KN6kCB7p7k0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbfBKPkg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:40:36 -0500
Received: from mail.kernel.org ([198.145.29.99]:33566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732594AbfBKOsU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:48:20 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3529B20700;
        Mon, 11 Feb 2019 14:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549896499;
        bh=e8986UNJgErYfRJTvl/OMdxIieU8rdQEE6PsLIU6w4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZxN8TGte0HHgLxdfodXWGBKn3k3fa5Sg+SIAOgtRBP743QSlDdcV5iZTLzbBKWHwp
         O0Sy0bPWnn0s9XBCd2RGm49O2WLHqaPb/TDOko9K/zMXEPl8a6S5Bb24ESu9tXQqCt
         Fefgu7SvP3WuBqNyH5um1VAdmhFpvtYwhnxjqcGA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 205/313] pinctrl: meson: meson8b: fix the GPIO function for the GPIOAO pins
Date:   Mon, 11 Feb 2019 15:18:05 +0100
Message-Id: <20190211141906.852879625@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141852.749630980@linuxfoundation.org>
References: <20190211141852.749630980@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



