Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeBTU7o (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Feb 2018 15:59:44 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:57449 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeBTU7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Feb 2018 15:59:42 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leonro@mellanox.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/core: reduce IB_POLL_BATCH constant
Date: Tue, 20 Feb 2018 21:59:09 +0100
Message-Id: <20180220205924.2035765-1-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
X-Provags-ID: V03:K0:owxbkrc1+qZ9FU21l7WAkFJwu9XkQFkuMLAUgLy+5JswtDGLOG0
 pmRwLqhFvivQICrXvz2eZWnaaOSJ+yiYOKUYvgmA/x8nBqaPEIcZTNtUnuedR0CuNKZFMY2
 piNM1c036HsmszApvgSbuZRZsnYQm6iewHULiH96ujQU2cEBlki/3M1LTcnQ8QOdrNLTLk5
 dumt6qd/rMHZn9HQHi8rQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:enJQUUyYUz8=:KCeCJaftbWVslYGlgMPfux
 nkoI0cqi4DrPy2NDbxy5emQvRtHZbrzCPACPJTbe3JRHxl5grFOIgwM33NNgh/51ZX1Fa1aPO
 GHKV0XNhTgquQdP8NSJnCteAQ2xkWYIFu+K6Iqj+oSO4jynJxacqqowue4D5p5MI0iN8RWvvL
 /i2CJMINXsTSNNph0gAEu6sGxv+rtgEkMgXgiWlm7WnSnk0ASArEKl/5PLIH4OsxeJnjvv1Sc
 ZaCSW5NF3v263TSbWXSb34ZE4aec3EJGiCX/WD8aEv+d+kfCt73z1NyN2hdIUIcite8Z5Bm/g
 ksK+g72hPJTt9uzBOFRv2ivZP7RCatbXa122kA4LAMUyhjmz3J7Wzbkc0mMZQ/8Eju82Zf0Ca
 SkQNrDvhzNUX5x/bBA6H0DIUQYgHIwOHsGesUZf0QduQyv/PwtVOg3bNDEVuYUNWfl2tjcA5U
 3tRgH/RORwYwpi4Fw0IGQd144oHiFmNZu4uOSSvzGKLOvGJtUaba8ma6akcR3uK4F0pVSunXv
 b5XMfo6Vz7+bW3YDH9pAUsicLwpn8/O10bE86Oa3tDMQf3eZhO17FplUQRtkpsdIk1pdHzXw8
 WfkLeUJLzvXPyN+FJNhZZqumDc5vYjWYvZaWopL8/E6Uy2Vn2ySJ6zQF+TCWy97FJ9fMsICyh
 BP/DqFPsPjizGVGNT4G0D67gdUqwkSekECOHZB6diW2VNAsNDDfBVGEnj6RS6ri6YSFOnHGTq
 qYSujN8Br9BXOy1VNxS/wk8vrabmkaoP1RD2Yg==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ib_wc structure has grown to much that putting 16 of them on the stack
hits the warning limit for dangerous kernel stack consumption:

drivers/infiniband/core/cq.c: In function 'ib_process_cq_direct':
drivers/infiniband/core/cq.c:78:1: error: the frame size of 1032 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]

Using half that number brings us comfortably below that limit again.

Fixes: 02d8883f520e ("RDMA/restrack: Add general infrastructure to track RDMA resources")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/infiniband/core/cq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/cq.c b/drivers/infiniband/core/cq.c
index bc79ca8215d7..2626adbb978e 100644
--- a/drivers/infiniband/core/cq.c
+++ b/drivers/infiniband/core/cq.c
@@ -16,7 +16,7 @@
 #include <rdma/ib_verbs.h>
 
 /* # of WCs to poll for with a single call to ib_poll_cq */
-#define IB_POLL_BATCH			16
+#define IB_POLL_BATCH			8
 
 /* # of WCs to iterate over before yielding */
 #define IB_POLL_BUDGET_IRQ		256
-- 
2.9.0
