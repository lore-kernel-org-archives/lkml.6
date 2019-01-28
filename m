Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAA9C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:46:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A3FA2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 15:46:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548690413;
	bh=lGqp12kRjIPhNiniLm81wkp0dzvtQF+diNyccXoRzyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QrzN/kzxyerD81MmT7na3Kq+waIUjzs1VRbqTXM2pWovrPAUOToujbTOm/VHfsGGP
	 Lkg/7s667JCSI5nStNHvB+IH5WHzDykDeAa2c3eXr6mO7blYj2ytnmRkGSprOBu9WG
	 bh/dAVp63lZfbOjC74lBZNttxq3olTxJJERJCObA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbfA1Pqv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:46:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:60098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728066AbfA1Pqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:46:43 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 80DCA2175B;
        Mon, 28 Jan 2019 15:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690403;
        bh=lGqp12kRjIPhNiniLm81wkp0dzvtQF+diNyccXoRzyY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gInBz2C3KDek4nh9BsVv6Sni5vgh0lcU0RGUwSx0EZ06FsLs2SxPTLPltL95uPPM8
         nN+xw0FQuBsfeD0FKa0M+mnxDFxUeYo9gw30Ox5k4inR/mP9kzuCobzWPR5ynDeMBn
         GM5+ROY6zoyEpfQxYFhgRzxJHikqIjJbkXtbpGL0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 073/304] clk: meson: meson8b: do not use cpu_div3 for cpu_scale_out_sel
Date:   Mon, 28 Jan 2019 10:39:50 -0500
Message-Id: <20190128154341.47195-73-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190128154341.47195-1-sashal@kernel.org>
References: <20190128154341.47195-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit a5ac1ead32c9aac285f6436e09b4f6111996e9b8 ]

The cpu_div3 clock (cpu_in divided by 3) generates a signal with a duty
cycle of 33%. The CPU clock however requires a clock signal with a duty
cycle of 50% to run stable.
cpu_div3 was observed to be problematic when cycling through all
available CPU frequencies (with additional patches on top of this one)
while running "stress --cpu 4" in the background. This caused sporadic
hangs where the whole system would fully lock up.

Amlogic's 3.10 kernel code also does not use the cpu_div3 clock either
when changing the CPU clock.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lkml.kernel.org/r/20181115224048.13511-3-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/meson8b.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 1d39273d7a04..328fcf50d9e8 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -612,20 +612,27 @@ static struct clk_regmap meson8b_cpu_scale_div = {
 	},
 };
 
+static u32 mux_table_cpu_scale_out_sel[] = { 0, 1, 3 };
 static struct clk_regmap meson8b_cpu_scale_out_sel = {
 	.data = &(struct clk_regmap_mux_data){
 		.offset = HHI_SYS_CPU_CLK_CNTL0,
 		.mask = 0x3,
 		.shift = 2,
+		.table = mux_table_cpu_scale_out_sel,
 	},
 	.hw.init = &(struct clk_init_data){
 		.name = "cpu_scale_out_sel",
 		.ops = &clk_regmap_mux_ro_ops,
+		/*
+		 * NOTE: We are skipping the parent with value 0x2 (which is
+		 * "cpu_div3") because it results in a duty cycle of 33% which
+		 * makes the system unstable and can result in a lockup of the
+		 * whole system.
+		 */
 		.parent_names = (const char *[]) { "cpu_in_sel",
 						   "cpu_div2",
-						   "cpu_div3",
 						   "cpu_scale_div" },
-		.num_parents = 4,
+		.num_parents = 3,
 		.flags = CLK_SET_RATE_PARENT,
 	},
 };
-- 
2.19.1

