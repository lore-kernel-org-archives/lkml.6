Return-Path: <SRS0=Clcj=JE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FFAC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A31720852
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Jun 2018 11:08:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A31720852
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936007AbeFRLHe (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Jun 2018 07:07:34 -0400
Received: from mga14.intel.com ([192.55.52.115]:37633 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933504AbeFRLHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jun 2018 07:07:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jun 2018 04:07:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,238,1526367600"; 
   d="scan'208";a="47923184"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 18 Jun 2018 04:07:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 7DE66FA; Mon, 18 Jun 2018 14:07:31 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Christian Kellner <christian@kellner.me>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/5] thunderbolt: Use 64-bit DMA mask if supported by the platform
Date:   Mon, 18 Jun 2018 14:07:27 +0300
Message-Id: <20180618110731.57427-2-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
References: <20180618110731.57427-1-mika.westerberg@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PCI defaults to 32-bit DMA mask but this device is capable of full
64-bit addressing, so make sure we first try 64-bit DMA mask before
falling back to the default 32-bit.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/nhi.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index f5a33e88e676..e3b7695fe37e 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1015,6 +1015,14 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	spin_lock_init(&nhi->lock);
 
+	res = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (res)
+		res = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (res) {
+		dev_err(&pdev->dev, "failed to set DMA mask\n");
+		return res;
+	}
+
 	pci_set_master(pdev);
 
 	tb = icm_probe(nhi);
-- 
2.17.1

