Return-Path: <SRS0=ZHI1=L7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B6EDECE560
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D84214C2
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Sep 2018 15:01:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1D84214C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729239AbeIQU3g (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Sep 2018 16:29:36 -0400
Received: from smtprelay0029.hostedemail.com ([216.40.44.29]:34263 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728016AbeIQU3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Sep 2018 16:29:36 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 8CB67837F243;
        Mon, 17 Sep 2018 15:01:52 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: show31_4a0572cc3055d
X-Filterd-Recvd-Size: 2593
Received: from joe-laptop.perches.com (mb42736d0.tmodns.net [208.54.39.180])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 17 Sep 2018 15:01:48 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Sathya Prakash <sathya.prakash@broadcom.com>,
        Chaitra P B <chaitra.basappa@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Cc:     "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] mpt3sas: Convert logging uses with MPT3SAS_FMT and reply_q_name to %s:
Date:   Mon, 17 Sep 2018 08:01:11 -0700
Message-Id: <80a0b24fd5be85fcd87b92958691ab19484a4295.1537183088.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <cover.1537183087.git.joe@perches.com>
References: <cover.1537183087.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the existing 2 uses to make the format and arguments
matching more obvious.

Miscellanea:

o Move the word "enabled" into the format to trivially reduce object size
o Remove unnecessary parentheses

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/scsi/mpt3sas/mpt3sas_base.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/mpt3sas/mpt3sas_base.c b/drivers/scsi/mpt3sas/mpt3sas_base.c
index 5c6634b7ca74..386af6739867 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_base.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_base.c
@@ -2705,7 +2705,7 @@ _base_request_irq(struct MPT3SAS_ADAPTER *ioc, u8 index)
 	r = request_irq(pci_irq_vector(pdev, index), _base_interrupt,
 			IRQF_SHARED, reply_q->name, reply_q);
 	if (r) {
-		pr_err(MPT3SAS_FMT "unable to allocate interrupt %d!\n",
+		pr_err("%s: unable to allocate interrupt %d!\n",
 		       reply_q->name, pci_irq_vector(pdev, index));
 		kfree(reply_q);
 		return -EBUSY;
@@ -3034,10 +3034,10 @@ mpt3sas_base_map_resources(struct MPT3SAS_ADAPTER *ioc)
 	}
 
 	list_for_each_entry(reply_q, &ioc->reply_queue_list, list)
-		pr_info(MPT3SAS_FMT "%s: IRQ %d\n",
-		    reply_q->name,  ((ioc->msix_enable) ? "PCI-MSI-X enabled" :
-		    "IO-APIC enabled"),
-		    pci_irq_vector(ioc->pdev, reply_q->msix_index));
+		pr_info("%s: %s enabled: IRQ %d\n",
+			reply_q->name,
+			ioc->msix_enable ? "PCI-MSI-X" : "IO-APIC",
+			pci_irq_vector(ioc->pdev, reply_q->msix_index));
 
 	ioc_info(ioc, "iomem(%pap), mapped(0x%p), size(%d)\n",
 		 &chip_phys, ioc->chip, memap_sz);
-- 
2.15.0

