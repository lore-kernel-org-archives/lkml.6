Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB5CBC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 932F8206BB
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 19:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="fG14Nv9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 932F8206BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387848AbeKVFm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 00:42:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:37590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387767AbeKVFm4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 00:42:56 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 037D1206BB;
        Wed, 21 Nov 2018 19:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542827244;
        bh=/FFOWekMoLDeKmsTMc7lCJeAzVOfDlNUcyn6pOQM/XM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fG14Nv9TI947PzlTtU6yEoVyMgqRAlKayNuIMZCz8713MNCp01E53/wz0KPchi3PP
         tG4nL9eRxsTpiyOAoqGiG1s5zDQ7KOeHfuDMZCPAO7X+dej1Cnpc9hNEbts7obzb26
         P+AQu1WAv5msSBp6irGbXe46aO946aKA349BMJig=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Raed Salem <raeds@mellanox.com>,
        Aviad Yehezkel <aviadye@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.19 28/42] net/mlx5: IPSec, Fix the SA context hash key
Date:   Wed, 21 Nov 2018 20:06:04 +0100
Message-Id: <20181121183149.202805283@linuxfoundation.org>
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

From: Raed Salem <raeds@mellanox.com>

[ Upstream commit f2b18732ee9863ac036759baf616ffa03c252ed5 ]

The commit "net/mlx5: Refactor accel IPSec code" introduced a
bug where asynchronous short time change in hash key value
by create/release SA context might happen during an asynchronous
hash resize operation this could cause a subsequent remove SA
context operation to fail as the key value used during resize is
not the same key value used when remove SA context operation is
invoked.

This commit fixes the bug by defining the SA context hash key
such that it includes only fields that never change during the
lifetime of the SA context object.

Fixes: d6c4f0298cec ("net/mlx5: Refactor accel IPSec code")
Signed-off-by: Raed Salem <raeds@mellanox.com>
Reviewed-by: Aviad Yehezkel <aviadye@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c |   10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fpga/ipsec.c
@@ -83,8 +83,14 @@ struct mlx5_fpga_ipsec_rule {
 };
 
 static const struct rhashtable_params rhash_sa = {
-	.key_len = FIELD_SIZEOF(struct mlx5_fpga_ipsec_sa_ctx, hw_sa),
-	.key_offset = offsetof(struct mlx5_fpga_ipsec_sa_ctx, hw_sa),
+	/* Keep out "cmd" field from the key as it's
+	 * value is not constant during the lifetime
+	 * of the key object.
+	 */
+	.key_len = FIELD_SIZEOF(struct mlx5_fpga_ipsec_sa_ctx, hw_sa) -
+		   FIELD_SIZEOF(struct mlx5_ifc_fpga_ipsec_sa_v1, cmd),
+	.key_offset = offsetof(struct mlx5_fpga_ipsec_sa_ctx, hw_sa) +
+		      FIELD_SIZEOF(struct mlx5_ifc_fpga_ipsec_sa_v1, cmd),
 	.head_offset = offsetof(struct mlx5_fpga_ipsec_sa_ctx, hash),
 	.automatic_shrinking = true,
 	.min_size = 1,


