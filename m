Return-Path: <SRS0=pNWC=KQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B8A8C28CF6
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:30:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF6DF20840
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Aug 2018 18:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF6DF20840
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387766AbeHAURX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Aug 2018 16:17:23 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:46030 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404222AbeHATDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Aug 2018 15:03:36 -0400
Received: from localhost (D57E6652.static.ziggozakelijk.nl [213.126.102.82])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1B073FDA;
        Wed,  1 Aug 2018 16:58:59 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alex Gagniuc <mr.nuke.me@gmail.com>,
        Keith Busch <keith.busch@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: [PATCH 4.17 116/336] nvme-pci: Fix AER reset handling
Date:   Wed,  1 Aug 2018 18:47:31 +0200
Message-Id: <20180801165033.590716475@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180801165028.930831994@linuxfoundation.org>
References: <20180801165028.930831994@linuxfoundation.org>
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

[ Upstream commit 72cd4cc28e234ed7189ee508ed65ab60c80a97c8 ]

The nvme timeout handling doesn't do anything if the pci channel is
offline, which is the case when recovering from PCI error event, so it
was a bad idea to sync the controller reset in this state. This patch
flushes the reset work in the error_resume callback instead when the
channel is back to online. This keeps AER handling serialized and
can recover from timeouts.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=199757
Fixes: cc1d5e749a2e ("nvme/pci: Sync controller reset for AER slot_reset")
Reported-by: Alex Gagniuc <mr.nuke.me@gmail.com>
Tested-by: Alex Gagniuc <mr.nuke.me@gmail.com>
Signed-off-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/pci.c |   14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2679,19 +2679,15 @@ static pci_ers_result_t nvme_slot_reset(
 
 	dev_info(dev->ctrl.device, "restart after slot reset\n");
 	pci_restore_state(pdev);
-	nvme_reset_ctrl_sync(&dev->ctrl);
-
-	switch (dev->ctrl.state) {
-	case NVME_CTRL_LIVE:
-	case NVME_CTRL_ADMIN_ONLY:
-		return PCI_ERS_RESULT_RECOVERED;
-	default:
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
+	nvme_reset_ctrl(&dev->ctrl);
+	return PCI_ERS_RESULT_RECOVERED;
 }
 
 static void nvme_error_resume(struct pci_dev *pdev)
 {
+	struct nvme_dev *dev = pci_get_drvdata(pdev);
+
+	flush_work(&dev->ctrl.reset_work);
 	pci_cleanup_aer_uncorrect_error_status(pdev);
 }
 


