Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 992F3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:04:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56E2620840
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:04:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="bTuW51YH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732768AbfAPWEq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:04:46 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:55766 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732006AbfAPWEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0HrSc9TjfAApcBtB66m46jVWZ+gQ86n9XEvM/jcR5Bk=; b=bTuW51YHeG3ZfthC3Xnt+y6B4
        +tYZrqsMd3hhPpoNkTVJoY5YyyRedscK07fii2Bc4/BZaJvqVan4/egVWU4jJmyvBWyyYavyVEU4y
        5gKG0jAUgimTJLNcms2VlI/db6GOypMoZ30aDQjkznsIKpWYziBr1d0sRV7Rw3nN6e/JY=;
Received: from p200300ccfbcc8e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbcc:8e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjtIW-0006la-Vm; Wed, 16 Jan 2019 23:04:33 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjtIW-0002PR-DT; Wed, 16 Jan 2019 23:04:32 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 1/3] clk: ti: add a usecount for autoidle
Date:   Wed, 16 Jan 2019 23:04:27 +0100
Message-Id: <20190116220429.9136-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190116220429.9136-1-andreas@kemnade.info>
References: <20190116220429.9136-1-andreas@kemnade.info>
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
Change  since v2:
- rebase on top of clk: ti: get rid of CLK_IS_BASIC
Changes since v1:
- use spinlocks instead of mutexes
- invert logic
 drivers/clk/ti/autoidle.c | 32 ++++++++++++++++++++++++++++----
 include/linux/clk/ti.h    |  1 +
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index a129b4b36ea3..964e97b5478a 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -36,17 +36,41 @@ struct clk_ti_autoidle {
 
 static LIST_HEAD(autoidle_clks);
 
+/*
+ * we have some non-atomic read/write
+ * operations behind it, so lets
+ * take one lock for handling autoidle
+ * of all clocks
+ */
+static DEFINE_SPINLOCK(autoidle_spinlock);
+
 static int _omap2_clk_deny_idle(struct clk_hw_omap *clk)
 {
-	if (clk->ops && clk->ops->deny_idle)
-		clk->ops->deny_idle(clk);
+	if (clk->ops && clk->ops->deny_idle) {
+		unsigned long irqflags;
+
+		spin_lock_irqsave(&autoidle_spinlock, irqflags);
+		clk->autoidle_count++;
+		if (clk->autoidle_count == 1)
+			clk->ops->deny_idle(clk);
+
+		spin_unlock_irqrestore(&autoidle_spinlock, irqflags);
+	}
 	return 0;
 }
 
 static int _omap2_clk_allow_idle(struct clk_hw_omap *clk)
 {
-	if (clk->ops && clk->ops->allow_idle)
-		clk->ops->allow_idle(clk);
+	if (clk->ops && clk->ops->allow_idle) {
+		unsigned long irqflags;
+
+		spin_lock_irqsave(&autoidle_spinlock, irqflags);
+		clk->autoidle_count--;
+		if (clk->autoidle_count == 0)
+			clk->ops->allow_idle(clk);
+
+		spin_unlock_irqrestore(&autoidle_spinlock, irqflags);
+	}
 	return 0;
 }
 
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

