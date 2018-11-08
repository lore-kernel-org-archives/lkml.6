Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F49DC43441
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0566E20844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="qrS/RhDm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0566E20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728833AbeKIINl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 03:13:41 -0500
Received: from mail.kernel.org ([198.145.29.99]:54278 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728109AbeKIHgn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:36:43 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D3AB4208E3;
        Thu,  8 Nov 2018 21:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714354;
        bh=KA4p5T/AHZBnuvWp3H2OQZ887cwYTOHwCHoOOQIaZos=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qrS/RhDmamgl1LzSHkdhGZ2+uMfr+1OUy7y1EsA1Lg4QXH8kPE/bLbvHnzks+r1h7
         dE8W5ELoamt/HuW8+eHnjMzfeYEMx3qHkV0w1FYAn3tfyM0jVBJiEBo20UNnFIlerE
         tx14qNrVjTtzmpnS6O0uTrml4tkqnHnFYPubjdNY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Eugenia Emantayev <eugenia@mellanox.com>,
        Tariq Toukan <tariqt@mellanox.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.4 029/114] net/mlx4_en: Resolve dividing by zero in 32-bit system
Date:   Thu,  8 Nov 2018 13:50:44 -0800
Message-Id: <20181108215101.728604370@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215059.051093652@linuxfoundation.org>
References: <20181108215059.051093652@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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



