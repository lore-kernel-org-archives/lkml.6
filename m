Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99F39C282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67BD620881
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697634;
	bh=W6Ee+8Na3o8JSRghgx72JSwGnzYakdYkq9XKLYI6xoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=MiTALK3jEu6apnTnS/pdq0jtN7cyFfkYnoJFa1i39SB+YUfIVfoQ0yaiWlvD4jh+4
	 gf+RGrl6dpsDV3WAI0C3hkzgcBOpXtPUJUjoMmfkPwz2FnBJuS8F/Nly6RzLW5yxsg
	 phH5n+MroSBJRwoaOuP0vCOWOF/qPJsW8Ubb/ClM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfA1RrM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:47:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:60168 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728085AbfA1Pqr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:46:47 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 570572177E;
        Mon, 28 Jan 2019 15:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690407;
        bh=W6Ee+8Na3o8JSRghgx72JSwGnzYakdYkq9XKLYI6xoQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4sPStVcwSBOBL0nR0rcp5CrzxW5RKQxgSyhVFe/Ce4l/h+WLLlhjLrJwPn+aeVFP
         7AbydorX7SG0AdIDW2S3MfWEgm4DAvNJf9+9BZt/g+O5B945HZFgRSsVILlap1QZZU
         xsWxIrNGkpCimzWoPYmLTzh+Q/HtQ9ctx2dYHsOU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 075/304] clk: meson: meson8b: mark the CPU clock as CLK_IS_CRITICAL
Date:   Mon, 28 Jan 2019 10:39:52 -0500
Message-Id: <20190128154341.47195-75-sashal@kernel.org>
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

[ Upstream commit 0dad1ec65bc30a549aba38d34a727309bbf41bc8 ]

We don't want the common clock framework to disable the "cpu_clk" if
it's not used by any device. The cpufreq-dt driver does not enable the
CPU clocks. However, even if it would we would still want the CPU clock
to be enabled at all times because the CPU clock is also required even
if we disable CPU frequency scaling on a specific board.

The reason why we want the CPU clock to be enabled is a clock further up
in the tree:
Since commit 6f888e7bc7bd58 ("clk: meson: clk-pll: add enable bit") the
sys_pll can be disabled. However, since the CPU clock is derived from
sys_pll we don't want sys_pll to get disabled. The common clock
framework takes care of that for us by enabling all parent clocks of our
CPU clock when we mark the CPU clock with CLK_IS_CRITICAL.

Until now this is not a problem yet because all clocks in the CPU
clock's tree (including sys_pll) are read-only. However, once we allow
modifications to the clocks in that tree we will need this.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lkml.kernel.org/r/20181115224048.13511-4-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/meson8b.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 9160a3b2e668..a3a826419c16 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -650,7 +650,8 @@ static struct clk_regmap meson8b_cpu_clk = {
 						  "cpu_scale_out_sel" },
 		.num_parents = 2,
 		.flags = (CLK_SET_RATE_PARENT |
-			  CLK_SET_RATE_NO_REPARENT),
+			  CLK_SET_RATE_NO_REPARENT |
+			  CLK_IS_CRITICAL),
 	},
 };
 
-- 
2.19.1

