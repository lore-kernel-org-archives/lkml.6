Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758488AbeD0NxF (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 09:53:05 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:44923 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758364AbeD0NxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 09:53:04 -0400
X-Google-Smtp-Source: AB8JxZocTJSNEsXop6+5SriwdoONPHypi511AvbCT2cg4aVXq+oLrPTkfSsAQ/lvLQfWW8eBvj2PiP9IB2J0y7bicCA=
MIME-Version: 1.0
From: Etienne Carriere <etienne.carriere@linaro.org>
Date: Fri, 27 Apr 2018 15:53:02 +0200
Message-ID: <CAN5uoS_GfCgWCc7QLPhtYkRzXfV+5Xy-TJobC7-NopQe5MGwMw@mail.gmail.com>
Subject: [PATCH] tee: check shm references are consistent in offset/size
To: linux-kernel@vger.kernel.org,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Alexandre Jutras <alexandre.jutras@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change prevents userland from referencing TEE shared memory
outside the area initially allocated by its owner. Prior this change an
application could not reference or access memory it did not own but
it could reference memory not explicitly allocated by owner.

Reported-by: Alexandre Jutras <alexandre.jutras@nxp.com>
Signed-off-by: Etienne Carriere <etienne.carriere@linaro.org>

---
 drivers/tee/tee_core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index 0124a91..dd46b75 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -238,6 +238,17 @@ static int params_from_user(struct tee_context
*ctx, struct tee_param *params,
             if (IS_ERR(shm))
                 return PTR_ERR(shm);

+            /*
+             * Ensure offset + size does not overflow offset
+             * and does not overflow the size of the referred
+             * shared memory object.
+             */
+            if ((ip.a + ip.b) < ip.a ||
+                (ip.a + ip.b) > shm->size) {
+                tee_shm_put(shm);
+                return -EINVAL;
+            }
+
             params[n].u.memref.shm_offs = ip.a;
             params[n].u.memref.size = ip.b;
             params[n].u.memref.shm = shm;
-- 
1.9.1
