Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 683CAC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3207C214F1
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndo5lPNZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3207C214F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387863AbeKVFnA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:43:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:37636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbeKVFm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5F839214DB;
        Wed, 21 Nov 2018 19:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827246;
        bh=XY5pO3WxsYYCJ8aEQolvisyRmceiPAlzgXWfUW1r3To=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ndo5lPNZsMHaFKhRlNFJ1r1X4QgG5H0i0RZnQZAYSqX56lTcW5bh1BEhmKVj7cnA1
         JtyK7pGsUy2EVT0yyS3URFSGPx6VqN9iftl0OAdYx2Jb2p3wavZbYJ61pEqhDH2+1v
         DxHx1K4jOxK1XpQGwINgGDPdsF+kkveGY0T0nkbA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Denis Drozdov <denisd@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 29/42] net/mlx5e: IPoIB, Reset QP after channels are closed
Date:   Wed, 21 Nov 2018 20:06:05 +0100
Message-Id: <20181121183149.244338208@linuxfoundation.org>
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

From: Denis Drozdov <denisd@mellanox.com>

[ Upstream commit acf3766b36d8e59ecbc307894c6d05703ee48014 ]

The mlx5e channels should be closed before mlx5i_uninit_underlay_qp
puts the QP into RST (reset) state during mlx5i_close. Currently QP
state incorrectly set to RST before channels got deactivated and closed,
since mlx5_post_send request expects QP in RTS (Ready To Send) state.

The fix is to keep QP in RTS state until mlx5e channels get closed
and to reset QP afterwards.

Also this fix is simply correct in order to keep the open/close flow
symmetric, i.e mlx5i_init_underlay_qp() is called first thing at open,
the correct thing to do is to call mlx5i_uninit_underlay_qp() last thing
at close, which is exactly what this patch is doing.

Fixes: dae37456c8ac ("net/mlx5: Support for attaching multiple underlay QPs to root flow table")
Signed-off-by: Denis Drozdov <denisd@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c
@@ -502,9 +502,9 @@ static int mlx5i_close(struct net_device
 
 	netif_carrier_off(epriv->netdev);
 	mlx5_fs_remove_rx_underlay_qpn(mdev, ipriv->qp.qpn);
-	mlx5i_uninit_underlay_qp(epriv);
 	mlx5e_deactivate_priv_channels(epriv);
 	mlx5e_close_channels(&epriv->channels);
+	mlx5i_uninit_underlay_qp(epriv);
 unlock:
 	mutex_unlock(&epriv->state_lock);
 	return 0;


