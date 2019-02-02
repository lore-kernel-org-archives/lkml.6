Return-Path: <SRS0=zrxM=QJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C794C282DA
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:24:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B2DC20870
	for <linux-kernel@archiver.kernel.org>; Sat,  2 Feb 2019 06:24:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tomli.me header.i=@tomli.me header.b="ppagsjEd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727829AbfBBGY0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 2 Feb 2019 01:24:26 -0500
Received: from tomli.me ([153.92.126.73]:45102 "EHLO tomli.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727778AbfBBGYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Feb 2019 01:24:25 -0500
X-Greylist: delayed 399 seconds by postgrey-1.27 at vger.kernel.org; Sat, 02 Feb 2019 01:24:22 EST
Received: from tomli.me (localhost [127.0.0.1])
        by tomli.me (OpenSMTPD) with ESMTP id da4f8d5b;
        Sat, 2 Feb 2019 06:17:41 +0000 (UTC)
X-HELO: localhost.lan
Authentication-Results: tomli.me; auth=pass (login) smtp.auth=tomli
Received: from Unknown (HELO localhost.lan) (2402:f000:1:1501:200:5efe:7b76:77ab)
 by tomli.me (qpsmtpd/0.95) with ESMTPSA (DHE-RSA-CHACHA20-POLY1305 encrypted); Sat, 02 Feb 2019 06:17:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=tomli.me; h=from:to:cc:subject:date:message-id:in-reply-to:references:mime-version:content-transfer-encoding; s=1490979754; bh=ymwVquARYH25vOe0O0vYizscGzeglujnl89fDE4zx3I=; b=ppagsjEdIHvlB6sPrGfHd5Ve9YQfXFruWZX/MERpyFJoeBHogf+Nn5fWDR3ElZctsk1siYybgFmOotxP8jmnnyA/sRvC2rDbqmUHx2vi/TTQ8qrNFxGrHCAdFCvs1yDJedaNzpyyoFDnsar7lRD3nkh4MmotSUgydeCC2nHpnCcMZyb37rtn17d2xIvCFLniWDfy5WIkayfKv0RvPhmgu9xx1i3m49/7SmWesDzjlTpcb+Amh8pqJie4OrE9yiVuOBVhkTmDFjrrsyhY3bIFmbZVXs5AtYxaGbQAnpZpUeS1AY1krng2pcSAdm3cQNUXyn03wRF4RqOTNOjC4fTlnQ==
From:   Yifeng Li <tomli@tomli.me>
To:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Cc:     Yifeng Li <tomli@tomli.me>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Teddy Wang <teddy.wang@siliconmotion.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH 6/8] Documentation: fb: sm712fb: add information mainly about 2D.
Date:   Sat,  2 Feb 2019 14:16:46 +0800
Message-Id: <20190202061648.30374-7-tomli@tomli.me>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190202061648.30374-1-tomli@tomli.me>
References: <20190202061648.30374-1-tomli@tomli.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commits add information about 32-bit color, 2D acceleration,
as well as adding additional, general information about the hardware
and many existing problems of the sm712fb driver.

Signed-off-by: Yifeng Li <tomli@tomli.me>
---
 Documentation/fb/sm712fb.txt | 123 +++++++++++++++++++++++++++++++----
 1 file changed, 110 insertions(+), 13 deletions(-)

diff --git a/Documentation/fb/sm712fb.txt b/Documentation/fb/sm712fb.txt
index c388442edf51..906b48aa40e4 100644
--- a/Documentation/fb/sm712fb.txt
+++ b/Documentation/fb/sm712fb.txt
@@ -1,31 +1,128 @@
 What is sm712fb?
 =================
 
-This is a graphics framebuffer driver for Silicon Motion SM712 based processors.
+"sm712fb" is a graphics framebuffer driver for Silicon Motion SM710 (LynxEM),
+SM712 (LynxEM+), and SM720 (Lynx3DM, Lynx3DM+, aka. LynxEM4+) series of
+video controllers. This series of video controller is a legacy from ~1998,
+and was used on many classic, "prehistoric" laptops from 1998-2004, such as
+IBM Thinkpad S30 and 240X. It was also used on some servers, industrial
+computers, x86 and non-x86 embedded devices where only basic graphics was
+needed.
+
+Notably, Lemote YeeLoong 8089, a MIPS laptop based on the Chinese Loongson
+2F MIPS processor, is also using this chip because of hardware constraints,
+and at a time, somewhat popular in the free software community due the
+fact that it was the first laptop powered exclusively by free software,
+and it was also an inexpensive platform for non-x86 hobbyists to explore.
 
 How to use it?
 ==============
 
-Switching modes is done using the video=sm712fb:... boot parameter.
-
-If you want, for example, enable a resolution of 1280x1024x24bpp you should
-pass to the kernel this command line: "video=sm712fb:0x31B".
+You should not compile-in vesafb, since SM7xx can be used in a VGA
+compatible mode, resulting conflicts with this driver. In addition,
+the VGA compatible mode was never tested by the maintainers.
 
