Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752132AbeA3Abw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 29 Jan 2018 19:31:52 -0500
Received: from gateway33.websitewelcome.com ([192.185.145.4]:15751 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751448AbeA3Abv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jan 2018 19:31:51 -0500
Date: Mon, 29 Jan 2018 18:31:47 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH 3/8] i2c: max2175: fix potential integer overflow in
 max2175_set_nco_freq
Message-ID: <4d475a610cb9c5c274ca4c9f4b1bc422c00776c0.1517268668.git.gustavo@embeddedor.com>
References: <cover.1517268667.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1517268667.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.145.57.174
X-Source-L: No
X-Exim-ID: 1egJq1-001e8C-O5
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (training) [189.145.57.174]:35454
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 21
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cast expression (clock_rate - abs_nco_freq) to s64 in order to avoid
a potential integer overflow. This variable is being used in a
context that expects an expression of type s64.

Addresses-Coverity-ID: 1446589 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/media/i2c/max2175.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/max2175.c b/drivers/media/i2c/max2175.c
index 2f1966b..3401ae6 100644
--- a/drivers/media/i2c/max2175.c
+++ b/drivers/media/i2c/max2175.c
@@ -643,7 +643,7 @@ static int max2175_set_nco_freq(struct max2175 *ctx, s32 nco_freq)
 	if (abs_nco_freq < clock_rate / 2) {
 		nco_val_desired = 2 * nco_freq;
 	} else {
-		nco_val_desired = 2 * (clock_rate - abs_nco_freq);
+		nco_val_desired = 2 * (s64)(clock_rate - abs_nco_freq);
 		if (nco_freq < 0)
 			nco_val_desired = -nco_val_desired;
 	}
-- 
2.7.4
