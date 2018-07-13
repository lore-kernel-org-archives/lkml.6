Return-Path: <SRS0=Zbfl=J5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AD04ECDFB0
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:28:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9C0220858
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Jul 2018 10:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9C0220858
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbeGMKm2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 13 Jul 2018 06:42:28 -0400
Received: from mail.bootlin.com ([62.4.15.54]:56094 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727040AbeGMKm2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jul 2018 06:42:28 -0400
Received: by mail.bootlin.com (Postfix, from userid 110)
        id 1A2E620741; Fri, 13 Jul 2018 12:28:25 +0200 (CEST)
Received: from localhost (unknown [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id DF0CB206A6;
        Fri, 13 Jul 2018 12:28:24 +0200 (CEST)
From:   Gregory CLEMENT <gregory.clement@bootlin.com>
To:     Stephen Boyd <sboyd@codeaurora.org>,
        Mike Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jason Cooper <jason@lakedaemon.net>, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel@lists.infradead.org,
        Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?q?Miqu=C3=A8l=20Raynal?= <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Nadav Haklai <nadavh@marvell.com>,
        Victor Gu <xigu@marvell.com>, Marcin Wojtas <mw@semihalf.com>,
        Wilson Ding <dingwei@marvell.com>,
        Hua Jing <jinghua@marvell.com>,
        Neta Zur Hershkovits <neta@marvell.com>,
        Ken Ma <make@marvell.com>
Subject: [PATCH] clk: mvebu: armada-37xx-periph: Fix wrong return value in get_parent
Date:   Fri, 13 Jul 2018 12:27:26 +0200
Message-Id: <20180713102726.1950-1-gregory.clement@bootlin.com>
X-Mailer: git-send-email 2.18.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of the get_parent operation is a u8, whereas a -EINVAL
was returned. This wrong value was return if the value was bigger that
the number of parent but this case was already handled by the core.

So we can just remove this chunk of code to fix the issue.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 9818a7a4fd10 ("clk: mvebu: armada-37xx-periph: prepare cpu clk to
be used with DVFS")
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
---
 drivers/clk/mvebu/armada-37xx-periph.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/clk/mvebu/armada-37xx-periph.c b/drivers/clk/mvebu/armada-37xx-periph.c
index a51edaab0c5c..287e98a7cff4 100644
--- a/drivers/clk/mvebu/armada-37xx-periph.c
+++ b/drivers/clk/mvebu/armada-37xx-periph.c
@@ -426,9 +426,6 @@ static u8 clk_pm_cpu_get_parent(struct clk_hw *hw)
 		val &= pm_cpu->mask_mux;
 	}
 
-	if (val >= num_parents)
-		return -EINVAL;
-
 	return val;
 }
 
-- 
2.18.0

