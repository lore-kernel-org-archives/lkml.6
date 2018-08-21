Return-Path: <SRS0=PzCS=LE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A2CEC4321D
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:06:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D0AF4217C9
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Aug 2018 21:06:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0AF4217C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727435AbeHVA2B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Aug 2018 20:28:01 -0400
Received: from mail.ispras.ru ([83.149.199.45]:55564 "EHLO mail.ispras.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726626AbeHVA2B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Aug 2018 20:28:01 -0400
Received: from localhost.localdomain (ppp85-140-189-12.pppoe.mtu-net.ru [85.140.189.12])
        by mail.ispras.ru (Postfix) with ESMTPSA id 199405400B5;
        Wed, 22 Aug 2018 00:06:11 +0300 (MSK)
From:   Alexey Khoroshilov <khoroshilov@ispras.ru>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Alexey Khoroshilov <khoroshilov@ispras.ru>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        ldv-project@linuxtesting.org
Subject: [PATCH] clk: cdce925: release child device nodes
Date:   Wed, 22 Aug 2018 00:05:32 +0300
Message-Id: <1534885532-26558-1-git-send-email-khoroshilov@ispras.ru>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

of_get_child_by_name() returns device node with refcount incremented,
but there is no decrement in cdce925_probe(). The patch adds one.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
---
 drivers/clk/clk-cdce925.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk-cdce925.c b/drivers/clk/clk-cdce925.c
index 0a7e7d5a7506..e9c3ffad4ac3 100644
--- a/drivers/clk/clk-cdce925.c
+++ b/drivers/clk/clk-cdce925.c
@@ -703,6 +703,7 @@ static int cdce925_probe(struct i2c_client *client,
 				0x12 + (i*CDCE925_OFFSET_PLL),
 				0x07, value & 0x07);
 		}
+		of_node_put(np_output);
 	}
 
 	/* Register output clock Y1 */
-- 
2.7.4

