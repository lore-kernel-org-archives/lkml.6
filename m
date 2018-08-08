Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA7BC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8AB35216F3
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 08:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AB35216F3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727202AbeHHKZz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 06:25:55 -0400
Received: from muru.com ([72.249.23.125]:53010 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726939AbeHHKZz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 06:25:55 -0400
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 497C58176;
        Wed,  8 Aug 2018 08:10:54 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/4] ARM: OMAP2+: Fix null hwmod for ti-sysc debug
Date:   Wed,  8 Aug 2018 01:07:03 -0700
Message-Id: <20180808080706.100389-2-tony@atomide.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180808080706.100389-1-tony@atomide.com>
References: <20180808080706.100389-1-tony@atomide.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We may call omap_hwmod_parse_module_range() with no hwmod allocated yet
and may have debug enabled. Let's fix this by checking for hwmod before
trying to use it's name.

Fixes: 6c72b3550672 ("ARM: OMAP2+: Parse module IO range from dts for legacy
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2220,7 +2220,7 @@ int omap_hwmod_parse_module_range(struct omap_hwmod *oh,
 	size = be32_to_cpup(ranges);
 
 	pr_debug("omap_hwmod: %s %s at 0x%llx size 0x%llx\n",
-		 oh->name, np->name, base, size);
+		 oh ? oh->name : "", np->name, base, size);
 
 	res->start = base;
 	res->end = base + size - 1;
-- 
2.17.1
