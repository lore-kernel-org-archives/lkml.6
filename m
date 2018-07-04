Return-Path: <SRS0=cgxA=JU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C22CC3279B
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEFE320837
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Jul 2018 13:01:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEFE320837
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=glider.be
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753331AbeGDNBN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Jul 2018 09:01:13 -0400
Received: from xavier.telenet-ops.be ([195.130.132.52]:35236 "EHLO
        xavier.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752678AbeGDNBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Jul 2018 09:01:12 -0400
Received: from ayla.of.borg ([84.194.111.163])
        by xavier.telenet-ops.be with bizsmtp
        id 6d1A1y00r3XaVaC01d1AjM; Wed, 04 Jul 2018 15:01:10 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ayla.of.borg with esmtp (Exim 4.86_2)
        (envelope-from <geert@linux-m68k.org>)
        id 1fahPC-0006lN-KA; Wed, 04 Jul 2018 15:01:10 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1fahPC-0008HW-Ib; Wed, 04 Jul 2018 15:01:10 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] clk: Really show symbolic clock flags in debugfs
Date:   Wed,  4 Jul 2018 15:01:03 +0200
Message-Id: <20180704130103.31790-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The last-minute fold-in of the ENTRY() macro did change behavior:
instead of printing the symbolic name (e.g. "CLK_IS_BASIC"), it prints
the expansion of it (e.g. "(1UL << (5))").

Use "#" instead of  __stringify() to fix this.

Fixes: a6059ab98130fb56 ("clk: Show symbolic clock flags in debugfs")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index e108f591d84a9539..f4856d49bd3a698c 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2739,7 +2739,7 @@ static const struct {
 	unsigned long flag;
 	const char *name;
 } clk_flags[] = {
-#define ENTRY(f) { f, __stringify(f) }
+#define ENTRY(f) { f, #f }
 	ENTRY(CLK_SET_RATE_GATE),
 	ENTRY(CLK_SET_PARENT_GATE),
 	ENTRY(CLK_SET_RATE_PARENT),
-- 
2.17.1

