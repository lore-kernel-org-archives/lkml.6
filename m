Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164209AbeE1Kxw (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:53:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163766AbeE1Kxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:53:43 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Chien Tin Tung <chien.tin.tung@intel.com>,
        Shiraz Saleem <shiraz.saleem@intel.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 275/496] RDMA/ucma: Correct option size check using optlen
Date: Mon, 28 May 2018 12:01:00 +0200
Message-Id: <20180528100331.435301840@linuxfoundation.org>
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

From: Chien Tin Tung <chien.tin.tung@intel.com>

[ Upstream commit 5f3e3b85cc0a5eae1c46d72e47d3de7bf208d9e2 ]

The option size check is using optval instead of optlen
causing the set option call to fail. Use the correct
field, optlen, for size check.

Fixes: 6a21dfc0d0db ("RDMA/ucma: Limit possible option size")
Signed-off-by: Chien Tin Tung <chien.tin.tung@intel.com>
Signed-off-by: Shiraz Saleem <shiraz.saleem@intel.com>
Reviewed-by: Leon Romanovsky <leonro@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/ucma.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/infiniband/core/ucma.c
+++ b/drivers/infiniband/core/ucma.c
@@ -1315,7 +1315,7 @@ static ssize_t ucma_set_option(struct uc
 	if (IS_ERR(ctx))
 		return PTR_ERR(ctx);
 
-	if (unlikely(cmd.optval > KMALLOC_MAX_SIZE))
+	if (unlikely(cmd.optlen > KMALLOC_MAX_SIZE))
 		return -EINVAL;
 
 	optval = memdup_user((void __user *) (unsigned long) cmd.optval,
