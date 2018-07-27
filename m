Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D12E2C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:48:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 847382089A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:48:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 847382089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388445AbeG0LJK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:09:10 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51616 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388154AbeG0LJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:09:10 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 45419898;
        Fri, 27 Jul 2018 09:48:04 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Roi Dayan <roid@mellanox.com>,
        Paul Blakey <paulb@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.17 28/66] net/mlx5e: Only allow offloading decap egress (egdev) flows
Date:   Fri, 27 Jul 2018 11:45:21 +0200
Message-Id: <20180727093812.318424099@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
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

From: Roi Dayan <roid@mellanox.com>

[ Upstream commit 7e29392eee7a1e3318eeb1099807264a49f60e33 ]

We get egress rules through the egdev mechanism when the ingress device
is not supporting offload, with the expected use-case of tunnel decap
ingress rule set on shared tunnel device.

Make sure to offload egress/egdev rules only if decap action (tunnel key
unset) exists there and err otherwise.

Fixes: 717503b9cf57 ("net: sched: convert cls_flower->egress_dev users to tc_setup_cb_egdev infra")
Signed-off-by: Roi Dayan <roid@mellanox.com>
Signed-off-by: Paul Blakey <paulb@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_tc.c
@@ -1894,6 +1894,10 @@ static bool actions_match_supported(stru
 	else
 		actions = flow->nic_attr->action;
 
+	if (flow->flags & MLX5E_TC_FLOW_EGRESS &&
+	    !(actions & MLX5_FLOW_CONTEXT_ACTION_DECAP))
+		return false;
+
 	if (actions & MLX5_FLOW_CONTEXT_ACTION_MOD_HDR)
 		return modify_header_match_supported(&parse_attr->spec, exts);
 


