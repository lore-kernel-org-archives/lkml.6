Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A74C4C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:29:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6252E20661
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:29:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yasODeEU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6252E20661
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965158AbeFSE26 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:28:58 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:9215 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965048AbeFSE2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:28:53 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx194.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5J4SnGK012519;
        Mon, 18 Jun 2018 23:28:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529382529;
        bh=SVt5qUG69WEdc0+DdygbTAchqGoRyD18Xs3bDpFHZEA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=yasODeEUukFOCLYQ0ER6vXYoMxE1MOWzMXyqHcVTTF7dVb2CC/mz0yeAxp4YPbJFb
         MmXAclOVqelSGFdJTvfpkNIMjIVB4LnsJqs25pjhEGWa2dt93AmFzFlFuI3yv0FjR9
         7lfrH9mVDPQ/do3P0nOjjA/YW+bgyPT0dpuD0Kw0=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5J4Snqr023090;
        Mon, 18 Jun 2018 23:28:49 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 18
 Jun 2018 23:28:49 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 18 Jun 2018 23:28:49 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5J4SeQs004959;
        Mon, 18 Jun 2018 23:28:47 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <t-kristo@ti.com>, <sboyd@kernel.org>, <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <d-gerlach@ti.com>, <j-keerthy@ti.com>
Subject: [PATCH 2/4] clk: clk: Add clk_dflt_restore
Date:   Tue, 19 Jun 2018 09:58:23 +0530
Message-ID: <1529382505-3069-3-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529382505-3069-1-git-send-email-j-keerthy@ti.com>
References: <1529382505-3069-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default restore context function enables or disables
the clock based on the enable_count. This is done in cases
where the clock context is lost and based on the enable_count
the clock either needs to be enabled/disabled. This particularly
helps restore the state of gate clocks.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 drivers/clk/clk.c            | 19 +++++++++++++++++++
 include/linux/clk-provider.h |  2 ++
 2 files changed, 21 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 7347e06..c201b8b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -910,6 +910,25 @@ static int clk_core_enable_lock(struct clk_core *core)
 	return ret;
 }
 
+/**
+ * clk_dflt_restore_context - restore context for poweroff
+ * @hw: the clk_hw pointer of clock whose state is to be restored
+ *
+ * The default restore context function enables or disables
+ * the clock based on the enable_count. This is done in cases
+ * where the clock context is lost and based on the enable_count
+ * the clock either needs to be enabled/disabled. This particularly
+ * helps restore the state of gate clocks.
+ */
+void clk_dflt_restore_context(struct clk_hw *hw)
+{
+	if (hw->clk->core->enable_count)
+		hw->clk->core->ops->enable(hw);
+	else
+		hw->clk->core->ops->disable(hw);
+}
+EXPORT_SYMBOL_GPL(clk_dflt_restore_context);
+
 static int _clk_save_context(struct clk_core *clk)
 {
 	struct clk_core *child;
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index 7f30d62..3e0c61a 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -992,5 +992,7 @@ static inline void clk_writel(u32 val, u32 __iomem *reg)
 
 #endif	/* platform dependent I/O accessors */
 
+void clk_dflt_restore_context(struct clk_hw *hw);
+
 #endif /* CONFIG_COMMON_CLK */
 #endif /* CLK_PROVIDER_H */
-- 
1.9.1

