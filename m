Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756392AbeDZNBo (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 09:01:44 -0400
Received: from gateway23.websitewelcome.com ([192.185.49.180]:45125 "EHLO
        gateway23.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1755643AbeDZNBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 09:01:41 -0400
X-Authority-Reason: nr=8
Date: Thu, 26 Apr 2018 08:01:38 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Prameela Rani Garnepudi <prameela.j04cs@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] rsi_91x_mac80211: fix structurally dead code
Message-ID: <20180426130138.GA440@embeddedor.com>
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
X-Source-IP: 189.145.33.162
X-Source-L: No
X-Exim-ID: 1fBgWq-002rz3-7t
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.33.162]:41406
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 5
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function rsi_hal_key_config returns before reaching code at line
922 if (status), hence this code is structurally dead.

Fix this by storing the value returned by rsi_hal_load_key
into _status_ for its further evaluation and use.

Addresses-Coverity-ID: 1468409 ("Structurally dead code")
Fixes: 4fd6c4762f37 ("rsi: roaming enhancements")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wireless/rsi/rsi_91x_mac80211.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/rsi/rsi_91x_mac80211.c b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
index 766d874..80e7f4f 100644
--- a/drivers/net/wireless/rsi/rsi_91x_mac80211.c
+++ b/drivers/net/wireless/rsi/rsi_91x_mac80211.c
@@ -911,14 +911,14 @@ static int rsi_hal_key_config(struct ieee80211_hw *hw,
 		}
 	}
 
-	return rsi_hal_load_key(adapter->priv,
-				key->key,
-				key->keylen,
-				key_type,
-				key->keyidx,
-				key->cipher,
-				sta_id,
-				vif);
+	status = rsi_hal_load_key(adapter->priv,
+				  key->key,
+				  key->keylen,
+				  key_type,
+				  key->keyidx,
+				  key->cipher,
+				  sta_id,
+				  vif);
 	if (status)
 		return status;
 
-- 
2.7.4
