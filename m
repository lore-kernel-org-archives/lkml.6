Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4861AC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0178F2088F
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 06:25:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0178F2088F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbeHUJn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 05:43:58 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:55312 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbeHUJn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 05:43:57 -0400
Received: from localhost (5355525A.cm-6-6b.dynamic.ziggo.nl [83.85.82.90])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E4BC2516;
        Tue, 21 Aug 2018 06:25:09 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Nir Dotan <nird@mellanox.com>,
        Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.17 08/42] mlxsw: core_acl_flex_actions: Return error for conflicting actions
Date:   Tue, 21 Aug 2018 08:20:40 +0200
Message-Id: <20180821055017.979288105@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180821055017.596264829@linuxfoundation.org>
References: <20180821055017.596264829@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nir Dotan <nird@mellanox.com>

[ Upstream commit 3757b255bf20ae3c941abae7624ff215bfd9ef05 ]

Spectrum switch ACL action set is built in groups of three actions
which may point to additional actions. A group holds a single record
which can be set as goto record for pointing at a following group
or can be set to mark the termination of the lookup. This is perfectly
adequate for handling a series of actions to be executed on a packet.
While the SW model allows configuration of conflicting actions
where it is clear that some actions will never execute, the mlxsw
driver must block such configurations as it creates a conflict
over the single terminate/goto record value.

For a conflicting actions configuration such as:

 # tc filter add dev swp49 parent ffff: \
   protocol ip pref 10 \
   flower skip_sw dst_ip 192.168.101.1 \
   action goto chain 100 \
   action mirred egress mirror dev swp4

Where it is clear that the last action will never execute, the
mlxsw driver was issuing a warning instead of returning an error.
Therefore replace that warning with an error for this specific
case.

Fixes: 4cda7d8d7098 ("mlxsw: core: Introduce flexible actions support")
Signed-off-by: Nir Dotan <nird@mellanox.com>
Reviewed-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c |   42 ++++++------
 1 file changed, 21 insertions(+), 21 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_acl_flex_actions.c
@@ -626,8 +626,8 @@ static char *mlxsw_afa_block_append_acti
 	char *oneact;
 	char *actions;
 
