Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755655AbeDYQYO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 12:24:14 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48973 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755015AbeDYQYK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 12:24:10 -0400
From: Colin King <colin.king@canonical.com>
To: Doug Ledford <dledford@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] RDMA/iwpm: fix memory leak on map_info
Date: Wed, 25 Apr 2018 17:24:04 +0100
Message-Id: <20180425162404.28625-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

In the cases where iwpm_hash_bucket is NULL and where function
get_mapinfo_hash_bucket returns NULL then the map_info is never added
to hash_bucket_head and hence there is a leak of map_info. Fix this
by nullifying hash_bucket_head and if that is null we know that
that map_info was not added to hash_bucket_head and hence map_info
should be free'd.

Detected by CoverityScan, CID#1222481 ("Resource Leak")

Fixes: 30dc5e63d6a5 ("RDMA/core: Add support for iWARP Port Mapper user space service")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/infiniband/core/iwpm_util.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/core/iwpm_util.c b/drivers/infiniband/core/iwpm_util.c
index 9821ae900f6d..da12da1c36f6 100644
--- a/drivers/infiniband/core/iwpm_util.c
+++ b/drivers/infiniband/core/iwpm_util.c
@@ -114,7 +114,7 @@ int iwpm_create_mapinfo(struct sockaddr_storage *local_sockaddr,
 			struct sockaddr_storage *mapped_sockaddr,
 			u8 nl_client)
 {
-	struct hlist_head *hash_bucket_head;
+	struct hlist_head *hash_bucket_head = NULL;
 	struct iwpm_mapping_info *map_info;
 	unsigned long flags;
 	int ret = -EINVAL;
@@ -142,6 +142,9 @@ int iwpm_create_mapinfo(struct sockaddr_storage *local_sockaddr,
 		}
 	}
 	spin_unlock_irqrestore(&iwpm_mapinfo_lock, flags);
+
+	if (!hash_bucket_head)
+		kfree(map_info);
 	return ret;
 }
 
-- 
2.17.0
