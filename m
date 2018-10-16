Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB175C5ACC6
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A33BA21477
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 17:18:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="m4rcLRTA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33BA21477
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730156AbeJQBKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Oct 2018 21:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:54872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728680AbeJQBKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Oct 2018 21:10:02 -0400
Received: from localhost (ip-213-127-77-176.ip.prioritytelecom.net [213.127.77.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 67B212147C;
        Tue, 16 Oct 2018 17:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539710318;
        bh=ZCKehb65ezTLMocdUmzoC2q5LuXD6iSu9Up1di8tmbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m4rcLRTALC5sz1T51+UifB4ZC+R04CUM9gxEfbkFCsa/o3PO/ViqWKLkSBE/MCRDu
         yiDcfALGXxtSfCqzs4JgeBQbdvnDYuEQQ4m7LMZo/pVeOTBg9gZHKq4uWV6/LAiCBr
         IbYk57soBUT5UWdevt2tL6jZqhzgUKc+QCXE5yjE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Jakub Kicinski <jakub.kicinski@netronome.com>,
        Simon Horman <simon.horman@netronome.com>,
        Pieter Jansen van Vuuren 
        <pieter.jansenvanvuuren@netronome.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 034/109] nfp: avoid soft lockups under control message storm
Date:   Tue, 16 Oct 2018 19:05:02 +0200
Message-Id: <20181016170526.889486892@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181016170524.530541524@linuxfoundation.org>
References: <20181016170524.530541524@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/netronome/nfp/nfp_net_common.c |   17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

--- a/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
+++ b/drivers/net/ethernet/netronome/nfp/nfp_net_common.c
@@ -2058,14 +2058,17 @@ nfp_ctrl_rx_one(struct nfp_net *nn, stru
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
@@ -2077,9 +2080,13 @@ static void nfp_ctrl_poll(unsigned long
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


