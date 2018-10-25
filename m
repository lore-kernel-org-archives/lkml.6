Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DA4AECDE47
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A6BC20870
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:19:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQx4WmVW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A6BC20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730377AbeJYWwI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:52:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:34012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727992AbeJYWwH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:52:07 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 168A820848;
        Thu, 25 Oct 2018 14:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540477150;
        bh=x3Sq3kVWrOZd6+qgj8SB7cRu3yavIH7tGfm3q/KK8iw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=AQx4WmVW+wp2IitZz5MGHZ0CT94aJr7I+ts2QqU3CZSfczoNfppEIFpFtdf9g59f1
         OQL/YFf0l3E1temw+5jHxPSbn7xUqTvgG5//23YymBQ1nmoSviDsk5Ojcz8GppjgxT
         v/WDuUgzJAM/Kn57l0Jt6WB/Xg638+T/GMnfra9k=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Matthijs van Duin <matthijsvanduin@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 3.18 08/98] ARM: OMAP5 / DRA7: Fix HYP mode boot for thumb2 build
Date:   Thu, 25 Oct 2018 10:17:23 -0400
Message-Id: <20181025141853.214051-8-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141853.214051-1-sashal@kernel.org>
References: <20181025141853.214051-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthijs van Duin <matthijsvanduin@gmail.com>

[ Upstream commit 448c077eeb02240c430db2a2c3bf5285a4c65d66 ]

'adr' yields a data-pointer, not a function-pointer.

Fixes: 999f934de195 ("ARM: omap5/dra7xx: Enable booting secondary
CPU in HYP mode")
Signed-off-by: Matthijs van Duin <matthijsvanduin@gmail.com>
Signed-off-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/mach-omap2/omap-headsmp.S | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/mach-omap2/omap-headsmp.S b/arch/arm/mach-omap2/omap-headsmp.S
index 6d1dffca6c7b..748dde9fa4a5 100644
--- a/arch/arm/mach-omap2/omap-headsmp.S
+++ b/arch/arm/mach-omap2/omap-headsmp.S
@@ -17,6 +17,7 @@
 
 #include <linux/linkage.h>
 #include <linux/init.h>
+#include <asm/assembler.h>
 
 #include "omap44xx.h"
 
@@ -56,7 +57,7 @@ wait_2:	ldr	r2, =AUX_CORE_BOOT0_PA	@ read from AuxCoreBoot0
 	cmp	r0, r4
 	bne	wait_2
 	ldr	r12, =API_HYP_ENTRY
-	adr	r0, hyp_boot
+	badr	r0, hyp_boot
 	smc	#0
 hyp_boot:
 	b	secondary_startup
-- 
2.17.1

