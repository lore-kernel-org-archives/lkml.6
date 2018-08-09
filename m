Return-Path: <SRS0=+sa6=KY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80A44C46460
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4649922392
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Aug 2018 20:04:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4649922392
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbeHIWa5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Aug 2018 18:30:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59972 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbeHIWa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Aug 2018 18:30:56 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id D3071308626E;
        Thu,  9 Aug 2018 20:04:33 +0000 (UTC)
Received: from gimli.home (ovpn-116-35.phx2.redhat.com [10.3.116.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 724AE45BF;
        Thu,  9 Aug 2018 20:04:31 +0000 (UTC)
Subject: [PATCH v4 3/3] PCI: Intel DC P3700 NVMe delay after FLR quirk
From:   Alex Williamson <alex.williamson@redhat.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Date:   Thu, 09 Aug 2018 14:04:31 -0600
Message-ID: <153384507110.15793.12191081187690448438.stgit@gimli.home>
In-Reply-To: <153384487209.15793.15203778129263981368.stgit@gimli.home>
References: <153384487209.15793.15203778129263981368.stgit@gimli.home>
User-Agent: StGit/0.18-136-gffd7-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.49]); Thu, 09 Aug 2018 20:04:33 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a device specific reset for Intel DC P3700 NVMe device which
exhibits a timeout failure in drivers waiting for the ready status to
update after NVMe enable if the driver interacts with the device too
quickly after FLR.  As this has been observed in device assignment
scenarios, resolve this with a device specific reset quirk to add an
additional, heuristically determined, delay after the FLR completes.

Link: https://bugzilla.redhat.com/show_bug.cgi?id=1592654
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/pci/quirks.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 0a4d802cb307..93791bd31a55 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3751,6 +3751,27 @@ static int nvme_disable_and_flr(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+/*
+ * Intel DC P3700 NVMe controller will timeout waiting for ready status
+ * to change after NVMe enable if the driver starts interacting with the
+ * device too quickly after FLR.  A 250ms delay after FLR has heuristically
+ * proven to produce reliably working results for device assignment cases.
+ */
+static int delay_250ms_after_flr(struct pci_dev *dev, int probe)
+{
+	if (!pcie_has_flr(dev))
+		return -ENOTTY;
+
+	if (probe)
+		return 0;
+
+	pcie_flr(dev);
+
+	msleep(250);
+
+	return 0;
+}
+
 static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82599_SFP_VF,
 		 reset_intel_82599_sfp_virtfn },
@@ -3759,6 +3780,7 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
 		reset_ivb_igd },
 	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },
+	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
 	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
 		reset_chelsio_generic_dev },
 	{ 0 }

