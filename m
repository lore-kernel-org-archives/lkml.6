Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E480C282D7
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:24:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0411621479
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="LIkFXrNK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727790AbfBBGYV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:24:21 -0500
Received: from tomli.me ([153.92.126.73]:45102 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727719AbfBBGYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:24:20 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Feb 2019 01:23:43 EST
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id 6ae1789f;
        Sat, 2 Feb 2019 06:17:35 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:7b76:77ab)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 02 Feb 2019 06:17:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=eESnIlzms/lXDJ8+ZfW4Pm3+rcBdmlNQmW0HjusPOLU=; b=LIkFXrNKztYk8PRlQDKhYW7sy4lJPC86csZOl3efS4FcvS9Knd0C+x47GEU4ro4OXX09dhVJm/b6S+pevLnCyMqNIxlQwbZKr/jU/Cw4sXPPkNJ35TA8OYq2EJyItXyPLTq2K7MVH6k/NkIpMS5JNpUWcykRuxGkGbnbUP8Pafm+J4WYxmBu3kUrKs/MkACcvyhsFrO3/KMAafnuTwmjuwwq6qk89z5XRz3KjGm6x3QYlNmBLIWzdYJQdpsAXHuP6gi2pRT7+RbSYjNAf9t5/UgXcuU7JgLbGZRZIDo1CVHMQ2DrT+bXGzLQ78C1lG5LxPQ59kOGClaH61OVMQUzTw==
From:   Yifeng Li <tomli@tomli.me>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH 5/8] fbdev: sm712fb: add 32-bit color modes, drops some other modes.
Date:   Sat,  2 Feb 2019 14:16:45 +0800
Message-Id: <20190202061648.30374-6-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190202061648.30374-1-tomli@tomli.me>
References: <20190202061648.30374-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The modesetting in sm712fb is an ugly hack. First, all the registers
are programmed by hardcoded register arrays, which makes it difficult
to support different variations of color depths, refresh rates, CRT/LCD
panel, etc of the same resolution. Second, it means the standard
fb_find_mode() cannot be used and a confusing non-standard "vga="
parameter is needed. Third, there's only minimum differences between
some modes, yet around 70 lines of code and 100 registers are needed to
be indepentently specified for each mode. Fourth, the register between
some modes are inconsistent: the register configuration of different
color depths in 640 x 480 modes are identical, but for 800 x 600 modes
it's completely different. Also, some modes can drive the LCD panel
properly yet some other modes will only show a white screen of death on
the LCD panel. Fifth, there is a specific hack for Lemote Loongson 8089D
laptop, the 1024x768, 16-bit color mode was modified to drive its LCD panel
and changed to 1024x600, but the original mode was not preserved, so
1024x768 16-bit color mode is completely unsupported. Sixth, some modes,
such as 32-bit color modes, are supported but never listed, and some modes
are listed, such as 1280x1024 modes, but never supported by the register
configuration arrays. And some modes are partially implemented but neither
listed nor supported, i.e. the 8-bit color modes.

Fixing these problems requires a complete rewrite of modesetting code,
which is well-beyond my motivation. This commit only perform a minimum
cleanup:

1. Remove the 320 x 240 register settings, since there are never listed
and never actually being used. This resolution is not even supported by
vesafb, so it's safe to assume that no one is using such hardware. Future
developers who needs them can simply recover them from the git history.

2. Remove 1280x1024 modes and 8-bit color modes. They are listed but never
supported by the register array. So it doesn't work in the beginning, and
only gives a black screen.

3. Add 32-bit color modes. They are supported but never listed, and are
useful to some users.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 drivers/video/fbdev/sm712fb.c | 158 +++++++---------------------------
 1 file changed, 31 insertions(+), 127 deletions(-)

