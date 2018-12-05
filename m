Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48900C04EB8
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:22:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E0C22082B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 02:22:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E0C22082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hpe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726477AbeLECWh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 21:22:37 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:10197 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbeLECWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 21:22:37 -0500
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by g9t1613g.houston.hpe.com (Postfix) with ESMTPS id 3DA6960D35;
        Wed,  5 Dec 2018 02:22:38 +0000 (UTC)
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id BF6EA4E;
        Wed,  5 Dec 2018 02:22:35 +0000 (UTC)
Received: from lxbuild.ftc.rdlabs.hpecorp.net (lxbuild.ftc.rdlabs.hpecorp.net [16.78.34.175])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 9BA1F4E;
        Wed,  5 Dec 2018 02:22:34 +0000 (UTC)
From:   Jerry Hoemann <jerry.hoemann@hpe.com>
To:     linux@roeck-us.net
Cc:     wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH 1/1] watchdog/hpwdt: Do not claim unsupported hardware
Date:   Tue,  4 Dec 2018 19:22:18 -0700
Message-Id: <1543976538-75532-1-git-send-email-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not claim when SSID 0x0289 as the watchdog features
are not enabled/validated by the firmware.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 9356230..b99ef0a4 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -281,6 +281,17 @@ static int hpwdt_init_one(struct pci_dev *dev,
 	    dev->subsystem_device == 0x1979)
 		return -ENODEV;
 
+	/*
+	 * Ignore unsupported hardware
+	 */
+	if (dev->vendor == PCI_VENDOR_ID_HP &&
+	    dev->device == 0x3306 &&
+	    dev->subsystem_vendor == PCI_VENDOR_ID_HP_3PAR &&
+	    dev->subsystem_device == 0x0289) {
+		dev_info(&dev->dev, "Not supported on this platform\n");
+		return -ENODEV;
+	}
+
 	if (pci_enable_device(dev)) {
 		dev_warn(&dev->dev,
 			"Not possible to enable PCI Device: 0x%x:0x%x.\n",
-- 
1.8.3.1

