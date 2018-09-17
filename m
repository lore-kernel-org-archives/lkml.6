Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 379A0ECE563
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:57:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48DB214AB
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 22:57:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48DB214AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbeIRE0n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 00:26:43 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46686 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726759AbeIRE0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 00:26:42 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id BD5FFCAF;
        Mon, 17 Sep 2018 22:57:10 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Anton Vasilyev <vasilyev@ispras.ru>,
        Adam Radford <aradford@gmail.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.9 40/70] scsi: 3ware: fix return 0 on the error path of probe
Date:   Tue, 18 Sep 2018 00:42:13 +0200
Message-Id: <20180917211652.461693904@linuxfoundation.org>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <20180917211649.099135838@linuxfoundation.org>
References: <20180917211649.099135838@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anton Vasilyev <vasilyev@ispras.ru>

[ Upstream commit 4dc98c1995482262e70e83ef029135247fafe0f2 ]

tw_probe() returns 0 in case of fail of tw_initialize_device_extension(),
pci_resource_start() or tw_reset_sequence() and releases resources.
twl_probe() returns 0 in case of fail of twl_initialize_device_extension(),
pci_iomap() and twl_reset_sequence().  twa_probe() returns 0 in case of
fail of tw_initialize_device_extension(), ioremap() and
twa_reset_sequence().

The patch adds retval initialization for these cases.

Found by Linux Driver Verification project (linuxtesting.org).

Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
Acked-by: Adam Radford <aradford@gmail.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/scsi/3w-9xxx.c |    6 +++++-
 drivers/scsi/3w-sas.c  |    3 +++
 drivers/scsi/3w-xxxx.c |    2 ++
 3 files changed, 10 insertions(+), 1 deletion(-)

--- a/drivers/scsi/3w-9xxx.c
+++ b/drivers/scsi/3w-9xxx.c
@@ -2045,6 +2045,7 @@ static int twa_probe(struct pci_dev *pde
 
 	if (twa_initialize_device_extension(tw_dev)) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x25, "Failed to initialize device extension");
+		retval = -ENOMEM;
 		goto out_free_device_extension;
 	}
 
@@ -2067,6 +2068,7 @@ static int twa_probe(struct pci_dev *pde
 	tw_dev->base_addr = ioremap(mem_addr, mem_len);
 	if (!tw_dev->base_addr) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x35, "Failed to ioremap");
+		retval = -ENOMEM;
 		goto out_release_mem_region;
 	}
 
@@ -2074,8 +2076,10 @@ static int twa_probe(struct pci_dev *pde
 	TW_DISABLE_INTERRUPTS(tw_dev);
 
 	/* Initialize the card */
-	if (twa_reset_sequence(tw_dev, 0))
+	if (twa_reset_sequence(tw_dev, 0)) {
+		retval = -ENOMEM;
 		goto out_iounmap;
+	}
 
 	/* Set host specific parameters */
 	if ((pdev->device == PCI_DEVICE_ID_3WARE_9650SE) ||
--- a/drivers/scsi/3w-sas.c
+++ b/drivers/scsi/3w-sas.c
@@ -1600,6 +1600,7 @@ static int twl_probe(struct pci_dev *pde
 
 	if (twl_initialize_device_extension(tw_dev)) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1a, "Failed to initialize device extension");
+		retval = -ENOMEM;
 		goto out_free_device_extension;
 	}
 
@@ -1614,6 +1615,7 @@ static int twl_probe(struct pci_dev *pde
 	tw_dev->base_addr = pci_iomap(pdev, 1, 0);
 	if (!tw_dev->base_addr) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1c, "Failed to ioremap");
+		retval = -ENOMEM;
 		goto out_release_mem_region;
 	}
 
@@ -1623,6 +1625,7 @@ static int twl_probe(struct pci_dev *pde
 	/* Initialize the card */
 	if (twl_reset_sequence(tw_dev, 0)) {
 		TW_PRINTK(tw_dev->host, TW_DRIVER, 0x1d, "Controller reset failed during probe");
+		retval = -ENOMEM;
 		goto out_iounmap;
 	}
 
--- a/drivers/scsi/3w-xxxx.c
+++ b/drivers/scsi/3w-xxxx.c
@@ -2281,6 +2281,7 @@ static int tw_probe(struct pci_dev *pdev
 
 	if (tw_initialize_device_extension(tw_dev)) {
 		printk(KERN_WARNING "3w-xxxx: Failed to initialize device extension.");
+		retval = -ENOMEM;
 		goto out_free_device_extension;
 	}
 
@@ -2295,6 +2296,7 @@ static int tw_probe(struct pci_dev *pdev
 	tw_dev->base_addr = pci_resource_start(pdev, 0);
 	if (!tw_dev->base_addr) {
 		printk(KERN_WARNING "3w-xxxx: Failed to get io address.");
+		retval = -ENOMEM;
 		goto out_release_mem_region;
 	}
 


