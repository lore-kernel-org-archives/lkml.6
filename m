Return-Path: <SRS0=/3Wd=NV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6D0AC0044B
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 20:31:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6750E208E3
	for <linux-kernel@archiver.kernel.org>; Sat, 10 Nov 2018 20:31:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="VZIjn4a8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6750E208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727062AbeKKGRz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 01:17:55 -0500
Received: from mail.andi.de1.cc ([85.214.239.24]:55208 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbeKKGRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 01:17:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=d0Z4wDFvJUTZrDNbdh0j0zfJTsQdVVzl/1whxXolpLM=; b=VZIjn4a8qDha3p+74pN37tu3B
        Kay/2snRuXsMCEb0uu4e5TmrJiRUKWIm1HgBoAe0PeVobi5GyYmeIN6WAWw12TptBp9F8KqrtXekQ
        Cw5S0WCK2StGd22SrINYrqmRxIc/ZVZc+mG1alXTXJfA3kIMV1WHfhqOJdOPp2yncDyVI=;
Received: from p200300ccfbcefb001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbce:fb00:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gLZun-0000BM-JV; Sat, 10 Nov 2018 21:31:33 +0100
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1gLZun-0003Tv-9x; Sat, 10 Nov 2018 21:31:33 +0100
From:   Andreas Kemnade <andreas@kemnade.info>
To:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH v2 3/3] arm: omap_hwmod disable ick autoidling when a hwmod requires that
Date:   Sat, 10 Nov 2018 21:31:15 +0100
Message-Id: <20181110203115.13335-4-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181110203115.13335-1-andreas@kemnade.info>
References: <20181110203115.13335-1-andreas@kemnade.info>
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
index 083dcd9942ce..3a86ba414973 100644
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
@@ -2425,9 +2429,13 @@ static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
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

