Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937273AbeE1Nkr (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 09:40:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:35292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937552AbeE1Kof (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:44:35 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Leon Romanovsky <leon@kernel.org>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 079/496] IB/uverbs: Fix unbalanced unlock on error path for rdma_explicit_destroy
Date: Mon, 28 May 2018 11:57:44 +0200
Message-Id: <20180528100323.106627523@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100319.498712256@linuxfoundation.org>
References: <20180528100319.498712256@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jason Gunthorpe <jgg@mellanox.com>

[ Upstream commit ec6f8401c48a86809237e86878a6fac6b281118f ]

If remove_commit fails then the lock is left locked while the uobj still
exists. Eventually the kernel will deadlock.

lockdep detects this and says:

 test/4221 is leaving the kernel with locks still held!
 1 lock held by test/4221:
  #0:  (&ucontext->cleanup_rwsem){.+.+}, at: [<000000001e5c7523>] rdma_explicit_destroy+0x37/0x120 [ib_uverbs]

Fixes: 4da70da23e9b ("IB/core: Explicitly destroy an object while keeping uobject")
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/rdma_core.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/infiniband/core/rdma_core.c
+++ b/drivers/infiniband/core/rdma_core.c
@@ -486,12 +486,13 @@ int rdma_explicit_destroy(struct ib_uobj
 	ret = uobject->type->type_class->remove_commit(uobject,
 						       RDMA_REMOVE_DESTROY);
 	if (ret)
-		return ret;
+		goto out;
 
 	uobject->type = &null_obj_type;
 
+out:
 	up_read(&ucontext->cleanup_rwsem);
-	return 0;
+	return ret;
 }
 
 static void alloc_commit_idr_uobject(struct ib_uobject *uobj)
