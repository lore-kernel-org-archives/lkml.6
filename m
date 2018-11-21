Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82516C04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:08:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A70421582
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:08:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="y1z0n+kj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A70421582
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388109AbeKVFnh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:43:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:38444 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732097AbeKVFnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:43:37 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1D14A214DB;
        Wed, 21 Nov 2018 19:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827284;
        bh=IX9e6h9Y2FkHf2T8q1R/mwfUOFwLRBO41GNuV6W4xYE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y1z0n+kj24IraQkk1mIQRlOgJ9kgpXPJ5Y1dkmy5lvb3yNZ0UKMCmdJCfBxFgDPbI
         Xbz45oen4LnWuHsZFaAmvq8KExX7aN2akpFbyRPzufQaWeRXmOhkUknIdOetdFqEAx
         2TsDP7wC2Tu8RGLGUQdJ38nHJ18KTCtJgf2JPZdQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.19 10/42] tg3: Add PHY reset for 5717/5719/5720 in change ring and flow control paths
Date:   Wed, 21 Nov 2018 20:05:46 +0100
Message-Id: <20181121183148.436876267@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181121183147.869199006@linuxfoundation.org>
References: <20181121183147.869199006@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Siva Reddy Kallam <siva.kallam@broadcom.com>

[ Upstream commit 59663e42199c93d1d7314d1446f6782fc4b1eb81 ]

This patch has the fix to avoid PHY lockup with 5717/5719/5720 in change
ring and flow control paths. This patch solves the RX hang while doing
continuous ring or flow control parameters with heavy traffic from peer.

Signed-off-by: Siva Reddy Kallam <siva.kallam@broadcom.com>
Acked-by: Michael Chan <michael.chan@broadcom.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/broadcom/tg3.c |   18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -12426,6 +12426,7 @@ static int tg3_set_ringparam(struct net_
 {
 	struct tg3 *tp = netdev_priv(dev);
 	int i, irq_sync = 0, err = 0;
+	bool reset_phy = false;
 
 	if ((ering->rx_pending > tp->rx_std_ring_mask) ||
 	    (ering->rx_jumbo_pending > tp->rx_jmb_ring_mask) ||
@@ -12457,7 +12458,13 @@ static int tg3_set_ringparam(struct net_
 
 	if (netif_running(dev)) {
 		tg3_halt(tp, RESET_KIND_SHUTDOWN, 1);
-		err = tg3_restart_hw(tp, false);
+		/* Reset PHY to avoid PHY lock up */
+		if (tg3_asic_rev(tp) == ASIC_REV_5717 ||
+		    tg3_asic_rev(tp) == ASIC_REV_5719 ||
+		    tg3_asic_rev(tp) == ASIC_REV_5720)
+			reset_phy = true;
+
+		err = tg3_restart_hw(tp, reset_phy);
 		if (!err)
 			tg3_netif_start(tp);
 	}
@@ -12491,6 +12498,7 @@ static int tg3_set_pauseparam(struct net
 {
 	struct tg3 *tp = netdev_priv(dev);
 	int err = 0;
+	bool reset_phy = false;
 
 	if (tp->link_config.autoneg == AUTONEG_ENABLE)
 		tg3_warn_mgmt_link_flap(tp);
@@ -12581,7 +12589,13 @@ static int tg3_set_pauseparam(struct net
 
 		if (netif_running(dev)) {
 			tg3_halt(tp, RESET_KIND_SHUTDOWN, 1);
-			err = tg3_restart_hw(tp, false);
+			/* Reset PHY to avoid PHY lock up */
+			if (tg3_asic_rev(tp) == ASIC_REV_5717 ||
+			    tg3_asic_rev(tp) == ASIC_REV_5719 ||
+			    tg3_asic_rev(tp) == ASIC_REV_5720)
+				reset_phy = true;
+
+			err = tg3_restart_hw(tp, reset_phy);
 			if (!err)
 				tg3_netif_start(tp);
 		}


