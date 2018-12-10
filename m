Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221B3C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:13:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CEF8620821
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:13:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEF8620821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=atomide.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbeLJWNj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 17:13:39 -0500
Received: from muru.com ([72.249.23.125]:57170 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727146AbeLJWNj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 17:13:39 -0500
Received: from hillo.muru.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTP id 8702F80F0;
        Mon, 10 Dec 2018 22:13:41 +0000 (UTC)
From:   Tony Lindgren <tony@atomide.com>
To:     linux-omap@vger.kernel.org
Cc:     Dave Gerlach <d-gerlach@ti.com>, Faiz Abbas <faiz_abbas@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keerthy <j-keerthy@ti.com>, Nishanth Menon <nm@ti.com>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ARM: OMAP2+: Check also the first dts child for hwmod flags
Date:   Mon, 10 Dec 2018 14:13:33 -0800
Message-Id: <20181210221334.24982-1-tony@atomide.com>
X-Mailer: git-send-email 2.19.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Until the board specific dts files are updated to have hwmod
flags at the interconnect target module level, we want to keep
things working both for old and new dts files.

So let's also check the first child for hwmod flags. The module
flags are for the whole module, so only the first child should
ever have them.

Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reported-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 arch/arm/mach-omap2/omap_hwmod.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/arch/arm/mach-omap2/omap_hwmod.c b/arch/arm/mach-omap2/omap_hwmod.c
--- a/arch/arm/mach-omap2/omap_hwmod.c
+++ b/arch/arm/mach-omap2/omap_hwmod.c
@@ -2345,6 +2345,17 @@ static int __init _init_mpu_rt_base(struct omap_hwmod *oh, void *data,
 	return 0;
 }
 
+static void __init parse_module_flags(struct omap_hwmod *oh,
+				      struct device_node *np)
+{
+	if (of_find_property(np, "ti,no-reset-on-init", NULL))
+		oh->flags |= HWMOD_INIT_NO_RESET;
+	if (of_find_property(np, "ti,no-idle-on-init", NULL))
+		oh->flags |= HWMOD_INIT_NO_IDLE;
+	if (of_find_property(np, "ti,no-idle", NULL))
+		oh->flags |= HWMOD_NO_IDLE;
+}
+
 /**
  * _init - initialize internal data for the hwmod @oh
  * @oh: struct omap_hwmod *
@@ -2392,12 +2403,12 @@ static int __init _init(struct omap_hwmod *oh, void *data)
 	}
 
 	if (np) {
-		if (of_find_property(np, "ti,no-reset-on-init", NULL))
-			oh->flags |= HWMOD_INIT_NO_RESET;
-		if (of_find_property(np, "ti,no-idle-on-init", NULL))
-			oh->flags |= HWMOD_INIT_NO_IDLE;
-		if (of_find_property(np, "ti,no-idle", NULL))
-			oh->flags |= HWMOD_NO_IDLE;
+		struct device_node *child;
+
+		parse_module_flags(oh, np);
+		child = of_get_next_child(np, NULL);
+		if (child)
+			parse_module_flags(oh, child);
 	}
 
 	oh->_state = _HWMOD_STATE_INITIALIZED;
-- 
2.19.2
