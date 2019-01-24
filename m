Return-Path: <SRS0=jJS3=QA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A08C282C3
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:31:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 136CF21903
	for <linux-kernel@archiver.kernel.org>; Thu, 24 Jan 2019 19:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548358295;
	bh=OcQazP88EBgyzboeJouFRNkf3f8SjNtrQlM7A+1JO3Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KEUaN/ovkiIFwEe56gi6Oty+V1kvmJl3fXnKKNSD9hNXZwq7kioZq0+DsAqqvNTMk
	 zJAdmN+gQYFfQhbKXbGnoPR5KU5sdJYEdBhg8Df6CyWoT3dkTAi+j8HgXkFXlGs2rJ
	 cWNZK9BL8XK4l2WIJ9roIdWw0RD015+0bdpRqCz4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731644AbfAXTbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Jan 2019 14:31:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:59248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730163AbfAXTb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jan 2019 14:31:28 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EABC3218E2;
        Thu, 24 Jan 2019 19:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548358287;
        bh=OcQazP88EBgyzboeJouFRNkf3f8SjNtrQlM7A+1JO3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xvXxPH8s4TEoeJjxgJZXAAlF2aNWEuGfJP8SHbM2/3en7FpbcX7rThExuWfpdTLPd
         Kqi1qqd1706RJkWMalW3sGdTCiumjJCPlZS2mzqNQFuli6TMBpndIIoITGB0ChLNX6
         nE+Z+iQLESkHgXf1r8foeV6CHuQBjYpL+Md2jFUY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Jiri Pirko <jiri@mellanox.com>,
        Ido Schimmel <idosch@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 02/63] mlxsw: spectrum: Disable lag port TX before removing it
Date:   Thu, 24 Jan 2019 20:19:51 +0100
Message-Id: <20190124190155.430643301@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190124190155.176570028@linuxfoundation.org>
References: <20190124190155.176570028@linuxfoundation.org>
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

From: Jiri Pirko <jiri@mellanox.com>

[ Upstream commit 8adbe212a159d9c78a90fca1d854f6e63452426b ]

Make sure that lag port TX is disabled before mlxsw_sp_port_lag_leave()
is called and prevent from possible EMAD error.

Fixes: 0d65fc13042f ("mlxsw: spectrum: Implement LAG port join/leave")
Signed-off-by: Jiri Pirko <jiri@mellanox.com>
Signed-off-by: Ido Schimmel <idosch@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum.c
@@ -4276,12 +4276,15 @@ static int mlxsw_sp_netdevice_port_upper
 							   lower_dev,
 							   upper_dev);
 		} else if (netif_is_lag_master(upper_dev)) {
-			if (info->linking)
+			if (info->linking) {
 				err = mlxsw_sp_port_lag_join(mlxsw_sp_port,
 							     upper_dev);
-			else
+			} else {
+				mlxsw_sp_port_lag_tx_en_set(mlxsw_sp_port,
+							    false);
 				mlxsw_sp_port_lag_leave(mlxsw_sp_port,
 							upper_dev);
+			}
 		} else if (netif_is_ovs_master(upper_dev)) {
 			if (info->linking)
 				err = mlxsw_sp_port_ovs_join(mlxsw_sp_port);


