Return-Path: <SRS0=MSGh=KR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E1FC43142
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:24:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B536B21571
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Aug 2018 21:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B536B21571
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731741AbeHBXRO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Aug 2018 19:17:14 -0400
Received: from g2t1383g.austin.hpe.com ([15.233.16.89]:30767 "EHLO
        g2t1383g.austin.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbeHBXRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Aug 2018 19:17:14 -0400
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g2t1383g.austin.hpe.com (Postfix) with ESMTPS id 67E831D4F;
        Thu,  2 Aug 2018 21:24:18 +0000 (UTC)
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2352.austin.hpe.com (Postfix) with ESMTP id C5677B3;
        Thu,  2 Aug 2018 21:24:17 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 7DEE737;
        Thu,  2 Aug 2018 21:24:17 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 1/4] watchdog: hpwdt: Initialize pretimeout from module parameter.
Date:   Thu,  2 Aug 2018 15:15:38 -0600
Message-Id: <1533244541-42310-2-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
References: <1533244541-42310-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the pretimeout is specified as a module parameter, the
value should be reflected in hpwdt_dev.pretimeout.  The default
(on) case is correct.  But, when disabling pretimeout, the value
should be set to zero in hpwdt_dev.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 9dc62a4..369022d 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -313,6 +313,11 @@ static int hpwdt_init_one(struct pci_dev *dev,
 	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
 		dev_warn(&dev->dev, "Invalid soft_margin: %d.\n", soft_margin);
 
+#ifdef CONFIG_HPWDT_NMI_DECODING
+	if (!pretimeout)
+		hpwdt_dev.pretimeout = 0;
+#endif
+
 	hpwdt_dev.parent = &dev->dev;
 	retval = watchdog_register_device(&hpwdt_dev);
 	if (retval < 0) {
-- 
1.8.3.1

