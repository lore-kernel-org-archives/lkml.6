Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1423958AbeE1LKs (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 07:10:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:58638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1423930AbeE1LKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 07:10:39 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Honggang Li <honli@redhat.com>,
        Hal Rosenstock <hal@mellanox.com>, Noa Osherovich <noaos@mellanox.com>,
        Jason Gunthorpe <jgg@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.16 145/272] IB/mlx5: Set the default active rate and width to QDR and 4X
Date: Mon, 28 May 2018 12:02:58 +0200
Message-Id: <20180528100253.194812249@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100240.256525891@linuxfoundation.org>
References: <20180528100240.256525891@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Honggang Li <honli@redhat.com>

[ Upstream commit 7672ed33c4c15dbe9d56880683baaba4227cf940 ]

Before commit f1b65df5a232 ("IB/mlx5: Add support for active_width and
active_speed in RoCE"), the mlx5_ib driver set the default active_width
and active_speed to IB_WIDTH_4X and IB_SPEED_QDR.

When the RoCE port is down, the RoCE port does not negotiate the active
width with the remote side, causing the active width to be zero. When
running userspace ibstat to view the port status, ibstat will panic as it
reads an invalid width from sys file.

This patch restores the original behavior.

Fixes: f1b65df5a232 ("IB/mlx5: Add support for active_width and active_speed in RoCE").
Signed-off-by: Honggang Li <honli@redhat.com>
Reviewed-by: Hal Rosenstock <hal@mellanox.com>
Reviewed-by: Noa Osherovich <noaos@mellanox.com>
Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/infiniband/hw/mlx5/main.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -388,6 +388,9 @@ static int mlx5_query_port_roce(struct i
 	if (err)
 		goto out;
 
+	props->active_width     = IB_WIDTH_4X;
+	props->active_speed     = IB_SPEED_QDR;
+
 	translate_eth_proto_oper(eth_prot_oper, &props->active_speed,
 				 &props->active_width);
 
