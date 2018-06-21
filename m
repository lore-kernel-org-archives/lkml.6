Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 447ACC43141
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE68E20883
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 08:12:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="v9ZW/6uY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE68E20883
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932960AbeFUIMR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Jun 2018 04:12:17 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:35538 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932707AbeFUILR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jun 2018 04:11:17 -0400
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by fllnx209.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5L8BE22027377;
        Thu, 21 Jun 2018 03:11:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529568674;
        bh=tynIC0y2K32HtUMhcjRxoKjNQtYEVRVi09NZg/+mfNc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=v9ZW/6uYpNQEEnn2j2YONovmcaR7bVJSlt6V//g80hRf5/KT8mHzFBTnnvC3ghJ9w
         I7hJyYzijk/CYpHERAWRR+EzwC5yWoh8XxTsD17oaTOmhs+tiVyY0EE/up+zEz0bYM
         m5WQILIKaneJa8DMejfUvZu6Dmvn4/pWVUvi0KxY=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5L8BExu019998;
        Thu, 21 Jun 2018 03:11:14 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Thu, 21
 Jun 2018 03:11:13 -0500
Received: from dlep33.itg.ti.com (157.170.170.75) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Thu, 21 Jun 2018 03:11:13 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep33.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5L8B5aW024513;
        Thu, 21 Jun 2018 03:11:11 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <t-kristo@ti.com>, <sboyd@kernel.org>, <tony@atomide.com>
CC:     <linux-clk@vger.kernel.org>, <d-gerlach@ti.com>,
        <linux-omap@vger.kernel.org.org>, <linux-kernel@vger.kernel.org>,
        <j-keerthy@ti.com>
Subject: [PATCH v2 2/4] clk: clk: Add clk_gate_restore_context function
Date:   Thu, 21 Jun 2018 13:40:18 +0530
Message-ID: <1529568620-19765-3-git-send-email-j-keerthy@ti.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1529568620-19765-1-git-send-email-j-keerthy@ti.com>
References: <1529568620-19765-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clock gate restore context function enables or disables
the gate clocks based on the enable_count. This is done in cases
where the clock context is lost and based on the enable_count
the clock either needs to be enabled/disabled.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---

Changes in v2:

	* Renamed clk_dflt_restore to clk_gate_restore_context

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
+ * clk_gate_restore_context - restore context for poweroff
+ * @hw: the clk_hw pointer of clock whose state is to be restored
+ *
+ * The clock gate restore context function enables or disables
+ * the gate clocks based on the enable_count. This is done in cases
+ * where the clock context is lost and based on the enable_count
+ * the clock either needs to be enabled/disabled. This
+ * helps restore the state of gate clocks.
+ */
+void clk_gate_restore_context(struct clk_hw *hw)
+{
+	if (hw->clk->core->enable_count)
+		hw->clk->core->ops->enable(hw);
+	else
+		hw->clk->core->ops->disable(hw);
+}
+EXPORT_SYMBOL_GPL(clk_gate_restore_context);
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
 
+void clk_gate_restore_context(struct clk_hw *hw);
+
 #endif /* CONFIG_COMMON_CLK */
 #endif /* CLK_PROVIDER_H */
-- 
1.9.1

