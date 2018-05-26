Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031633AbeEZJjS (ORCPT <rfc822;w@1wt.eu>);
        Sat, 26 May 2018 05:39:18 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8155 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1031487AbeEZJjM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 May 2018 05:39:12 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>,
        Steven Royer <seroyer@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] misc: ibmvmc: Use GFP_ATOMIC under spin lock
Date: Sat, 26 May 2018 09:45:59 +0000
Message-ID: <1527327959-83701-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function alloc_dma_buffer() is called from ibmvmc_add_buffer(),
in which a spin lock be held here, so we should use GFP_ATOMIC when
a lock is held.

Fixes: 0eca353e7ae7 ("misc: IBM Virtual Management Channel Driver (VMC)")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/misc/ibmvmc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/ibmvmc.c b/drivers/misc/ibmvmc.c
index fb83d13..8f82bb9 100644
--- a/drivers/misc/ibmvmc.c
+++ b/drivers/misc/ibmvmc.c
@@ -273,7 +273,7 @@ static void *alloc_dma_buffer(struct vio_dev *vdev, size_t size,
 			      dma_addr_t *dma_handle)
 {
 	/* allocate memory */
-	void *buffer = kzalloc(size, GFP_KERNEL);
+	void *buffer = kzalloc(size, GFP_ATOMIC);
 
 	if (!buffer) {
 		*dma_handle = 0;
