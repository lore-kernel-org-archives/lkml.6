Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B1AC4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:21:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70BA22178B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 19:21:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70BA22178B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730375AbeHHVm6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 17:42:58 -0400
Received: from g4t3426.houston.hpe.com ([15.241.140.75]:29787 "EHLO
        g4t3426.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbeHHVm5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 17:42:57 -0400
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 6EABE5D;
        Wed,  8 Aug 2018 19:21:51 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 23AB34B;
        Wed,  8 Aug 2018 19:21:51 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 1/5] watchdog: hpwdt: Initialize pretimeout from module parameter.
Date:   Wed,  8 Aug 2018 13:13:23 -0600
Message-Id: <1533755607-71418-2-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
References: <1533755607-71418-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the pretimeout is specified as a module parameter, the
value should be reflected in hpwdt_dev.pretimeout.  The default
(on) case is correct.  But, when disabling pretimeout, the value
should be set to zero in hpwdt_dev.

When compiling w/o CONFIG_HPWDT_NMI_DECODING defined, the pretimeout
module parameter is ignored and the value internally will be 0.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 9dc62a4..fae9364 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -205,9 +205,7 @@ static int hpwdt_pretimeout(unsigned int ulReason, struct pt_regs *regs)
 	.min_timeout	= 1,
 	.max_timeout	= HPWDT_MAX_TIMER,
 	.timeout	= DEFAULT_MARGIN,
-#ifdef CONFIG_HPWDT_NMI_DECODING
 	.pretimeout	= PRETIMEOUT_SEC,
-#endif
 };
 
 
@@ -313,6 +311,8 @@ static int hpwdt_init_one(struct pci_dev *dev,
 	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
 		dev_warn(&dev->dev, "Invalid soft_margin: %d.\n", soft_margin);
 
+	hpwdt_dev.pretimeout = pretimeout ? PRETIMEOUT_SEC : 0;
+
 	hpwdt_dev.parent = &dev->dev;
 	retval = watchdog_register_device(&hpwdt_dev);
 	if (retval < 0) {
-- 
1.8.3.1

