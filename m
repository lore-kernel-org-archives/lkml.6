Return-Path: <SRS0=OQFz=KL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF12C67790
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:49:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802BD2089A
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Jul 2018 09:49:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 802BD2089A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388929AbeG0LKf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Jul 2018 07:10:35 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52852 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730915AbeG0LKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Jul 2018 07:10:34 -0400
Received: from localhost (unknown [89.188.5.116])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 25221BB6;
        Fri, 27 Jul 2018 09:49:27 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Ariel Levkovich <lariel@mellanox.com>,
        Eran Ben Elisha <eranbe@mellanox.com>,
        Saeed Mahameed <saeedm@mellanox.com>
Subject: [PATCH 4.17 37/66] net/mlx5: Adjust clock overflow work period
Date:   Fri, 27 Jul 2018 11:45:30 +0200
Message-Id: <20180727093813.287283053@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180727093809.043856530@linuxfoundation.org>
References: <20180727093809.043856530@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ariel Levkovich <lariel@mellanox.com>

[ Upstream commit 33180bee86a8940a84950edca46315cd9dd6deb5 ]

When driver converts HW timestamp to wall clock time it subtracts
the last saved cycle counter from the HW timestamp and converts the
difference to nanoseconds.
The conversion is done by multiplying the cycles difference with the
clock multiplier value as a first step and therefore the cycles
difference should be small enough so that the multiplication product
doesn't exceed 64bit.

The overflow handling routine is in charge of updating the last saved
cycle counter in driver and it is called periodically using kernel
delayed workqueue.

The delay period for this work is calculated using the max HW cycle
counter value (a 41 bit mask) as a base which doesn't take the 64bit
limit into account so the delay period may be incorrect and too
long to prevent a large difference between the HW counter and the last
saved counter in SW.

This change adjusts the work period for the HW clock overflow work by
taking the minimum between the previous value and the quotient of max
u64 value and the clock multiplier value.

Fixes: ef9814deafd0 ("net/mlx5e: Add HW timestamping (TS) support")
Signed-off-by: Ariel Levkovich <lariel@mellanox.com>
Reviewed-by: Eran Ben Elisha <eranbe@mellanox.com>
Signed-off-by: Saeed Mahameed <saeedm@mellanox.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/lib/clock.c
@@ -487,6 +487,7 @@ void mlx5_pps_event(struct mlx5_core_dev
 void mlx5_init_clock(struct mlx5_core_dev *mdev)
 {
 	struct mlx5_clock *clock = &mdev->clock;
+	u64 overflow_cycles;
 	u64 ns;
 	u64 frac = 0;
 	u32 dev_freq;
@@ -510,10 +511,17 @@ void mlx5_init_clock(struct mlx5_core_de
 
 	/* Calculate period in seconds to call the overflow watchdog - to make
 	 * sure counter is checked at least once every wrap around.
+	 * The period is calculated as the minimum between max HW cycles count
+	 * (The clock source mask) and max amount of cycles that can be
+	 * multiplied by clock multiplier where the result doesn't exceed
+	 * 64bits.
 	 */
-	ns = cyclecounter_cyc2ns(&clock->cycles, clock->cycles.mask,
+	overflow_cycles = div64_u64(~0ULL >> 1, clock->cycles.mult);
+	overflow_cycles = min(overflow_cycles, clock->cycles.mask >> 1);
+
+	ns = cyclecounter_cyc2ns(&clock->cycles, overflow_cycles,
 				 frac, &frac);
-	do_div(ns, NSEC_PER_SEC / 2 / HZ);
+	do_div(ns, NSEC_PER_SEC / HZ);
 	clock->overflow_period = ns;
 
 	mdev->clock_info_page = alloc_page(GFP_KERNEL);


