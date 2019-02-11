Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DA0C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A905120675
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 14:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549895499;
	bh=9hVn75N3LPSjsv3h8GF57VsxqxoZ7Po5V16rZH7lrVs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=fjDi7XMODmm86WJdeMwBs+vBVjl5sBy1rSebOfyr8wkAj9uln8ga6TiSSy8ifhtBh
	 d7SVbpqpzJFC9ygQNLSNj6/Iw6vlpyi3DqKGwTq3B1laxT0RY8nJdxMmA+tgmI0XlN
	 UFLahWvvyeaokITAExD4Ijva1h1Bu9p2rJ0TfI6c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730338AbfBKObi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 09:31:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:38548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730325AbfBKObe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 09:31:34 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A125820844;
        Mon, 11 Feb 2019 14:31:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549895494;
        bh=9hVn75N3LPSjsv3h8GF57VsxqxoZ7Po5V16rZH7lrVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H3oYFeGntiXGEvrq1bMe9pHKxhbAA7VZkNkO8CepK0qx/JycOMyzoYUVt6kLpKDq1
         cRDtjzsDyRBZo/tbfeemKgEfzPe2ECCWTzxbvcjEfakRCw1Cg6dT2UnJoqp/HUjgPz
         I8nLWjSw45HSi8QISARy2UWQN67GMYBs+2z1jIFw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
        Ariel Levkovich <lariel@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>,
        Miroslav Lichvar <mlichvar@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.20 224/352] mlx5: update timecounter at least twice per counter overflow
Date:   Mon, 11 Feb 2019 15:17:31 +0100
Message-Id: <20190211141901.475896932@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141846.543045703@linuxfoundation.org>
References: <20190211141846.543045703@linuxfoundation.org>
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

4.20-stable review patch.  If anyone has any objections, please let me know.

------------------

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
index 0d90b1b4a3d3..2d6168ee99e8 100644
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



