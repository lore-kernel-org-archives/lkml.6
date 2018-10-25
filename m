Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23C2ECDE46
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 90ADA20870
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="sTdwmzyr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90ADA20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730572AbeJYWw3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:34494 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730541AbeJYWw2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:28 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC61D2147A;
        Thu, 25 Oct 2018 14:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477170;
        bh=ghnrFA6xlhIs9A5rBQlzdKGt3ajPKSeX0Qj1hKeUVwA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sTdwmzyrdmeQnkpgzknPetkp7VJ5E6sq/lR2ncxsi3a8kX9qfbm74SUQEuMG3wF4s
         jPixa0wsHO0g29jq10Ml27QbfrSXghCNytp5O67/sY314Zb/Waa8WYkGH8hjBHYGjE
         WzZWnXqC4XodjZYWHkyLuI8//7oitMV8mYE/Kh38=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Tony Lindgren <tony@atomide.com>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 23/98] ARM: OMAP2+: Fix n900 board name for legacy user space
Date:   Thu, 25 Oct 2018 10:17:38 -0400
Message-Id: <20181025141853.214051-23-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tony Lindgren <tony@atomide.com>

[ Upstream commit 71c4f6027da75c6c1fd92e05b63108a09ec2b109 ]

N900 legacy user space apps need the board name in
/proc/cpuinfo to work properly for the Hardware entry.

For other boards this should not be an issues and they
can use the generic Hardware entry.

Let's fix the issue by adding a custom DT_MACHINE_START
for n900.

Tested-by: Pali Rohár <pali.rohar@gmail.com>
Acked-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/board-generic.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/mach-omap2/board-generic.c b/arch/arm/mach-omap2/board-generic.c
index 608079a1aba6..b61c049f92d6 100644
--- a/arch/arm/mach-omap2/board-generic.c
+++ b/arch/arm/mach-omap2/board-generic.c
@@ -77,6 +77,24 @@ MACHINE_END
 #endif
 
 #ifdef CONFIG_ARCH_OMAP3
+/* Some boards need board name for legacy userspace in /proc/cpuinfo */
+static const char *const n900_boards_compat[] __initconst = {
+	"nokia,omap3-n900",
+	NULL,
+};
+
+DT_MACHINE_START(OMAP3_N900_DT, "Nokia RX-51 board")
+	.reserve	= omap_reserve,
+	.map_io		= omap3_map_io,
+	.init_early	= omap3430_init_early,
+	.init_machine	= omap_generic_init,
+	.init_late	= omap3_init_late,
+	.init_time	= omap3_sync32k_timer_init,
+	.dt_compat	= n900_boards_compat,
+	.restart	= omap3xxx_restart,
+MACHINE_END
+
+/* Generic omap3 boards, most boards can use these */
 static const char *const omap3_boards_compat[] __initconst = {
 	"ti,omap3430",
 	"ti,omap3",
-- 
2.17.1

