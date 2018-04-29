Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753336AbeD2MXR (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 08:23:17 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:39999 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753054AbeD2MXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 08:23:16 -0400
X-Google-Smtp-Source: AB8JxZq/A8968LdvKBF3V9Q43Djais+2xa7wUufIvS0TuVcJin1cAroR5jVtr1/MpX65NazZEQbUYg==
From: Etienne Carriere <etienne.carriere@linaro.org>
To: alexandre.jutras@nxp.com, linux-kernel@vger.kernel.org,
        jens.wiklander@linaro.org
Cc: Etienne Carriere <etienne.carriere@linaro.org>
Subject: [PATCH] tee: check shm references are consistent in offset/size
Date: Sun, 29 Apr 2018 14:22:29 +0200
Message-Id: <1525004549-16266-1-git-send-email-etienne.carriere@linaro.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change prevents userland from referencing TEE shared memory
outside the area initially allocated by its owner. Prior this change an
application could not reference or access memory it did not own but
it could reference memory not explicitly allocated by owner but still
allocated to the owner due to the memory allocation granule.

Reported-by: Alexandre Jutras <alexandre.jutras@nxp.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>
---
 drivers/tee/tee_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 0124a91..dd46b75 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -238,6 +238,17 @@ static int params_from_user(struct tee_context *ctx, struct tee_param *params,
 			if (IS_ERR(shm))
 				return PTR_ERR(shm);
 
+			/*
+			 * Ensure offset + size does not overflow offset
+			 * and does not overflow the size of the referred
+			 * shared memory object.
+			 */
+			if ((ip.a + ip.b) < ip.a ||
+			    (ip.a + ip.b) > shm->size) {
+				tee_shm_put(shm);
+				return -EINVAL;
+			}
+
 			params[n].u.memref.shm_offs = ip.a;
 			params[n].u.memref.size = ip.b;
 			params[n].u.memref.shm = shm;
-- 
1.9.1
