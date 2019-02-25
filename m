Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5E6C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:18:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0CDCA217F4
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 21:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1551129493;
	bh=BsKlt01CzD0tptuGp2VzscKoAzZuM90vBmAqrVsN720=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=v2nEr8MSHg5iK7izhcaoWXQhBn0Y01TVOlGHnQzAlZtWH2OUErov0HF55lQ8stPM0
	 bonDprtsBZUe03NBywhX91kouj2N43cjsk6G0XcQG5wSGn+wLjQvlVGCxpFmoV5Tlv
	 tIcj7Wdky+dzqisrMOX6CNAlpF2NxeYr+hzzBfg0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730069AbfBYVSL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 16:18:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:50562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730054AbfBYVSH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 16:18:07 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEC14217F9;
        Mon, 25 Feb 2019 21:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1551129486;
        bh=BsKlt01CzD0tptuGp2VzscKoAzZuM90vBmAqrVsN720=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zmbJTNBP+PcphBxNJWauSYm7ZmrgomTr7hAgMwHCw/zcNYeUYy3/HxkY/b2Tn1xdK
         5shn29qcsfxZcXrPVu03nN9XeImIs1lnl9xH8N3W4S0hsZ1MXWfzv+VJ8yM3ptY7qE
         M2H80rbv8flcMblYvc57vIT8DiQxPIdtO3/+1+gA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Or Gerlitz <ogerlitz@mellanox.com>,
        Tonghao Zhang <xiangxia.m.yue@gmail.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 47/71] net/mlx5e: Dont overwrite pedit action when multiple pedit used
Date:   Mon, 25 Feb 2019 22:11:49 +0100
Message-Id: <20190225195038.175897761@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190225195034.555044862@linuxfoundation.org>
References: <20190225195034.555044862@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tonghao Zhang <xiangxia.m.yue@gmail.com>

[ Upstream commit 218d05ce326f9e1b40a56085431fa1068b43d5d9 ]

In some case, we may use multiple pedit actions to modify packets.
The command shown as below: the last pedit action is effective.

$ tc filter add dev netdev_rep parent ffff: protocol ip prio 1    \
	flower skip_sw ip_proto icmp dst_ip 3.3.3.3        \
	action pedit ex munge ip dst set 192.168.1.100 pipe    \
	action pedit ex munge eth src set 00:00:00:00:00:01 pipe    \
	action pedit ex munge eth dst set 00:00:00:00:00:02 pipe    \
	action csum ip pipe    \
	action tunnel_key set src_ip 1.1.1.100 dst_ip 1.1.1.200 dst_port 4789 id 100 \
	action mirred egress redirect dev vxlan0

To fix it, we add max_mod_hdr_actions to mlx5e_tc_flow_parse_attr struction,
max_mod_hdr_actions will store the max pedit action number we support and
num_mod_hdr_actions indicates how many pedit action we used, and store all
pedit action to mod_hdr_actions.

Fixes: d79b6df6b10a ("net/mlx5e: Add parsing of TC pedit actions to HW format")
Cc: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Tonghao Zhang <xiangxia.m.yue@gmail.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Acked-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |   25 ++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -81,6 +81,7 @@ struct mlx5e_tc_flow_parse_attr {
 	struct ip_tunnel_info tun_info;
 	struct mlx5_flow_spec spec;
 	int num_mod_hdr_actions;
+	int max_mod_hdr_actions;
 	void *mod_hdr_actions;
 	int mirred_ifindex;
 };
@@ -1128,9 +1129,9 @@ static struct mlx5_fields fields[] = {
 	OFFLOAD(UDP_DPORT, 2, udp.dest,   0),
 };
 
-/* On input attr->num_mod_hdr_actions tells how many HW actions can be parsed at
- * max from the SW pedit action. On success, it says how many HW actions were
- * actually parsed.
+/* On input attr->max_mod_hdr_actions tells how many HW actions can be parsed at
+ * max from the SW pedit action. On success, attr->num_mod_hdr_actions
+ * says how many HW actions were actually parsed.
  */
 static int offload_pedit_fields(struct pedit_headers *masks,
 				struct pedit_headers *vals,
@@ -1153,9 +1154,11 @@ static int offload_pedit_fields(struct p
 	add_vals = &vals[TCA_PEDIT_KEY_EX_CMD_ADD];
 
 	action_size = MLX5_UN_SZ_BYTES(set_action_in_add_action_in_auto);
-	action = parse_attr->mod_hdr_actions;
-	max_actions = parse_attr->num_mod_hdr_actions;
-	nactions = 0;
+	action = parse_attr->mod_hdr_actions +
+		 parse_attr->num_mod_hdr_actions * action_size;
+
+	max_actions = parse_attr->max_mod_hdr_actions;
+	nactions = parse_attr->num_mod_hdr_actions;
 
 	for (i = 0; i < ARRAY_SIZE(fields); i++) {
 		f = &fields[i];
@@ -1260,7 +1263,7 @@ static int alloc_mod_hdr_actions(struct
 	if (!parse_attr->mod_hdr_actions)
 		return -ENOMEM;
 
-	parse_attr->num_mod_hdr_actions = max_actions;
+	parse_attr->max_mod_hdr_actions = max_actions;
 	return 0;
 }
 
@@ -1304,9 +1307,11 @@ static int parse_tc_pedit_action(struct
 			goto out_err;
 	}
 
-	err = alloc_mod_hdr_actions(priv, a, namespace, parse_attr);
-	if (err)
-		goto out_err;
+	if (!parse_attr->mod_hdr_actions) {
+		err = alloc_mod_hdr_actions(priv, a, namespace, parse_attr);
+		if (err)
+			goto out_err;
+	}
 
 	err = offload_pedit_fields(masks, vals, parse_attr);
 	if (err < 0)


