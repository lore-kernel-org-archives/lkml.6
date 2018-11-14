Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18BBCC43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA4B32145D
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 22:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELbkA0Gl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA4B32145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728886AbeKOI1X (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 15 Nov 2018 03:27:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728824AbeKOI1W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Nov 2018 03:27:22 -0500
Received: from sasha-vm.mshome.net (unknown [64.114.255.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 19F1422525;
        Wed, 14 Nov 2018 22:22:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542234139;
        bh=npnP/6vB2S1U+pAywWLduNRLDMOcnThc/5LFgrk//H4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ELbkA0Gl4ih+JYyL2nrR+odEZv3hHk0k97SYZDccXODyl30bjGdu2iIHo2fqafMJB
         +QBZVzfpSrf3kzsNyoQM+iHabVBZKef/38DWltBp1tzsQ0iIyTisQHXlhTNpQyMXjn
         HzYG/ShH+qwbqPWBvt41HkFdiT9mz+MwPc8fqEaw=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 46/73] clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL
Date:   Wed, 14 Nov 2018 17:21:40 -0500
Message-Id: <20181114222207.98701-46-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181114222207.98701-1-sashal@kernel.org>
References: <20181114222207.98701-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Hewitt <christianshewitt@gmail.com>

[ Upstream commit e2576c8bdfd462c34b8a46c0084e7c30b0851bf4 ]

On the Khadas VIM2 (GXM) and LePotato (GXL) board there are problems
with reboot; e.g. a ~60 second delay between issuing reboot and the
board power cycling (and in some OS configurations reboot will fail
and require manual power cycling).

Similar to 'commit c987ac6f1f088663b6dad39281071aeb31d450a8 ("clk:
meson-gxbb: set fclk_div2 as CLK_IS_CRITICAL")' the SCPI Cortex-M4
Co-Processor seems to depend on FCLK_DIV3 being operational.

Until commit 05f814402d6174369b3b29832cbb5eb5ed287059 ("clk:
meson: add fdiv clock gates"), this clock was modeled and left on by
the bootloader.

We don't have precise documentation about the SCPI Co-Processor and
its clock requirement so we are learning things the hard way.

Marking this clock as critical solves the problem but it should not
be viewed as final solution. Ideally, the SCPI driver should claim
these clocks. We also depends on some clock hand-off mechanism
making its way to CCF, to make sure the clock stays on between its
registration and the SCPI driver probe.

Fixes: 05f814402d61 ("clk: meson: add fdiv clock gates")
Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/clk/meson/gxbb.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/clk/meson/gxbb.c b/drivers/clk/meson/gxbb.c
index 86d3ae58e84c..6435d86118f1 100644
--- a/drivers/clk/meson/gxbb.c
+++ b/drivers/clk/meson/gxbb.c
@@ -522,6 +522,18 @@ static struct clk_regmap gxbb_fclk_div3 = {
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

