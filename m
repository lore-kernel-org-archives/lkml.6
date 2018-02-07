Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754557AbeBGQRc (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 11:17:32 -0500
Received: from gateway30.websitewelcome.com ([192.185.194.16]:48576 "EHLO
        gateway30.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754347AbeBGQRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 11:17:31 -0500
Date: Wed, 7 Feb 2018 10:17:29 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Chas Williams <3chas3@gmail.com>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] atm: he: use 64-bit arithmetic instead of 32-bit
Message-ID: <20180207161729.GA10329@embeddedgus>
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
X-Exim-ID: 1ejSPa-0002D8-8p
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.4.238]:32978
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 15
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add suffix ULL to constants 272, 204, 136 and 68 in order to give the
compiler complete information about the proper arithmetic to use.
Notice that these constants are used in contexts that expect
expressions of type unsigned long long (64 bits, unsigned).

The following expressions are currently being evaluated using 32-bit
arithmetic:

272 * mult
204 * mult
136 * mult
68 * mult

Addresses-Coverity-ID: 201058
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/atm/he.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/atm/he.c b/drivers/atm/he.c
index e58538c..29f102d 100644
--- a/drivers/atm/he.c
+++ b/drivers/atm/he.c
@@ -738,13 +738,13 @@ static int he_init_cs_block_rcm(struct he_dev *he_dev)
 #else
 		/* this is pretty, but avoids _divdu3 and is mostly correct */
 		mult = he_dev->atm_dev->link_rate / ATM_OC3_PCR;
-		if (rate_cps > (272 * mult))
+		if (rate_cps > (272ULL * mult))
 			buf = 4;
-		else if (rate_cps > (204 * mult))
+		else if (rate_cps > (204ULL * mult))
 			buf = 3;
-		else if (rate_cps > (136 * mult))
+		else if (rate_cps > (136ULL * mult))
 			buf = 2;
-		else if (rate_cps > (68 * mult))
+		else if (rate_cps > (68ULL * mult))
 			buf = 1;
 		else
 			buf = 0;
-- 
2.7.4
