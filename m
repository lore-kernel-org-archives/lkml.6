Return-Path: <SRS0=FObM=LF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CB2FC43615
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39796214DC
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Aug 2018 08:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="MCq6AGIH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39796214DC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728570AbeHVMSP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Aug 2018 08:18:15 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:40183 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728484AbeHVMSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Aug 2018 08:18:13 -0400
Received: by mail-ed1-f54.google.com with SMTP id e19-v6so899726edq.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Aug 2018 01:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zjs9x1oRZvQ/469mWNn9ds5wt7/ZxVRBNDZEAc3LgHc=;
        b=MCq6AGIHplZ8mg8+RFumNmkyyAsofDMA7fCabl1RC6fZtW2HSsFHZob/Vq1Ug6pyq5
         D4cCCKiJT7KYV3Xu7S/Dv7D3n83o3A40QLIJVThw4eT06a9cs++5lE3xwZlayDSU9tZ+
         VASAhioL+/Z8H8eGB4ikgiA2NfiPsnmUoNMy8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zjs9x1oRZvQ/469mWNn9ds5wt7/ZxVRBNDZEAc3LgHc=;
        b=ToYsAr/n3ISisQ2nz1I6TIgSd7IJeiumkfOZLfvdpcznqD1CZQ+kvm87zWgPpnfjS8
         Z2D6KSwnpgid59ZPfE7+igySUt6BnHDgnLn8AUr2mkobeSyFW42RhVVyvSIRd2viNTC0
         dhKRiozzmYrv3LFn4X1C5jlWwZxPq3Iy4kUGkUIpY62Cj+O52c8ajc38THSDuCwM7Zpc
         ccMuzlSrfWSNe80VfODji86HCiz+ny3GITM5/ZUws/9YDf7PFKot5TtkqRvywW0RUR3L
         6fQBIf5e45M7XbYaFqusrxE/7+WwvoU1iMMq4s9Qe3t5TU6duAzuMJ2sSsj8cdeZluV1
         jkRA==
X-Gm-Message-State: APzg51DKmvrGUtGHQKwrmlihla+KxpqBxAEfOutCLLHh05/WYPeJoTvv
        XyqEvavlg4FD2CYqKQXamrBrig==
X-Google-Smtp-Source: ANB0VdY8T593JMrcxWGo9oh1uiBPFe8/Squdn67Xe+79fGjX7np2VCoYVuPL7KojlAXT1YIMCr1HYg==
X-Received: by 2002:aa7:d3c2:: with SMTP id o2-v6mr4758106edr.29.1534928055054;
        Wed, 22 Aug 2018 01:54:15 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-109.fiber7.init7.net. [212.51.149.109])
        by smtp.gmail.com with ESMTPSA id r21-v6sm636418eds.7.2018.08.22.01.54.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Aug 2018 01:54:14 -0700 (PDT)
From:   Daniel Vetter <daniel.vetter@ffwll.ch>
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>,
        Meng Xu <mengxu.gatech@gmail.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        Thomas Meyer <thomas@m3y3r.de>,
        Mike Frysinger <vapier@chromium.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <treding@nvidia.com>,
        David Lechner <david@lechnology.com>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Daniel Vetter <daniel.vetter@intel.com>
Subject: [PATCH 2/4] vt: Remove vc_panic_force_write
Date:   Wed, 22 Aug 2018 10:54:03 +0200
Message-Id: <20180822085405.10787-2-daniel.vetter@ffwll.ch>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
References: <20180822085405.10787-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It was only used by the panic support in fbcon, which is now gone.
Remove this now dead code too.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Joe Perches <joe@perches.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Meng Xu <mengxu.gatech@gmail.com>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Thomas Meyer <thomas@m3y3r.de>
Cc: Mike Frysinger <vapier@chromium.org>
Cc: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Thierry Reding <treding@nvidia.com>
Cc: David Lechner <david@lechnology.com>
Cc: Philippe Ombredanne <pombredanne@nexb.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>
Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
---
 drivers/tty/vt/vt.c              | 12 ++++--------
 drivers/video/fbdev/core/fbcon.c |  3 +--
 include/linux/console_struct.h   |  1 -
 include/linux/vt_kern.h          |  7 -------
 4 files changed, 5 insertions(+), 18 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 15eb6c829d39..6d41b14e4fc7 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -700,9 +700,7 @@ void redraw_screen(struct vc_data *vc, int is_switch)
 			clear_buffer_attributes(vc);
 		}
 
