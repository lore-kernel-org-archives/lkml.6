Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B813C04EBC
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE3262252B
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:24:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="oLs/Z2hR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE3262252B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbeKOI3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:29:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:36652 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732360AbeKOI3k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:29:40 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 313C122529;
        Wed, 14 Nov 2018 22:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234276;
        bh=8WrDsZ4kKm/oVsjSplgvqLOtdVCKMMm0ezO0p/64XwE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oLs/Z2hRPnwqC1uaXsVcM2jviNMAmyTMOj4CrS2KlYOSPN1/FLl1MIWjhq4qYYQWR
         D1yfXiFPd9JeCZWPBTJKJnwOzK4nt9YLJjpW5436erl2dD/Q2jfvr1kfWWCCwS4H1Z
         UDJ2JqwtO9ACUGluWvDrxLRYfwZzwDPlSpdJFsrw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org
Subject: [PATCH AUTOSEL 4.18 37/59] clk: meson: axg: mark fdiv2 and fdiv3 as critical
Date:   Wed, 14 Nov 2018 17:23:09 -0500
Message-Id: <20181114222335.99339-37-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222335.99339-1-sashal@kernel.org>
References: <20181114222335.99339-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>

[ Upstream commit d6ee1e7e9004d3d246cdfa14196989e0a9466c16 ]

Similar to gxbb and gxl platforms, axg SCPI Cortex-M co-processor
uses the fdiv2 and fdiv3 to, among other things, provide the cpu
clock.

Until clock hand-off mechanism makes its way to CCF and the generic
SCPI claims platform specific clocks, these clocks must be marked as
critical to make sure they are never disabled when needed by the
co-processor.

Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Acked-by: Neil Armstrong <narmstrong@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/axg.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/clk/meson/axg.c b/drivers/clk/meson/axg.c
index bd4dbc696b88..cfd26fd7e404 100644
--- a/drivers/clk/meson/axg.c
+++ b/drivers/clk/meson/axg.c
@@ -320,6 +320,7 @@ static struct clk_regmap axg_fclk_div2 = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "fclk_div2_div" },
 		.num_parents = 1,
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 
@@ -344,6 +345,18 @@ static struct clk_regmap axg_fclk_div3 = {
 		.ops = &clk_regmap_gate_ops,
 		.parent_names = (const char *[]){ "fclk_div3_div" },
 		.num_parents = 1,
+		/*
+		 * FIXME:
+		 * This clock, as fdiv2, is used by the SCPI FW and is required
+		 * by the platform to operate correctly.
+		 * Until the following condition are met, we need this clock to
+		 * be marked as critical:
+		 * a) The SCPI generic driver claims and enable all the clocks
+		 *    it needs
+		 * b) CCF has a clock hand-off mechanism to make the sure the
+		 *    clock stays on until the proper driver comes along
+		 */
+		.flags = CLK_IS_CRITICAL,
 	},
 };
 
-- 
2.17.1

