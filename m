Return-Path: <SRS0=I/I1=QE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FA5EC282C8
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 525FD2175B
	for <linux-kernel@archiver.kernel.org>; Mon, 28 Jan 2019 17:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1548697630;
	bh=h/8E9Te9IzF9OE4JWBOsNsRFIzBuwefo23Zv7qScLnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=E/G9hL7w9JAs/tV6BnhLiWBQcHjzhJimiz4hqX/vfzFLMjaePIkKfAoGM/N0AqiZQ
	 HtlXCMXHsReO+YaIHSgodJqJo+ECX4RAEIs8yKvt7jE2YvMUIgqNM+SuK8is9i1hei
	 D1Y90WNRIXbdaSisr5jfH6NhYM6b4HOZWwZpz4no=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728097AbfA1Pqs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 28 Jan 2019 10:46:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:60132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727047AbfA1Pqp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jan 2019 10:46:45 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8868E20880;
        Mon, 28 Jan 2019 15:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1548690404;
        bh=h/8E9Te9IzF9OE4JWBOsNsRFIzBuwefo23Zv7qScLnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CFPSIw9F9BmVh9uppWgdl+ewlBoRRu1RZJ2gBI9tmk3xvSZbqLutUHUN/x4FGCd3b
         +g2U0y7LPF+QLfADmIrju2mL2TZQvYW7I5xcoEcwXempYWjLyaGxysQ3wQML8mM/4F
         b+5yPVUnGKfERtY25ZUOy12LzQd5xLaR2gYL1PGM=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 074/304] clk: meson: meson8b: fix the width of the cpu_scale_div clock
Date:   Mon, 28 Jan 2019 10:39:51 -0500
Message-Id: <20190128154341.47195-74-sashal@kernel.org>
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

[ Upstream commit a8662eadd1032018f31e37deda811790b2326662 ]

According to the public S805 datasheet HHI_SYS_CPU_CLK_CNTL1[29:20] is
the register for the CPU scale_div clock. This matches the code in
Amlogic's 3.10 GPL kernel sources:
N = (aml_read_reg32(P_HHI_SYS_CPU_CLK_CNTL1) >> 20) & 0x3FF;

This means that the divider register is 10 bit wide instead of 9 bits.
So far this is not a problem since all u-boot versions I have seen are
not using the cpu_scale_div clock at all (instead they are configuring
the CPU clock to run off cpu_in_sel directly).

The fixes tag points to the latest rework of the CPU clocks. However,
even before the rework it was wrong. Commit 7a29a869434e8b ("clk: meson:
Add support for Meson clock controller") defines MESON_N_WIDTH as 9 (in
drivers/clk/meson/clk-cpu.c). But since the old clk-cpu implementation
this only carries the fixes tag for the CPU clock rewordk.

Fixes: 251b6fd38bcb9c ("clk: meson: rework meson8b cpu clock")
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lkml.kernel.org/r/20180927085921.24627-3-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/meson8b.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 328fcf50d9e8..9160a3b2e668 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -599,7 +599,7 @@ static struct clk_regmap meson8b_cpu_scale_div = {
 	.data = &(struct clk_regmap_div_data){
 		.offset =  HHI_SYS_CPU_CLK_CNTL1,
 		.shift = 20,
-		.width = 9,
+		.width = 10,
 		.table = cpu_scale_table,
 		.flags = CLK_DIVIDER_ALLOW_ZERO,
 	},
-- 
2.19.1

