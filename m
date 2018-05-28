Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1163260AbeE1Kre (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 06:47:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1163243AbeE1KrZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 06:47:25 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
        Mark Bloch <markb@mellanox.com>, Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 108/496] net/mlx5e: Return error if prio is specified when offloading eswitch vlan push
Date: Mon, 28 May 2018 11:58:13 +0200
Message-Id: <20180528100324.459968455@linuxfoundation.org>
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

From: Or Gerlitz <ogerlitz@mellanox.com>

[ Upstream commit 001a2fc0c8cc29241305e44ffbce52d1daf8782b ]

This isn't supported when we emulate eswitch vlan push action which
is the current state of things.

Fixes: 8b32580df1cb ('net/mlx5e: Add TC vlan action for SRIOV offloads')
Signed-off-by: Or Gerlitz <ogerlitz@mellanox.com>
Reviewed-by: Mark Bloch <markb@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -2018,7 +2018,8 @@ static int parse_tc_fdb_actions(struct m
 			if (tcf_vlan_action(a) == TCA_VLAN_ACT_POP) {
 				attr->action |= MLX5_FLOW_CONTEXT_ACTION_VLAN_POP;
 			} else if (tcf_vlan_action(a) == TCA_VLAN_ACT_PUSH) {
-				if (tcf_vlan_push_proto(a) != htons(ETH_P_8021Q))
+				if (tcf_vlan_push_proto(a) != htons(ETH_P_8021Q) ||
+				    tcf_vlan_push_prio(a))
 					return -EOPNOTSUPP;
 
 				attr->action |= MLX5_FLOW_CONTEXT_ACTION_VLAN_PUSH;
