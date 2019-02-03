Return-Path: <SRS0=V1kc=QK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2792C169C4
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C29C820815
	for <linux-kernel@archiver.kernel.org>; Sun,  3 Feb 2019 14:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbfBCOCa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 Feb 2019 09:02:30 -0500
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:53132 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728061AbfBCNtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Feb 2019 08:49:47 -0500
Received: from cable-78.29.236.164.coditel.net ([78.29.236.164] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9a-0003td-8n; Sun, 03 Feb 2019 13:49:46 +0000
Received: from ben by deadeye with local (Exim 4.92-RC4)
        (envelope-from <ben@decadent.org.uk>)
        id 1gqI9X-0006ws-QU; Sun, 03 Feb 2019 14:49:43 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, Denis Kirjanov <kda@linux-powerpc.org>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Stephen Boyd" <sboyd@kernel.org>
Date:   Sun, 03 Feb 2019 14:45:08 +0100
Message-ID: <lsq.1549201508.121705298@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
X-Patchwork-Hint: ignore
Subject: [PATCH 3.16 092/305] clk: s2mps11: Fix matching when built as
 module and DT node contains compatible
In-Reply-To: <lsq.1549201507.384106140@decadent.org.uk>
X-SA-Exim-Connect-IP: 78.29.236.164
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

3.16.63-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzk@kernel.org>

commit 8985167ecf57f97061599a155bb9652c84ea4913 upstream.

When driver is built as module and DT node contains clocks compatible
(e.g. "samsung,s2mps11-clk"), the module will not be autoloaded because
module aliases won't match.

The modalias from uevent: of:NclocksT<NULL>Csamsung,s2mps11-clk
The modalias from driver: platform:s2mps11-clk

The devices are instantiated by parent's MFD.  However both Device Tree
bindings and parent define the compatible for clocks devices.  In case
of module matching this DT compatible will be used.

The issue will not happen if this is a built-in (no need for module
matching) or when clocks DT node does not contain compatible (not
correct from bindings perspective but working for driver).

Note when backporting to stable kernels: adjust the list of device ID
entries.

Fixes: 53c31b3437a6 ("mfd: sec-core: Add of_compatible strings for clock MFD cells")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
[bwh: Backported to 3.16: drop entry for "samsung,s2mps13-clk"]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
--- a/drivers/clk/clk-s2mps11.c
+++ b/drivers/clk/clk-s2mps11.c
@@ -296,6 +296,33 @@ static const struct platform_device_id s
 };
 MODULE_DEVICE_TABLE(platform, s2mps11_clk_id);
 
+#ifdef CONFIG_OF
+/*
+ * Device is instantiated through parent MFD device and device matching is done
+ * through platform_device_id.
+ *
+ * However if device's DT node contains proper clock compatible and driver is
+ * built as a module, then the *module* matching will be done trough DT aliases.
+ * This requires of_device_id table.  In the same time this will not change the
+ * actual *device* matching so do not add .of_match_table.
+ */
+static const struct of_device_id s2mps11_dt_match[] = {
+	{
+		.compatible = "samsung,s2mps11-clk",
+		.data = (void *)S2MPS11X,
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

