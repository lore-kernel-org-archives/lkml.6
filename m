Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id DFCC7C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:00:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD24208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 17:00:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="l57cnV8T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CD24208B1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934718AbeFLRAr (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 13:00:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:51880 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754377AbeFLQxR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 12:53:17 -0400
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 790B0208B4;
        Tue, 12 Jun 2018 16:53:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528822397;
        bh=fnfsGlk2Wl7XbLt6P94MNny/pRiMvdNqQPBJZoxjBb8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l57cnV8T+DAhRac+BeTbkxBy4ypCcIOfVkWqV32YD93Z9mhQDAcotUoBXOibA3tmC
         FsQsUiSJOZsU4UYW2PnDL8tr/f9cDaErTT4fOJrYFUL5yDYTThgQFwgD2hvX3mumE1
         U9Qui0KDWk8rmEp5wxn6O5Xov6Fn4L87qjC8Eo6M=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Jiri Pirko <jiri@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.4 21/24] team: use netdev_features_t instead of u32
Date:   Tue, 12 Jun 2018 18:52:05 +0200
Message-Id: <20180612164817.721601047@linuxfoundation.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180612164816.587001852@linuxfoundation.org>
References: <20180612164816.587001852@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

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
@@ -983,7 +983,8 @@ static void team_port_disable(struct tea
 static void ___team_compute_features(struct team *team)
 {
 	struct team_port *port;
-	u32 vlan_features = TEAM_VLAN_FEATURES & NETIF_F_ALL_FOR_ALL;
+	netdev_features_t vlan_features = TEAM_VLAN_FEATURES &
+					  NETIF_F_ALL_FOR_ALL;
 	unsigned short max_hard_header_len = ETH_HLEN;
 	unsigned int dst_release_flag = IFF_XMIT_DST_RELEASE |
 					IFF_XMIT_DST_RELEASE_PERM;


