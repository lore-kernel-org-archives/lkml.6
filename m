Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F700C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:55:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0559620893
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 15:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzuRZ6A/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0559620893
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbeGYRIG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 13:08:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:43856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbeGYRIF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 13:08:05 -0400
Received: from localhost.localdomain (xdsl-188-155-58-14.adslplus.ch [188.155.58.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4E27920833;
        Wed, 25 Jul 2018 15:55:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532534148;
        bh=3Q7DkHvuaHvyKu4aq/s8U/g0IcJSYg81+jHohCuVcek=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IzuRZ6A/vxgkvqJIBVmq45sqbwECJAEbchke1QS2mfJTgcbZeYvXa1igEqvj9C46U
         xaK3SnHzZBIJSipGYlChBurIxstnoVNvSaViPkr3yUvOL4TWF5eDqKGr81JbPLNhMK
         KfsJqNLNcjO9GzTYn/mFtRGaas6A/GzCyBVABPHA=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Sangbeom Kim <sbkim73@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     stable@vger.kernel.org
Subject: [PATCH 1/3] clk: s2mps11: Fix matching when built as module and DT node contains compatible
Date:   Wed, 25 Jul 2018 17:55:15 +0200
Message-Id: <20180725155517.4872-2-krzk@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180725155517.4872-1-krzk@kernel.org>
References: <20180725155517.4872-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When driver is built as module and DT node contains clocks compatible
(e.g. "samsung,s2mps11-clk"), the module will not be autoloaded because
module aliases won't match.

The modalias from uevent: of:NclocksT<NULL>Csamsung,s2mps11-clk
The modalias from driver: platform:s2mps11-clk

The devices are instantiated by parent's MFD.  However both Device Tree
bindings and parent define the compatible for clocks devices.  In case
of module matching this DT compatible will be used.

The issue will not happen if this is built-in (no need for module
matching) or when clocks DT node does not contain compatible (not
correct from bindings perspective but working for driver).

Note when backporting to stable kernels: adjust the list of device ID
entries.

Cc: <stable@vger.kernel.org>
Fixes: 53c31b3437a6 ("mfd: sec-core: Add of_compatible strings for clock MFD cells")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/clk/clk-s2mps11.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/clk/clk-s2mps11.c b/drivers/clk/clk-s2mps11.c
index d44e0eea31ec..11a1e83ff805 100644
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -245,6 +245,36 @@ static const struct platform_device_id s2mps11_clk_id[] = {
 };
 MODULE_DEVICE_TABLE(platform, s2mps11_clk_id);
 
+#ifdef CONFIG_OF
+/*
+ * Device is instantiated through parent MFD device and device matching is done
+ * through platform_device_id.
+ *
+ * However if device's DT node contains proper clock compatible and it is built
+ * as a module, then the module matching will be done trough DT aliases.  This
+ * requires of_device_id table.  In the same time this will not change the
+ * actual device matching so do not add .of_match_table.
+ */
+static const struct of_device_id s2mps11_dt_match[] = {
+	{
+		.compatible = "samsung,s2mps11-clk",
+		.data = (void *)S2MPS11X,
+	}, {
+		.compatible = "samsung,s2mps13-clk",
+		.data = (void *)S2MPS13X,
+	}, {
+		.compatible = "samsung,s2mps14-clk",
+		.data = (void *)S2MPS14X,
+	}, {
+		.compatible = "samsung,s5m8767-clk",
+		.data = (void *)S5M8767X,
+	}, {
+		/* Sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, s2mps11_dt_match);
+#endif
+
 static struct platform_driver s2mps11_clk_driver = {
 	.driver = {
 		.name  = "s2mps11-clk",
-- 
2.14.1

