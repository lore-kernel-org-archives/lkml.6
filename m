Return-Path: <pratik.jain0509@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521546862; cv=none;
        d=google.com; s=arc-20160816;
        b=uSHBtltcHjZ9foU3lLGcB7d4bi+Yef2DRwfOQEnYRvMD167qNTAoU+B9tvTDaJkLBc
         iaO1teIe00YvoLackfyeOxdivypB22ojkALXcLZOWb3cZi9ivPICPOdUWnOzIwd/QWtm
         2iwVHS6b0tO+eoqtgk1Dp8GV9NAWCxJpk3FTvFbwty1epanAs3uqlrFindhMcC4fuAGb
         H8z9Zwx+JbO8A8XLrh2saIMrP8MsRC9w/dGsnis4CQxVJUK+9aVo1lTcNBCinTNP+bLq
         dYb0hdxWKtn131iyqJU1RmWQDZeS1zGZ9QA3C4zyFMnGayNM/FqIRCHu71z227sAMzkU
         rYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :dkim-signature:arc-authentication-results;
        bh=bVmbjnH8wkTLnd0XH14FUOrTwre9W8YtbCCXiOivN58=;
        b=vWIu+CP4E9x71mFiS5QLFNqO85DIXhaFAoNDyokOPXPjJq2aUbAJ2d3r9o5n7NCuu4
         aBSdVKIPD7SWch08fitqwsFLkTvWaQViYEHUsmFtonIU+jJRe0r9EBnJFV7hUvF8x2CY
         iHhtcZsTgtU2WNkgkrLLrWZZ8nt1mSejUc7BRDPExqYXt1Zj9DLbm2vM9Q9+OMcc9wbL
         Y8Nl66RpOGEV/QzePSvJW9eqrTy2Qd8D351iVQ6gHDEy8aDr0ZrUtToA2FuGx+jqH7uA
         jd5K2QvhZhy/40xDsCdhoyOqlRT/X5NVGPKuMIkh8ki8pIOE+Z9piDgPxo5uS3N7Y2Qo
         /GTw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pJLksgqU;
       spf=pass (google.com: domain of pratik.jain0509@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=pratik.jain0509@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=pJLksgqU;
       spf=pass (google.com: domain of pratik.jain0509@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=pratik.jain0509@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtOEiJGkL+QkEHWNlo+SETA8QQ1KfArZXUD5VFuiNgDIZbjK+MjlEalwijZmLvyRgvZyj4SRg==
From: Pratik Jain <pratik.jain0509@gmail.com>
To: arnaud.patard@rtp-net.org
Cc: linux-kernel@vger.kernel.org,
	devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org,
	Pratik Jain <pratik.jain0509@gmail.com>
Subject: [PATCH] Staging: xgifb: XGI_main_26.c: Refactored the function
Date: Tue, 20 Mar 2018 17:24:13 +0530
Message-Id: <20180320115413.20561-1-pratik.jain0509@gmail.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320114111.GA18734@archlinux>
References: <20180320114111.GA18734@archlinux>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595445043191954085?=
X-GMAIL-MSGID: =?utf-8?q?1595457523454608273?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Refactored the function `XGIfb_search_refresh_rate` by removing a level
of `if...else` block nesting. Removed unnecessary parantheses.

Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
---
 drivers/staging/xgifb/XGI_main_26.c | 61 +++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/xgifb/XGI_main_26.c b/drivers/staging/xgifb/XGI_main_26.c
index 10107de0119a..7bbc12f3146f 100644
--- a/drivers/staging/xgifb/XGI_main_26.c
+++ b/drivers/staging/xgifb/XGI_main_26.c
@@ -544,41 +544,44 @@ static u8 XGIfb_search_refresh_rate(struct xgifb_video_info *xgifb_info,
 	yres = XGIbios_mode[xgifb_info->mode_idx].yres;
 
 	xgifb_info->rate_idx = 0;
-	while ((XGIfb_vrate[i].idx != 0) && (XGIfb_vrate[i].xres <= xres)) {
-		if ((XGIfb_vrate[i].xres == xres) &&
-		    (XGIfb_vrate[i].yres == yres)) {
-			if (XGIfb_vrate[i].refresh == rate) {
+	
+	// Skip values with less xres
+	while (XGIfb_vrate[i].idx != 0 && XGIfb_vrate[i].xres < xres)
+		i++;
+
+	while (XGIfb_vrate[i].idx != 0 && XGIfb_vrate[i].xres <= xres) {
+		if (XGIfb_vrate[i].yres != yres) {
+			i++;
+			continue;
+		}
+		if (XGIfb_vrate[i].refresh == rate) {
+			xgifb_info->rate_idx = XGIfb_vrate[i].idx;
+			break;
+		} else if (XGIfb_vrate[i].refresh > rate) {
+			if (XGIfb_vrate[i].refresh - rate <= 3) {
+				pr_debug("Adjusting rate from %d up to %d\n",
+					rate, XGIfb_vrate[i].refresh);
 				xgifb_info->rate_idx = XGIfb_vrate[i].idx;
-				break;
-			} else if (XGIfb_vrate[i].refresh > rate) {
-				if ((XGIfb_vrate[i].refresh - rate) <= 3) {
-					pr_debug("Adjusting rate from %d up to %d\n",
-						 rate, XGIfb_vrate[i].refresh);
-					xgifb_info->rate_idx =
-						XGIfb_vrate[i].idx;
-					xgifb_info->refresh_rate =
-						XGIfb_vrate[i].refresh;
-				} else if (((rate - XGIfb_vrate[i - 1].refresh)
-						<= 2) && (XGIfb_vrate[i].idx
-						!= 1)) {
-					pr_debug("Adjusting rate from %d down to %d\n",
-						 rate,
-						 XGIfb_vrate[i - 1].refresh);
-					xgifb_info->rate_idx =
-						XGIfb_vrate[i - 1].idx;
-					xgifb_info->refresh_rate =
-						XGIfb_vrate[i - 1].refresh;
-				}
-				break;
-			} else if ((rate - XGIfb_vrate[i].refresh) <= 2) {
+				xgifb_info->refresh_rate =
+					XGIfb_vrate[i].refresh;
+			} else if ((rate - XGIfb_vrate[i - 1].refresh <= 2)
+					&& (XGIfb_vrate[i].idx != 1)) {
 				pr_debug("Adjusting rate from %d down to %d\n",
-					 rate, XGIfb_vrate[i].refresh);
-				xgifb_info->rate_idx = XGIfb_vrate[i].idx;
-				break;
+					rate, XGIfb_vrate[i - 1].refresh);
+				xgifb_info->rate_idx = XGIfb_vrate[i - 1].idx;
+				xgifb_info->refresh_rate =
+					XGIfb_vrate[i - 1].refresh;
 			}
+			break;
+		} else if (rate - XGIfb_vrate[i].refresh <= 2) {
+			pr_debug("Adjusting rate from %d down to %d\n",
+				rate, XGIfb_vrate[i].refresh);
+			xgifb_info->rate_idx = XGIfb_vrate[i].idx;
+			break;
 		}
 		i++;
 	}
+
 	if (xgifb_info->rate_idx > 0)
 		return xgifb_info->rate_idx;
 	pr_info("Unsupported rate %d for %dx%d\n",
-- 
2.16.2
