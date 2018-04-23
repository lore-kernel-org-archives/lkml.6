Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932515AbeDWRw6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 13:52:58 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.144]:25857 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932342AbeDWRwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 13:52:38 -0400
X-Authority-Reason: nr=8
Date: Mon, 23 Apr 2018 12:52:35 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-renesas-soc@vger.kernel.org
Subject: [PATCH 11/11] vsp1_rwpf: fix potential Spectre variant 1
Message-ID: <54ddd5303a6964e1295a4f5d009e683810fc3c18.1524499368.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1fAfdk-0009D4-AF
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.48.65]:49630
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 72
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

code->index can be controlled by user-space, hence leading to
a potential exploitation of the Spectre variant 1 vulnerability.

Smatch warning:
drivers/media/platform/vsp1/vsp1_rwpf.c:47 vsp1_rwpf_enum_mbus_code() warn: potential spectre issue 'codes'

Fix this by sanitizing code->index before using it to index
codes.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/platform/vsp1/vsp1_rwpf.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/vsp1/vsp1_rwpf.c b/drivers/media/platform/vsp1/vsp1_rwpf.c
index cfd8f19..6e887be 100644
--- a/drivers/media/platform/vsp1/vsp1_rwpf.c
+++ b/drivers/media/platform/vsp1/vsp1_rwpf.c
@@ -13,6 +13,8 @@
 
 #include <media/v4l2-subdev.h>
 
+#include <linux/nospec.h>
+
 #include "vsp1.h"
 #include "vsp1_rwpf.h"
 #include "vsp1_video.h"
@@ -44,6 +46,7 @@ static int vsp1_rwpf_enum_mbus_code(struct v4l2_subdev *subdev,
 	if (code->index >= ARRAY_SIZE(codes))
 		return -EINVAL;
 
+	code->index = array_index_nospec(code->index, ARRAY_SIZE(codes));
 	code->code = codes[code->index];
 
 	return 0;
-- 
2.7.4
