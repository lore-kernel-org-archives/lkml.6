Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751865AbeFEJKH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 05:10:07 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:8691 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751497AbeFEJKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 05:10:04 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Alastair D'Silva" <alastair@d-silva.org>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <linuxppc-dev@lists.ozlabs.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] ocxl: Fix missing unlock on error in afu_ioctl_enable_p9_wait()
Date: Tue, 5 Jun 2018 09:16:21 +0000
Message-ID: <1528190181-15745-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the missing unlock before return from function
afu_ioctl_enable_p9_wait() in the error handling case.

Fixes: e948e06fc63a ("ocxl: Expose the thread_id needed for wait on POWER9")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/misc/ocxl/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/ocxl/file.c b/drivers/misc/ocxl/file.c
index 33ae46c..e6a6074 100644
--- a/drivers/misc/ocxl/file.c
+++ b/drivers/misc/ocxl/file.c
@@ -139,8 +139,10 @@ static long afu_ioctl_enable_p9_wait(struct ocxl_context *ctx,
 		// Locks both status & tidr
 		mutex_lock(&ctx->status_mutex);
 		if (!ctx->tidr) {
-			if (set_thread_tidr(current))
+			if (set_thread_tidr(current)) {
+				mutex_unlock(&ctx->status_mutex);
 				return -ENOENT;
+			}
 
 			ctx->tidr = current->thread.tidr;
 		}
