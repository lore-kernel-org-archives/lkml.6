Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 616E5C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 05:11:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12633208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 05:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12633208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726434AbeHQIN3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 04:13:29 -0400
Received: from gate.crashing.org ([63.228.1.57]:57649 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeHQIN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 04:13:29 -0400
Received: from pasglop.ozlabs.ibm.com (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w7H4nAsF017258;
        Thu, 16 Aug 2018 23:49:22 -0500
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc:     Hari Vyas <hari.vyas@broadcom.com>, Ray Jui <ray.jui@broadcom.com>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jens Axboe <axboe@kernel.dk>, Lukas Wunner <lukas@wunner.de>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Marta Rybczynska <mrybczyn@kalray.eu>,
        Pierre-Yves Kerbrat <pkerbrat@kalray.eu>,
        linux-kernel@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [RFC PATCH 2/6] pci: Set pci_dev->is_added before calling device_add
Date:   Fri, 17 Aug 2018 14:48:58 +1000
Message-Id: <20180817044902.31420-3-benh@kernel.crashing.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180817044902.31420-1-benh@kernel.crashing.org>
References: <20180817044902.31420-1-benh@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This re-fixes the bug reported by Hari Vyas <hari.vyas@broadcom.com>
after my revert of his commit but in a much simpler way.

The main issues is that is_added was being set after the driver
got bound and started, and thus setting it could race with other
changes to struct pci_dev.

This fixes it by setting the flag first, which also has the
advantage of matching the fact that we are clearing it *after*
unbinding in the remove path, thus the flag is now symtetric
and always set while the driver code is running.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 drivers/pci/bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 35b7fc87eac5..48ae63673aa8 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -321,16 +321,16 @@ void pci_bus_add_device(struct pci_dev *dev)
 	pci_proc_attach_device(dev);
 	pci_bridge_d3_update(dev);
 
+	dev->is_added = 1;
 	dev->match_driver = true;
 	retval = device_attach(&dev->dev);
 	if (retval < 0 && retval != -EPROBE_DEFER) {
+		dev->is_added = 0;
 		pci_warn(dev, "device attach failed (%d)\n", retval);
 		pci_proc_detach_device(dev);
 		pci_remove_sysfs_dev_files(dev);
 		return;
 	}
-
-	dev->is_added = 1;
 }
 EXPORT_SYMBOL_GPL(pci_bus_add_device);
 
-- 
2.17.1

