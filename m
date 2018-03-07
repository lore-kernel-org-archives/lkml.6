Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934105AbeCGQ4U (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 11:56:20 -0500
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:36768 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933502AbeCGQ4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 11:56:18 -0500
Authentication-Results: mx-rz-3.rrze.uni-erlangen.de; dkim=none
        reason="no signature"; dkim-adsp=none (unprotected policy);
        dkim-atps=neutral
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 217.238.11.28
From: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
To: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
        Scott Bauer <scott.bauer@intel.com>,
        Jonathan Derrick <jonathan.derrick@intel.com>,
        Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] block: sed-opal: fix u64 short atom length
Date: Wed,  7 Mar 2018 17:55:56 +0100
Message-Id: <20180307165556.2618-1-jonas.rabenstein@studium.uni-erlangen.de>
X-Mailer: git-send-email 2.16.1
References: <1520379912.4178.83.camel@intel.com> <20180301132700.1279-1-jonas.rabenstein@studium.uni-erlangen.de>
In-Reply-To: <1520379912.4178.83.camel@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The length must be given as bytes and not as 4 bit tuples.

Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
---
v2:
  - use fls64
  - shorten loop body
---
 block/sed-opal.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/block/sed-opal.c b/block/sed-opal.c
index 36842bfa572e..38411c5c477f 100644
--- a/block/sed-opal.c
+++ b/block/sed-opal.c
@@ -554,15 +554,14 @@ static void add_token_u64(int *err, struct opal_dev *cmd, u64 number)
 
 	size_t len;
 	int msb;
-	u8 n;
 
 	if (!(number & ~TINY_ATOM_DATA_MASK)) {
 		add_token_u8(err, cmd, number);
 		return;
 	}
 
-	msb = fls(number);
-	len = DIV_ROUND_UP(msb, 4);
+	msb = fls64(number);
+	len = DIV_ROUND_UP(msb, 8);
 
 	if (cmd->pos >= IO_BUFFER_LENGTH - len - 1) {
 		pr_debug("Error adding u64: end of buffer.\n");
@@ -570,10 +569,8 @@ static void add_token_u64(int *err, struct opal_dev *cmd, u64 number)
 		return;
 	}
 	add_short_atom_header(cmd, false, false, len);
-	while (len--) {
-		n = number >> (len * 8);
-		add_token_u8(err, cmd, n);
-	}
+	while (len--)
+		add_token_u8(err, cmd, number >> (len * 8));
 }
 
 static void add_token_bytestring(int *err, struct opal_dev *cmd,
-- 
2.16.1
