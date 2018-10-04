Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3BCC64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:38:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 44CFF20877
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="AU1VWG6c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44CFF20877
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727810AbeJEDd3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:33:29 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:33926 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJEDd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hxKaBbQP9Ohf6unfmS5C4E5JDsTkQe6IxUA7qgDVBQc=; b=AU1VWG6c6U0Tcj29nA5TnaB9i
        yf4HzBgo0h+2bKYXNSnhpf3lj0a4NtcoVGVBrXWLH8DxemA4oiPT7q6XF0laRSRMGb1kzKABT2+Cs
        wtSGEbhs1MhP7951I3K/trG7ArKgYwTwPOrx0xCH/q3WxJPjzObu7tT1f2JRQWgWU6ZMc=;
Received: from p200300ccfbcbd5001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbcb:d500:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g8AOA-0007GZ-C4; Thu, 04 Oct 2018 22:38:26 +0200
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g8AOA-0005mB-1h; Thu, 04 Oct 2018 22:38:26 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 1/2] clk: ti: add a usecount for autoidle
Date:   Thu,  4 Oct 2018 22:38:16 +0200
Message-Id: <20181004203817.22101-2-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181004203817.22101-1-andreas@kemnade.info>
References: <20181004203817.22101-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have the scenario that first autoidle is disabled for all clocks,
then it is disabled for selected ones and then enabled for all. So
we should have some counting here, also according to the
comment in  _setup_iclk_autoidle()

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 drivers/clk/ti/autoidle.c | 32 ++++++++++++++++++++++++--------
 include/linux/clk/ti.h    |  1 +
 2 files changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index 7bb9afbe4058..bb6cff168e73 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -37,6 +37,14 @@ struct clk_ti_autoidle {
 static LIST_HEAD(autoidle_clks);
 static LIST_HEAD(clk_hw_omap_clocks);
 
+/*
+ * we have some non-atomic read/write
+ * operations behind it, so lets
+ * take one mutex for handling autoidle
+ * of all clocks
+ */
+static DEFINE_MUTEX(autoidle_mutex);
+
 /**
  * omap2_clk_deny_idle - disable autoidle on an OMAP clock
  * @clk: struct clk * to disable autoidle for
@@ -48,8 +56,13 @@ int omap2_clk_deny_idle(struct clk *clk)
 	struct clk_hw_omap *c;
 
 	c = to_clk_hw_omap(__clk_get_hw(clk));
-	if (c->ops && c->ops->deny_idle)
-		c->ops->deny_idle(c);
+	if (c->ops && c->ops->deny_idle) {
+		mutex_lock(&autoidle_mutex);
+		c->autoidle_count--;
+		if (c->autoidle_count == -1)
+			c->ops->deny_idle(c);
+		mutex_unlock(&autoidle_mutex);
+	}
 	return 0;
 }
 
@@ -64,8 +77,13 @@ int omap2_clk_allow_idle(struct clk *clk)
 	struct clk_hw_omap *c;
 
 	c = to_clk_hw_omap(__clk_get_hw(clk));
-	if (c->ops && c->ops->allow_idle)
-		c->ops->allow_idle(c);
+	if (c->ops && c->ops->allow_idle) {
+		mutex_lock(&autoidle_mutex);
+		c->autoidle_count++;
+		if (c->autoidle_count == 0)
+			c->ops->allow_idle(c);
+		mutex_unlock(&autoidle_mutex);
+	}
 	return 0;
 }
 
@@ -201,8 +219,7 @@ int omap2_clk_enable_autoidle_all(void)
 	struct clk_hw_omap *c;
 
 	list_for_each_entry(c, &clk_hw_omap_clocks, node)
-		if (c->ops && c->ops->allow_idle)
-			c->ops->allow_idle(c);
+		omap2_clk_allow_idle(c->hw.clk);
 
 	_clk_generic_allow_autoidle_all();
 
@@ -223,8 +240,7 @@ int omap2_clk_disable_autoidle_all(void)
 	struct clk_hw_omap *c;
 
 	list_for_each_entry(c, &clk_hw_omap_clocks, node)
-		if (c->ops && c->ops->deny_idle)
-			c->ops->deny_idle(c);
+		omap2_clk_deny_idle(c->hw.clk);
 
 	_clk_generic_deny_autoidle_all();
 
diff --git a/include/linux/clk/ti.h b/include/linux/clk/ti.h
index a8faa38b1ed6..c460355419c0 100644
--- a/include/linux/clk/ti.h
+++ b/include/linux/clk/ti.h
@@ -159,6 +159,7 @@ struct clk_hw_omap {
 	const char		*clkdm_name;
 	struct clockdomain	*clkdm;
 	const struct clk_hw_omap_ops	*ops;
+	int autoidle_count;
 };
 
 /*
-- 
2.11.0