diff --git a/drivers/video/fbdev/sm712fb.c b/drivers/video/fbdev/sm712fb.c
index 133e31f75d67..0cc395d52057 100644
--- a/drivers/video/fbdev/sm712fb.c
+++ b/drivers/video/fbdev/sm712fb.c
@@ -118,25 +118,48 @@ struct vesa_mode {
 };
 
 static const struct vesa_mode vesa_mode_table[] = {
-	{"0x301", 640,  480,  8},
-	{"0x303", 800,  600,  8},
-	{"0x305", 1024, 768,  8},
-	{"0x307", 1280, 1024, 8},
-
 	{"0x311", 640,  480,  16},
 	{"0x314", 800,  600,  16},
 	{"0x317", 1024, 768,  16},
-	{"0x31A", 1280, 1024, 16},
 
 	{"0x312", 640,  480,  24},
 	{"0x315", 800,  600,  24},
 	{"0x318", 1024, 768,  24},
-	{"0x31B", 1280, 1024, 24},
+
+	{"0x329", 640,  480,  32},
+	{"0x32e", 800,  600,  32},
+	{"0x338", 1024, 768,  32},
 };
 
 /**********************************************************************
 			 SM712 Mode table.
- **********************************************************************/
+
+ The modesetting in sm712fb is an ugly hack. First, all the registers
+ are programmed by hardcoded register arrays, which makes it difficult
+ to support different variations of color depths, refresh rates, CRT/LCD
+ panel, etc of the same resolution. Second, it means the standard
+ fb_find_mode() cannot be used and a confusing non-standard "vga="
+ parameter is needed. Third, there's only minimum differences between
+ some modes, yet around 70 lines of code and 100 registers are needed to
+ be indepentently specified for each mode. Fourth, the register between
+ some modes are inconsistent: the register configuration of different
+ color depths in 640 x 480 modes are identical, but for 800 x 600 modes
+ it's completely different. Also, some modes can drive the LCD panel
+ properly yet some other modes will only show a white screen of death on
+ the LCD panel. Fifth, there is a specific hack for Lemote Loongson 8089D
+ laptop, the 1024x768, 16-bit color mode was modified to drive its LCD panel
+ and changed to 1024x600, but the original mode was not preserved, so
+ 1024x768 16-bit color mode is completely unsupported. And previously,
+ some modes are listed, such as 1280x1024 modes, but never supported by
+ the register configuration arrays, so they are now removed. And some modes
+ are partially implemented but neither listed nor supported, i.e. the 8-bit
+ color modes, so they have been removed from vesa_mode_table, too.
+
+ I'm not the original author of the code, fixing these problems requires a
+ complete rewrite of modesetting code, which is well-beyond my motivation.
+
+ See Documentation/fb/sm712fb.txt for more information.
+**********************************************************************/
 static const struct modeinit vgamode[] = {
 	{
 		/*  mode#0: 640 x 480  16Bpp  60Hz */
@@ -673,125 +696,6 @@ static const struct modeinit vgamode[] = {
 			0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x15, 0x03,
 		},
 	},
-	{	/*  mode#6: 320 x 240  16Bpp  60Hz */
-		320, 240, 16, 60,
-		/*  Init_MISC */
-		0xEB,
-		{	/*  Init_SR0_SR4 */
-			0x03, 0x01, 0x0F, 0x03, 0x0E,
-		},
-		{	/*  Init_SR10_SR24 */
-			0xF3, 0xB6, 0xC0, 0xDD, 0x00, 0x0E, 0x17, 0x2C,
-			0x99, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
-			0xC4, 0x32, 0x02, 0x01, 0x01,
-		},
-		{	/*  Init_SR30_SR75 */
-			0x38, 0x03, 0x20, 0x09, 0xC0, 0x3A, 0x3A, 0x3A,
-			0x3A, 0x3A, 0x3A, 0x3A, 0x00, 0x00, 0x03, 0xFF,
-			0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
-			0x20, 0x0C, 0x44, 0x20, 0x00, 0x00, 0x00, 0x3A,
-			0x06, 0x68, 0xA7, 0x7F, 0x83, 0x24, 0xFF, 0x03,
-			0x00, 0x60, 0x59, 0x3A, 0x3A, 0x00, 0x00, 0x3A,
-			0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
-			0x50, 0x03, 0x74, 0x14, 0x08, 0x43, 0x08, 0x43,
-			0x04, 0x45, 0x30, 0x30, 0x40, 0x20,
-		},
-		{	/*  Init_SR80_SR93 */
-			0xFF, 0x07, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x3A,
-			0xF7, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x3A, 0x3A,
-			0x00, 0x00, 0x00, 0x00,
-		},
-		{	/*  Init_SRA0_SRAF */
-			0x00, 0xFB, 0x9F, 0x01, 0x00, 0xED, 0xED, 0xED,
-			0x7B, 0xFB, 0xFF, 0xFF, 0x97, 0xEF, 0xBF, 0xDF,
-		},
-		{	/*  Init_GR00_GR08 */
-			0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
-			0xFF,
-		},
-		{	/*  Init_AR00_AR14 */
-			0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
-			0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
-			0x41, 0x00, 0x0F, 0x00, 0x00,
-		},
-		{	/*  Init_CR00_CR18 */
-			0xA3, 0x7F, 0x7F, 0x00, 0x85, 0x16, 0x24, 0xF5,
-			0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			0x03, 0x09, 0xFF, 0x80, 0x40, 0xFF, 0x00, 0xE3,
-			0xFF,
-		},
-		{	/*  Init_CR30_CR4D */
-			0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x02, 0x20,
-			0x00, 0x00, 0x30, 0x40, 0x00, 0xFF, 0xBF, 0xFF,
-			0x2E, 0x27, 0x00, 0x2b, 0x0c, 0x0F, 0xEF, 0x00,
-			0xFe, 0x0f, 0x01, 0xC0, 0x27, 0xEF,
-		},
-		{	/*  Init_CR90_CRA7 */
-			0x55, 0xD9, 0x5D, 0xE1, 0x86, 0x1B, 0x8E, 0x26,
-			0xDA, 0x8D, 0xDE, 0x94, 0x00, 0x00, 0x18, 0x00,
-			0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x15, 0x03,
-		},
-	},
-
-	{	/*  mode#8: 320 x 240  32Bpp  60Hz */
-		320, 240, 32, 60,
-		/*  Init_MISC */
-		0xEB,
-		{	/*  Init_SR0_SR4 */
-			0x03, 0x01, 0x0F, 0x03, 0x0E,
-		},
-		{	/*  Init_SR10_SR24 */
-			0xF3, 0xB6, 0xC0, 0xDD, 0x00, 0x0E, 0x17, 0x2C,
-			0x99, 0x02, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00,
-			0xC4, 0x32, 0x02, 0x01, 0x01,
-		},
-		{	/*  Init_SR30_SR75 */
-			0x38, 0x03, 0x20, 0x09, 0xC0, 0x3A, 0x3A, 0x3A,
-			0x3A, 0x3A, 0x3A, 0x3A, 0x00, 0x00, 0x03, 0xFF,
-			0x00, 0xFC, 0x00, 0x00, 0x20, 0x18, 0x00, 0xFC,
-			0x20, 0x0C, 0x44, 0x20, 0x00, 0x00, 0x00, 0x3A,
-			0x06, 0x68, 0xA7, 0x7F, 0x83, 0x24, 0xFF, 0x03,
-			0x00, 0x60, 0x59, 0x3A, 0x3A, 0x00, 0x00, 0x3A,
-			0x01, 0x80, 0x7E, 0x1A, 0x1A, 0x00, 0x00, 0x00,
-			0x50, 0x03, 0x74, 0x14, 0x08, 0x43, 0x08, 0x43,
-			0x04, 0x45, 0x30, 0x30, 0x40, 0x20,
-		},
-		{	/*  Init_SR80_SR93 */
-			0xFF, 0x07, 0x00, 0xFF, 0xFF, 0xFF, 0xFF, 0x3A,
-			0xF7, 0x00, 0x00, 0x00, 0xFF, 0xFF, 0x3A, 0x3A,
-			0x00, 0x00, 0x00, 0x00,
-		},
-		{	/*  Init_SRA0_SRAF */
-			0x00, 0xFB, 0x9F, 0x01, 0x00, 0xED, 0xED, 0xED,
-			0x7B, 0xFB, 0xFF, 0xFF, 0x97, 0xEF, 0xBF, 0xDF,
-		},
-		{	/*  Init_GR00_GR08 */
-			0x00, 0x00, 0x00, 0x00, 0x00, 0x40, 0x05, 0x0F,
-			0xFF,
-		},
-		{	/*  Init_AR00_AR14 */
-			0x00, 0x01, 0x02, 0x03, 0x04, 0x05, 0x06, 0x07,
-			0x08, 0x09, 0x0A, 0x0B, 0x0C, 0x0D, 0x0E, 0x0F,
-			0x41, 0x00, 0x0F, 0x00, 0x00,
-		},
-		{	/*  Init_CR00_CR18 */
-			0xA3, 0x7F, 0x7F, 0x00, 0x85, 0x16, 0x24, 0xF5,
-			0x00, 0x60, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-			0x03, 0x09, 0xFF, 0x80, 0x40, 0xFF, 0x00, 0xE3,
-			0xFF,
-		},
-		{	/*  Init_CR30_CR4D */
-			0x00, 0x00, 0x00, 0x00, 0x00, 0x80, 0x02, 0x20,
-			0x00, 0x00, 0x30, 0x40, 0x00, 0xFF, 0xBF, 0xFF,
-			0x2E, 0x27, 0x00, 0x2b, 0x0c, 0x0F, 0xEF, 0x00,
-			0xFe, 0x0f, 0x01, 0xC0, 0x27, 0xEF,
-		},
-		{	/*  Init_CR90_CRA7 */
-			0x55, 0xD9, 0x5D, 0xE1, 0x86, 0x1B, 0x8E, 0x26,
-			0xDA, 0x8D, 0xDE, 0x94, 0x00, 0x00, 0x18, 0x00,
-			0x03, 0x03, 0x03, 0x03, 0x03, 0x03, 0x15, 0x03,
-		},
-	},
 };
 
 
-- 
2.20.1

