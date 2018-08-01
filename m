Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FE61C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:34:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1839A20862
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 17:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1839A20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436622AbeHATSj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 15:18:39 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:52922 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436514AbeHATSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:18:37 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id CC9A1F16;
        Wed,  1 Aug 2018 16:55:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Stephen Boyd <sboyd@kernel.org>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 057/336] clk: ingenic: jz4770: Modify C1CLK clock to disable CPU clock stop on idle
Date:   Wed,  1 Aug 2018 18:46:32 +0200
Message-Id: <20180801165031.256518416@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

From: Paul Cercueil <paul@crapouillou.net>

[ Upstream commit 45ba63a29fd9b8a461110185e3abc5b4c90b806a ]

When the main processor goes idle, by default its clock is stopped.
However, this also stops the clock of the co-processor.

Here, if the C1CLK clock is enabled, we disable this functionality.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/clk/ingenic/jz4770-cgu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/clk/ingenic/jz4770-cgu.c
+++ b/drivers/clk/ingenic/jz4770-cgu.c
@@ -194,9 +194,10 @@ static const struct ingenic_cgu_clk_info
 		.div = { CGU_REG_CPCCR, 16, 1, 4, 22, -1, -1 },
 	},
 	[JZ4770_CLK_C1CLK] = {
-		"c1clk", CGU_CLK_DIV,
+		"c1clk", CGU_CLK_DIV | CGU_CLK_GATE,
 		.parents = { JZ4770_CLK_PLL0, },
 		.div = { CGU_REG_CPCCR, 12, 1, 4, 22, -1, -1 },
+		.gate = { CGU_REG_OPCR, 31, true }, // disable CCLK stop on idle
 	},
 	[JZ4770_CLK_PCLK] = {
 		"pclk", CGU_CLK_DIV,