-		/* Forcibly update if we're panicing */
-		if ((update && vc->vc_mode != KD_GRAPHICS) ||
-		    vt_force_oops_output(vc))
+		if (update && vc->vc_mode != KD_GRAPHICS)
 			do_update_region(vc, vc->vc_origin, vc->vc_screenbuf_size / 2);
 	}
 	set_cursor(vc);
@@ -742,7 +740,6 @@ static void visual_init(struct vc_data *vc, int num, int init)
 	vc->vc_hi_font_mask = 0;
 	vc->vc_complement_mask = 0;
 	vc->vc_can_do_color = 0;
-	vc->vc_panic_force_write = false;
 	vc->vc_cur_blink_ms = DEFAULT_CURSOR_BLINK_MS;
 	vc->vc_sw->con_init(vc, init);
 	if (!vc->vc_complement_mask)
@@ -2576,7 +2573,7 @@ static void vt_console_print(struct console *co, const char *b, unsigned count)
 		goto quit;
 	}
 
-	if (vc->vc_mode != KD_TEXT && !vt_force_oops_output(vc))
+	if (vc->vc_mode != KD_TEXT)
 		goto quit;
 
 	/* undraw cursor first */
@@ -3894,8 +3891,7 @@ void do_unblank_screen(int leaving_gfx)
 		return;
 	}
 	vc = vc_cons[fg_console].d;
-	/* Try to unblank in oops case too */
-	if (vc->vc_mode != KD_TEXT && !vt_force_oops_output(vc))
+	if (vc->vc_mode != KD_TEXT)
 		return; /* but leave console_blanked != 0 */
 
 	if (blankinterval) {
@@ -3904,7 +3900,7 @@ void do_unblank_screen(int leaving_gfx)
 	}
 
 	console_blanked = 0;
-	if (vc->vc_sw->con_blank(vc, 0, leaving_gfx) || vt_force_oops_output(vc))
+	if (vc->vc_sw->con_blank(vc, 0, leaving_gfx))
 		/* Low-level driver cannot restore -> do it ourselves */
 		update_screen(vc);
 	if (console_blank_hook)
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 2b5bb52b1798..4541bc17573e 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -284,8 +284,7 @@ static inline int fbcon_is_inactive(struct vc_data *vc, struct fb_info *info)
 	struct fbcon_ops *ops = info->fbcon_par;
 
 	return (info->state != FBINFO_STATE_RUNNING ||
-		vc->vc_mode != KD_TEXT || ops->graphics) &&
-		!vt_force_oops_output(vc);
+		vc->vc_mode != KD_TEXT || ops->graphics);
 }
 
 static int get_color(struct vc_data *vc, struct fb_info *info,
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index c0ec478ea5bf..c96e7f5f7c77 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -140,7 +140,6 @@ struct vc_data {
 	struct vc_data **vc_display_fg;		/* [!] Ptr to var holding fg console for this display */
 	struct uni_pagedir *vc_uni_pagedir;
 	struct uni_pagedir **vc_uni_pagedir_loc; /* [!] Location of uni_pagedir variable for this console */
-	bool vc_panic_force_write; /* when oops/panic this VC can accept forced output/blanking */
 	/* additional information is in vt_kern.h */
 };
 
diff --git a/include/linux/vt_kern.h b/include/linux/vt_kern.h
index 3fd07912909c..8dc77e40bc03 100644
--- a/include/linux/vt_kern.h
+++ b/include/linux/vt_kern.h
@@ -135,13 +135,6 @@ extern int do_unbind_con_driver(const struct consw *csw, int first, int last,
 			     int deflt);
 int vty_init(const struct file_operations *console_fops);
 
-static inline bool vt_force_oops_output(struct vc_data *vc)
-{
-	if (oops_in_progress && vc->vc_panic_force_write  && panic_timeout >= 0)
-		return true;
-	return false;
-}
-
 extern char vt_dont_switch;
 extern int default_utf8;
 extern int global_cursor_default;
-- 
2.18.0

