Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932414AbeDWRtI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 13:49:08 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.144]:47838 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932324AbeDWRtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 13:49:00 -0400
X-Authority-Reason: nr=8
Date: Mon, 23 Apr 2018 12:48:55 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 08/11] sh_vou: fix potential Spectre variant 1
Message-ID: <56615d4b6a9557645468873d60f5b0b5fcffcfc7.1524499368.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1fAfaE-00068J-48
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.48.65]:49602
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 58
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fmt->index can be controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

Smatch warning:
drivers/media/platform/sh_vou.c:407 sh_vou_enum_fmt_vid_out() warn: potential spectre issue 'vou_fmt'

Fix this by sanitizing fmt->index before using it to index
vou_fmt.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/platform/sh_vou.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/sh_vou.c b/drivers/media/platform/sh_vou.c
index 4dccf29..58d8645 100644
--- a/drivers/media/platform/sh_vou.c
+++ b/drivers/media/platform/sh_vou.c
@@ -30,6 +30,8 @@
 #include <media/videobuf2-v4l2.h>
 #include <media/videobuf2-dma-contig.h>
 
+#include <linux/nospec.h>
+
 /* Mirror addresses are not available for all registers */
 #define VOUER	0
 #define VOUCR	4
@@ -398,6 +400,7 @@ static int sh_vou_enum_fmt_vid_out(struct file *file, void  *priv,
 
 	if (fmt->index >= ARRAY_SIZE(vou_fmt))
 		return -EINVAL;
+	fmt->index = array_index_nospec(fmt->index, ARRAY_SIZE(vou_fmt));
 
 	dev_dbg(vou_dev->v4l2_dev.dev, "%s()\n", __func__);
 
-- 
2.7.4
