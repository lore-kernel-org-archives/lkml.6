Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932203AbeBGAE1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 19:04:27 -0500
Received: from gateway32.websitewelcome.com ([192.185.145.113]:15570 "EHLO
        gateway32.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932188AbeBGAE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 19:04:26 -0500
Date: Tue, 6 Feb 2018 18:04:24 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] video: fbdev: vermilion: use 64-bit arithmetic instead of
 32-bit
Message-ID: <20180207000424.GA32680@embeddedgus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1ejDDt-0032dU-PJ
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.4.238]:39266
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast _pitch_ to u64 in order to give the compiler complete information
about the proper arithmetic to use. Notice that this variable is
being used in a context that expects an expression of type u64
(64 bits, unsigned).

The expression pitch * var->yres_virtual is currently being evaluated
using 32-bit arithmetic and the result of the operation is being stored
into variable mem, which is a variable of type u64. Based on that,
chances are there is a potential integer overflow as a result of the
operation.

Addresses-Coverity-ID: 200655 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/video/fbdev/vermilion/vermilion.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/video/fbdev/vermilion/vermilion.c b/drivers/video/fbdev/vermilion/vermilion.c
index 6f8d444..5172fa5 100644
--- a/drivers/video/fbdev/vermilion/vermilion.c
+++ b/drivers/video/fbdev/vermilion/vermilion.c
@@ -651,7 +651,7 @@ static int vmlfb_check_var_locked(struct fb_var_screeninfo *var,
 	}
 
 	pitch = ALIGN((var->xres * var->bits_per_pixel) >> 3, 0x40);
-	mem = pitch * var->yres_virtual;
+	mem = (u64)pitch * var->yres_virtual;
 	if (mem > vinfo->vram_contig_size) {
 		return -ENOMEM;
 	}
-- 
2.7.4
