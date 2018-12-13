Return-Path: <SRS0=yjy/=OW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EECCC65BAE
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58D4920849
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Dec 2018 04:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544675967;
	bh=NTIHDr+O04owDLVRi/ZEKq2EO460F7ajvWApna8f+oQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=imUqwiNrDRSOTdUaq8GvDcQbz0fAT7JvIBAWUkzg0CzXhVey7iP5b/EItu0umASyO
	 sXu6atgpU2bzqtiVMDBKHg7bHAwz9U2wVZp2rTs2o/4s4HuuTs6UyveQLB5XvEIaHu
	 JtC9tYBma7SWq8VL8eJesfw0IOBnwWgzQvCOdO8w=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58D4920849
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729352AbeLMEj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Dec 2018 23:39:26 -0500
Received: from mail.kernel.org ([198.145.29.99]:45564 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729149AbeLMEck (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Dec 2018 23:32:40 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 740F820879;
        Thu, 13 Dec 2018 04:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544675560;
        bh=NTIHDr+O04owDLVRi/ZEKq2EO460F7ajvWApna8f+oQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CvsT1A+8vKAWe/f/iUFCOZNH+1GCyipBpjpDBrkL+CsjqiK3+fjyE7ko/CMLpHoNL
         3504hm9cMmPm0MlbEDVvcDT4O7Gmyaxd6Ltw8FsEHa43cuXl4xSfDAxzBOo010vhK6
         2MgGdJ3A0sCNtoQX4MyNfzb9Zxd5chfYH/hh2Ykw=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Saeed Mahameed <saeedm@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.9 23/34] net/mlx4_en: Fix build break when CONFIG_INET is off
Date:   Wed, 12 Dec 2018 23:31:49 -0500
Message-Id: <20181213043200.76295-23-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181213043200.76295-1-sashal@kernel.org>
References: <20181213043200.76295-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Saeed Mahameed <saeedm@mellanox.com>

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
index 5098e7f21987..a0eb4e4bc525 100644
--- a/drivers/net/ethernet/mellanox/mlx4/Kconfig
+++ b/drivers/net/ethernet/mellanox/mlx4/Kconfig
@@ -5,7 +5,7 @@
 config MLX4_EN
 	tristate "Mellanox Technologies 1/10/40Gbit Ethernet support"
 	depends on MAY_USE_DEVLINK
-	depends on PCI
+	depends on PCI && NETDEVICES && ETHERNET && INET
 	select MLX4_CORE
 	select PTP_1588_CLOCK
 	---help---
-- 
2.19.1

