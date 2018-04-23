Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932184AbeDWRiH (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 13:38:07 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.144]:17657 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932093AbeDWRiG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 13:38:06 -0400
X-Authority-Reason: nr=8
Date: Mon, 23 Apr 2018 12:38:03 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 01/11] media: tm6000: fix potential Spectre variant 1
Message-ID: <3d4973141e218fb516422d3d831742d55aaa5c04.1524499368.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1fAfPh-004LbA-4O
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.48.65]:49542
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 19
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

f->index can be controlled by user-space, hence leading to a
potential exploitation of the Spectre variant 1 vulnerability.

Smatch warning:
drivers/media/usb/tm6000/tm6000-video.c:879 vidioc_enum_fmt_vid_cap() warn: potential spectre issue 'format'

Fix this by sanitizing f->index before using it to index
array _format_

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/usb/tm6000/tm6000-video.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/media/usb/tm6000/tm6000-video.c b/drivers/media/usb/tm6000/tm6000-video.c
index b2399d4..d701027 100644
--- a/drivers/media/usb/tm6000/tm6000-video.c
+++ b/drivers/media/usb/tm6000/tm6000-video.c
@@ -26,6 +26,7 @@
 #include <linux/kthread.h>
 #include <linux/highmem.h>
 #include <linux/freezer.h>
+#include <linux/nospec.h>
 
 #include "tm6000-regs.h"
 #include "tm6000.h"
@@ -875,6 +876,7 @@ static int vidioc_enum_fmt_vid_cap(struct file *file, void  *priv,
 	if (f->index >= ARRAY_SIZE(format))
 		return -EINVAL;
 
+	f->index = array_index_nospec(f->index, ARRAY_SIZE(format));
 	strlcpy(f->description, format[f->index].name, sizeof(f->description));
 	f->pixelformat = format[f->index].fourcc;
 	return 0;
-- 
2.7.4
