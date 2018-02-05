Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752058AbeBEU2J (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 15:28:09 -0500
Received: from gateway23.websitewelcome.com ([192.185.48.104]:35797 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752022AbeBEU15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 15:27:57 -0500
Date: Mon, 5 Feb 2018 14:27:56 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2 7/8] platform: sh_veu: use 64-bit arithmetic instead of
 32-bit
Message-ID: <502e55a2fd44a61126b639d581c8fa7447eb0e72.1517856716.git.gustavo@embeddedor.com>
References: <cover.1517856716.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1517856716.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.152.201.65
X-Source-L: No
X-Exim-ID: 1einMq-003ZXY-Qh
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.152.201.65]:47710
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 37
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast left and top to dma_addr_t in order to give the compiler complete
information about the proper arithmetic to use. Notice that these
variables are being used in contexts that expect expressions of
type dma_addr_t (64 bit, unsigned).

Such expressions are currently being evaluated using 32-bit arithmetic.

Also, move the expression (((dma_addr_t)left * veu->vfmt_out.fmt->depth) >> 3)
at the end in order to avoid a line wrapping checkpatch.pl warning.

Addresses-Coverity-ID: 1056807
Addresses-Coverity-ID: 1056808
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Update subject and changelog to better reflect the proposed code changes.
 - Move the expression (((dma_addr_t)left * veu->vfmt_out.fmt->depth) >> 3)
   at the end in order to avoid a line wrapping checkpatch.pl warning.

 drivers/media/platform/sh_veu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/media/platform/sh_veu.c b/drivers/media/platform/sh_veu.c
index 976ea0b..1a0cde0 100644
--- a/drivers/media/platform/sh_veu.c
+++ b/drivers/media/platform/sh_veu.c
@@ -520,8 +520,8 @@ static void sh_veu_colour_offset(struct sh_veu_dev *veu, struct sh_veu_vfmt *vfm
 	/* dst_left and dst_top validity will be verified in CROP / COMPOSE */
 	unsigned int left = vfmt->frame.left & ~0x03;
 	unsigned int top = vfmt->frame.top;
-	dma_addr_t offset = ((left * veu->vfmt_out.fmt->depth) >> 3) +
-		top * veu->vfmt_out.bytesperline;
+	dma_addr_t offset = (dma_addr_t)top * veu->vfmt_out.bytesperline +
+			(((dma_addr_t)left * veu->vfmt_out.fmt->depth) >> 3);
 	unsigned int y_line;
 
 	vfmt->offset_y = offset;
-- 
2.7.4