-You should not compile-in vesafb.
+Currently, the driver supports 3 modes: 640x480, 800x600, 1024x768,
+at 16, 24 or 32-bit depth. Switching modes is done using the
+`video=sm712fb:0x___` boot parameter. If you want, for example,
+enable a resolution of 1280x1024x24bpp, you should pass to the kernel
+this command line: "video=sm712fb:0x31B".
 
-Currently supported video modes are:
+Please consult the following table for the hexadecimal codes of
+different modes.
 
 [Graphic modes]
 
-bpp | 640x480  800x600  1024x768  1280x1024
-----+--------------------------------------------
-  8 | 0x301    0x303    0x305    0x307
- 16 | 0x311    0x314    0x317    0x31A
- 24 | 0x312    0x315    0x318    0x31B
+bpp | 640x480  800x600  1024x768
+----+---------------------------
+ 16 | 0x311    0x314    0x317
+ 24 | 0x312    0x315    0x318
+ 32 | 0x329    0x32E    0x338
+
+32-bit is really 8:8:8:8, but the final 8-bit number is an "empty"
+alpha channel, it's otherwise equal to 24-bit color. However, they
+could still be useful. For example, "fbterm" supports 32-bit mode
+but not 24-bit mode.
+
+Notes about Modesetting
+========================
+
+The modesetting code in sm712fb has major problems.
+
+* Switching to 8-bit color mode will result in a black screen, so
+they are removed from the list of supported graphic modes. But they
+can still be switched to on-the-fly, don't do that then!
+
+* Only a refresh rate of 60 Hz is supported.
+
+* 1024x768 with 16-bit color is not really supported, because the
+registers have been hacked by the original developer to adapt
+the 1024x600 screen on Lemote YeeLoong 8089.
+
+* If you are using a Lemote YeeLoong 8089, please remember that only
+the 1024x768 modes are guaranteed to drive the LCD panel properly.
+Other modes are meant to drive a CRT, and may drive the LCD incorrectly
+and result in a white screen with random garbage. External VGA output is
+unaffected.
+
+Due to the way registers are hardcoded, it's impossible to fix them
+without a major code rewrite. If you've been hit by these problems badly
+and really need to get them fixed, please contact the driver maintainers.
+
+2D acceleration
+==============
+
+Without 2D acceleration, the framebuffer suffers from extremely low performance,
+even scrolling a single line of text on the console required an unaccelerated
+screen redraw. Thus, 2D acceleration is enable by default. However, currently
+it's only supported on SM710/712 with Little-Endian CPUs. Big-endian and
+SM720 devices are currently not supported.
+
+2D acceleration can be controlled using the `video=sm712fb:accel:1` parameter.
+The default option, "1" activate 2D acceleration. If you have problems, you can
+set "0" to disable it. Different options can be separated by a comma, for
+example, "video=sm712fb:0x31B,accel:0" set the resolution to 1280x1024x24bpp
+while disabling the 2D acceleration.
+
+Although it has been extensively tested by the maintainer, 2D acceleration
+in 24-bit color mode may still have minor issues. If you've encounter any
+screen glitches in 24-bit mode in Linux framebuffer the framebuffer, don't
+hurry disabling it, you should try switching to 32-bit mode first, normally
+it should fix the problem. If you can reliably reproduce the screen glitches,
+please report your method to the maintainers.
 
 Missing Features
 ================
 (alias TODO list)
 
-	* 2D acceleratrion
+The following features are not implemented in this driver,
+
+	* 2D acceleration on SM720 and Big-Endian CPUs.
+	* More VGA modes.
 	* dual-head support
+	* hardware cursor support
+
+The first feature is planned to be implemented soon, but the maintainer
+does not receive any monetary or hardware support from any company or OEMs,
+and he has to purchase a test platform personally. The 1998's hardware
+still costs 200 USD+, so don't expected an ETA. If you have a Big-Endian
+platform and willing to help testing, please contact the maintainer, thanks!
+
+Other VGA modes, dual-head, or hardware cursor support should be possible to
+implement, but parts of the code must be rewritten, and there's little demand
+for them on this legacy (retro?) platform, so there's no plan to implement them.
+If you have a genuine need for them, please contact the maintainers.
+
+Maintainers
+================
+
+This driver is maintained by
+
+	* Tom Li <tomli@tomli.me>
+	* Sudip Mukherjee <sudipm.mukherjee@gmail.com>
+	* Teddy Wang <teddy.wang@siliconmotion.com>
+
+Tom Li was the last contributor of this driver who implemented 2D acceleration,
+and is the main author of this documentation, please send any bug reports or
+requests to Tom, but don't forget to CC other maintainers as well to make everyone
+be informed.
-- 
2.20.1

