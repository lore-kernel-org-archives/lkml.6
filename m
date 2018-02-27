Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754142AbeB0PnC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:43:02 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:33768 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754118AbeB0Pm7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:42:59 -0500
X-Google-Smtp-Source: AH8x227CGah2mK0MVJtFSW350J43aLJ3lnXsbOsyF6nHRsUypmt24/y9QrHu9jc5yNYHbKiQ4mwDXQ==
From: Jan Glauber <jglauber@cavium.com>
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Glauber <jglauber@cavium.com>
Subject: [PATCH] i2c: octeon: Prevent error message on bus error
Date: Tue, 27 Feb 2018 16:42:13 +0100
Message-Id: <20180227154213.3023-1-jglauber@cavium.com>
X-Mailer: git-send-email 2.16.2
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The error message:

[Fri Feb 16 13:42:13 2018] i2c-thunderx 0000:01:09.4: unhandled state: 0

is mis-leading as state 0 (bus error) is not an unknown state.

Return -EIO as before but avoid printing the message. Also rename
STAT_ERROR to STATE_BUS_ERROR.

Signed-off-by: Jan Glauber <jglauber@cavium.com>
---
 drivers/i2c/busses/i2c-octeon-core.c | 1 +
 drivers/i2c/busses/i2c-octeon-core.h | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-octeon-core.c b/drivers/i2c/busses/i2c-octeon-core.c
index 1d8775799056..d9607905dc2f 100644
--- a/drivers/i2c/busses/i2c-octeon-core.c
+++ b/drivers/i2c/busses/i2c-octeon-core.c
@@ -233,6 +233,7 @@ static int octeon_i2c_check_status(struct octeon_i2c *i2c, int final_read)
 		return -EOPNOTSUPP;
 
 	case STAT_TXDATA_NAK:
+	case STAT_BUS_ERROR:
 		return -EIO;
 	case STAT_TXADDR_NAK:
 	case STAT_RXADDR_NAK:
diff --git a/drivers/i2c/busses/i2c-octeon-core.h b/drivers/i2c/busses/i2c-octeon-core.h
index a7ef19855bb8..9bb9f64fdda0 100644
--- a/drivers/i2c/busses/i2c-octeon-core.h
+++ b/drivers/i2c/busses/i2c-octeon-core.h
@@ -43,7 +43,7 @@
 #define TWSI_CTL_AAK		0x04	/* Assert ACK */
 
 /* Status values */
-#define STAT_ERROR		0x00
+#define STAT_BUS_ERROR		0x00
 #define STAT_START		0x08
 #define STAT_REP_START		0x10
 #define STAT_TXADDR_ACK		0x18
-- 
2.16.2
