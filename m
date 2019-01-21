Return-Path: <SRS0=RWde=P5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B007C282DB
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:44:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DC8492084A
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Jan 2019 07:44:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="KCjAlSqB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728942AbfAUHoM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Jan 2019 02:44:12 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35738 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728485AbfAUHoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jan 2019 02:44:12 -0500
Received: by mail-qk1-f195.google.com with SMTP id w204so11790168qka.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Jan 2019 23:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=CpPMpjhb3lB7s2KZRGykFLTqswu/y32QmJo5HrnL5As=;
        b=KCjAlSqBfUlpr6/bNNZ+/b91cOD0xLSe3kXpnY5Yk9HPexVMeUzNhyfH6ktzaK1MAp
         EtfDpkT/HtwBVjuWcJzqENGd+VjLy7AVtVNCWQm5BuTr7++iEfgVEbB+q/3fIaU7OzUV
         7FVPLoGOeO68HM16Ks9S5KudqpEfUmzaZbe0I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=CpPMpjhb3lB7s2KZRGykFLTqswu/y32QmJo5HrnL5As=;
        b=qcouVp62cPD1eKwtgUNmNl1Sis4xDX+XsOrKVzLxlni5jyza3W1sYTZcTc582OqmBW
         S3kwxj+z63+WcUMWe+uVZ1Gcb1d86Yxj7UlO+HIndxaLiRbu/ghG3zX9oLE3VSyGuIg0
         kaVEc34pzIUFFJDMiQuo+YalV1+ARMtuGscnxzvIjqqKwg74VoaYrZkf0xQKn392INXS
         Bl3Qpk3ICN6hx/MXxkvvRg+hbVSia9vcRO5YWLX3a0jS0XFNOYJwGe+ujZ2KU3VaWtag
         bzaKIIOXjnoE3BQ/+oos86bYqOF4NFsJSYxjb4q8VTGBMc9ddxz7gMNJDRv3wyLT9LLz
         oseQ==
X-Gm-Message-State: AJcUukfcJ5YbVdJNlnscwc3ive6AznkHAWtgSPy7SPPZx5zY/TjR16Qm
        fjEKp9NPdY9tTZ0NK2sJXnQBHbPfLyU=
X-Google-Smtp-Source: ALg8bN6R2/QyUJi0/wNJRBZmF/ZpIUgEZ/+Gx0loI9iAU3lObbZbx53pVBlhpwNcy1RrK9yk+hJYHA==
X-Received: by 2002:a37:4b44:: with SMTP id y65mr22477595qka.316.1548044538138;
        Sun, 20 Jan 2019 20:22:18 -0800 (PST)
Received: from xanadu.home (modemcable228.104-82-70.mc.videotron.ca. [70.82.104.228])
        by smtp.gmail.com with ESMTPSA id c48sm67891799qtd.9.2019.01.20.20.22.16
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 Jan 2019 20:22:17 -0800 (PST)
Date:   Sun, 20 Jan 2019 23:22:11 -0500 (EST)
From:   Nicolas Pitre <nicolas.pitre@linaro.org>
To:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vgacon: unconfuse vc_origin when using soft scrollback
Message-ID: <nycvar.YSQ.7.76.1901202317500.1525@knanqh.ubzr>
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
index 09731b2f68..c6b3bdbbdb 100644
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
+		c->vc_origin = (unsigned long)c->vc_screenbuf;
 		vgacon_scrollback_cur->save = 1;
 	}
 
@@ -335,7 +336,7 @@ static void vgacon_scrolldelta(struct vc_data *c, int lines)
 		int copysize;
 
 		int diff = c->vc_rows - count;
-		void *d = (void *) c->vc_origin;
+		void *d = (void *) c->vc_visible_origin;
 		void *s = (void *) c->vc_screenbuf;
 
 		count *= c->vc_size_row;
