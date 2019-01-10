Return-Path: <SRS0=lBHl=PS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5561C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:40:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D820206B7
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Jan 2019 16:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="PVLSnkNV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728506AbfAJQkd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Jan 2019 11:40:33 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36006 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727807AbfAJQkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jan 2019 11:40:33 -0500
Received: by mail-qt1-f195.google.com with SMTP id t13so13837540qtn.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jan 2019 08:40:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=mBcQZOKa9Newdq27djWne7nwXId0AwdhV+OFwusDdUk=;
        b=PVLSnkNVkz+k8XlAsQvBOYKuNdz/ihk/xPmhwj7IUnS28W1LA89pJz/8OECRk3/gp6
         F0dpAJtHYko3q/6vREzw2YDtFbZjV83cSK5tYsqQhfm5C237jiiwZJGlgQdXuRTim9Ts
         K2EmKmCDwwMCpNM64HkzoNiFj4nHiuxsnnN1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=mBcQZOKa9Newdq27djWne7nwXId0AwdhV+OFwusDdUk=;
        b=JaYxDTou4sMocx3CwCto1NfKwyP82qx4rFX6SfizEPq9OAAbnCZZK0Mc4raN/niw/S
         dkop09xwZXd8ghTgD5jX93zXY61wzlPgLJr8XgkLW37rCotXLuou8FSZlZaEqC2v9H+t
         NBM5H2mEzXkI3ZiGAqtMK0pVbjPff4/dIdZBahIsma4VLUeQieg7MgI5GGUIfYngmLJL
         gvUsNiYHsJnlwzs8kJwJTFoKYSmDiQdkaxCBHPzWQUsxHWkAZljsbLlIRnsCas3lygNf
         Pb9AKCyQS2q9JX02hhLZ2FUd2KAxzehAhVSOT6EE/R30ZlafrJjKivrTVOzwFKoY6/0b
         HvSw==
X-Gm-Message-State: AJcUukcwmVNM6lpGZpcSfY5HpM0UrOC84LlnL6geS/usKEsnsyTqxh6u
        N3mIoZBnjhEdzmJ5xQ/Kz4yNAw==
X-Google-Smtp-Source: ALg8bN4ugVZtGHYaf+MZK593b+r+eJ6tGA/gBOjKO0uKYoiMvii+r5Vyp6x8QCWWYwHSgfynAV8wjg==
X-Received: by 2002:a37:7a06:: with SMTP id v6mr9609481qkc.10.1547138431918;
        Thu, 10 Jan 2019 08:40:31 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id c12sm47814698qka.42.2019.01.10.08.40.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 10 Jan 2019 08:40:31 -0800 (PST)
Date:   Thu, 10 Jan 2019 11:40:29 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Greg KH <gregkh@linuxfoundation.org>
cc:     Dave Mielke <dave@mielke.cc>, linux-kernel@vger.kernel.org
Subject: [PATCH] vgacon: unconfuse vc_origin when using soft scrollback
Message-ID: <nycvar.YSQ.7.76.1901101131090.6027@knanqh.ubzr>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_VGACON_SOFT_SCROLLBACK is selected, the VGA display memory
index and vc_visible_origin don't change when scrollback is activated.
The actual screen content is saved away and the scrollbackdata is copied
over it. However the vt code, and /dev/vcs devices in particular, still
expect vc_origin to always point at the actual screen content not the
displayed scrollback content.

So adjust vc_origin to point at the saved screen content when scrollback
is active and set it back to vc_visible_origin when restoring the screen.

This fixes /dev/vcsa<n> that return scrollback content when they
shouldn't (onli /dev/vcsa without a number should), and also fixes
/dev/vcsu that should return scrollback content when scrollback is
active but currently doesn't.

An unnecessary call to vga_set_mem_top() is also removed.

Signed-off-by: Nicolas Pitre <nico@linaro.org>
Cc: stable@vger.kernel.org # v4.19+

---

I tagged it for stable starting with v4.19 as this is the kernel that
introduced /dev/vcsu* which is directly affected. Users of earlier kernels
most likely won't care.

diff --git a/drivers/video/console/vgacon.c b/drivers/video/console/vgacon.c
index 09731b2f68..a3353a9970 100644
--- a/drivers/video/console/vgacon.c
+++ b/drivers/video/console/vgacon.c
@@ -271,6 +271,7 @@ static void vgacon_scrollback_update(struct vc_data *c, int t, int count)
 
 static void vgacon_restore_screen(struct vc_data *c)
 {
+	c->vc_origin = c->vc_visible_origin;
 	vgacon_scrollback_cur->save = 0;
 
 	if (!vga_is_gfx && !vgacon_scrollback_cur->restore) {
@@ -287,8 +288,7 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
 	int start, end, count, soff;
 
 	if (!lines) {
-		c->vc_visible_origin = c->vc_origin;
-		vga_set_mem_top(c);
+		vgacon_restore_screen(c);
 		return;
 	}
 
@@ -298,6 +298,7 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
 	if (!vgacon_scrollback_cur->save) {
 		vgacon_cursor(c, CM_ERASE);
 		vgacon_save_screen(c);
+		c->vc_origin = c->vc_screenbuf;
 		vgacon_scrollback_cur->save = 1;
 	}
 
@@ -335,7 +336,7 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
 		int copysize;
 
 		int diff = c->vc_rows - count;
-		void *d = (void *) c->vc_origin;
+		void *d = (void *) c->vc_visible_origin;
 		void *s = (void *) c->vc_screenbuf;
 
 		count *= c->vc_size_row;
