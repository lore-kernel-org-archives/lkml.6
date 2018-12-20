Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8939C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8676217D8
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545297725;
	bh=syfbO2RfYYm4RXB26U8FdzcF6iqJOxFXi6B90yD5A38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=RD5eJr1TA4Nad8kUiMgBbjCYwwCjL5GR1x8EWDTZhEeWre2M0yFi+8pSdg+gUxUtW
	 Sdwvp+W+knwdt2tHPX8d2II/A0Jb6WRiZwF4oSpTTJc2otxzNPiJivH9t7SEXIQEnk
	 ETL5BDFNZ17wZlkcki3Oenge0puuOo2fIkhhj5Z8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731255AbeLTJWE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:22:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:39706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731236AbeLTJWB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:22:01 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AFB7F21773;
        Thu, 20 Dec 2018 09:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545297720;
        bh=syfbO2RfYYm4RXB26U8FdzcF6iqJOxFXi6B90yD5A38=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HOrbtdMjlHM0vyBRs1xs7g3lI7YeyNDhEWEVtqeALYPOipK2Qcr99gsP83F5nUZXp
         /3l2XfL5aibg9PN6IFY73W57I1Mlj+WQAyCNBnIUF5z5C1FKKh10oUPenJx8xDnXcw
         O3gEcH0KRJ3NXu29Z7D7GWXAt8nWqRoJK+VGyEmA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Tony Lindgren <tony@atomide.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 31/40] Input: omap-keypad - fix keyboard debounce configuration
Date:   Thu, 20 Dec 2018 10:18:43 +0100
Message-Id: <20181220085827.701634602@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085826.212663515@linuxfoundation.org>
References: <20181220085826.212663515@linuxfoundation.org>
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 6639b2b8528a..f78c464899db 100644
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



