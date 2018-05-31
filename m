Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754757AbeEaLet (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 07:34:49 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43713 "EHLO huawei.com"
        rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754522AbeEaLep (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 07:34:45 -0400
From: Wei Yongjun <weiyongjun1@huawei.com>
To: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
CC: Wei Yongjun <weiyongjun1@huawei.com>, <linux-nvme@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] nvmet: fix error return code in nvmet_file_ns_enable()
Date: Thu, 31 May 2018 11:41:30 +0000
Message-ID: <1527766890-72455-1-git-send-email-weiyongjun1@huawei.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to return error code -ENOMEM from the memory alloc fail error
handling case instead of 0, as done elsewhere in this function.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/nvme/target/io-cmd-file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index ca1ccf8..e9d6ce4 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -49,14 +49,18 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	ns->bvec_cache = kmem_cache_create("nvmet-bvec",
 			NVMET_MAX_MPOOL_BVEC * sizeof(struct bio_vec),
 			0, SLAB_HWCACHE_ALIGN, NULL);
-	if (!ns->bvec_cache)
+	if (!ns->bvec_cache) {
+		ret = -ENOMEM;
 		goto err;
+	}
 
 	ns->bvec_pool = mempool_create(NVMET_MIN_MPOOL_OBJ, mempool_alloc_slab,
 			mempool_free_slab, ns->bvec_cache);
 
-	if (!ns->bvec_pool)
+	if (!ns->bvec_pool) {
+		ret = -ENOMEM;
 		goto err;
+	}
 
 	return ret;
 err:
