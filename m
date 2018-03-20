Return-Path: <pratik.jain0509@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521534960; cv=none;
        d=google.com; s=arc-20160816;
        b=oaWrCkLIayXoMA4y/cI7q270kYbOXlJNKZjbQnVP1bR+iuO+MN5RjozHilo5GlERqq
         8g6Y72whc746acmvh0ksY5a7Psu5XRsw1pKgUXgZkgvdM3xOqRPJBI1usYqSweuaE2Ng
         MvGXdl3O6tBzj05MwFjPkbVxT9FXDAwQsi7cslMLJjkSwmjFByPBNNSM0x1SGWCwmrOg
         k1DhBpcFolQ8+bm+cIIH0NVmLF/bP/dI3Mox6zm1tyHAfGV0M3vqEeeZF/JbYj5x4ryT
         O1jNjN/L5rj43c2Ryh0s/OS8Zhn84B2pSk8XnCnmMwPk1DICrgyIhBIZkLfHEnQY4eRK
         tVcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=message-id:date:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=xEMrbHJt0TH9RNvzHLFDtOZKiVUX/9zpY5KNfHTTzmM=;
        b=DJk6kaF8cnfRKgj+AQ1/5KqvdoEFPmhzXm7yzCPMQYyqF5x9t3XyMW/Oe3Xm+pX4D8
         QNgNjGOw7Kjk1Kpyacvipk9l87qiKiv2uyVox8Ejxmf89Yud8LgwO7A6ymchVsh2d8Bm
         +DmE4bJflr6P8EjbtPAXN5ajiMSfcBu+sUFstAcAch6TdLhPJ+1L0AvUroM2QXSejIs3
         yyA/TTDjBMjGMnskr+MGTFxI2+McNkBXN8sB0cDAvm0USkj0RGHmcDNrWqfnVwIup5OA
         nURDhRuKs5oJUhre+xhcv0PV9OXD06iFcdASe2HgN+elJpZu6DO1/Q7swdpmxo+rPwU1
         rOcw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HFaNS0S8;
       spf=pass (google.com: domain of pratik.jain0509@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=pratik.jain0509@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=HFaNS0S8;
       spf=pass (google.com: domain of pratik.jain0509@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=pratik.jain0509@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELt0dvtkgeKsu1V5lvL/Xzabjoi4ZFrYWaY/jo2S62KvpPgVIYOR5ira6NtQMbVA2tKsGcQ14Q==
From: Pratik Jain <pratik.jain0509@gmail.com>
To: arnaud.patard@rtp-net.org
Cc: linux-kernel@vger.kernel.org,
	devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org,
	Pratik Jain <pratik.jain0509@gmail.com>
Subject: [PATCH] Staging: xgifb: XGI_main_26.c: Refactored the function
Date: Tue, 20 Mar 2018 14:05:49 +0530
Message-Id: <20180320083549.6795-1-pratik.jain0509@gmail.com>
X-Mailer: git-send-email 2.16.2
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595445043191954085?=
X-GMAIL-MSGID: =?utf-8?q?1595445043191954085?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

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
