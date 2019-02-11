Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A6EC169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:27:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFB7021855
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895224;
	bh=LvFom4aUZURAW5OByWQFjPjv9PMk0b5Oo66qnMAY+hM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=lYlAG0h0i8/mlQHVWczDpC5X3Ajpx98JdRjrL7sTd3xnTUzEziDEOaHOK1JRSt8fM
	 MXmSjSra8+vF9F4BszijuEnZB1Bgqpm8maqHORMEhtoAsA0vI/W5BWmVNzyZdyyGYx
	 RjJy3dNM3vBjqMDRTxed92BpXZj77DUWuB6EwKC8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729647AbfBKO1C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:27:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:60928 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfBKO06 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:26:58 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 27F4321855;
        Mon, 11 Feb 2019 14:26:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895217;
        bh=LvFom4aUZURAW5OByWQFjPjv9PMk0b5Oo66qnMAY+hM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ih40jaoyZwwbW5du2pmb9OQy5Z3Cj5InLbJhFm1Bqq4UsoTFM4l9Xu03qtXeAQJJx
         14jxNNEI5HdPRs24WHRpmn4W/6IQkbGHLYErmYXLzqqI6gZxZS1oDfkbh+Sp1HQLGw
         uhkXD+tCwwLQ0/BcumPL3Kx0k4rsscJfNklFM1pU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 132/352] ARM: OMAP1: ams-delta: Fix audio permanently muted
Date:   Mon, 11 Feb 2019 15:15:59 +0100
Message-Id: <20190211141854.897960207@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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



