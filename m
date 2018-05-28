Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1162188AbeE1KgU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:36:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:56640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1162169AbeE1KgN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:36:13 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        Doug Ledford <dledford@redhat.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 190/329] IB/core: Fix possible crash to access NULL netdev
Date: Mon, 28 May 2018 12:01:59 +0200
Message-Id: <20180528100258.124353694@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit bb7f8f199c354c4cf155b1d6d55f86eaaed7fa5a ]

resolved_dev returned might be NULL as ifindex is transient number.
Ignoring NULL check of resolved_dev might crash the kernel.
Therefore perform NULL check before accessing resolved_dev.

Additionally rdma_resolve_ip_route() invokes addr_resolve() which
performs check and address translation for loopback ifindex.
Therefore, checking it again in rdma_resolve_ip_route() is not helpful.
Therefore, the code is simplified to avoid IFF_LOOPBACK check.

Fixes: 200298326b27 ("IB/core: Validate route when we init ah")
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Doug Ledford <dledford@redhat.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/sa_query.c |    7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

--- a/drivers/infiniband/core/sa_query.c
+++ b/drivers/infiniband/core/sa_query.c
@@ -1137,10 +1137,9 @@ int ib_init_ah_from_path(struct ib_devic
 
 		resolved_dev = dev_get_by_index(dev_addr.net,
 						dev_addr.bound_dev_if);
-		if (resolved_dev->flags & IFF_LOOPBACK) {
-			dev_put(resolved_dev);
-			resolved_dev = idev;
-			dev_hold(resolved_dev);
+		if (!resolved_dev) {
+			dev_put(idev);
+			return -ENODEV;
 		}
 		ndev = ib_get_ndev_from_path(rec);
 		rcu_read_lock();
