Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4902FECDFB8
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 073132075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 073132075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbeGRDjq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:39:46 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:37772 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731178AbeGRDjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:39:24 -0400
Received: from 89-71-158-145.dynamic.chello.pl ([89.71.158.145] helo=umbar.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1ffckX-0007zH-GG; Wed, 18 Jul 2018 05:03:36 +0200
Received: from kilobyte by umbar.angband.pl with local (Exim 4.91)
        (envelope-from <kilobyte@umbar.angband.pl>)
        id 1ffckX-0000AK-4l; Wed, 18 Jul 2018 05:03:33 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Wed, 18 Jul 2018 05:03:23 +0200
Message-Id: <20180718030327.579-2-kilobyte@angband.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718030327.579-1-kilobyte@angband.pl>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
 <20180718030327.579-1-kilobyte@angband.pl>
X-SA-Exim-Connect-IP: 89.71.158.145
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 2/6] vt: add console flag "unblinking"
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marks consoles that interpret the blink bit by showing bright background
instead.  Doesn't matter if the console can't do either.

For now, turn it on for fbcon when in color mode.  Vgacon can also do so
but requires setting appropriate VGA register (bit 3 of AMCR).  I don't
know other consoles: newport looks like it shows bright bg, sti can't do
either, mda appears to blink, etc -- but confirmation would be needed.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/tty/vt/vt.c              | 1 +
 drivers/video/fbdev/core/fbcon.c | 1 +
 include/linux/console_struct.h   | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 846dfedb657d..45057bbf6f74 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -998,6 +998,7 @@ static void visual_init(struct vc_data *vc, int num, int init)
 	vc->vc_hi_font_mask = 0;
 	vc->vc_complement_mask = 0;
 	vc->vc_can_do_color = 0;
+	vc->vc_unblinking = 0;
 	vc->vc_panic_force_write = false;
 	vc->vc_cur_blink_ms = DEFAULT_CURSOR_BLINK_MS;
 	vc->vc_sw->con_init(vc, init);
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index c910e74d46ff..4c67254f1ec4 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -1092,6 +1092,7 @@ static void fbcon_init(struct vc_data *vc, int init)
 
 	vc->vc_panic_force_write = !!(info->flags & FBINFO_CAN_FORCE_OUTPUT);
 	vc->vc_can_do_color = (fb_get_color_depth(&info->var, &info->fix)!=1);
+	vc->vc_unblinking = vc->vc_can_do_color;
 	vc->vc_complement_mask = vc->vc_can_do_color ? 0x7700 : 0x0800;
 	if (charcnt == 256) {
 		vc->vc_hi_font_mask = 0;
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index fea64f2692a0..f94b28a6bd2d 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
@@ -122,6 +122,7 @@ struct vc_data {
 	unsigned int	vc_ques		: 1;
 	unsigned int	vc_need_wrap	: 1;
 	unsigned int	vc_can_do_color	: 1;
+	unsigned int	vc_unblinking   : 1;	/* shows bright bg for blink */
 	unsigned int	vc_report_mouse : 2;
 	unsigned char	vc_utf		: 1;	/* Unicode UTF-8 encoding */
 	unsigned char	vc_utf_count;
-- 
2.18.0

