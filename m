Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033379AbeE2Bsm (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 21:48:42 -0400
Received: from gate.crashing.org ([63.228.1.57]:44126 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1033347AbeE2Bsi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 21:48:38 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeremy Kerr <jk@ozlabs.org>, Joel Stanley <joel@jms.id.au>,
        Christopher Bostic <cbostic@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 07/15] fsi/fsi-master-gpio: Reduce dpoll clocks
Date: Tue, 29 May 2018 11:30:36 +1000
Message-Id: <20180529013044.23815-8-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180529013044.23815-1-benh@kernel.crashing.org>
References: <20180529013044.23815-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

FSI_GPIO_DPOLL_CLOCKS is the number of clocks before sending
a DPOLL command after receiving a BUSY status. It should be
at least tSendDelay (16 clocks).

According to comments in the code, it needs to also be at least
21 clocks due to HW issues.

It's currently 100 clocks which impacts performances negatively
in some cases. Reduces it in half to 50 clocks which seems to
still be solid.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reviewed-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
---
 drivers/fsi/fsi-master-gpio.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/fsi/fsi-master-gpio.c b/drivers/fsi/fsi-master-gpio.c
index 029b0a5b6d89..bd2b2cbd5eb5 100644
--- a/drivers/fsi/fsi-master-gpio.c
+++ b/drivers/fsi/fsi-master-gpio.c
@@ -29,7 +29,8 @@
 #define	FSI_GPIO_CMD_TERM	0x3f
 #define FSI_GPIO_CMD_ABS_AR	0x4
 
-#define	FSI_GPIO_DPOLL_CLOCKS	100      /* < 21 will cause slave to hang */
+
+#define	FSI_GPIO_DPOLL_CLOCKS	50      /* < 21 will cause slave to hang */
 
 /* Bus errors */
 #define	FSI_GPIO_ERR_BUSY	1	/* Slave stuck in busy state */
@@ -43,7 +44,7 @@
 #define	FSI_GPIO_RESP_ACK	0
 #define	FSI_GPIO_RESP_ACKD	4
 
-#define	FSI_GPIO_MAX_BUSY	100
+#define	FSI_GPIO_MAX_BUSY	200
 #define	FSI_GPIO_MTOE_COUNT	1000
 #define	FSI_GPIO_DRAIN_BITS	20
 #define	FSI_GPIO_CRC_SIZE	4
-- 
2.17.0
