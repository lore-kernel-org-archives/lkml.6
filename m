Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C6CC0044B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 20:31:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A4FF2146E
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 20:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="as+EzBEV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A4FF2146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbeKKGRv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 01:17:51 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:55176 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725846AbeKKGRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 01:17:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bkT6Tvgpqv1f+bqR/z7UZurhOG3dEwgC/MQ7DiTqGn0=; b=as+EzBEVbE5PEBH8tav8ZjqVh
        OWO73h29oavst3j58voN17vUJlsDtdfWuwhc5M3QxZjXvU9ENM6XBoVAY3fnXQs19PNJrcYii+0ba
        zAgQtYDGwPfYVeQhLrrlB9aLDS/3yhILf60GRIYIWRe9XNSQXWGOGAOjDZxYJpQIEWkcA=;
Received: from p200300ccfbcefb001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbce:fb00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gLZul-0000Ay-UL; Sat, 10 Nov 2018 21:31:32 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gLZul-0003Ts-L2; Sat, 10 Nov 2018 21:31:31 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 2/3] clk: ti: check clock type before doing autoidle ops
Date:   Sat, 10 Nov 2018 21:31:14 +0100
Message-Id: <20181110203115.13335-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181110203115.13335-1-andreas@kemnade.info>
References: <20181110203115.13335-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Code might use autoidle api with clocks not being omap2 clocks,
so check if clock type is not basic

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
New in v2
---
 drivers/clk/ti/autoidle.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/ti/autoidle.c b/drivers/clk/ti/autoidle.c
index 161f67850393..5bdae5552d38 100644
--- a/drivers/clk/ti/autoidle.c
+++ b/drivers/clk/ti/autoidle.c
@@ -54,8 +54,12 @@ static DEFINE_SPINLOCK(autoidle_spinlock);
 int omap2_clk_deny_idle(struct clk *clk)
 {
 	struct clk_hw_omap *c;
+	struct clk_hw *hw = __clk_get_hw(clk);
 
-	c = to_clk_hw_omap(__clk_get_hw(clk));
+	if (clk_hw_get_flags(hw) & CLK_IS_BASIC)
+		return -EINVAL;
+
+	c = to_clk_hw_omap(hw);
 	if (c->ops && c->ops->deny_idle) {
 		unsigned long irqflags;
 
@@ -77,8 +81,12 @@ int omap2_clk_deny_idle(struct clk *clk)
 int omap2_clk_allow_idle(struct clk *clk)
 {
 	struct clk_hw_omap *c;
+	struct clk_hw *hw = __clk_get_hw(clk);
 
-	c = to_clk_hw_omap(__clk_get_hw(clk));
+	if (clk_hw_get_flags(hw) & CLK_IS_BASIC)
+		return -EINVAL;
+
+	c = to_clk_hw_omap(hw);
 	if (c->ops && c->ops->allow_idle) {
 		unsigned long irqflags;
 
-- 
2.11.0

