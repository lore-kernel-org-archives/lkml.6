Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9393C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC08B20856
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 16:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548691731;
	bh=P/9susO6JXRHQi1Ay1pwjAQT6Xqj82L8fUkhh6zd0Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0x752y/eUDXKbx8WFYmOH7v6MB+mTag/CbjNxll2IVedHLm5HiuaZf3VYtROdkNc7
	 xqeL7lBwtVshiNXww46187gVa0p3yeSH1ivkioG7goMKySeVHZycGPX4WbIAR1nony
	 Awt0KCYLoGfYoQMdnhz7uXv27RGR6QkbM8M/3SRQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732486AbfA1QIu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 11:08:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731323AbfA1QIt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:08:49 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C8D652171F;
        Mon, 28 Jan 2019 16:08:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691728;
        bh=P/9susO6JXRHQi1Ay1pwjAQT6Xqj82L8fUkhh6zd0Ls=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TYA5VNIdeRoJXONTDvjJ3lZZRTCaDScV0VNNq53HG8JvZ6stBGPtPD9QBeLxZkems
         SGnFfB0ssXxJ7WX+X4U74dTbd9yt05DGTHXm4KGgxZwjJ5V/H15iuxd/nLkxY2II/G
         beAYjBBCKHhjwAvJ7bpOs94wORUqHw8xeCSDWkCk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Miroslav Lichvar <mlichvar@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Sasha Levin <sashal@kernel.org>, netdev@vger.kernel.org,
        linux-rdma@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 198/258] mlx5: update timecounter at least twice per counter overflow
Date:   Mon, 28 Jan 2019 10:58:24 -0500
Message-Id: <20190128155924.51521-198-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128155924.51521-1-sashal@kernel.org>
References: <20190128155924.51521-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Miroslav Lichvar <mlichvar@redhat.com>

[ Upstream commit 5d8678365c90b9ce1fd2243ff5ea562609f6cec1 ]

The timecounter needs to be updated at least once in half of the
cyclecounter interval to prevent timecounter_cyc2time() interpreting a
new timestamp as an old value and causing a backward jump.

This would be an issue if the timecounter multiplier was so small that
the update interval would not be limited by the 64-bit overflow in
multiplication.

Shorten the calculated interval to make sure the timecounter is updated
in time even when the system clock is slowed down by up to 10%, the
multiplier is increased by up to 10%, and the scheduled overflow check
is late by 15%.

Cc: Richard Cochran <richardcochran@gmail.com>
Cc: Ariel Levkovich <lariel@mellanox.com>
Cc: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
index 3f767cde4c1d..54f1a40a68ed 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -511,14 +511,14 @@ void mlx5_init_clock(struct mlx5_core_dev *mdev)
 			 ktime_to_ns(ktime_get_real()));
 
 	/* Calculate period in seconds to call the overflow watchdog - to make
-	 * sure counter is checked at least once every wrap around.
+	 * sure counter is checked at least twice every wrap around.
 	 * The period is calculated as the minimum between max HW cycles count
 	 * (The clock source mask) and max amount of cycles that can be
 	 * multiplied by clock multiplier where the result doesn't exceed
 	 * 64bits.
 	 */
 	overflow_cycles = div64_u64(~0ULL >> 1, clock->cycles.mult);
-	overflow_cycles = min(overflow_cycles, clock->cycles.mask >> 1);
+	overflow_cycles = min(overflow_cycles, div_u64(clock->cycles.mask, 3));
 
 	ns = cyclecounter_cyc2ns(&clock->cycles, overflow_cycles,
 				 frac, &frac);
-- 
2.19.1

