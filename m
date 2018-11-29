Return-Path: <SRS0=8q1S=OI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4DDC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:05:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0696720868
	for <linux-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 06:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qu7xYQZl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0696720868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730489AbeK2RKF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 12:10:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:50498 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729932AbeK2RKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 12:10:04 -0500
Received: from sasha-vm.mshome.net (unknown [37.142.5.207])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B096620868;
        Thu, 29 Nov 2018 06:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543471552;
        bh=On35lYXTQkomtSr4iE0BZjVyrwpKWwjGvpHvPuW/tbM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Qu7xYQZlGVmY12dCMke0d9eES4ron9ObC6t75R++pbl5BAP/ZJAjOBbNXBJt07Vn1
         7CB+rhySvuJPmq9I77qryAEKlb6eJUXYqzLgbfO5acfy9Bpxi4TbcnE8r55+gwOdYu
         GJC6wC6NexvWEKPLDRLhZrWUj7+gNxCG1CR40n8g=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aya Levin <ayal@mellanox.com>, Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 3.18 4/6] net/mlx4: Fix UBSAN warning of signed integer overflow
Date:   Thu, 29 Nov 2018 01:05:33 -0500
Message-Id: <20181129060535.160592-4-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129060535.160592-1-sashal@kernel.org>
References: <20181129060535.160592-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aya Levin <ayal@mellanox.com>

[ Upstream commit a463146e67c848cbab5ce706d6528281b7cded08 ]

UBSAN: Undefined behavior in
drivers/net/ethernet/mellanox/mlx4/resource_tracker.c:626:29
signed integer overflow: 1802201963 + 1802201963 cannot be represented
in type 'int'

The union of res_reserved and res_port_rsvd[MLX4_MAX_PORTS] monitors
granting of reserved resources. The grant operation is calculated and
protected, thus both members of the union cannot be negative.  Changed
type of res_reserved and of res_port_rsvd[MLX4_MAX_PORTS] from signed
int to unsigned int, allowing large value.

Fixes: 5a0d0a6161ae ("mlx4: Structures and init/teardown for VF resource quotas")
Signed-off-by: Aya Levin <ayal@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/mlx4.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/mlx4.h b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
index de10dbb2e6ed..4f63915f14be 100644
--- a/drivers/net/ethernet/mellanox/mlx4/mlx4.h
+++ b/drivers/net/ethernet/mellanox/mlx4/mlx4.h
@@ -516,8 +516,8 @@ struct slave_list {
 struct resource_allocator {
 	spinlock_t alloc_lock; /* protect quotas */
 	union {
-		int res_reserved;
-		int res_port_rsvd[MLX4_MAX_PORTS];
+		unsigned int res_reserved;
+		unsigned int res_port_rsvd[MLX4_MAX_PORTS];
 	};
 	union {
 		int res_free;
-- 
2.17.1

