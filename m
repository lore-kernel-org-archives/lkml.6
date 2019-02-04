Return-Path: <SRS0=wTza=QL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A11FEC282C4
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:48:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71B622087C
	for <linux-kernel@archiver.kernel.org>; Mon,  4 Feb 2019 10:48:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549277308;
	bh=asfdIc74bPe2Z3PoWi6Yk+zvNvk0wY4LMq05xxYfk84=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=bDL0dNa2u+gP9pc8mQqKeOx1IVJ+I5qcsHdWNY8OdgAUjsbA5qLYCoJ1kJ8HjApNj
	 /ECU8oZzmSBZvT/gpRpyRKwq80vFY99pOndE2xQh0Aw1Hlp3x5ioPtmHTPqMNS42bc
	 JAwPMZy3i/9kdTxIOy14W6x1JppZ5eWDppcO8TEg=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731841AbfBDKs0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 Feb 2019 05:48:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:46410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731827AbfBDKsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Feb 2019 05:48:23 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACF192087C;
        Mon,  4 Feb 2019 10:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549277302;
        bh=asfdIc74bPe2Z3PoWi6Yk+zvNvk0wY4LMq05xxYfk84=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QvwXxl/GqtPXRCUcBjz3VCy+kVkBYAP1IC0H4/DzpxNtvD5v3CF5zNSVJGs9rdha2
         gokTGDY+8riYg5ANYgPC6itk4WKkKWWJGCD6zl5Y8iOgYClVDo9HCjsLcvyID0Ta+K
         fSsu/hnO8CNuRVqwll9S65umoRdJvVh6BoUBfx94=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Bodong Wang <bodong@mellanox.com>,
        Yuval Avnery <yuvalav@mellanox.com>,
        Daniel Jurgens <danielj@mellanox.com>,
        Or Gerlitz <ogerlitz@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 23/74] Revert "net/mlx5e: E-Switch, Initialize eswitch only if eswitch manager"
Date:   Mon,  4 Feb 2019 11:36:36 +0100
Message-Id: <20190204103622.730444020@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190204103619.714714157@linuxfoundation.org>
References: <20190204103619.714714157@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bodong Wang <bodong@mellanox.com>

[ Upstream commit 4e046de0f50e04acd48eb373d6a9061ddf014e0c ]

This reverts commit 5f5991f36dce1e69dd8bd7495763eec2e28f08e7.

With the original commit, eswitch instance will not be initialized for
a function which is vport group manager but not eswitch manager such as
host PF on SmartNIC (BlueField) card. This will result in a kernel crash
when such a vport group manager is trying to access vports in its group.
E.g, PF vport manager (not eswitch manager) tries to configure the MAC
of its VF vport, a kernel trace will happen similar as bellow:

 BUG: unable to handle kernel NULL pointer dereference at 0000000000000000
 ...
 RIP: 0010:mlx5_eswitch_get_vport_config+0xc/0x180 [mlx5_core]
 ...

Fixes: 5f5991f36dce ("net/mlx5e: E-Switch, Initialize eswitch only if eswitch manager")
Signed-off-by: Bodong Wang <bodong@mellanox.com>
Reported-by: Yuval Avnery <yuvalav@mellanox.com>
Reviewed-by: Daniel Jurgens <danielj@mellanox.com>
Reviewed-by: Or Gerlitz <ogerlitz@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eswitch.c
@@ -1689,7 +1689,7 @@ int mlx5_eswitch_init(struct mlx5_core_d
 	int vport_num;
 	int err;
 
-	if (!MLX5_ESWITCH_MANAGER(dev))
+	if (!MLX5_VPORT_MANAGER(dev))
 		return 0;
 
 	esw_info(dev,
@@ -1758,7 +1758,7 @@ abort:
 
 void mlx5_eswitch_cleanup(struct mlx5_eswitch *esw)
 {
-	if (!esw || !MLX5_ESWITCH_MANAGER(esw->dev))
+	if (!esw || !MLX5_VPORT_MANAGER(esw->dev))
 		return;
 
 	esw_info(esw->dev, "cleanup\n");


