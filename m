Return-Path: <SRS0=ejdu=OA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C3CC04EBA
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:34:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1E4E3214D9
	for <linux-kernel@archiver.kernel.org>; Wed, 21 Nov 2018 12:34:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E4E3214D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=osadl.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbeKUXIS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 21 Nov 2018 18:08:18 -0500
Received: from www.osadl.org ([62.245.132.105]:36442 "EHLO www.osadl.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729233AbeKUXIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Nov 2018 18:08:18 -0500
Received: from debian01.hofrr.at (178.115.242.59.static.drei.at [178.115.242.59])
        by www.osadl.org (8.13.8/8.13.8/OSADL-2007092901) with ESMTP id wALCVUk8029987;
        Wed, 21 Nov 2018 13:31:30 +0100
From:   Nicholas Mc Guire <hofrat@osadl.org>
To:     Michael Turquette <mturquette@baylibre.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH V2] clk: zynq: do not allow kmalloc failure
Date:   Wed, 21 Nov 2018 13:28:30 +0100
Message-Id: <1542803310-32673-1-git-send-email-hofrat@osadl.org>
X-Mailer: git-send-email 2.1.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kmalloc here is small (< 16 bytes) and occurs during initialization
during system startup here (can not be built as module) thus if this
kmalloc failed it is an indication of something more serious going on
and it is fine to hang the system here rather than cause some harder
to understand error by dereferencing NULL.

Explicitly checking would not make that much sense here as the only
possible reaction would be would BUG() here anyway.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 0ee52b157b8e ("clk: zynq: Add clock controller driver")
Acked-by: Michal Simek <michal.simek@xilinx.com>
---

V2: dropped leading spaces from commit message and moved the
    compile/tool info out of git history on request of
    Michal Simek <michal.simek@xilinx.com> - thanks !

Problem located with experimental coccinelle script

Patch was compile tested with: multi_v7_defconfig (implies
CONFIG_ARCH_ZYNQ=y)

Patch is against 4.20-rc3 (localversion-next is next-20181121)

 drivers/clk/zynq/clkc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/zynq/clkc.c b/drivers/clk/zynq/clkc.c
index d7b53ac..014d4a4 100644
--- a/drivers/clk/zynq/clkc.c
+++ b/drivers/clk/zynq/clkc.c
@@ -440,7 +440,7 @@ static void __init zynq_clk_setup(struct device_node *np)
 			SLCR_GEM1_CLK_CTRL, 0, 0, &gem1clk_lock);
 
 	tmp = strlen("mio_clk_00x");
-	clk_name = kmalloc(tmp, GFP_KERNEL);
+	clk_name = kmalloc(tmp, GFP_KERNEL | __GFP_NOFAIL);
 	for (i = 0; i < NUM_MIO_PINS; i++) {
 		int idx;
 
-- 
2.1.4

