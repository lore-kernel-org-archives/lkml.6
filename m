Return-Path: <SRS0=rfjF=MD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5DBFC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:50:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F0562154C
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Sep 2018 20:50:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F0562154C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391467AbeIVClX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Sep 2018 22:41:23 -0400
Received: from g9t5008.houston.hpe.com ([15.241.48.72]:44452 "EHLO
        g9t5008.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391243AbeIVClX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Sep 2018 22:41:23 -0400
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 85C08265;
        Fri, 21 Sep 2018 20:50:47 +0000 (UTC)
Received: from anatevka.ftc.rdlabs.hpecorp.net (anatevka.americas.hpqcorp.net [10.34.81.6])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 1B1B548;
        Fri, 21 Sep 2018 20:50:46 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH] watchdog/hpwdt: Disable PreTimeout when Timeout is smaller
Date:   Fri, 21 Sep 2018 14:50:39 -0600
Message-Id: <20180921205039.11466-1-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.13.6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During module install, disable pretimeout if the requested timeout
value is not greater than the minimal pretimeout value that is
supported by hardware.

This makes the module load handling of pretimeout consistent
with the ioctl handling of pretimeout.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 7af358b3e278..93562304f7aa 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -311,6 +311,10 @@ static int hpwdt_init_one(struct pci_dev *dev,
 	if (watchdog_init_timeout(&hpwdt_dev, soft_margin, NULL))
 		dev_warn(&dev->dev, "Invalid soft_margin: %d.\n", soft_margin);
 
+	if (pretimeout && hpwdt_dev.timeout <= PRETIMEOUT_SEC) {
+		dev_warn(&dev->dev, "timeout <= pretimeout. Setting pretimeout to zero\n");
+		pretimeout = 0;
+	}
 	hpwdt_dev.pretimeout = pretimeout ? PRETIMEOUT_SEC : 0;
 
 	hpwdt_dev.parent = &dev->dev;
-- 
2.13.6

