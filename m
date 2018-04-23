Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932268AbeDWRmD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 13:42:03 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.144]:37608 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932092AbeDWRmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 13:42:00 -0400
X-Authority-Reason: nr=8
Date: Mon, 23 Apr 2018 12:41:59 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 05/11] omap_vout: fix potential Spectre variant 1
Message-ID: <078fe4c0397eceae961e4a3dc37c19513b9f8614.1524499368.git.gustavo@embeddedor.com>
References: <cover.1524499368.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1524499368.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.48.65
X-Source-L: No
X-Exim-ID: 1fAfTT-004OmQ-ON
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.48.65]:49560
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 42
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

index can be controlled by user-space, hence leading to a
potential exploitation of the Spectre variant 1 vulnerability.

Smatch warning:
drivers/media/platform/omap/omap_vout.c:1062 vidioc_enum_fmt_vid_out() warn: potential spectre issue 'omap_formats'

Fix this by sanitizing index before using it to index
omap_formats.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/platform/omap/omap_vout.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/omap/omap_vout.c b/drivers/media/platform/omap/omap_vout.c
index 5700b78..1a7ec39 100644
--- a/drivers/media/platform/omap/omap_vout.c
+++ b/drivers/media/platform/omap/omap_vout.c
@@ -51,6 +51,8 @@
 #include "omap_voutdef.h"
 #include "omap_vout_vrfb.h"
 
+#include <linux/nospec.h>
+
 MODULE_AUTHOR("Texas Instruments");
 MODULE_DESCRIPTION("OMAP Video for Linux Video out driver");
 MODULE_LICENSE("GPL");
@@ -1059,6 +1061,7 @@ static int vidioc_enum_fmt_vid_out(struct file *file, void *fh,
 	if (index >= NUM_OUTPUT_FORMATS)
 		return -EINVAL;
 
+	index = array_index_nospec(index, NUM_OUTPUT_FORMATS);
 	fmt->flags = omap_formats[index].flags;
 	strlcpy(fmt->description, omap_formats[index].description,
 			sizeof(fmt->description));
-- 
2.7.4
