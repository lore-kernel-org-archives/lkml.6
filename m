Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753199AbeFDHCR (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 03:02:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:54670 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753168AbeFDHCO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 03:02:14 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>
Subject: [PATCH 4.14 42/52] IB/core: Fix error code for invalid GID entry
Date: Mon,  4 Jun 2018 08:58:37 +0200
Message-Id: <20180604065608.281621228@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180604065606.532044490@linuxfoundation.org>
References: <20180604065606.532044490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Parav Pandit <parav@mellanox.com>

commit a840c93ca7582bb6c88df2345a33f979b7a67874 upstream.

When a GID entry is invalid EAGAIN is returned. This is an incorrect error
code, there is nothing that will make this GID entry valid again in
bounded time.

Some user space tools fail incorrectly if EAGAIN is returned here, and
this represents a small ABI change from earlier kernels.

The first patch in the Fixes list makes entries that were valid before
to become invalid, allowing this code to trigger, while the second patch
in the Fixes list introduced the wrong EAGAIN.

Therefore revert the return result to EINVAL which matches the historical
expectations of the ibv_query_gid_type() API of the libibverbs user space
library.

Cc: <stable@vger.kernel.org>
Fixes: 598ff6bae689 ("IB/core: Refactor GID modify code for RoCE")
Fixes: 03db3a2d81e6 ("IB/core: Add RoCE GID table management")
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/infiniband/core/cache.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/cache.c
+++ b/drivers/infiniband/core/cache.c
@@ -434,7 +434,7 @@ static int __ib_cache_gid_get(struct ib_
 		return -EINVAL;
 
 	if (table->data_vec[index].props & GID_TABLE_ENTRY_INVALID)
-		return -EAGAIN;
+		return -EINVAL;
 
 	memcpy(gid, &table->data_vec[index].gid, sizeof(*gid));
 	if (attr) {
