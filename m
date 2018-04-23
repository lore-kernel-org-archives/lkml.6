Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932265AbeDWRlK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 13:41:10 -0400
Received: from gateway22.websitewelcome.com ([192.185.47.144]:16334 "EHLO
        gateway22.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932079AbeDWRk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 13:40:58 -0400
X-Authority-Reason: nr=8
Date: Mon, 23 Apr 2018 12:40:54 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 04/11] marvell-ccic: mcam-core: fix potential Spectre variant
 1
Message-ID: <64785db2204b1a4446d012e4508c16c523c43345.1524499368.git.gustavo@embeddedor.com>
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
X-Exim-ID: 1fAfST-004Nvv-Hx
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.48.65]:49558
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 37
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fmt->index can be controlled by user-space, hence leading to a
potential exploitation of the Spectre variant 1 vulnerability.

Smatch warning:
drivers/media/platform/marvell-ccic/mcam-core.c:1323 mcam_vidioc_enum_fmt_vid_cap() warn: potential spectre issue 'mcam_formats'

Fix this by sanitizing fmt->index before using it to index
mcam_formats.

Notice that given that speculation windows are large, the policy is
to kill the speculation on the first load and not worry if it can be
completed with a dependent load/store [1].

[1] https://marc.info/?l=linux-kernel&m=152449131114778&w=2

Cc: stable@vger.kernel.org
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/platform/marvell-ccic/mcam-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/platform/marvell-ccic/mcam-core.c b/drivers/media/platform/marvell-ccic/mcam-core.c
index 80670ee..0a54dba 100644
--- a/drivers/media/platform/marvell-ccic/mcam-core.c
+++ b/drivers/media/platform/marvell-ccic/mcam-core.c
@@ -33,6 +33,8 @@
 
 #include "mcam-core.h"
 
+#include <linux/nospec.h>
+
 #ifdef MCAM_MODE_VMALLOC
 /*
  * Internal DMA buffer management.  Since the controller cannot do S/G I/O,
@@ -1318,6 +1320,7 @@ static int mcam_vidioc_enum_fmt_vid_cap(struct file *filp,
 {
 	if (fmt->index >= N_MCAM_FMTS)
 		return -EINVAL;
+	fmt->index = array_index_nospec(fmt->index, N_MCAM_FMTS);
 	strlcpy(fmt->description, mcam_formats[fmt->index].desc,
 			sizeof(fmt->description));
 	fmt->pixelformat = mcam_formats[fmt->index].pixelformat;
-- 
2.7.4
