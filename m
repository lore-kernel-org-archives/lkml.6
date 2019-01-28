Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1B2C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 68B802177B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548695495;
	bh=Mpyhe8qTaIus1fIsKC5CIORoBVb834a3TFJUdNtqIq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=VQFXk/uqgJ8/B44OujA2lRBZLd3O1P7hFDr92RM3pbOwK4EzC5JCxJtEpMYAZcJyY
	 RXiu4sTh6dYdiogMjWASVX2lYw1+/A6lGL95lxDKOqrU7y2DNyf/zXv2nQavJT/oOz
	 VHORdy68lSwNCsCULTBUjvCV0yhEhgsKWyw3N+uo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732645AbfA1QJm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:09:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:34570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732629AbfA1QJh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:09:37 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3DD1021738;
        Mon, 28 Jan 2019 16:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691776;
        bh=Mpyhe8qTaIus1fIsKC5CIORoBVb834a3TFJUdNtqIq4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nFHxBW2CCdB1R0VJoQbs/52CMHh//WfA7NaYMvBw+1aONJ6k9MpDMIoNpY25lFpqv
         1iAfs9LK8OhmlC1HzCIQwdL4GorHOiRidyuQt7C+Cn3/yYERyrYc+4DmYarR2P/8R1
         nLBHv5PhOMOR/2kwNIZIaSkyLE8pds/Xbvcq72QQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sasha Levin <sashal@kernel.org>, linux-gpio@vger.kernel.org,
        linux-amlogic@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 213/258] pinctrl: meson: meson8: fix the GPIO function for the GPIOAO pins
Date:   Mon, 28 Jan 2019 10:58:39 -0500
Message-Id: <20190128155924.51521-213-sashal@kernel.org>
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
index 86466173114d..e482672e833a 100644
--- a/drivers/pinctrl/meson/pinctrl-meson8.c
+++ b/drivers/pinctrl/meson/pinctrl-meson8.c
@@ -807,7 +807,9 @@ static const char * const gpio_groups[] = {
 	"BOOT_5", "BOOT_6", "BOOT_7", "BOOT_8", "BOOT_9",
 	"BOOT_10", "BOOT_11", "BOOT_12", "BOOT_13", "BOOT_14",
 	"BOOT_15", "BOOT_16", "BOOT_17", "BOOT_18",
+};
 
+static const char * const gpio_aobus_groups[] = {
 	"GPIOAO_0", "GPIOAO_1", "GPIOAO_2", "GPIOAO_3",
 	"GPIOAO_4", "GPIOAO_5", "GPIOAO_6", "GPIOAO_7",
 	"GPIOAO_8", "GPIOAO_9", "GPIOAO_10", "GPIOAO_11",
@@ -1030,6 +1032,7 @@ static struct meson_pmx_func meson8_cbus_functions[] = {
 };
 
 static struct meson_pmx_func meson8_aobus_functions[] = {
+	FUNCTION(gpio_aobus),
 	FUNCTION(uart_ao),
 	FUNCTION(remote),
 	FUNCTION(i2c_slave_ao),
-- 
2.19.1

