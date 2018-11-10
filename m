Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC24C43441
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 20:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34A0F20989
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 20:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="aUnKtmTF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34A0F20989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726943AbeKKGRy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 01:17:54 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:55174 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbeKKGRw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 01:17:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=Wf/u8C0XrToxFFyDJHcHwb5Q4HKFOYNOE9vQVibkCE0=; b=aUnKtmTFxtHvV2fn4h6KxQGkG
        svdITzofToM7T0gTNPFiCYjORzReq/q3AUUw5/LvGEmLTkNYrw2UQANBaBzc2oTrWs7E9LeIy4Esv
        YWmayvdNviUHkjyy/pJ7w+qVUEyQkTMvSejoIYPFea7Yv+9EQRLzdCfRGujZR3n6KBTQk=;
Received: from p200300ccfbcefb001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbce:fb00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gLZuj-0000Au-Bf; Sat, 10 Nov 2018 21:31:29 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gLZuj-0003Tp-1E; Sat, 10 Nov 2018 21:31:29 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 1/3] clk: ti: add a usecount for autoidle
Date:   Sat, 10 Nov 2018 21:31:13 +0100
Message-Id: <20181110203115.13335-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181110203115.13335-1-andreas@kemnade.info>
References: <20181110203115.13335-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Multiple users might deny autoidle on a clock. So we should have some
counting here, also according to the comment in  _setup_iclk_autoidle().
Also setting autoidle regs is not atomic, so there is another reason
for locking.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Changes since v1:
- use spinlocks instead of mutexes
- invert logic
---
 drivers/clk/ti/autoidle.c | 36 ++++++++++++++++++++++++++++--------
 include/linux/clk/ti.h    |  1 +
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index 7bb9afbe4058..161f67850393 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -37,6 +37,14 @@ struct clk_ti_autoidle {
 static LIST_HEAD(autoidle_clks);
 static LIST_HEAD(clk_hw_omap_clocks);
 
+/*
+ * we have some non-atomic read/write
+ * operations behind it, so lets
+ * take one lock for handling autoidle
+ * of all clocks
+ */
+static DEFINE_SPINLOCK(autoidle_spinlock);
+
 /**
  * omap2_clk_deny_idle - disable autoidle on an OMAP clock
  * @clk: struct clk * to disable autoidle for
@@ -48,8 +56,15 @@ int omap2_clk_deny_idle(struct clk *clk)
 	struct clk_hw_omap *c;
 
 	c = to_clk_hw_omap(__clk_get_hw(clk));
-	if (c->ops && c->ops->deny_idle)
-		c->ops->deny_idle(c);
+	if (c->ops && c->ops->deny_idle) {
+		unsigned long irqflags;
+
+		spin_lock_irqsave(&autoidle_spinlock, irqflags);
+		c->autoidle_count++;
+		if (c->autoidle_count == 1)
+			c->ops->deny_idle(c);
+		spin_unlock_irqrestore(&autoidle_spinlock, irqflags);
+	}
 	return 0;
 }
 
@@ -64,8 +79,15 @@ int omap2_clk_allow_idle(struct clk *clk)
 	struct clk_hw_omap *c;
 
 	c = to_clk_hw_omap(__clk_get_hw(clk));
-	if (c->ops && c->ops->allow_idle)
-		c->ops->allow_idle(c);
+	if (c->ops && c->ops->allow_idle) {
+		unsigned long irqflags;
+
+		spin_lock_irqsave(&autoidle_spinlock, irqflags);
+		c->autoidle_count--;
+		if (c->autoidle_count == 0)
+			c->ops->allow_idle(c);
+		spin_unlock_irqrestore(&autoidle_spinlock, irqflags);
+	}
 	return 0;
 }
 
@@ -201,8 +223,7 @@ int omap2_clk_enable_autoidle_all(void)
 	struct clk_hw_omap *c;
 
 	list_for_each_entry(c, &clk_hw_omap_clocks, node)
-		if (c->ops && c->ops->allow_idle)
-			c->ops->allow_idle(c);
+		omap2_clk_allow_idle(c->hw.clk);
 
 	_clk_generic_allow_autoidle_all();
 
@@ -223,8 +244,7 @@ int omap2_clk_disable_autoidle_all(void)
 	struct clk_hw_omap *c;
 
 	list_for_each_entry(c, &clk_hw_omap_clocks, node)
-		if (c->ops && c->ops->deny_idle)
-			c->ops->deny_idle(c);
+		omap2_clk_deny_idle(c->hw.clk);
 
 	_clk_generic_deny_autoidle_all();
 
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index eacc5df57b99..78872efc7be0 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -160,6 +160,7 @@ struct clk_hw_omap {
 	struct clockdomain	*clkdm;
 	const struct clk_hw_omap_ops	*ops;
 	u32			context;
+	int			autoidle_count;
 };
 
 /*
-- 
2.11.0

