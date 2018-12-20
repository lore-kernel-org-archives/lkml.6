Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F1C8C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F072320989
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 09:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1545298233;
	bh=KDQipaR4c2uNqsWisozBk+Nso+MQxcrMR6oJxX8LPZo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=UTGVBSc26ZHfsKzDT6caPjMUYouQJZc4xk2nRkaak+qMtwM5L2z7b2WtVrixtI8t1
	 LJNTTd5ny/2oWJHDrn7zLcXaJvInJoknoDVPPdQBWZY+LKXaTZyR9CP8DPi8OjUR0+
	 H5mvpj67toAy1Zwg7rHro6JV+Fck3uQDLaFt2lr8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732942AbeLTJac (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 04:30:32 -0500
Received: from mail.kernel.org ([198.145.29.99]:37386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732917AbeLTJaY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 04:30:24 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1416A20989;
        Thu, 20 Dec 2018 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1545298223;
        bh=KDQipaR4c2uNqsWisozBk+Nso+MQxcrMR6oJxX8LPZo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RnVmG8EWmrGKNuAjiaGxReLutYiRcuU0ShHJ5oxlLuflzD4AuG2JrxAuxaL3hemxD
         ARl/yFU7RQZ5Puwk3Bz77rjwxKVWf7LnSegeWWIbpi3H/VKwPkx5zY8skCM4djKJtC
         LF5yg4Lpf/kNm/K/9yD3m7XbJpqHa6BDM8oYm+0Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 45/67] net/mlx4_en: Fix build break when CONFIG_INET is off
Date:   Thu, 20 Dec 2018 10:18:57 +0100
Message-Id: <20181220085905.325070048@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20181220085903.562090333@linuxfoundation.org>
References: <20181220085903.562090333@linuxfoundation.org>
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

[ Upstream commit 1b603f9e4313348608f256b564ed6e3d9e67f377 ]

MLX4_EN depends on NETDEVICES, ETHERNET and INET Kconfigs.
Make sure they are listed in MLX4_EN Kconfig dependencies.

This fixes the following build break:

drivers/net/ethernet/mellanox/mlx4/en_rx.c:582:18: warning: ‘struct iphdr’ declared inside parameter list [enabled by default]
struct iphdr *iph)
^
drivers/net/ethernet/mellanox/mlx4/en_rx.c:582:18: warning: its scope is only this definition or declaration, which is probably not what you want [enabled by default]
drivers/net/ethernet/mellanox/mlx4/en_rx.c: In function ‘get_fixed_ipv4_csum’:
drivers/net/ethernet/mellanox/mlx4/en_rx.c:586:20: error: dereferencing pointer to incomplete type
_u8 ipproto = iph->protocol;

Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/Kconfig b/drivers/net/ethernet/mellanox/mlx4/Kconfig
index 36054e6fb9d3..f200b8c420d5 100644
--- a/drivers/net/ethernet/mellanox/mlx4/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx4/Kconfig
@@ -5,7 +5,7 @@
 config MLX4_EN
 	tristate "Mellanox Technologies 1/10/40Gbit Ethernet support"
 	depends on MAY_USE_DEVLINK
-	depends on PCI
+	depends on PCI && NETDEVICES && ETHERNET && INET
 	select MLX4_CORE
 	imply PTP_1588_CLOCK
 	---help---
-- 
2.19.1



