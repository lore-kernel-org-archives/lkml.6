Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932313AbeCFGE3 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Mar 2018 01:04:29 -0500
Received: from gateway24.websitewelcome.com ([192.185.51.35]:22516 "EHLO
        gateway24.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750783AbeCFGE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Mar 2018 01:04:28 -0500
Date: Mon, 5 Mar 2018 23:39:34 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Santosh Raspatur <santosh@chelsio.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] cxgb3: remove VLA
Message-ID: <20180306053934.GA17162@embeddedgus>
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
X-Source-IP: 189.175.117.58
X-Source-L: No
X-Exim-ID: 1et5K3-00063o-5U
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:49272
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to enabling -Wvla, remove VLA and replace it
with dynamic memory allocation.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/ethernet/chelsio/cxgb3/t3_hw.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c b/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
index a89721f..ad6a280 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
@@ -683,20 +683,37 @@ int t3_seeprom_wp(struct adapter *adapter, int enable)
 
 static int vpdstrtouint(char *s, int len, unsigned int base, unsigned int *val)
 {
-	char tok[len + 1];
+	char *tok;
+	int ret;
+
+	tok = kcalloc(len + 1, sizeof(*tok), GFP_KERNEL);
+	if (!tok)
+		return -ENOMEM;
 
 	memcpy(tok, s, len);
 	tok[len] = 0;
-	return kstrtouint(strim(tok), base, val);
+	ret = kstrtouint(strim(tok), base, val);
+
+	kfree(tok);
+	return ret;
 }
 
 static int vpdstrtou16(char *s, int len, unsigned int base, u16 *val)
 {
-	char tok[len + 1];
+	char *tok;
+	int ret;
+
+	tok = kcalloc(len + 1, sizeof(*tok), GFP_KERNEL);
+	if (!tok)
+		return -ENOMEM;
 
 	memcpy(tok, s, len);
 	tok[len] = 0;
-	return kstrtou16(strim(tok), base, val);
+
+	ret = kstrtou16(strim(tok), base, val);
+
+	kfree(tok);
+	return ret;
 }
 
 /**
-- 
2.7.4
