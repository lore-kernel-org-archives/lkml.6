Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BBD5C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69429206C2
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 22:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="f9frrGk6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732666AbfAPWEm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 16 Jan 2019 17:04:42 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:55778 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732331AbfAPWEl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jan 2019 17:04:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=W8mLpcohFLbgoUsNHzm3JNGLn4a+GB69xPfLUSFX8bA=; b=f9frrGk6lUGj9X6wHXVjlU9kS
        u5CnFyIKhHdjwdLUnYXFHMPk2hKVEu2dSdMd871yiC86bhSaXR6cXFWXt/udDNl70gJ//WqS5OBA4
        TY7WEho82TFakjS/JuG0lIAUSvh7NhgGcU1qG5fF5OUlOues8bvqP7HGFwo4xAb7myjcE=;
Received: from p200300ccfbcc8e001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbcc:8e00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjtIY-0006lg-1a; Wed, 16 Jan 2019 23:04:34 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gjtIX-0002PX-Oy; Wed, 16 Jan 2019 23:04:33 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v3 3/3] arm: omap_hwmod disable ick autoidling when a hwmod requires that
Date:   Wed, 16 Jan 2019 23:04:29 +0100
Message-Id: <20190116220429.9136-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20190116220429.9136-1-andreas@kemnade.info>
References: <20190116220429.9136-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deny autoidle for hwmods with the OCPIF_SWSUP_IDLE flag,
that makes hwmods working properly which cannot handle
autoidle properly in lower power states.
Affected is e. g. the omap_hdq.
Since an ick might have mulitple users, autoidle is disabled
when an individual user requires that rather than in
_setup_iclk_autoidle. dss_ick is an example for that.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 Comments to v1 to this patch were worked into a new 2/3
---
 arch/arm/mach-omap2/omap_hwmod.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index b5531dd3ae9c..3a04c73ac03c 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -1002,8 +1002,10 @@ static int _enable_clocks(struct omap_hwmod *oh)
 		clk_enable(oh->_clk);
 
 	list_for_each_entry(os, &oh->slave_ports, node) {
-		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
+		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE)) {
+			omap2_clk_deny_idle(os->_clk);
 			clk_enable(os->_clk);
+		}
 	}
 
 	/* The opt clocks are controlled by the device driver. */
@@ -1055,8 +1057,10 @@ static int _disable_clocks(struct omap_hwmod *oh)
 		clk_disable(oh->_clk);
 
 	list_for_each_entry(os, &oh->slave_ports, node) {
-		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
+		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE)) {
 			clk_disable(os->_clk);
+			omap2_clk_allow_idle(os->_clk);
+		}
 	}
 
 	if (oh->flags & HWMOD_OPT_CLKS_NEEDED)
@@ -2436,9 +2440,13 @@ static void _setup_iclk_autoidle(struct omap_hwmod *oh)
 			continue;
 
 		if (os->flags & OCPIF_SWSUP_IDLE) {
-			/* XXX omap_iclk_deny_idle(c); */
+			/*
+			 * we might have multiple users of one iclk with
+			 * different requirements, disable autoidle when
+			 * the module is enabled, e.g. dss iclk
+			 */
 		} else {
-			/* XXX omap_iclk_allow_idle(c); */
+			/* we are enabling autoidle afterwards anyways */
 			clk_enable(os->_clk);
 		}
 	}
-- 
2.11.0

