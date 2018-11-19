Return-Path: <SRS0=tadO=N6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC88BC43441
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A772B20989
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Nov 2018 16:34:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ymhyYulU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A772B20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731511AbeKTC67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Nov 2018 21:58:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:58174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731471AbeKTC67 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Nov 2018 21:58:59 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 060DD208E4;
        Mon, 19 Nov 2018 16:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1542645291;
        bh=+sdL92XKTVUZWHt5QzS/KJSwUaZqvQK6NBTbz44Umc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ymhyYulUMiLMANCHHNJu9Sme/Cv0aKkU1KpQLLoOdny8Y+Fq0JJhePqyrkqUPiTN1
         K5YbRlDAAVcibhl/b5DDyF4BbXOP5ZW6nHCKkSf7JoHhKVi4GNlb3m0+BjdEznT9nW
         Y6bjpi+cQ1HZxBzkHHyvM8tuVVeuX3GNJUEaMeMU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Christian Hewitt <christianshewitt@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 071/205] clk: meson-gxbb: set fclk_div3 as CLK_IS_CRITICAL
Date:   Mon, 19 Nov 2018 17:26:18 +0100
Message-Id: <20181119162629.765620757@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181119162616.586062722@linuxfoundation.org>
References: <20181119162616.586062722@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

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



