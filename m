Return-Path: <SRS0=DzqL=JK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B52B9C43144
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:45:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BC2C24CFE
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Jun 2018 15:45:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BC2C24CFE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933189AbeFXPpL (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Jun 2018 11:45:11 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:60264 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932719AbeFXPpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jun 2018 11:45:08 -0400
Received: from localhost (li1825-44.members.linode.com [172.104.248.44])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4480F49F;
        Sun, 24 Jun 2018 15:45:06 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Gagniuc <mr.nuke.me@gmail.com>,
        Sinan Kaya <okaya@codeaurora.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Christoph Hellwig <hch@lst.de>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Keith Busch <keith.busch@intel.com>
Subject: [PATCH 4.17 49/70] nvme/pci: Sync controller reset for AER slot_reset
Date:   Sun, 24 Jun 2018 23:22:41 +0800
Message-Id: <20180624142743.519673826@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180624142740.481662434@linuxfoundation.org>
References: <20180624142740.481662434@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Keith Busch <keith.busch@intel.com>

commit cc1d5e749a2e1cf59fa940b976181e631d6985e1 upstream.

AER handling expects a successful return from slot_reset means the
driver made the device functional again. The nvme driver had been using
an asynchronous reset to recover the device, so the device
may still be initializing after control is returned to the
AER handler. This creates problems for subsequent event handling,
causing the initializion to fail.

This patch fixes that by syncing the controller reset before returning
to the AER driver, and reporting the true state of the reset.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199657
Reported-by: Alex Gagniuc <mr.nuke.me@gmail.com>
Cc: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: stable@vger.kernel.org
Tested-by: Alex Gagniuc <mr.nuke.me@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 drivers/nvme/host/pci.c |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2679,8 +2679,15 @@ static pci_ers_result_t nvme_slot_reset(
 
 	dev_info(dev->ctrl.device, "restart after slot reset\n");
 	pci_restore_state(pdev);
-	nvme_reset_ctrl(&dev->ctrl);
-	return PCI_ERS_RESULT_RECOVERED;
+	nvme_reset_ctrl_sync(&dev->ctrl);
+
+	switch (dev->ctrl.state) {
+	case NVME_CTRL_LIVE:
+	case NVME_CTRL_ADMIN_ONLY:
+		return PCI_ERS_RESULT_RECOVERED;
+	default:
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
 }
 
 static void nvme_error_resume(struct pci_dev *pdev)


