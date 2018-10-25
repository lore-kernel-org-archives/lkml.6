Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08D57ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4FC22085A
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="buw5FwGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4FC22085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729646AbeJYWuZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:50:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729604AbeJYWuY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:50:24 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 759B420834;
        Thu, 25 Oct 2018 14:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477047;
        bh=8/q8lDxAVbsbhJxG2nfrAxcBPW8AmLMl7jfGy5upL9Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=buw5FwGtrbjnXF9O4QW9Wr4br9rQdxGw2UvjRTukm1B5pHrxo3LSruPS0xtVkJFV4
         v8NflFw7sUDyE1+fzxrLchKXjQGb+hOJE+C6UMSRlGMmqW6ko0IQG0BPYqOAeRq9PG
         SlVjZ/0I0d0FjP7onyXAX6/axrImLxWQI+pOULQQ=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Eugenia Emantayev <eugenia@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.4 11/65] net/mlx4_en: Resolve dividing by zero in 32-bit system
Date:   Thu, 25 Oct 2018 10:16:11 -0400
Message-Id: <20181025141705.213937-11-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141705.213937-1-sashal@kernel.org>
References: <20181025141705.213937-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eugenia Emantayev <eugenia@mellanox.com>

[ Upstream commit 4850cf4581578216468b7b3c3d06cc5abb0a697d ]

When doing roundup_pow_of_two for large enough number with
bit 31, an overflow will occur and a value equal to 1 will
be returned. In this case 1 will be subtracted from the return
value and division by zero will be reached.

Fixes: 31c128b66e5b ("net/mlx4_en: Choose time-stamping shift value according to HW frequency")
Signed-off-by: Eugenia Emantayev <eugenia@mellanox.com>
Signed-off-by: Tariq Toukan <tariqt@mellanox.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx4/en_clock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx4/en_clock.c b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
index 4dccf7287f0f..52e4ed2f639d 100644
--- a/drivers/net/ethernet/mellanox/mlx4/en_clock.c
+++ b/drivers/net/ethernet/mellanox/mlx4/en_clock.c
@@ -251,8 +251,11 @@ static u32 freq_to_shift(u16 freq)
 {
 	u32 freq_khz = freq * 1000;
 	u64 max_val_cycles = freq_khz * 1000 * MLX4_EN_WRAP_AROUND_SEC;
+	u64 tmp_rounded =
+		roundup_pow_of_two(max_val_cycles) > max_val_cycles ?
+		roundup_pow_of_two(max_val_cycles) - 1 : UINT_MAX;
 	u64 max_val_cycles_rounded = is_power_of_2(max_val_cycles + 1) ?
-		max_val_cycles : roundup_pow_of_two(max_val_cycles) - 1;
+		max_val_cycles : tmp_rounded;
 	/* calculate max possible multiplier in order to fit in 64bit */
 	u64 max_mul = div_u64(0xffffffffffffffffULL, max_val_cycles_rounded);
 
-- 
2.17.1

