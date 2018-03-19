Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S972052AbeCSV4I (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 17:56:08 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:35587 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934269AbeCSP4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:56:55 -0400
X-Google-Smtp-Source: AG47ELsVLxFtq2k4tmPvuqCsG78Gor6YjY8U5a+dS0CC4ImD7VpsPCGa2f0zOdP4+2QzwI1Odb2Taw==
From: Pratik Jain <pratik.jain0509@gmail.com>
To: arnaud.patard@rtp-net.org
Cc: linux-kernel@vger.kernel.org, Pratik Jain <pratik.jain0509@gmail.com>
Subject: [PATCH] Staging: xgifb: XGI_main_26.c: Refactored the function
Date: Mon, 19 Mar 2018 21:26:26 +0530
Message-Id: <20180319155626.28568-1-pratik.jain0509@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactored the function `XGIfb_search_refresh_rate` by removing a level
of `if...else` block nesting. Removed unnecessary parantheses.

Signed-off-by: Pratik Jain <pratik.jain0509@gmail.com>
---
 drivers/staging/xgifb/XGI_main_26.c | 63 +++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/xgifb/XGI_main_26.c b/drivers/staging/xgifb/XGI_main_26.c
index 10107de0119a..ef9a726cd35d 100644
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
+		++i;
+
+	while (XGIfb_vrate[i].idx != 0 && XGIfb_vrate[i].xres <= xres) {
+		if (XGIfb_vrate[i].yres != yres) {
+			++i;
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
-		i++;
+		++i;
 	}
+
 	if (xgifb_info->rate_idx > 0)
 		return xgifb_info->rate_idx;
 	pr_info("Unsupported rate %d for %dx%d\n",
-- 
2.16.2
