Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18203C282CD
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D99AD20855
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548696231;
	bh=Ba0R+3g9W4HxNnMVLMF/nf8iIUSZJx7lxNUDRwOGYLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0mnMfLXVRHca6GFp6pwj2YsAjoRuRTFPf7EjEaEkAUa8hNaVEaA/zQvyo7/fxfov9
	 887hHWF/bbFc14w7mS0IsteeKDDTkG+2PtHBvSZcRQFb8lS3w/m0dbPIpg4Bw6ZoBB
	 rZoatVUOCEYiqV0izXHrEdiDYMvBDXTnS35qhkDs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728227AbfA1RXu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 12:23:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:47722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730093AbfA1QCY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 11:02:24 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3CEC21916;
        Mon, 28 Jan 2019 16:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548691343;
        bh=Ba0R+3g9W4HxNnMVLMF/nf8iIUSZJx7lxNUDRwOGYLM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rZbe4OGyNXzFnGCC0yj+wRpsPv1NF9chgVMYhTDewfPY1RbEeozDfn7dgLNrF2uyj
         7ZtXh6276fDFhbPHMDA1A+ZcmIdWEJrQ947r9uQuoeyK12S5j1k395FnmyItmxIB5L
         jI3ou8lmPABmR8YXuSXK4NqAZDMlbrk0RoUed48U=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 062/258] clk: meson: meson8b: mark the CPU clock as CLK_IS_CRITICAL
Date:   Mon, 28 Jan 2019 10:56:08 -0500
Message-Id: <20190128155924.51521-62-sashal@kernel.org>
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
index 0da8334f2e43..9d79ff857d83 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -634,7 +634,8 @@ static struct clk_regmap meson8b_cpu_clk = {
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

