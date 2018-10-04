Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F821C64EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:52:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2080C213A2
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 05:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kemnade.info header.i=@kemnade.info header.b="DDvUfGyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2080C213A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kemnade.info
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbeJDMnu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 08:43:50 -0400
Received: from mail.andi.de1.cc ([85.214.239.24]:60024 "EHLO
        h2641619.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbeJDMnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 08:43:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=kemnade.info; s=20180802; h=References:In-Reply-To:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=A8OtTmmIqAi34/iweTVhJk0UefWSAt5qAatDD1l4zfM=; b=DDvUfGyp1Umgk+HpkDcRN3V9l
        dSNmPn8YCxOZsJ0LQkMQriiPc1SvYu78AxEA1wuTHgU6lcdZTlM0hxEaDCKnDlv1CRCNnkHl0BC6x
        cuhlro14U1xWKVroCu7ic2GYq+x0KmgCnoXmPZ0UbcijC4XvxPZi2miqdjmNFVnthbayY=;
Received: from p200300ccfbcbd5001a3da2fffebfd33a.dip0.t-ipconnect.de ([2003:cc:fbcb:d500:1a3d:a2ff:febf:d33a] helo=aktux)
        by h2641619.stratoserver.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g7wYS-0003YY-5q; Thu, 04 Oct 2018 07:52:08 +0200
Received: from andi by aktux with local (Exim 4.89)
        (envelope-from <andreas@kemnade.info>)
        id 1g7wYS-00060b-1G; Thu, 04 Oct 2018 07:52:08 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     t-kristo@ti.com, mturquette@baylibre.com, sboyd@kernel.org,
        linux-omap@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, paul@pwsan.com, tony@atomide.com,
        letux-kernel@openphoenux.org
Cc:     Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RFC 2/2] arm: mach-omap2: setup iclk autoidle according to flags
Date:   Thu,  4 Oct 2018 07:51:47 +0200
Message-Id: <20181004055147.23048-3-andreas@kemnade.info>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20181004055147.23048-1-andreas@kemnade.info>
References: <20181004055147.23048-1-andreas@kemnade.info>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deny autoidle for hwmods with the OCPIF_SWSUP_IDLE flag,
that makes hwmods working properly which cannot handle
autoidle properly in lower power states.
Affected is e. g. the omap_hdq.
It also disables CM_AUTOIDLE_DSS. Need to check if
that is wanted or not.
Note: Autoidle is not enabled explicitly because there
might be clocks which do not support that operation and
it is enabled afterwards in arm/mach-omap2/pm.c anyways.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
 arch/arm/mach-omap2/omap_hwmod.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
index bb641e6c93d0..6f9687a4f421 100644
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -131,6 +131,7 @@
 #include <linux/errno.h>
 #include <linux/io.h>
 #include <linux/clk.h>
+#include <linux/clk/ti.h>
 #include <linux/clk-provider.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -2410,9 +2411,12 @@ static void __init _setup_iclk_autoidle(struct omap_hwmod *oh)
 			continue;
 
 		if (os->flags & OCPIF_SWSUP_IDLE) {
-			/* XXX omap_iclk_deny_idle(c); */
+			omap2_clk_deny_idle(os->_clk);
 		} else {
-			/* XXX omap_iclk_allow_idle(c); */
+			/*
+			 * no allow_idle here since there is
+			 * later an allow idle in pm.c
+			 */
 			clk_enable(os->_clk);
 		}
 	}
-- 
2.11.0

