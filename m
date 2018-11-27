Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BAFC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:15:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BB3292082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 11:15:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB3292082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729464AbeK0WMw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 17:12:52 -0500
Received: from mga18.intel.com ([134.134.136.126]:24775 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbeK0WMw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 17:12:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Nov 2018 03:15:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,286,1539673200"; 
   d="scan'208";a="92798409"
Received: from powerlab.fi.intel.com (HELO powerlab.backendnet) ([10.237.71.25])
  by orsmga007.jf.intel.com with ESMTP; 27 Nov 2018 03:15:17 -0800
From:   Luming Yu <luming.yu@intel.com>
To:     linux-kernel@vger.kernel.org
Subject: [PATCH] reorder slow clock source read for clock source watchdog
Date:   Tue, 27 Nov 2018 13:15:16 +0200
Message-Id: <20181127111516.73733-1-luming.yu@intel.com>
X-Mailer: git-send-email 2.14.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

the clock source watchdog (HPET) in skx is much slower
than the clock source TSC. The long latency in the first
call may trigger a false postive TSC unstable noise.
Let the fast one follows the slow one should fix it.

Signed-off-by: Luming Yu <luming.yu@intel.com>
Signed-off-by: Yongkai Wu <yongkaiwu@tencent.com>
---
 kernel/time/clocksource.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/clocksource.c b/kernel/time/clocksource.c
index ffe081623aec..8ea929e50ca6 100644
--- a/kernel/time/clocksource.c
+++ b/kernel/time/clocksource.c
@@ -225,8 +225,8 @@ static void clocksource_watchdog(struct timer_list *unused)
 		}
 
 		local_irq_disable();
-		csnow = cs->read(cs);
 		wdnow = watchdog->read(watchdog);
+		csnow = cs->read(cs);
 		local_irq_enable();
 
 		/* Clocksource initialized ? */
-- 
2.14.4

