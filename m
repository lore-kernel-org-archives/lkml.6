Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8F7C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:03:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7485E2146F
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:03:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXc9K7+a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7485E2146F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729821AbeK2RHU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:07:20 -0500
Received: from mail.kernel.org ([198.145.29.99]:44474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728459AbeK2RHS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:07:18 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 85068213A2;
        Thu, 29 Nov 2018 06:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471386;
        bh=qZ7mVqWDic5+86wDpMVzPbqh1bzluqqHQrPXL5Y4rmw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RXc9K7+aRPPWmrVt8HoBPSfeUPME+oLBUF9Ky3DN/U+fH6VsSMj96vcaLsS7nuHM6
         Cea+sHO8OFhxbkXKMsA2KQSVaAVO7gXcvtl+2EMud/OcmwXAM9s98GBks20f6K3STm
         SH1qen/UV8iaH+Dkxj4z0/ekwLQfirqNNrMIXiqc=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 29/35] net: thunderx: set xdp_prog to NULL if bpf_prog_add fails
Date:   Thu, 29 Nov 2018 01:01:03 -0500
Message-Id: <20181129060110.159878-29-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060110.159878-1-sashal@kernel.org>
References: <20181129060110.159878-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>

[ Upstream commit 6d0f60b0f8588fd4380ea5df9601e12fddd55ce2 ]

Set xdp_prog pointer to NULL if bpf_prog_add fails since that routine
reports the error code instead of NULL in case of failure and xdp_prog
pointer value is used in the driver to verify if XDP is currently
enabled.
Moreover report the error code to userspace if nicvf_xdp_setup fails

Fixes: 05c773f52b96 ("net: thunderx: Add basic XDP support")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index 2237ef8e4344..f13256af8031 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -1691,6 +1691,7 @@ static int nicvf_xdp_setup(struct nicvf *nic, struct bpf_prog *prog)
 	bool if_up = netif_running(nic->netdev);
 	struct bpf_prog *old_prog;
 	bool bpf_attached = false;
+	int ret = 0;
 
 	/* For now just support only the usual MTU sized frames */
 	if (prog && (dev->mtu > 1500)) {
@@ -1724,8 +1725,12 @@ static int nicvf_xdp_setup(struct nicvf *nic, struct bpf_prog *prog)
 	if (nic->xdp_prog) {
 		/* Attach BPF program */
 		nic->xdp_prog = bpf_prog_add(nic->xdp_prog, nic->rx_queues - 1);
-		if (!IS_ERR(nic->xdp_prog))
+		if (!IS_ERR(nic->xdp_prog)) {
 			bpf_attached = true;
+		} else {
+			ret = PTR_ERR(nic->xdp_prog);
+			nic->xdp_prog = NULL;
+		}
 	}
 
 	/* Calculate Tx queues needed for XDP and network stack */
@@ -1737,7 +1742,7 @@ static int nicvf_xdp_setup(struct nicvf *nic, struct bpf_prog *prog)
 		netif_trans_update(nic->netdev);
 	}
 
-	return 0;
+	return ret;
 }
 
 static int nicvf_xdp(struct net_device *netdev, struct netdev_xdp *xdp)
-- 
2.17.1

