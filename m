Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755310AbeCHHIr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Mar 2018 02:08:47 -0500
Received: from mx01.hxt-semitech.com.96.203.223.in-addr.arpa ([223.203.96.7]:43314
        "EHLO barracuda.hxt-semitech.com" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1755009AbeCHHIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Mar 2018 02:08:42 -0500
X-ASG-Debug-ID: 1520492919-093b7e4ca910e20001-xx1T2L
X-Barracuda-Envelope-From: shunyong.yang@hxt-semitech.com
From: Shunyong Yang <shunyong.yang@hxt-semitech.com>
To: <kwankhede@nvidia.com>
CC: <kvm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Shunyong Yang <shunyong.yang@hxt-semitech.com>,
        Joey Zheng <yu.zheng@hxt-semitech.com>
Subject: [PATCH] vfio-mdev/samples: change RDI interrupt condition
Date: Thu, 8 Mar 2018 15:08:07 +0800
X-ASG-Orig-Subj: [PATCH] vfio-mdev/samples: change RDI interrupt condition
Message-ID: <1520492887-8021-1-git-send-email-shunyong.yang@hxt-semitech.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.5.21.109]
X-ClientProxiedBy: HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14) To
 HXTBJIDCEMVIW01.hxtcorp.net (10.128.0.14)
X-Barracuda-Connect: UNKNOWN[10.128.0.14]
X-Barracuda-Start-Time: 1520492919
X-Barracuda-Encrypted: ECDHE-RSA-AES256-SHA
X-Barracuda-URL: https://192.168.50.101:443/cgi-mod/mark.cgi
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.5975 1.0000 0.7500
X-Barracuda-Spam-Score: 0.75
X-Barracuda-Spam-Status: No, SCORE=0.75 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.48719
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When FIFO mode is enabled, the receive data available interrupt
(UART_IIR_RDI in code) should be triggered when the number of data
in FIFO is equal or larger than interrupt trigger level.

This patch changes the trigger level check to ensure multiple bytes
received from upper layer can trigger RDI interrupt correctly.

Cc: Joey Zheng <yu.zheng@hxt-semitech.com>
Signed-off-by: Shunyong Yang <shunyong.yang@hxt-semitech.com>
---
 samples/vfio-mdev/mtty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/vfio-mdev/mtty.c b/samples/vfio-mdev/mtty.c
index 09f255bdf3ac..7abb79d8313d 100644
--- a/samples/vfio-mdev/mtty.c
+++ b/samples/vfio-mdev/mtty.c
@@ -534,7 +534,7 @@ static void handle_bar_read(unsigned int index, struct mdev_state *mdev_state,
 
 		/* Interrupt priority 2: Fifo trigger level reached */
 		if ((ier & UART_IER_RDI) &&
-		    (mdev_state->s[index].rxtx.count ==
+		    (mdev_state->s[index].rxtx.count >=
 		      mdev_state->s[index].intr_trigger_level))
 			*buf |= UART_IIR_RDI;
 
-- 
1.8.3.1
