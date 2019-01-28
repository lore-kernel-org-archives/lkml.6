Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0D2EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 850E120880
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:50:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690617;
	bh=hGh/PhJbf1jDeaDkWby5KHQR7ZxBdZI94M8XkUNeZf4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=immj5LqdXnmegQlUjZJLcR2ws24ipZUTnG9N6ypfpmwbUqSGM6a7AnviMFPmO6bJG
	 AcG1qkAoAb47sPQw5I5BXxo5uV8NV2AWNs0aLQrSUfvG2ldL6hg+xU/+ArrMtEM+2y
	 LPFTJe3+xa6Br2cUV3XoBTCB/+n6B/FAo+ENWBSk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfA1PuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:50:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:36384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727590AbfA1PuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:50:14 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 669A120880;
        Mon, 28 Jan 2019 15:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690613;
        bh=hGh/PhJbf1jDeaDkWby5KHQR7ZxBdZI94M8XkUNeZf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b8mDUZgH4AIRLAOQBTUlZR93wQJspW9XDLM8BKHEq6CwxgzqQEPWUfMGC4ZU0y/TW
         wei8NNxLpKvaS30eWPCD/dUKxdLgWCfMpNCXyP3FNph0eZi3mEiwJQt5aTJNIB5vys
         trHUzV/yhno03uUhdTk0Z+Z8/RvQyKEu4sLG20mY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>, linux-omap@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 141/304] ARM: OMAP1: ams-delta: Fix audio permanently muted
Date:   Mon, 28 Jan 2019 10:40:58 -0500
Message-Id: <20190128154341.47195-141-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Janusz Krzysztofik <jmkrzyszt@gmail.com>

[ Upstream commit 2afdb4c41d7876e430b9bc6e2d7e2fe28609fd6a ]

Since commit 1137ceee76ba ("ARM: OMAP1: ams-delta: Don't request unused
GPIOs"), on-board audio has appeared muted.  Believed to be unused GPIO
pin "hookflash1", apparently set high regardless of the corresponding
bit of "latch2" port attempted to be set low during .init_machine(),
has been identified as the reason.

According to Amstrad E3 wiki, the purpose of the pin hasn't been
clearly identified.  Original Amstrad software used to produce a high
pulse on it when the phone was taken off hook or recall was pressed.
With the current finding, we can assume the pin provides a kind of
audio mute function.

Proper resolution of the issue should be done in two steps:
- resolution of an issue with the pin state not reflecting the value
  the corresponding bit of the port was attempted to be initialized
  with,
- extension of on-board audio driver with a new control.

For now, rename the pin to "audio_mute" to reflect its function and,
as a quick fix, hogg it as output low so on-board audio can produce
audible sound again.

Fixes: 1137ceee76ba ("ARM: OMAP1: ams-delta: Don't request unused GPIOs")
Signed-off-by: Janusz Krzysztofik <jmkrzyszt@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap1/board-ams-delta.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap1/board-ams-delta.c b/arch/arm/mach-omap1/board-ams-delta.c
index 17886744dbe6..55bf73710a59 100644
--- a/arch/arm/mach-omap1/board-ams-delta.c
+++ b/arch/arm/mach-omap1/board-ams-delta.c
@@ -247,8 +247,8 @@ static struct platform_device latch2_gpio_device = {
 #define LATCH2_PIN_SCARD_CMDVCC		11
 #define LATCH2_PIN_MODEM_NRESET		12
 #define LATCH2_PIN_MODEM_CODEC		13
-#define LATCH2_PIN_HOOKFLASH1		14
-#define LATCH2_PIN_HOOKFLASH2		15
+#define LATCH2_PIN_AUDIO_MUTE		14
+#define LATCH2_PIN_HOOKFLASH		15
 
 static struct regulator_consumer_supply modem_nreset_consumers[] = {
 	REGULATOR_SUPPLY("RESET#", "serial8250.1"),
@@ -588,6 +588,8 @@ static int gpiochip_match_by_label(struct gpio_chip *chip, void *data)
 static struct gpiod_hog ams_delta_gpio_hogs[] = {
 	GPIO_HOG(LATCH2_LABEL, LATCH2_PIN_KEYBRD_DATAOUT, "keybrd_dataout",
 		 GPIO_ACTIVE_HIGH, GPIOD_OUT_LOW),
+	GPIO_HOG(LATCH2_LABEL, LATCH2_PIN_AUDIO_MUTE, "audio_mute",
+		 GPIO_ACTIVE_HIGH, GPIOD_OUT_LOW),
 	{},
 };
 
-- 
2.19.1

