Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E00A1C43387
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:08:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE92E20660
	for <linux-kernel@archiver.kernel.org>; Tue,  8 Jan 2019 20:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1546978101;
	bh=/yiKT8skie3SGWtl1V7G2gUA9sKuNHe7Fc33UHpocGI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ulw2eZIsqGAE0S6VrVSKV0QLMk12eIiB7yG2UXvcsbw73nwx1xq5iKr3SwNyU+YUn
	 1D5eA+K4lRKhdMcVMvU9ULEXAZuJve81eVssVo8wqIGeAvNv7KGx7y7LlgwRFiaX2e
	 4ShbBW+toxVGVJGBp8cZc2RDjBwg/hCgPYLdmct0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729687AbfAHT12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Jan 2019 14:27:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:33436 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729605AbfAHT1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jan 2019 14:27:22 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6782A20883;
        Tue,  8 Jan 2019 19:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1546975641;
        bh=/yiKT8skie3SGWtl1V7G2gUA9sKuNHe7Fc33UHpocGI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JnxmGGXHSLR+BI9fXXuAD41pVJHoku6WANqSY0Mve9PODos1qfDvMGeFg5BkpCbdG
         3/zlrNLP6pcc5OtyyaNc2MMdaoLj2F8oxXDpuTojJgPIN++iubRylhHxEEbtpx5fHV
         WUUdBNUoP4CdDY/8wP3Eme7mkxHOWiz26lnXNpz4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.20 027/117] clk: meson: meson8b: add support for more M/N values in sys_pll
Date:   Tue,  8 Jan 2019 14:24:55 -0500
Message-Id: <20190108192628.121270-27-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192628.121270-1-sashal@kernel.org>
References: <20190108192628.121270-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

[ Upstream commit e36c7e9898f2ba34becf37bda37b70e984b0bf4e ]

The sys_pll on the EC-100 board is configured to 1584MHz at boot
(either by u-boot, firmware or chip defaults). This is achieved by using
M = 66, N = 1 (24MHz * 66 / 1).
At boot the CPU clock is running off sys_pll divided by 2 which results
in 792MHz. Thus M = 66 is considered to be a "safe" value for Meson8b.

To achieve 1608MHz (one of the CPU OPPs on Meson8 and Meson8m2) we need
M = 67, N = 1. I ran "stress --cpu 4" while infinitely cycling through
all available frequencies on my Meson8m2 board and could not spot any
issues with this setting (after ~12 hours of running this).

On Meson8, Meson8b and Meson8m2 we also want to be able to use 408MHz
and 816MHz CPU frequencies. These can be achieved by dividing sys_pll by
4 (for 408MHz) or 2 (for 816MHz). That means that sys_pll has to run at
1632MHz which can be generated using M = 68, N = 1.
Similarily we also want to be able to use 1008MHz as CPU frequency. This
means that sys_pll has to run either at 1008MHz or 2016MHz. The former
would result in an M value of 42, which is lower than the smallest value
used by the 3.10 GPL kernel sources from Amlogic (50 is the lower limit
there). Thus we need to run sys_pll at 2016MHz which can ge generated
using M = 84, N = 1.
I tested M = 68 and M = 84 on my Meson8b Odroid-C1 and my Meson8m2 board
by running "stress --cpu 4" while infinitely cycling thorugh all
available frequencies. I could not spot any issues after ~12 hours of
running this.

Amlogic's 3.10 GPL kernel sources have more M/N combinations. I did not
add them yet because M = 74 (to achieve close to 1800MHz on Meson8) and
M = 82 (to achieve close to 1992MHz on Meson8 as well) caused my
Meson8m2 board to hang randomly. It's not clear why this is (for example
because the board's voltage regulator design is bad, some missing bits
for these values in our clk-pll driver, etc.). Thus the following M
values from the Amlogic 3.10 GPL kernel sources are skipped as of now:
69, 70, 71, 72, 73, 74, 76, 78, 80, 82, 84, 86, 88, 90, 92, 94, 96, 98

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Acked-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Link: https://lkml.kernel.org/r/20181115224048.13511-5-martin.blumenstingl@googlemail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/meson8b.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/clk/meson/meson8b.c b/drivers/clk/meson/meson8b.c
index 346b9e165b7a..a059db63907c 100644
--- a/drivers/clk/meson/meson8b.c
+++ b/drivers/clk/meson/meson8b.c
@@ -42,6 +42,11 @@ static const struct pll_params_table sys_pll_params_table[] = {
 	PLL_PARAMS(62, 1),
 	PLL_PARAMS(63, 1),
 	PLL_PARAMS(64, 1),
+	PLL_PARAMS(65, 1),
+	PLL_PARAMS(66, 1),
+	PLL_PARAMS(67, 1),
+	PLL_PARAMS(68, 1),
+	PLL_PARAMS(84, 1),
 	{ /* sentinel */ },
 };
 
-- 
2.19.1

