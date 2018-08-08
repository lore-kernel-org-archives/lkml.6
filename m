Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C32BC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:22:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D62DE21798
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:22:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D62DE21798
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731089AbeHHVnU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:43:20 -0400
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:29805 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727295AbeHHVm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:42:57 -0400
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id D3AB960;
        Wed,  8 Aug 2018 19:21:51 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 7D79648;
        Wed,  8 Aug 2018 19:21:51 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 2/5] watchdog: hpwdt: Claim NMI from iLO
Date:   Wed,  8 Aug 2018 13:13:24 -0600
Message-Id: <1533755607-71418-3-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hwpdt driver is overloaded for handling both the iLO
watchdog and the explicit "Generate NMI to System" virutal
button.  Hence NMI handler needs to claim NMI resulting
from the virutal button.

Claim if iLO generated accommodating firmware that might
set wrong bit.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index fae9364..bb41714 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -162,7 +162,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	if (ilo5 && ulReason == NMI_UNKNOWN && !mynmi)
 		return NMI_DONE;
 
-	if (ilo5 && !pretimeout)
+	if (ilo5 && !pretimeout && !mynmi)
 		return NMI_DONE;
 
 	hpwdt_stop();
-- 
1.8.3.1

