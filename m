Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB883C5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9481121476
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 18:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2bouZrK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9481121476
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729811AbeJSCEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 22:04:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:52986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729137AbeJSCEs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 22:04:48 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3816121476;
        Thu, 18 Oct 2018 18:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539885760;
        bh=dPa1fDm7k0emiirKR9u+e5UmgqSN3uWismJwpj2Y2Zs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i2bouZrKyDdtZowmBHfaQRIxTfGr2ZCsJnzQEmYtoOOlHhHiytOPazskOF8sah4Ir
         nqyWQods8nfeSygUZDQac3fOyXEcaoijGgRB0k93mb7betl2LVIpreOEVWcV5SI/Ar
         M6E0SsHPSKETuwgBomWOdLygiuP4M41yBRF2l4oQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Michael Schmitz <schmitzmic@gmail.com>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 13/35] Input: atakbd - fix Atari keymap
Date:   Thu, 18 Oct 2018 19:54:42 +0200
Message-Id: <20181018175424.639227264@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181018175422.506152522@linuxfoundation.org>
References: <20181018175422.506152522@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Andreas Schwab <schwab@linux-m68k.org>

[ Upstream commit 9e62df51be993035c577371ffee5477697a56aad ]

Fix errors in Atari keymap (mostly in keypad, help and undo keys).

Patch provided on debian-68k ML by Andreas Schwab <schwab@linux-m68k.org>,
keymap array size and unhandled scancode limit adjusted to 0x73 by me.

Tested-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Michael Schmitz <schmitzmic@gmail.com>
Signed-off-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/keyboard/atakbd.c |   64 ++++++++++++++++------------------------
 1 file changed, 26 insertions(+), 38 deletions(-)

--- a/drivers/input/keyboard/atakbd.c
+++ b/drivers/input/keyboard/atakbd.c
@@ -79,8 +79,7 @@ MODULE_LICENSE("GPL");
  */
 
 
-static unsigned char atakbd_keycode[0x72] = {	/* American layout */
-	[0]	 = KEY_GRAVE,
+static unsigned char atakbd_keycode[0x73] = {	/* American layout */
 	[1]	 = KEY_ESC,
 	[2]	 = KEY_1,
 	[3]	 = KEY_2,
@@ -121,9 +120,9 @@ static unsigned char atakbd_keycode[0x72
 	[38]	 = KEY_L,
 	[39]	 = KEY_SEMICOLON,
 	[40]	 = KEY_APOSTROPHE,
-	[41]	 = KEY_BACKSLASH,	/* FIXME, '#' */
+	[41]	 = KEY_GRAVE,
 	[42]	 = KEY_LEFTSHIFT,
-	[43]	 = KEY_GRAVE,		/* FIXME: '~' */
+	[43]	 = KEY_BACKSLASH,
 	[44]	 = KEY_Z,
 	[45]	 = KEY_X,
 	[46]	 = KEY_C,
@@ -149,45 +148,34 @@ static unsigned char atakbd_keycode[0x72
 	[66]	 = KEY_F8,
 	[67]	 = KEY_F9,
 	[68]	 = KEY_F10,
-	[69]	 = KEY_ESC,
-	[70]	 = KEY_DELETE,
-	[71]	 = KEY_KP7,
-	[72]	 = KEY_KP8,
-	[73]	 = KEY_KP9,
+	[71]	 = KEY_HOME,
+	[72]	 = KEY_UP,
 	[74]	 = KEY_KPMINUS,
-	[75]	 = KEY_KP4,
-	[76]	 = KEY_KP5,
-	[77]	 = KEY_KP6,
+	[75]	 = KEY_LEFT,
+	[77]	 = KEY_RIGHT,
 	[78]	 = KEY_KPPLUS,
-	[79]	 = KEY_KP1,
-	[80]	 = KEY_KP2,
-	[81]	 = KEY_KP3,
-	[82]	 = KEY_KP0,
-	[83]	 = KEY_KPDOT,
-	[90]	 = KEY_KPLEFTPAREN,
-	[91]	 = KEY_KPRIGHTPAREN,
-	[92]	 = KEY_KPASTERISK,	/* FIXME */
-	[93]	 = KEY_KPASTERISK,
-	[94]	 = KEY_KPPLUS,
-	[95]	 = KEY_HELP,
+	[80]	 = KEY_DOWN,
+	[82]	 = KEY_INSERT,
+	[83]	 = KEY_DELETE,
 	[96]	 = KEY_102ND,
-	[97]	 = KEY_KPASTERISK,	/* FIXME */
-	[98]	 = KEY_KPSLASH,
+	[97]	 = KEY_UNDO,
+	[98]	 = KEY_HELP,
 	[99]	 = KEY_KPLEFTPAREN,
 	[100]	 = KEY_KPRIGHTPAREN,
 	[101]	 = KEY_KPSLASH,
 	[102]	 = KEY_KPASTERISK,
-	[103]	 = KEY_UP,
-	[104]	 = KEY_KPASTERISK,	/* FIXME */
-	[105]	 = KEY_LEFT,
-	[106]	 = KEY_RIGHT,
-	[107]	 = KEY_KPASTERISK,	/* FIXME */
-	[108]	 = KEY_DOWN,
-	[109]	 = KEY_KPASTERISK,	/* FIXME */
-	[110]	 = KEY_KPASTERISK,	/* FIXME */
-	[111]	 = KEY_KPASTERISK,	/* FIXME */
-	[112]	 = KEY_KPASTERISK,	/* FIXME */
-	[113]	 = KEY_KPASTERISK	/* FIXME */
+	[103]	 = KEY_KP7,
+	[104]	 = KEY_KP8,
+	[105]	 = KEY_KP9,
+	[106]	 = KEY_KP4,
+	[107]	 = KEY_KP5,
+	[108]	 = KEY_KP6,
+	[109]	 = KEY_KP1,
+	[110]	 = KEY_KP2,
+	[111]	 = KEY_KP3,
+	[112]	 = KEY_KP0,
+	[113]	 = KEY_KPDOT,
+	[114]	 = KEY_KPENTER,
 };
 
 static struct input_dev *atakbd_dev;
@@ -195,7 +183,7 @@ static struct input_dev *atakbd_dev;
 static void atakbd_interrupt(unsigned char scancode, char down)
 {
 
-	if (scancode < 0x72) {		/* scancodes < 0xf2 are keys */
+	if (scancode < 0x73) {		/* scancodes < 0xf3 are keys */
 
 		// report raw events here?
 
@@ -209,7 +197,7 @@ static void atakbd_interrupt(unsigned ch
 			input_report_key(atakbd_dev, scancode, down);
 			input_sync(atakbd_dev);
 		}
-	} else				/* scancodes >= 0xf2 are mouse data, most likely */
+	} else				/* scancodes >= 0xf3 are mouse data, most likely */
 		printk(KERN_INFO "atakbd: unhandled scancode %x\n", scancode);
 
 	return;


