Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B09FC43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CBBA5206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="Dxw+LUUR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732703AbfAPWEn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:04:43 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:55770 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732159AbfAPWEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=WXds+0lDhrbxDFvkp+UhCojJxIFBCbMZxCTk3UNSSQQ=; b=Dxw+LUURMGDCGydQL113B7jAx
        dyIBnAthJaiBatdnSpH41x4h8EMB9fK5PH2mOdNd08AYJqh713vazLLb2lnuk6hzqMNB/7AghCkZj
        +6yZ2o9Xk4gCCB5zYwp/wbiwbiOO4jqZwcitLj5OEFw0fekmmLVtxXaW0uwzYmUFPc9x8=;
Received: from p200300ccfbcc8e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbcc:8e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjtIX-0006lc-BY; Wed, 16 Jan 2019 23:04:33 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjtIX-0002PU-3p; Wed, 16 Jan 2019 23:04:33 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 2/3] clk: ti: check clock type before doing autoidle ops
Date:   Wed, 16 Jan 2019 23:04:28 +0100
Message-Id: <20190116220429.9136-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190116220429.9136-1-andreas@kemnade.info>
References: <20190116220429.9136-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code might use autoidle api with clocks not being omap2 clocks,
so check if clock type is really omap2.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
v3: replace CLK_IS_BASIC check
New in v2
 drivers/clk/ti/autoidle.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index 964e97b5478a..1cae226759dd 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -82,9 +82,15 @@ static int _omap2_clk_allow_idle(struct clk_hw_omap *clk)
  */
 int omap2_clk_deny_idle(struct clk *clk)
 {
-	struct clk_hw_omap *c = to_clk_hw_omap(__clk_get_hw(clk));
+	struct clk_hw *hw = __clk_get_hw(clk);
 
-	return _omap2_clk_deny_idle(c);
+	if (omap2_clk_is_hw_omap(hw)) {
+		struct clk_hw_omap *c = to_clk_hw_omap(hw);
+
+		return _omap2_clk_deny_idle(c);
+	}
+
+	return -EINVAL;
 }
 
 /**
@@ -95,9 +101,15 @@ int omap2_clk_deny_idle(struct clk *clk)
  */
 int omap2_clk_allow_idle(struct clk *clk)
 {
-	struct clk_hw_omap *c = to_clk_hw_omap(__clk_get_hw(clk));
+	struct clk_hw *hw = __clk_get_hw(clk);
+
+	if (omap2_clk_is_hw_omap(hw)) {
+		struct clk_hw_omap *c = to_clk_hw_omap(hw);
+
+		return _omap2_clk_allow_idle(c);
+	}
 
-	return _omap2_clk_allow_idle(c);
+	return -EINVAL;
 }
 
 static void _allow_autoidle(struct clk_ti_autoidle *clk)
-- 
2.11.0