-	if (WARN_ON(block->finished))
-		return NULL;
+	if (block->finished)
+		return ERR_PTR(-EINVAL);
 	if (block->cur_act_index + action_size >
 	    block->afa->max_acts_per_set) {
 		struct mlxsw_afa_set *set;
@@ -637,7 +637,7 @@ static char *mlxsw_afa_block_append_acti
 		 */
 		set = mlxsw_afa_set_create(false);
 		if (!set)
-			return NULL;
+			return ERR_PTR(-ENOBUFS);
 		set->prev = block->cur_set;
 		block->cur_act_index = 0;
 		block->cur_set->next = set;
@@ -724,8 +724,8 @@ int mlxsw_afa_block_append_vlan_modify(s
 						  MLXSW_AFA_VLAN_CODE,
 						  MLXSW_AFA_VLAN_SIZE);
 
-	if (!act)
-		return -ENOBUFS;
+	if (IS_ERR(act))
+		return PTR_ERR(act);
 	mlxsw_afa_vlan_pack(act, MLXSW_AFA_VLAN_VLAN_TAG_CMD_NOP,
 			    MLXSW_AFA_VLAN_CMD_SET_OUTER, vid,
 			    MLXSW_AFA_VLAN_CMD_SET_OUTER, pcp,
@@ -806,8 +806,8 @@ int mlxsw_afa_block_append_drop(struct m
 						  MLXSW_AFA_TRAPDISC_CODE,
 						  MLXSW_AFA_TRAPDISC_SIZE);
 
-	if (!act)
-		return -ENOBUFS;
+	if (IS_ERR(act))
+		return PTR_ERR(act);
 	mlxsw_afa_trapdisc_pack(act, MLXSW_AFA_TRAPDISC_TRAP_ACTION_NOP,
 				MLXSW_AFA_TRAPDISC_FORWARD_ACTION_DISCARD, 0);
 	return 0;
@@ -820,8 +820,8 @@ int mlxsw_afa_block_append_trap(struct m
 						  MLXSW_AFA_TRAPDISC_CODE,
 						  MLXSW_AFA_TRAPDISC_SIZE);
 
-	if (!act)
-		return -ENOBUFS;
+	if (IS_ERR(act))
+		return PTR_ERR(act);
 	mlxsw_afa_trapdisc_pack(act, MLXSW_AFA_TRAPDISC_TRAP_ACTION_TRAP,
 				MLXSW_AFA_TRAPDISC_FORWARD_ACTION_DISCARD,
 				trap_id);
@@ -836,8 +836,8 @@ int mlxsw_afa_block_append_trap_and_forw
 						  MLXSW_AFA_TRAPDISC_CODE,
 						  MLXSW_AFA_TRAPDISC_SIZE);
 
-	if (!act)
-		return -ENOBUFS;
+	if (IS_ERR(act))
+		return PTR_ERR(act);
 	mlxsw_afa_trapdisc_pack(act, MLXSW_AFA_TRAPDISC_TRAP_ACTION_TRAP,
 				MLXSW_AFA_TRAPDISC_FORWARD_ACTION_FORWARD,
 				trap_id);
@@ -908,8 +908,8 @@ mlxsw_afa_block_append_allocated_mirror(
 	char *act = mlxsw_afa_block_append_action(block,
 						  MLXSW_AFA_TRAPDISC_CODE,
 						  MLXSW_AFA_TRAPDISC_SIZE);
-	if (!act)
-		return -ENOBUFS;
+	if (IS_ERR(act))
+		return PTR_ERR(act);
 	mlxsw_afa_trapdisc_pack(act, MLXSW_AFA_TRAPDISC_TRAP_ACTION_NOP,
 				MLXSW_AFA_TRAPDISC_FORWARD_ACTION_FORWARD, 0);
 	mlxsw_afa_trapdisc_mirror_pack(act, true, mirror_agent);
@@ -996,8 +996,8 @@ int mlxsw_afa_block_append_fwd(struct ml
 
 	act = mlxsw_afa_block_append_action(block, MLXSW_AFA_FORWARD_CODE,
 					    MLXSW_AFA_FORWARD_SIZE);
-	if (!act) {
-		err = -ENOBUFS;
+	if (IS_ERR(act)) {
+		err = PTR_ERR(act);
 		goto err_append_action;
 	}
 	mlxsw_afa_forward_pack(act, MLXSW_AFA_FORWARD_TYPE_PBS,
@@ -1052,8 +1052,8 @@ int mlxsw_afa_block_append_allocated_cou
 {
 	char *act = mlxsw_afa_block_append_action(block, MLXSW_AFA_POLCNT_CODE,
 						  MLXSW_AFA_POLCNT_SIZE);
-	if (!act)
-		return -ENOBUFS;
+	if (IS_ERR(act))
+		return PTR_ERR(act);
 	mlxsw_afa_polcnt_pack(act, MLXSW_AFA_POLCNT_COUNTER_SET_TYPE_PACKETS_BYTES,
 			      counter_index);
 	return 0;
@@ -1123,8 +1123,8 @@ int mlxsw_afa_block_append_fid_set(struc
 	char *act = mlxsw_afa_block_append_action(block,
 						  MLXSW_AFA_VIRFWD_CODE,
 						  MLXSW_AFA_VIRFWD_SIZE);
-	if (!act)
-		return -ENOBUFS;
+	if (IS_ERR(act))
+		return PTR_ERR(act);
 	mlxsw_afa_virfwd_pack(act, MLXSW_AFA_VIRFWD_FID_CMD_SET, fid);
 	return 0;
 }
@@ -1193,8 +1193,8 @@ int mlxsw_afa_block_append_mcrouter(stru
 	char *act = mlxsw_afa_block_append_action(block,
 						  MLXSW_AFA_MCROUTER_CODE,
 						  MLXSW_AFA_MCROUTER_SIZE);
-	if (!act)
-		return -ENOBUFS;
+	if (IS_ERR(act))
+		return PTR_ERR(act);
 	mlxsw_afa_mcrouter_pack(act, MLXSW_AFA_MCROUTER_RPF_ACTION_TRAP,
 				expected_irif, min_mtu, rmid_valid, kvdl_index);
 	return 0;


