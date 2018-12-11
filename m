Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 359A0C07E85
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:23:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DCBFA2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 16:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544545380;
	bh=sAPiXTXShBb6zsb5/SvdDf5j0AqQJvA11mzD7REyVRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=HCeG0rCSqixVjKXQJN5cH3IK1FVbXXbZJuuSt9kWuIzFjSfg5B+jyzvzFYk9igIwQ
	 98z8/yDiiwuOEvWc+yEKy3qiTe9AnkqbWNZVK/MQYAg8Z+ZT9FfiAI/IrZuU2fmCik
	 6dK3XHHyD86BTJzW8X6MLXjdhmZnAjfhXXMqShnc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCBFA2084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727639AbeLKPnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 10:43:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727622AbeLKPnq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 10:43:46 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0AB1920672;
        Tue, 11 Dec 2018 15:43:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544543025;
        bh=sAPiXTXShBb6zsb5/SvdDf5j0AqQJvA11mzD7REyVRw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nnZSDUMxr/9j4dxQKD6fdPzeYXkBQBb6D8PAxMIb84dZYLON1dJZ/Mpx7cPb7iVNL
         nWivl/mtJvgJVD5SnOS/w5XQyQScxbJbgoQjmDXDV1zD7Ma7/uk5GUltfS5dvHg+iv
         WZncpjDBTWwOpmKm2xAAdJfVckYtOxrGK3mkEoO4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Aya Levin <ayal@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 3.18 37/54] net/mlx4: Fix UBSAN warning of signed integer overflow
Date:   Tue, 11 Dec 2018 16:41:25 +0100
Message-Id: <20181211151548.178947254@linuxfoundation.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181211151546.010073210@linuxfoundation.org>
References: <20181211151546.010073210@linuxfoundation.org>
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

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
2.19.1



