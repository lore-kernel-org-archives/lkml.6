Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753568AbeE3Llw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 07:41:52 -0400
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:60741 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752133AbeE3LHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 07:07:00 -0400
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From: Ben Hutchings <ben@decadent.org.uk>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC: akpm@linux-foundation.org, "Sean Hefty" <sean.hefty@intel.com>,
        "Leon Romanovsky" <leonro@mellanox.com>,
        "Jason Gunthorpe" <jgg@mellanox.com>,
        "" <syzbot+dcfd344365a56fbebd0f@syzkaller.appspotmail.com>
Date: Wed, 30 May 2018 11:52:42 +0100
Message-ID: <lsq.1527677562.576219870@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 135/153] RDMA/ucma: Fix use-after-free access in
 ucma_close
In-Reply-To: <lsq.1527677560.486731940@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.2.102-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Leon Romanovsky <leonro@mellanox.com>

commit ed65a4dc22083e73bac599ded6a262318cad7baf upstream.

The error in ucma_create_id() left ctx in the list of contexts belong
to ucma file descriptor. The attempt to close this file descriptor causes
to use-after-free accesses while iterating over such list.

Fixes: 75216638572f ("RDMA/cma: Export rdma cm interface to userspace")
Reported-by: <syzbot+dcfd344365a56fbebd0f@syzkaller.appspotmail.com>
Signed-off-by: Leon Romanovsky <leonro@mellanox.com>
Reviewed-by: Sean Hefty <sean.hefty@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 drivers/infiniband/core/ucma.c | 3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -433,6 +433,9 @@ err1:
 	mutex_lock(&mut);
 	idr_remove(&ctx_idr, ctx->id);
 	mutex_unlock(&mut);
+	mutex_lock(&file->mut);
+	list_del(&ctx->list);
+	mutex_unlock(&file->mut);
 	kfree(ctx);
 	return ret;
 }
