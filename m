Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE7CC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1387E2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 08:03:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1387E2088E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbeGYJNr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 05:13:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:47126 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728505AbeGYJNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 05:13:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 25 Jul 2018 01:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,400,1526367600"; 
   d="scan'208";a="218915350"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 25 Jul 2018 01:03:13 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 4AC5B149; Wed, 25 Jul 2018 11:03:22 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] thunderbolt: Use 64-bit DMA mask if supported by the platform
Date:   Wed, 25 Jul 2018 11:03:16 +0300
Message-Id: <20180725080321.35746-3-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180725080321.35746-1-mika.westerberg@linux.intel.com>
References: <20180725080321.35746-1-mika.westerberg@linux.intel.com>
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
2.18.0

