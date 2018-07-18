Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E712BECDFB4
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:04:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A580E2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 03:04:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A580E2075E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=angband.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731724AbeGRDjh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 23:39:37 -0400
Received: from tartarus.angband.pl ([89.206.35.136]:37804 "EHLO
        tartarus.angband.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731567AbeGRDj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 23:39:26 -0400
Received: from 89-71-158-145.dynamic.chello.pl ([89.71.158.145] helo=umbar.angband.pl)
        by tartarus.angband.pl with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <kilobyte@angband.pl>)
        id 1ffckZ-0007zP-KD; Wed, 18 Jul 2018 05:03:41 +0200
Received: from kilobyte by umbar.angband.pl with local (Exim 4.91)
        (envelope-from <kilobyte@umbar.angband.pl>)
        id 1ffckZ-0000AW-AE; Wed, 18 Jul 2018 05:03:35 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, linux-console@vger.kernel.org,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Adam Borowski <kilobyte@angband.pl>
Date:   Wed, 18 Jul 2018 05:03:27 +0200
Message-Id: <20180718030327.579-6-kilobyte@angband.pl>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180718030327.579-1-kilobyte@angband.pl>
References: <20180718030152.kdq53mwpdfusvwl5@angband.pl>
 <20180718030327.579-1-kilobyte@angband.pl>
X-SA-Exim-Connect-IP: 89.71.158.145
X-SA-Exim-Mail-From: kilobyte@angband.pl
Subject: [PATCH 6/6] vt: support bright backgrounds for \e[48m if unblinking
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on tartarus.angband.pl)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This improves schemes used by fancy new programs.  For example, it lets
bright powerline segments match, and fixes images shown by catimg being
striped to the point of unreadability.

Handling of 8-color backgrounds uses stripped 16-color value instead of a
dedicated formula; this works worse for dark and better for bright inputs.

Signed-off-by: Adam Borowski <kilobyte@angband.pl>
---
 drivers/tty/vt/vt.c | 38 +++++++++++++++++---------------------
 1 file changed, 17 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index c777f4c91df0..7fcb0ff2dccf 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1555,7 +1555,7 @@ static void rgb_from_256(int i, struct rgb *c)
 		c->r = c->g = c->b = i * 10 - 2312;
 }
 
-static void rgb_foreground(struct vc_data *vc, const struct rgb *c)
+static u8 rgb_to_16(const struct rgb *c)
 {
 	u8 hue = 0, max = max3(c->r, c->g, c->b);
 
@@ -1566,22 +1566,12 @@ static void rgb_foreground(struct vc_data *vc, const struct rgb *c)
 	if (c->b > max / 2 + 32)
 		hue |= 1;
 
-	if (hue == 7 && max <= 0x70) {
-		hue = 0;
-		vc->vc_intensity = 2;
-	} else if (max > 0xc0)
-		vc->vc_intensity = 2;
+	if (hue == 7 && max <= 0x70)
+		return 8;
+	if (max > 0xc0)
+		return hue | 8;
 	else
-		vc->vc_intensity = 1;
-
-	vc->vc_color = (vc->vc_color & 0xf0) | hue;
-}
-
-static void rgb_background(struct vc_data *vc, const struct rgb *c)
-{
-	/* For backgrounds, err on the dark side. */
-	vc->vc_color = (vc->vc_color & 0x0f)
-		| (c->r&0x80) >> 1 | (c->g&0x80) >> 2 | (c->b&0x80) >> 3;
+		return hue;
 }
 
 /*
@@ -1593,10 +1583,10 @@ static void rgb_background(struct vc_data *vc, const struct rgb *c)
  * Subcommands 3 (CMY) and 4 (CMYK) are so insane there's no point in
  * supporting them.
  */
-static int vc_t416_color(struct vc_data *vc, int i,
-		void(*set_color)(struct vc_data *vc, const struct rgb *c))
+static int vc_t416_color(struct vc_data *vc, int i, int bgshift)
 {
 	struct rgb c;
+	u8 v;
 
 	i++;
 	if (i > vc->vc_npar)
@@ -1615,7 +1605,13 @@ static int vc_t416_color(struct vc_data *vc, int i,
 	} else
 		return i;
 
-	set_color(vc, &c);
+	v = rgb_to_16(&c);
+
+	vc->vc_color = (vc->vc_color & (0xf0 >> bgshift)) | v << bgshift;
+	if (!bgshift)
+		vc->vc_intensity = (v & 8 >> 4) + 1;
+	else if (vc->vc_unblinking)
+		vc->vc_blink = v & 8 >> 4;
 
 	return i;
 }
@@ -1695,10 +1691,10 @@ static void csi_m(struct vc_data *vc)
 			vc->vc_reverse = 0;
 			break;
 		case 38:
-			i = vc_t416_color(vc, i, rgb_foreground);
+			i = vc_t416_color(vc, i, 0);
 			break;
 		case 48:
-			i = vc_t416_color(vc, i, rgb_background);
+			i = vc_t416_color(vc, i, 4);
 			break;
 		case 39:
 			vc->vc_color = (vc->vc_def_color & 0x0f) |
-- 
2.18.0

