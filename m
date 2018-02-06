Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752788AbeBFQrx (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:47:53 -0500
Received: from gateway23.websitewelcome.com ([192.185.50.108]:27487 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752742AbeBFQrj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:47:39 -0500
Date: Tue, 6 Feb 2018 10:47:37 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Ramesh Shanmugasundaram <ramesh.shanmugasundaram@bp.renesas.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v3 3/8] i2c: max2175: use 64-bit arithmetic instead of 32-bit
Message-ID: <fdeffeff7451f52fd903e4773c6b10fe21f707e4.1517929336.git.gustavo@embeddedor.com>
References: <cover.1517929336.git.gustavo@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1517929336.git.gustavo@embeddedor.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 189.175.4.238
X-Source-L: No
X-Exim-ID: 1ej6PC-000lD9-G1
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.4.238]:46642
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 25
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suffix LL to constant 2 in order to give the compiler complete
information about the proper arithmetic to use. Notice that this
constant is used in a context that expects an expression of type
s64 (64 bits, signed).

The expression 2 * (clock_rate - abs_nco_freq) is currently being
evaluated using 32-bit arithmetic.

Addresses-Coverity-ID: 1446589 ("Unintentional integer overflow")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Update subject and changelog to better reflect the proposed code changes.
 - Add suffix LL to constant instead of casting a variable.

Changes in v3:
 - Mention the specific Coverity report in the commit message.

 drivers/media/i2c/max2175.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/media/i2c/max2175.c b/drivers/media/i2c/max2175.c
index 2f1966b..87cba15 100644
--- a/drivers/media/i2c/max2175.c
+++ b/drivers/media/i2c/max2175.c
@@ -643,7 +643,7 @@ static int max2175_set_nco_freq(struct max2175 *ctx, s32 nco_freq)
 	if (abs_nco_freq < clock_rate / 2) {
 		nco_val_desired = 2 * nco_freq;
 	} else {
-		nco_val_desired = 2 * (clock_rate - abs_nco_freq);
+		nco_val_desired = 2LL * (clock_rate - abs_nco_freq);
 		if (nco_freq < 0)
 			nco_val_desired = -nco_val_desired;
 	}
-- 
2.7.4
