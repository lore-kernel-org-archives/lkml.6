Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC76ECDFBB
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:32:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B7782075C
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Jul 2018 19:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B7782075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730302AbeGRULW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Jul 2018 16:11:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:48066 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728929AbeGRULW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jul 2018 16:11:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Jul 2018 12:32:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,371,1526367600"; 
   d="scan'208";a="75876468"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga002.jf.intel.com with ESMTP; 18 Jul 2018 12:32:02 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH v2] HID: intel-ish-hid: Prevent loading of driver on Mehlow
Date:   Wed, 18 Jul 2018 12:32:00 -0700
Message-Id: <20180718193200.17944-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mehlow Xeon-E workstation, ISH PCI device is enabled but without ISH
firmware. Here the ISH device PCI device id was reused for some non Linux
storage drivers. So this was not done for enabling ISH. But this has a
undesirable side effect for Linux.

Here the ISH driver will be loaded via PCI enumeration and will try to do
reset sequence. But reset sequence will wait till timeout as there is no
real ISH firmware is present to take action. This delay will add to boot
time of Linux (This platform will still continue to boot after this
timeout).

To avoid this boot delay we need to prevent loading of ISH drivers on
this platform. So we need to have hack to avoid treating this device as
ISH on this platform. To identify this workstation, we need some runtime
method. Luckily there are special PCI id on this workstation to
distinguish from the client version of this platform. On client version,
the ISH is supported using same PCI device id. So this change look for
the presence of PCI device IDs A309 and A30A and exit.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
v2
 Replaced pci_get_device with pci_dev_present to check in a loop as
suggested by Benjamin.

 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index a2c53ea3b5ed..4a55eab39b88 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -95,6 +95,13 @@ static int ish_init(struct ishtp_device *dev)
 	return 0;
 }
 
+static const struct pci_device_id ish_invalid_pci_ids[] = {
+	/* Mehlow platform special pci ids */
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xA309)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0xA30A)},
+	{}
+};
+
 /**
  * ish_probe() - PCI driver probe callback
  * @pdev:	pci device
@@ -110,6 +117,10 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct ish_hw *hw;
 	int	ret;
 
+	/* Check for invalid platforms for ISH support */
+	if (pci_dev_present(ish_invalid_pci_ids))
+		return -ENODEV;
+
 	/* enable pci dev */
 	ret = pci_enable_device(pdev);
 	if (ret) {
-- 
2.17.1

