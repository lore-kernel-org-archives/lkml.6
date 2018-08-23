Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58A04C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DDEB208D6
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 08:23:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DDEB208D6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730874AbeHWLvz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 07:51:55 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:47178 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbeHWLvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 07:51:55 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 89038C7B;
        Thu, 23 Aug 2018 08:23:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eli Cohen <eli@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.14 099/217] net/mlx5: E-Switch, Disallow vlan/spoofcheck setup if not being esw manager
Date:   Thu, 23 Aug 2018 09:53:32 +0200
Message-Id: <20180823075509.957996464@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180823075505.090246914@linuxfoundation.org>
References: <20180823075505.090246914@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Eli Cohen <eli@mellanox.com>

[ Upstream commit a8d70a054a718b63058b3d3ac58b6181815e4289 ]

In smartnic env, if the host (PF) driver is not an e-switch manager, we
are not allowed to apply eswitch ports setups such as vlan (VST),
spoof-checks, min/max rate or state.

Make sure we are eswitch manager when coming to issue these callbacks
and err otherwise.

Also fix the definition of ESW_ALLOWED to rely on eswitch_manager
capability and on the vport_group_manger.

Operations on the VF nic vport context, such as setting a mac or reading
the vport counters are allowed to the PF in this scheme.

The modify nic vport guid code was modified to omit checking the
nic_vport_node_guid_modify eswitch capability.
The reason for doing so is that modifying node guid requires vport group
manager capability, and there's no need to check further capabilities.

1. set_vf_vlan     - disallowed
2. set_vf_spoofchk - disallowed
3. set_vf_mac      - allowed
4. get_vf_config   - allowed
5. set_vf_trust    - disallowed
6. set_vf_rate     - disallowed
7. get_vf_stat     - allowed
8. set_vf_link_state - disallowed

Fixes: f942380c1239 ('net/mlx5: E-Switch, Vport ingress/egress ACLs rules for spoofchk')
Signed-off-by: Eli Cohen <eli@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Tested-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |   12 +++++-------
 drivers/net/ethernet/mellanox/mlx5/core/vport.c   |    2 --
 2 files changed, 5 insertions(+), 9 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1525,17 +1525,15 @@ static void esw_disable_vport(struct mlx
 }
 
 /* Public E-Switch API */
-#define ESW_ALLOWED(esw) ((esw) && MLX5_VPORT_MANAGER((esw)->dev))
+#define ESW_ALLOWED(esw) ((esw) && MLX5_ESWITCH_MANAGER((esw)->dev))
+
 
 int mlx5_eswitch_enable_sriov(struct mlx5_eswitch *esw, int nvfs, int mode)
 {
 	int err;
 	int i, enabled_events;
 
-	if (!ESW_ALLOWED(esw))
-		return 0;
-
-	if (!MLX5_ESWITCH_MANAGER(esw->dev) ||
+	if (!ESW_ALLOWED(esw) ||
 	    !MLX5_CAP_ESW_FLOWTABLE_FDB(esw->dev, ft_support)) {
 		esw_warn(esw->dev, "E-Switch FDB is not supported, aborting ...\n");
 		return -EOPNOTSUPP;
@@ -1728,7 +1726,7 @@ int mlx5_eswitch_set_vport_mac(struct ml
 	u64 node_guid;
 	int err = 0;
 
-	if (!ESW_ALLOWED(esw))
+	if (!MLX5_CAP_GEN(esw->dev, vport_group_manager))
 		return -EPERM;
 	if (!LEGAL_VPORT(esw, vport) || is_multicast_ether_addr(mac))
 		return -EINVAL;
@@ -1805,7 +1803,7 @@ int mlx5_eswitch_get_vport_config(struct
 {
 	struct mlx5_vport *evport;
 
-	if (!ESW_ALLOWED(esw))
+	if (!MLX5_CAP_GEN(esw->dev, vport_group_manager))
 		return -EPERM;
 	if (!LEGAL_VPORT(esw, vport))
 		return -EINVAL;
--- a/drivers/net/ethernet/mellanox/mlx5/core/vport.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/vport.c
@@ -549,8 +549,6 @@ int mlx5_modify_nic_vport_node_guid(stru
 		return -EINVAL;
 	if (!MLX5_CAP_GEN(mdev, vport_group_manager))
 		return -EACCES;
-	if (!MLX5_CAP_ESW(mdev, nic_vport_node_guid_modify))
-		return -EOPNOTSUPP;
 
 	in = kvzalloc(inlen, GFP_KERNEL);
 	if (!in)


