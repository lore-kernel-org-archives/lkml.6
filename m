Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754592AbeCGSDo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:03:44 -0500
Received: from gateway33.websitewelcome.com ([192.185.146.21]:21132 "EHLO
        gateway33.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754039AbeCGSDn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:03:43 -0500
Date: Wed, 7 Mar 2018 12:03:33 -0600
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: David Miller <davem@davemloft.net>,
        Santosh Raspatur <santosh@chelsio.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2] cxgb3: remove VLA usage
Message-ID: <20180307180333.GA13800@embeddedgus>
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
X-Exim-ID: 1etdPg-000YOM-PC
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedgus) [189.175.117.58]:44660
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove VLA usage and change the 'len' argument to a u8 and use a 256
byte buffer on the stack. Notice that these lengths are limited by the
encoding field in the VPD structure, which is a u8 [1].

[1] https://marc.info/?l=linux-netdev&m=152044354814024&w=2

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
Changes in v2:
 - Update the code as suggested by David Miller.
 - Update changelog based on David's comments.
 - Update subject.

 drivers/net/ethernet/chelsio/cxgb3/t3_hw.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c b/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
index a89721f..080918a 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
@@ -681,18 +681,18 @@ int t3_seeprom_wp(struct adapter *adapter, int enable)
 	return t3_seeprom_write(adapter, EEPROM_STAT_ADDR, enable ? 0xc : 0);
 }
 
-static int vpdstrtouint(char *s, int len, unsigned int base, unsigned int *val)
+static int vpdstrtouint(char *s, u8 len, unsigned int base, unsigned int *val)
 {
-	char tok[len + 1];
+	char tok[256];
 
 	memcpy(tok, s, len);
 	tok[len] = 0;
 	return kstrtouint(strim(tok), base, val);
 }
 
-static int vpdstrtou16(char *s, int len, unsigned int base, u16 *val)
+static int vpdstrtou16(char *s, u8 len, unsigned int base, u16 *val)
 {
-	char tok[len + 1];
+	char tok[256];
 
 	memcpy(tok, s, len);
 	tok[len] = 0;
-- 
2.7.4
