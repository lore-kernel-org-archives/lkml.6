Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DB0ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:54:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F2B572145D
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 11:54:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2B572145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729331AbeIXR4I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 13:56:08 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51710 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728423AbeIXR4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 13:56:08 -0400
Received: from localhost (ip-213-127-77-73.ip.prioritytelecom.net [213.127.77.73])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 87F401073;
        Mon, 24 Sep 2018 11:54:22 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Fredrik Noring <noring@nocrew.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.4 16/70] fbdev: Distinguish between interlaced and progressive modes
Date:   Mon, 24 Sep 2018 13:52:15 +0200
Message-Id: <20180924113100.344250285@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180924113058.420454070@linuxfoundation.org>
References: <20180924113058.420454070@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Fredrik Noring <noring@nocrew.org>

[ Upstream commit 1ba0a59cea41ea05fda92daaf2a2958a2246b9cf ]

I discovered the problem when developing a frame buffer driver for the
PlayStation 2 (not yet merged), using the following video modes for the
PlayStation 3 in drivers/video/fbdev/ps3fb.c:

    }, {
        /* 1080if */
        "1080if", 50, 1920, 1080, 13468, 148, 484, 36, 4, 88, 5,
        FB_SYNC_BROADCAST, FB_VMODE_INTERLACED
    }, {
        /* 1080pf */
        "1080pf", 50, 1920, 1080, 6734, 148, 484, 36, 4, 88, 5,
        FB_SYNC_BROADCAST, FB_VMODE_NONINTERLACED
    },

In ps3fb_probe, the mode_option module parameter is used with fb_find_mode
but it can only select the interlaced variant of 1920x1080 since the loop
matching the modes does not take the difference between interlaced and
progressive modes into account.

In short, without the patch, progressive 1920x1080 cannot be chosen as a
mode_option parameter since fb_find_mode (falsely) thinks interlace is a
perfect match.

Signed-off-by: Fredrik Noring <noring@nocrew.org>
Cc: "Maciej W. Rozycki" <macro@linux-mips.org>
[b.zolnierkie: updated patch description]
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/video/fbdev/core/modedb.c |   41 +++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

--- a/drivers/video/fbdev/core/modedb.c
+++ b/drivers/video/fbdev/core/modedb.c
@@ -644,7 +644,7 @@ static int fb_try_mode(struct fb_var_scr
  *
  *     Valid mode specifiers for @mode_option:
  *
- *     <xres>x<yres>[M][R][-<bpp>][@<refresh>][i][m] or
+ *     <xres>x<yres>[M][R][-<bpp>][@<refresh>][i][p][m] or
  *     <name>[-<bpp>][@<refresh>]
  *
  *     with <xres>, <yres>, <bpp> and <refresh> decimal numbers and
@@ -653,10 +653,10 @@ static int fb_try_mode(struct fb_var_scr
  *      If 'M' is present after yres (and before refresh/bpp if present),
  *      the function will compute the timings using VESA(tm) Coordinated
  *      Video Timings (CVT).  If 'R' is present after 'M', will compute with
- *      reduced blanking (for flatpanels).  If 'i' is present, compute
- *      interlaced mode.  If 'm' is present, add margins equal to 1.8%
- *      of xres rounded down to 8 pixels, and 1.8% of yres. The char
- *      'i' and 'm' must be after 'M' and 'R'. Example:
+ *      reduced blanking (for flatpanels).  If 'i' or 'p' are present, compute
+ *      interlaced or progressive mode.  If 'm' is present, add margins equal
+ *      to 1.8% of xres rounded down to 8 pixels, and 1.8% of yres. The chars
+ *      'i', 'p' and 'm' must be after 'M' and 'R'. Example:
  *
  *      1024x768MR-8@60m - Reduced blank with margins at 60Hz.
  *
@@ -697,7 +697,8 @@ int fb_find_mode(struct fb_var_screeninf
 		unsigned int namelen = strlen(name);
 		int res_specified = 0, bpp_specified = 0, refresh_specified = 0;
 		unsigned int xres = 0, yres = 0, bpp = default_bpp, refresh = 0;
-		int yres_specified = 0, cvt = 0, rb = 0, interlace = 0;
+		int yres_specified = 0, cvt = 0, rb = 0;
+		int interlace_specified = 0, interlace = 0;
 		int margins = 0;
 		u32 best, diff, tdiff;
 
@@ -748,9 +749,17 @@ int fb_find_mode(struct fb_var_screeninf
 				if (!cvt)
 					margins = 1;
 				break;
+			case 'p':
+				if (!cvt) {
+					interlace = 0;
+					interlace_specified = 1;
+				}
+				break;
 			case 'i':
-				if (!cvt)
+				if (!cvt) {
 					interlace = 1;
+					interlace_specified = 1;
+				}
 				break;
 			default:
 				goto done;
@@ -819,11 +828,21 @@ done:
 			if ((name_matches(db[i], name, namelen) ||
 			     (res_specified && res_matches(db[i], xres, yres))) &&
 			    !fb_try_mode(var, info, &db[i], bpp)) {
-				if (refresh_specified && db[i].refresh == refresh)
-					return 1;
+				const int db_interlace = (db[i].vmode &
+					FB_VMODE_INTERLACED ? 1 : 0);
+				int score = abs(db[i].refresh - refresh);
+
+				if (interlace_specified)
+					score += abs(db_interlace - interlace);
+
+				if (!interlace_specified ||
+				    db_interlace == interlace)
+					if (refresh_specified &&
+					    db[i].refresh == refresh)
+						return 1;
 
-				if (abs(db[i].refresh - refresh) < diff) {
-					diff = abs(db[i].refresh - refresh);
+				if (score < diff) {
+					diff = score;
 					best = i;
 				}
 			}


