Return-Path: <SRS0=r7UP=JF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14AEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:29:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8908C20874
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Jun 2018 04:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="b7F7QhQ0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8908C20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=ti.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965113AbeFSE24 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Jun 2018 00:28:56 -0400
Received: from lelnx193.ext.ti.com ([198.47.27.77]:37175 "EHLO
        lelnx193.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750917AbeFSE2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jun 2018 00:28:50 -0400
Received: from dflxv15.itg.ti.com ([128.247.5.124])
        by lelnx193.ext.ti.com (8.15.1/8.15.1) with ESMTP id w5J4SkN4022247;
        Mon, 18 Jun 2018 23:28:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1529382527;
        bh=W2avgJTogNaIFDKcoRlZ6qBnQOnUs7D/ObCaFkzhv4I=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=b7F7QhQ0wrjPbY6KBsxgh7YDPchG9mdwIcgWMS44dvIQ5223lPbaTByGp0Hdeifls
         5/CiHsdD/hdZCL99LiOGS7zY9FyMkwr7dkX/eoJXemc1a6iY9U4jTsIby2lX56csNz
         slZBOQqu+T0Bf0LzSp6OjrcbnxRbJjh1aqlGnRp4=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by dflxv15.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5J4SkNo023064;
        Mon, 18 Jun 2018 23:28:46 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1466.3; Mon, 18
 Jun 2018 23:28:46 -0500
Received: from dlep32.itg.ti.com (157.170.170.100) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_0,
 cipher=TLS_RSA_WITH_AES_256_CBC_SHA) id 15.1.1466.3 via Frontend Transport;
 Mon, 18 Jun 2018 23:28:46 -0500
Received: from ula0393675.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by dlep32.itg.ti.com (8.14.3/8.13.8) with ESMTP id w5J4SeQr004959;
        Mon, 18 Jun 2018 23:28:44 -0500
From:   Keerthy <j-keerthy@ti.com>
To:     <t-kristo@ti.com>, <sboyd@kernel.org>, <tony@atomide.com>
CC:     <linux-omap@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mturquette@baylibre.com>,
        <d-gerlach@ti.com>, <j-keerthy@ti.com>,
        Russ Dill <Russ.Dill@ti.com>
Subject: [PATCH 1/4] clk: clk: Add functions to save/restore clock context en-masse
Date:   Tue, 19 Jun 2018 09:58:22 +0530
Message-ID: <1529382505-3069-2-git-send-email-j-keerthy@ti.com>
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

From: Russ Dill <Russ.Dill@ti.com>

Deep enough power saving mode can result into losing context of the clock
registers also, and they need to be restored once coming back from the power
saving mode. Hence add functions to save/restore clock context.

Signed-off-by: Keerthy <j-keerthy@ti.com>
Signed-off-by: Russ Dill <Russ.Dill@ti.com>
---
 drivers/clk/clk.c            | 74 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/clk-provider.h |  7 +++++
 include/linux/clk.h          | 25 +++++++++++++++
 3 files changed, 106 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index a24a6af..7347e06 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -910,6 +910,80 @@ static int clk_core_enable_lock(struct clk_core *core)
 	return ret;
 }
 
+static int _clk_save_context(struct clk_core *clk)
+{
+	struct clk_core *child;
+	int ret = 0;
+
+	hlist_for_each_entry(child, &clk->children, child_node) {
+		ret = _clk_save_context(child);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (clk->ops && clk->ops->save_context)
+		ret = clk->ops->save_context(clk->hw);
+
+	return ret;
+}
+
+static void _clk_restore_context(struct clk_core *clk)
+{
+	struct clk_core *child;
+
+	if (clk->ops && clk->ops->restore_context)
+		clk->ops->restore_context(clk->hw);
+
+	hlist_for_each_entry(child, &clk->children, child_node)
+		_clk_restore_context(child);
+}
+
+/**
+ * clk_save_context - save clock context for poweroff
+ *
+ * Saves the context of the clock register for powerstates in which the
+ * contents of the registers will be lost. Occurs deep within the suspend
+ * code.  Returns 0 on success.
+ */
+int clk_save_context(void)
+{
+	struct clk_core *clk;
+	int ret;
+
+	hlist_for_each_entry(clk, &clk_root_list, child_node) {
+		ret = _clk_save_context(clk);
+		if (ret < 0)
+			return ret;
+	}
+
+	hlist_for_each_entry(clk, &clk_orphan_list, child_node) {
+		ret = _clk_save_context(clk);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(clk_save_context);
+
+/**
+ * clk_restore_context - restore clock context after poweroff
+ *
+ * Restore the saved clock context upon resume.
+ *
+ */
+void clk_restore_context(void)
+{
+	struct clk_core *clk;
+
+	hlist_for_each_entry(clk, &clk_root_list, child_node)
+		_clk_restore_context(clk);
+
+	hlist_for_each_entry(clk, &clk_orphan_list, child_node)
+		_clk_restore_context(clk);
+}
+EXPORT_SYMBOL_GPL(clk_restore_context);
+
 /**
  * clk_enable - ungate a clock
  * @clk: the clk being ungated
diff --git a/include/linux/clk-provider.h b/include/linux/clk-provider.h
index b7cfa03..7f30d62 100644
--- a/include/linux/clk-provider.h
+++ b/include/linux/clk-provider.h
@@ -106,6 +106,11 @@ struct clk_rate_request {
  *		Called with enable_lock held.  This function must not
  *		sleep.
  *
+ * @save_context: Save the context of the clock in prepration for poweroff.
+ *
+ * @restore_context: Restore the context of the clock after a restoration
+ *		of power.
+ *
  * @recalc_rate	Recalculate the rate of this clock, by querying hardware. The
  *		parent rate is an input parameter.  It is up to the caller to
  *		ensure that the prepare_mutex is held across this call.
@@ -201,6 +206,8 @@ struct clk_ops {
 	void		(*disable)(struct clk_hw *hw);
 	int		(*is_enabled)(struct clk_hw *hw);
 	void		(*disable_unused)(struct clk_hw *hw);
+	int		(*save_context)(struct clk_hw *hw);
+	void		(*restore_context)(struct clk_hw *hw);
 	unsigned long	(*recalc_rate)(struct clk_hw *hw,
 					unsigned long parent_rate);
 	long		(*round_rate)(struct clk_hw *hw, unsigned long rate,
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 0dbd088..70a2662 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -596,6 +596,23 @@ int __must_check clk_bulk_enable(int num_clks,
  */
 struct clk *clk_get_sys(const char *dev_id, const char *con_id);
 
+/**
+ * clk_save_context - save clock context for poweroff
+ *
+ * Saves the context of the clock register for powerstates in which the
+ * contents of the registers will be lost. Occurs deep within the suspend
+ * code so locking is not necessary.
+ */
+int clk_save_context(void);
+
+/**
+ * clk_restore_context - restore clock context after poweroff
+ *
+ * This occurs with all clocks enabled. Occurs deep within the resume code
+ * so locking is not necessary.
+ */
+void clk_restore_context(void);
+
 #else /* !CONFIG_HAVE_CLK */
 
 static inline struct clk *clk_get(struct device *dev, const char *id)
@@ -695,6 +712,14 @@ static inline struct clk *clk_get_sys(const char *dev_id, const char *con_id)
 {
 	return NULL;
 }
+
+static inline int clk_save_context(void)
+{
+	return 0;
+}
+
+static inline void clk_restore_context(void) {}
+
 #endif
 
 /* clk_prepare_enable helps cases using clk_enable in non-atomic context. */
-- 
1.9.1

