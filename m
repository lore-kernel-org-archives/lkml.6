Return-Path: <SRS0=QM4b=KB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9818FECDFB1
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:06:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5A5B52077B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Jul 2018 20:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5B52077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730600AbeGQUkW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Jul 2018 16:40:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:3191 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbeGQUkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jul 2018 16:40:22 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 13:06:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,366,1526367600"; 
   d="scan'208";a="57249539"
Received: from spandruv-desk.jf.intel.com ([10.54.75.31])
  by orsmga007.jf.intel.com with ESMTP; 17 Jul 2018 13:06:03 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     jikos@kernel.org
Cc:     benjamin.tissoires@redhat.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] HID: intel-ish-hid: Prevent loading of driver on Mehlow
Date:   Tue, 17 Jul 2018 13:05:57 -0700
Message-Id: <20180717200557.39925-1-srinivas.pandruvada@linux.intel.com>
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
This is not a change for 4.18-rc.

 drivers/hid/intel-ish-hid/ipc/pci-ish.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/hid/intel-ish-hid/ipc/pci-ish.c b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
index a2c53ea3b5ed..d6e7156c36d9 100644
--- a/drivers/hid/intel-ish-hid/ipc/pci-ish.c
+++ b/drivers/hid/intel-ish-hid/ipc/pci-ish.c
@@ -95,6 +95,26 @@ static int ish_init(struct ishtp_device *dev)
 	return 0;
 }
 
+
+static bool ish_invalid_firmware(void)
+{
+	struct pci_dev *pdev;
+
+	pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0xA309, NULL);
+	if (pdev) {
+		pci_dev_put(pdev);
+		return true;
+	}
+
+	pdev = pci_get_device(PCI_VENDOR_ID_INTEL, 0xA30A, NULL);
+	if (pdev) {
+		pci_dev_put(pdev);
+		return true;
+	}
+
+	return false;
+}
+
 /**
  * ish_probe() - PCI driver probe callback
  * @pdev:	pci device
@@ -110,6 +130,9 @@ static int ish_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	struct ish_hw *hw;
 	int	ret;
 
+	if (ish_invalid_firmware())
+		return -ENODEV;
+
 	/* enable pci dev */
 	ret = pci_enable_device(pdev);
 	if (ret) {
-- 
2.17.1

