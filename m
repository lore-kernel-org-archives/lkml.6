Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271D9C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:38:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F452087D
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 20:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="ZeBFcSu2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2F452087D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbeJEDdg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 23:33:36 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:33974 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727499AbeJEDdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 23:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=gsrVQYqOvt6bHEaGNBZ3ivI+imRg6+0o4MIOMQo5To4=; b=ZeBFcSu2Hx1koLT2PIh73dYHu
        jPtkOI5GZ4A3vQqPOip3WbsbqBQuOXL6a7pl6sVMRKQvigEUWEv/gj1sX0JHgt2HZY8KHZaBmYftz
        I8SKgTmAGsw5/qS9qdNkhfI02qaMqmMFGnPNVvdBLfMciucd4zBaYijGNIzUD4sSQKWhk=;
Received: from p200300ccfbcbd5001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbcb:d500:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g8AOG-0007Gy-FE; Thu, 04 Oct 2018 22:38:32 +0200
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g8AOG-0005mE-71; Thu, 04 Oct 2018 22:38:32 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, bcousson@baylibre.com,
        paul@pwsan.com, tony@atomide.com, letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH 2/2] arm: omap_hwmod disable ick autoidling when a hwmod requires that
Date:   Thu,  4 Oct 2018 22:38:17 +0200
Message-Id: <20181004203817.22101-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181004203817.22101-1-andreas@kemnade.info>
References: <20181004203817.22101-1-andreas@kemnade.info>
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
 arch/arm/mach-omap2/omap_hwmod.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index bb641e6c93d0..0078b0e1d242 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -986,8 +986,10 @@ static int _enable_clocks(struct omap_hwmod *oh)
 		clk_enable(oh->_clk);
 
 	list_for_each_entry(os, &oh->slave_ports, node) {
-		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
+		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE)) {
+			omap2_clk_deny_idle(os->_clk);
 			clk_enable(os->_clk);
+		}
 	}
 
 	/* The opt clocks are controlled by the device driver. */
@@ -1039,8 +1041,10 @@ static int _disable_clocks(struct omap_hwmod *oh)
 		clk_disable(oh->_clk);
 
 	list_for_each_entry(os, &oh->slave_ports, node) {
-		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE))
+		if (os->_clk && (os->flags & OCPIF_SWSUP_IDLE)) {
 			clk_disable(os->_clk);
+			omap2_clk_allow_idle(os->_clk);
+		}
 	}
 
 	if (oh->flags & HWMOD_OPT_CLKS_NEEDED)
@@ -2410,9 +2414,13 @@ static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
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

