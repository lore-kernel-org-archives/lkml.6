Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751603AbeDEPtx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 5 Apr 2018 11:49:53 -0400
Received: from gateway34.websitewelcome.com ([192.185.148.231]:46966 "EHLO
        gateway34.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751278AbeDEPtw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Apr 2018 11:49:52 -0400
Date: Thu, 5 Apr 2018 10:49:49 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To: Igor Mitsyanko <imitsyanko@quantenna.com>,
        Avinash Patil <avinashp@quantenna.com>,
        Sergey Matyukevich <smatyukevich@quantenna.com>,
        Kalle Valo <kvalo@codeaurora.org>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] qtnfmac: pearl: pcie: fix memory leak in qtnf_fw_work_handler
Message-ID: <20180405154949.GA32223@embeddedor.com>
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
X-Source-IP: 189.145.54.187
X-Source-L: No
X-Exim-ID: 1f4794-004Mku-Sr
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [189.145.54.187]:41644
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 7
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In case memory resources for fw were succesfully allocated, release
them before jumping to fw_load_fail.

Addresses-Coverity-ID: 1466092 ("Resource leak")
Fixes: c3b2f7ca4186 ("qtnfmac: implement asynchronous firmware loading")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/net/wireless/quantenna/qtnfmac/pearl/pcie.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/wireless/quantenna/qtnfmac/pearl/pcie.c b/drivers/net/wireless/quantenna/qtnfmac/pearl/pcie.c
index f117904..6c1e139 100644
--- a/drivers/net/wireless/quantenna/qtnfmac/pearl/pcie.c
+++ b/drivers/net/wireless/quantenna/qtnfmac/pearl/pcie.c
@@ -1185,6 +1185,10 @@ static void qtnf_fw_work_handler(struct work_struct *work)
 	if (qtnf_poll_state(&priv->bda->bda_ep_state, QTN_EP_FW_LOADRDY,
 			    QTN_FW_DL_TIMEOUT_MS)) {
 		pr_err("card is not ready\n");
+
+		if (!flashboot)
+			release_firmware(fw);
+
 		goto fw_load_fail;
 	}
 
-- 
2.7.4
