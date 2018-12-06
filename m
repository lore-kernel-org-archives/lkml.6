Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BF1CC04EBF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:42:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38AB420878
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 00:42:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38AB420878
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728818AbeLFAmf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 19:42:35 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:33195 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbeLFAmc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 19:42:32 -0500
Received: from g2t2353.austin.hpe.com (g2t2353.austin.hpe.com [15.233.44.26])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 7BB3C60B4D;
        Thu,  6 Dec 2018 00:42:33 +0000 (UTC)
Received: from g2t2360.austin.hpecorp.net (g2t2360.austin.hpecorp.net [16.196.225.135])
        by g2t2353.austin.hpe.com (Postfix) with ESMTP id B46461C2;
        Thu,  6 Dec 2018 00:42:30 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g2t2360.austin.hpecorp.net (Postfix) with ESMTP id 5EAE13D;
        Thu,  6 Dec 2018 00:42:30 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     linux@roeck-us.net
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 1/3] watchdog/hpwdt: Exclude via blacklist
Date:   Wed,  5 Dec 2018 17:42:21 -0700
Message-Id: <1544056943-79958-2-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1544056943-79958-1-git-send-email-jerry.hoemann@hpe.com>
References: <1544056943-79958-1-git-send-email-jerry.hoemann@hpe.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of having explicit if statments excluding devices,
use a pci_device_id table of devices to blacklist.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 9356230..eecd014 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -50,6 +50,10 @@
 };
 MODULE_DEVICE_TABLE(pci, hpwdt_devices);
 
+static const struct pci_device_id hpwdt_blacklist[] = {
+	{ PCI_DEVICE_SUB(PCI_VENDOR_ID_HP, 0x3306, PCI_VENDOR_ID_HP, 0x1979) }, /* auxilary iLO */
+	{0},			/* terminate list */
+};
 
 /*
  *	Watchdog operations
@@ -274,12 +278,10 @@ static int hpwdt_init_one(struct pci_dev *dev,
 		return -ENODEV;
 	}
 
-	/*
-	 * Ignore all auxilary iLO devices with the following PCI ID
-	 */
-	if (dev->subsystem_vendor == PCI_VENDOR_ID_HP &&
-	    dev->subsystem_device == 0x1979)
+	if (pci_match_id(hpwdt_blacklist, dev)) {
+		dev_dbg(&dev->dev, "Not supported on this device\n");
 		return -ENODEV;
+	}
 
 	if (pci_enable_device(dev)) {
 		dev_warn(&dev->dev,
-- 
1.8.3.1

