Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B772AC04EBF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 856AE2148D
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 04:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgtBIVWO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 856AE2148D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbeJPMB5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 08:01:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:49384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727877AbeJPMBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 08:01:55 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 30B082148C;
        Tue, 16 Oct 2018 04:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539663212;
        bh=26gkfIWFRXxsFr4zKmChovErmPlQuWWFe8SXOYUSZ4Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UgtBIVWOFDQJNvUcF+V9oG9X3FkhrjII0VRuXjkAmgJtfO4gxZs3IXILBq6qAhgVH
         waW3mjGHpQ+JAVhwc1PUINKE9eN8iPlOpytDejff8BxehBI5Zl4tBqniaGdrZBtw8M
         /M/9SFzwCLyCIzxBMa1t1SqQokBmSUEcC+RxWzdg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jakub Kicinski <jakub.kicinski@netronome.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.18 074/100] nfp: avoid soft lockups under control message storm
Date:   Tue, 16 Oct 2018 00:11:55 -0400
Message-Id: <20181016041221.135528-74-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181016041221.135528-1-sashal@kernel.org>
References: <20181016041221.135528-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jakub Kicinski <jakub.kicinski@netronome.com>

[ Upstream commit ff58e2df62ce29d0552278c290ae494b30fe0c6f ]

When FW floods the driver with control messages try to exit the cmsg
processing loop every now and then to avoid soft lockups.  Cmsg
processing is generally very lightweight so 512 seems like a reasonable
budget, which should not be exceeded under normal conditions.

Fixes: 77ece8d5f196 ("nfp: add control vNIC datapath")
Signed-off-by: Jakub Kicinski <jakub.kicinski@netronome.com>
Reviewed-by: Simon Horman <simon.horman@netronome.com>
Tested-by: Pieter Jansen van Vuuren <pieter.jansenvanvuuren@netronome.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/netronome/nfp/nfp_net_common.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
index bfccc1955907..80306e4f247c 100644
--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2068,14 +2068,17 @@ nfp_ctrl_rx_one(struct nfp_net *nn, struct nfp_net_dp *dp,
 	return true;
 }
 
-static void nfp_ctrl_rx(struct nfp_net_r_vector *r_vec)
+static bool nfp_ctrl_rx(struct nfp_net_r_vector *r_vec)
 {
 	struct nfp_net_rx_ring *rx_ring = r_vec->rx_ring;
 	struct nfp_net *nn = r_vec->nfp_net;
 	struct nfp_net_dp *dp = &nn->dp;
+	unsigned int budget = 512;
 
-	while (nfp_ctrl_rx_one(nn, dp, r_vec, rx_ring))
+	while (nfp_ctrl_rx_one(nn, dp, r_vec, rx_ring) && budget--)
 		continue;
+
+	return budget;
 }
 
 static void nfp_ctrl_poll(unsigned long arg)
@@ -2087,9 +2090,13 @@ static void nfp_ctrl_poll(unsigned long arg)
 	__nfp_ctrl_tx_queued(r_vec);
 	spin_unlock_bh(&r_vec->lock);
 
-	nfp_ctrl_rx(r_vec);
-
-	nfp_net_irq_unmask(r_vec->nfp_net, r_vec->irq_entry);
+	if (nfp_ctrl_rx(r_vec)) {
+		nfp_net_irq_unmask(r_vec->nfp_net, r_vec->irq_entry);
+	} else {
+		tasklet_schedule(&r_vec->tasklet);
+		nn_dp_warn(&r_vec->nfp_net->dp,
+			   "control message budget exceeded!\n");
+	}
 }
 
 /* Setup and Configuration
-- 
2.17.1

