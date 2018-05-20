Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbeETGun (ORCPT <rfc822;w@1wt.eu>);
        Sun, 20 May 2018 02:50:43 -0400
Received: from sauhun.de ([88.99.104.3]:41472 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751021AbeETGuj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 May 2018 02:50:39 -0400
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-i2c@vger.kernel.org
Cc: Peter Rosin <peda@axentia.se>, Wolfram Sang <wsa@the-dreams.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] i2c: opal: don't check number of messages in the driver
Date: Sun, 20 May 2018 08:50:34 +0200
Message-Id: <20180520065035.7920-3-wsa@the-dreams.de>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180520065035.7920-1-wsa@the-dreams.de>
References: <20180520065035.7920-1-wsa@the-dreams.de>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 1eace8344c02 ("i2c: add param sanity check to
i2c_transfer()") and b7f625840267 ("i2c: add quirk checks to core"), the
I2C core does this check now. We can remove it here.

Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
---

Only build tested.

 drivers/i2c/busses/i2c-opal.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-opal.c b/drivers/i2c/busses/i2c-opal.c
index 0aabb7eca0c5..dc2a23f4fb52 100644
--- a/drivers/i2c/busses/i2c-opal.c
+++ b/drivers/i2c/busses/i2c-opal.c
@@ -94,8 +94,6 @@ static int i2c_opal_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 	 */
 	memset(&req, 0, sizeof(req));
 	switch(num) {
-	case 0:
-		return 0;
 	case 1:
 		req.type = (msgs[0].flags & I2C_M_RD) ?
 			OPAL_I2C_RAW_READ : OPAL_I2C_RAW_WRITE;
@@ -114,8 +112,6 @@ static int i2c_opal_master_xfer(struct i2c_adapter *adap, struct i2c_msg *msgs,
 		req.size = cpu_to_be32(msgs[1].len);
 		req.buffer_ra = cpu_to_be64(__pa(msgs[1].buf));
 		break;
-	default:
-		return -EOPNOTSUPP;
 	}
 
 	rc = i2c_opal_send_request(opal_id, &req);
-- 
2.11.0
