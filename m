Return-Path: <SRS0=Mdfq=OF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACBCAC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7456821104
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Nov 2018 10:53:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiBIQWSi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7456821104
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeKZVre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Nov 2018 16:47:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:55780 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727045AbeKZVrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Nov 2018 16:47:33 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5F5621104;
        Mon, 26 Nov 2018 10:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543229630;
        bh=vY9nGcdJ7m+1n2UMsima4l6ujp4RQy5ZbH4/z0xu5FM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JiBIQWSi7dDUexwFi4gBT8i9fYuZ2C5+VZ1HmBsHIWLD5/a8ijyOnN9u+vDphknMQ
         SdKphu36FKWK5q0C7sumf1i6YcNd3p8KPAnTmc9/ywP3yx/EXq6tG+35IBIKi5+XzU
         zd3pyooY4HVzFeMozuxQ/T7ctKmwKjN2HNPg5a4U=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Siva Reddy Kallam <siva.kallam@broadcom.com>,
        Michael Chan <michael.chan@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 04/70] tg3: Add PHY reset for 5717/5719/5720 in change ring and flow control paths
Date:   Mon, 26 Nov 2018 11:50:19 +0100
Message-Id: <20181126105047.296249142@linuxfoundation.org>
X-Mailer: git-send-email 2.19.2
In-Reply-To: <20181126105046.722096341@linuxfoundation.org>
References: <20181126105046.722096341@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -12379,6 +12379,7 @@ static int tg3_set_ringparam(struct net_
 {
 	struct tg3 *tp = netdev_priv(dev);
 	int i, irq_sync = 0, err = 0;
+	bool reset_phy = false;
 
 	if ((ering->rx_pending > tp->rx_std_ring_mask) ||
 	    (ering->rx_jumbo_pending > tp->rx_jmb_ring_mask) ||
@@ -12410,7 +12411,13 @@ static int tg3_set_ringparam(struct net_
 
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
@@ -12444,6 +12451,7 @@ static int tg3_set_pauseparam(struct net
 {
 	struct tg3 *tp = netdev_priv(dev);
 	int err = 0;
+	bool reset_phy = false;
 
 	if (tp->link_config.autoneg == AUTONEG_ENABLE)
 		tg3_warn_mgmt_link_flap(tp);
@@ -12534,7 +12542,13 @@ static int tg3_set_pauseparam(struct net
 
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


