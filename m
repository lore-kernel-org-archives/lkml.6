Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D9FC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:13:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 929CF20834
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 11:13:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 929CF20834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=renesas.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbeLCLOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 06:14:04 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:47716 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725907AbeLCLOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 06:14:03 -0500
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Dec 2018 20:13:26 +0900
Received: from vbox.ree.adwin.renesas.com (unknown [10.226.37.67])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 73562402D031;
        Mon,  3 Dec 2018 20:13:24 +0900 (JST)
From:   Phil Edworthy <phil.edworthy@renesas.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Phil Edworthy <phil.edworthy@renesas.com>
Subject: [PATCH v9 1/2] clk: Add comment about __of_clk_get_by_name() error values
Date:   Mon,  3 Dec 2018 11:13:08 +0000
Message-Id: <20181203111309.3709-2-phil.edworthy@renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181203111309.3709-1-phil.edworthy@renesas.com>
References: <20181203111309.3709-1-phil.edworthy@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not immediately obvious from the code that failure to get a
clock provider can return either -ENOENT or -EINVAL. Therefore, add
a comment to highlight this.

Signed-off-by: Phil Edworthy <phil.edworthy@renesas.com>
---
 drivers/clk/clkdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/clk/clkdev.c b/drivers/clk/clkdev.c
index 9ab3db8b3988..cc5df3970cd3 100644
--- a/drivers/clk/clkdev.c
+++ b/drivers/clk/clkdev.c
@@ -52,6 +52,12 @@ struct clk *of_clk_get(struct device_node *np, int index)
 }
 EXPORT_SYMBOL(of_clk_get);
 
+/*
+ * Beware the return values when np is valid, but no clock provider is found.
+ * If name = NULL, the function returns -ENOENT.
+ * If name != NULL, the function returns -EINVAL. This is because __of_clk_get()
+ * is called even if of_property_match_string() returns an error.
+ */
 static struct clk *__of_clk_get_by_name(struct device_node *np,
 					const char *dev_id,
 					const char *name)
-- 
2.17.1

