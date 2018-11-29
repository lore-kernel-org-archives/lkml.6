Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F72C43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE38E21104
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 05:58:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="BY0LysIF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE38E21104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbeK2RCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:02:45 -0500
Received: from mail.kernel.org ([198.145.29.99]:36456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727643AbeK2RCo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:02:44 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5249C21104;
        Thu, 29 Nov 2018 05:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471113;
        bh=HYGN2PRzcbfCl/sE6MZ7zY1JN2RomxZprAlNRsHQmnI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BY0LysIFmdmb40EVQPPz+J2iqktAdEIwcQn2VCAYMzfPg2Wz2ZQmpeZIJDNIepK4N
         YOWxM89T3326BkB0VtcjAhgov1mYu75PxG3z2hqVXRn7EyuW2DCxucIsRN3ATCDO4/
         0QGhr/+k2xLiG28raJJnwkre4iv+i1WnOLevU4Dg=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jack Morgenstein <jackm@dev.mellanox.co.il>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 29/68] net/mlx4_core: Zero out lkey field in SW2HW_MPT fw command
Date:   Thu, 29 Nov 2018 00:55:20 -0500
Message-Id: <20181129055559.159228-29-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129055559.159228-1-sashal@kernel.org>
References: <20181129055559.159228-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jack Morgenstein <jackm@dev.mellanox.co.il>

[ Upstream commit bd85fbc2038a1bbe84990b23ff69b6fc81a32b2c ]

When re-registering a user mr, the mpt information for the
existing mr when running SRIOV is obtained via the QUERY_MPT
fw command. The returned information includes the mpt's lkey.

This retrieved mpt information is used to move the mpt back
to hardware ownership in the rereg flow (via the SW2HW_MPT
fw command when running SRIOV).

The fw API spec states that for SW2HW_MPT, the lkey field
must be zero. Any ConnectX-3 PF driver which checks for strict spec
adherence will return failure for SW2HW_MPT if the lkey field is not
zero (although the fw in practice ignores this field for SW2HW_MPT).

Thus, in order to conform to the fw API spec, set the lkey field to zero
before invoking SW2HW_MPT when running SRIOV.

Fixes: e630664c8383 ("mlx4_core: Add helper functions to support MR re-registration")
Signed-off-by: Jack Morgenstein <jackm@dev.mellanox.co.il>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/mr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx4/mr.c b/drivers/net/ethernet/mellanox/mlx4/mr.c
index 2e84f10f59ba..1a11bc0e1612 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mr.c
+++ b/drivers/net/ethernet/mellanox/mlx4/mr.c
@@ -363,6 +363,7 @@ int mlx4_mr_hw_write_mpt(struct mlx4_dev *dev, struct mlx4_mr *mmr,
 			container_of((void *)mpt_entry, struct mlx4_cmd_mailbox,
 				     buf);
 
+		(*mpt_entry)->lkey = 0;
 		err = mlx4_SW2HW_MPT(dev, mailbox, key);
 	}
 
-- 
2.17.1

