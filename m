Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1164669AbeE1K7v (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:59:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:47520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932449AbeE1K7i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:59:38 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Daniel Jurgens <danielj@mellanox.com>,
        Parav Pandit <parav@mellanox.com>, Leon Romanovsky <leon@kernel.org>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 404/496] IB/core: Honor port_num while resolving GID for IB link layer
Date: Mon, 28 May 2018 12:03:09 +0200
Message-Id: <20180528100336.787142818@linuxfoundation.org>
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

From: Parav Pandit <parav@mellanox.com>

[ Upstream commit 563c4ba3bd2b8b0b21c65669ec2226b1cfa1138b ]

ah_attr contains the port number to which cm_id is bound. However, while
searching for GID table for matching GID entry, the port number is
ignored.

This could cause the wrong GID to be used when the ah_attr is converted to
an AH.

Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Signed-off-by: Parav Pandit <parav@mellanox.com>
Signed-off-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/core/multicast.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--- a/drivers/infiniband/core/multicast.c
+++ b/drivers/infiniband/core/multicast.c
@@ -724,21 +724,19 @@ int ib_init_ah_from_mcmember(struct ib_d
 {
 	int ret;
 	u16 gid_index;
-	u8 p;
 
-	if (rdma_protocol_roce(device, port_num)) {
-		ret = ib_find_cached_gid_by_port(device, &rec->port_gid,
-						 gid_type, port_num,
-						 ndev,
-						 &gid_index);
-	} else if (rdma_protocol_ib(device, port_num)) {
-		ret = ib_find_cached_gid(device, &rec->port_gid,
-					 IB_GID_TYPE_IB, NULL, &p,
-					 &gid_index);
-	} else {
-		ret = -EINVAL;
-	}
+	/* GID table is not based on the netdevice for IB link layer,
+	 * so ignore ndev during search.
+	 */
+	if (rdma_protocol_ib(device, port_num))
+		ndev = NULL;
+	else if (!rdma_protocol_roce(device, port_num))
+		return -EINVAL;
 
+	ret = ib_find_cached_gid_by_port(device, &rec->port_gid,
+					 gid_type, port_num,
+					 ndev,
+					 &gid_index);
 	if (ret)
 		return ret;
 
