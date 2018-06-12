Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 75D54C5CFF1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22889208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 16:56:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rJxS4RTv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22889208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934881AbeFLQ4e (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 12:56:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:56232 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933893AbeFLQy0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:54:26 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50776208B4;
        Tue, 12 Jun 2018 16:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822465;
        bh=AjGRTKFT4wIuxmDqikvEVUvnD+bRg2B3df/N6hap5JY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rJxS4RTvFOMEtsoxlkwTF1k14Q+++5j8Yv3LQiohUUNWrli/Pz3cYORFJIhVBn5lw
         x+nttcAv79mqZDxT6m+u7JWAW9ew8ZEnhNRh8/5BEELjkuPOto6uPGX6AqTU9vMA9q
         nfQW9wB30LLzXUSj2bm+cKiapFLkeM10QTrJF3NE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 3.18 20/21] team: use netdev_features_t instead of u32
Date:   Tue, 12 Jun 2018 18:52:17 +0200
Message-Id: <20180612164826.222632439@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164825.401145490@linuxfoundation.org>
References: <20180612164825.401145490@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 25ea66544bfd1d9df1b7e1502f8717e85fa1e6e6 ]

This code was introduced in 2011 around the same time that we made
netdev_features_t a u64 type.  These days a u32 is not big enough to
hold all the potential features.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Acked-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/team/team.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/net/team/team.c
+++ b/drivers/net/team/team.c
@@ -989,7 +989,8 @@ static void team_port_disable(struct tea
 static void __team_compute_features(struct team *team)
 {
 	struct team_port *port;
-	u32 vlan_features = TEAM_VLAN_FEATURES & NETIF_F_ALL_FOR_ALL;
+	netdev_features_t vlan_features = TEAM_VLAN_FEATURES &
+					  NETIF_F_ALL_FOR_ALL;
 	unsigned short max_hard_header_len = ETH_HLEN;
 	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
 					IFF_XMIT_DST_RELEASE_PERM;


