Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B20C67839
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3B00C20882
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675401;
	bh=T3JjYbSkYooc0yWAOpao44OPgE9j32rK8lMtODVmky0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OudXjJouhNt93TPzF4iXz24Gt/YM+zF4pOhXxWJzcyHllL5FN7kosGJoaFiAqLtR7
	 w2wLuB/7cJREZEhnL8RpAHceBrfCMzsWAkx+jWeZo07puWK0/Yl+Ve/h8HXj2sE573
	 nDMnELlRcFBQzPLLolVL6nh2dGtpxJryTv8whESc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B00C20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbeLMEaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:30:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:42900 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbeLME36 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:29:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 99B4420879;
        Thu, 13 Dec 2018 04:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675398;
        bh=T3JjYbSkYooc0yWAOpao44OPgE9j32rK8lMtODVmky0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Iu6XqyoPONWfahfW560pYbpkdyToAckv+LtrfryFjoiTqkhAUnEftW4pcUL3R8Kh3
         JDZHGq0ULgs5Gu/hQc6890Obz4y44RWn7tidn1pDpJO25hqEkmycaFrbTPy25zeUji
         2Ly0ZjV3OGE1sJQi2EFc0OePvXxpLTGcLZwuv6Jg=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-input@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 40/73] Input: omap-keypad - fix keyboard debounce configuration
Date:   Wed, 12 Dec 2018 23:28:05 -0500
Message-Id: <20181213042838.75160-40-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213042838.75160-1-sashal@kernel.org>
References: <20181213042838.75160-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 6c3516fed7b61a3527459ccfa67fab130d910610 ]

I noticed that the Android v3.0.8 kernel on droid4 is using different
keypad values from the mainline kernel and does not have issues with
keys occasionally being stuck until pressed again. Turns out there was
an earlier patch posted to fix this as "Input: omap-keypad: errata i689:
Correct debounce time", but it was never reposted to fix use macros
for timing calculations.

This updated version is using macros, and also fixes the use of the
input clock rate to use 32768KiHz instead of 32000KiHz. And we want to
use the known good Android kernel values of 3 and 6 instead of 2 and 6
in the earlier patch.

Reported-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/input/keyboard/omap4-keypad.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/omap4-keypad.c b/drivers/input/keyboard/omap4-keypad.c
index 46406345742b..a7dc286f406c 100644
--- a/drivers/input/keyboard/omap4-keypad.c
+++ b/drivers/input/keyboard/omap4-keypad.c
@@ -60,8 +60,18 @@
 
 /* OMAP4 values */
 #define OMAP4_VAL_IRQDISABLE		0x0
-#define OMAP4_VAL_DEBOUNCINGTIME	0x7
-#define OMAP4_VAL_PVT			0x7
+
+/*
+ * Errata i689: If a key is released for a time shorter than debounce time,
+ * the keyboard will idle and never detect the key release. The workaround
+ * is to use at least a 12ms debounce time. See omap5432 TRM chapter
+ * "26.4.6.2 Keyboard Controller Timer" for more information.
+ */
+#define OMAP4_KEYPAD_PTV_DIV_128        0x6
+#define OMAP4_KEYPAD_DEBOUNCINGTIME_MS(dbms, ptv)     \
+	((((dbms) * 1000) / ((1 << ((ptv) + 1)) * (1000000 / 32768))) - 1)
+#define OMAP4_VAL_DEBOUNCINGTIME_16MS					\
+	OMAP4_KEYPAD_DEBOUNCINGTIME_MS(16, OMAP4_KEYPAD_PTV_DIV_128)
 
 enum {
 	KBD_REVISION_OMAP4 = 0,
@@ -181,9 +191,9 @@ static int omap4_keypad_open(struct input_dev *input)
 
 	kbd_writel(keypad_data, OMAP4_KBD_CTRL,
 			OMAP4_DEF_CTRL_NOSOFTMODE |
-			(OMAP4_VAL_PVT << OMAP4_DEF_CTRL_PTV_SHIFT));
+			(OMAP4_KEYPAD_PTV_DIV_128 << OMAP4_DEF_CTRL_PTV_SHIFT));
 	kbd_writel(keypad_data, OMAP4_KBD_DEBOUNCINGTIME,
-			OMAP4_VAL_DEBOUNCINGTIME);
+			OMAP4_VAL_DEBOUNCINGTIME_16MS);
 	/* clear pending interrupts */
 	kbd_write_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS,
 			 kbd_read_irqreg(keypad_data, OMAP4_KBD_IRQSTATUS));
-- 
2.19.1

