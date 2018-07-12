Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2577ECDFAA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FBA2087C
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Jul 2018 22:33:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51FBA2087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733308AbeGLWoq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Jul 2018 18:44:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732340AbeGLWop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jul 2018 18:44:45 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.24])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 582BDC04AC45;
        Thu, 12 Jul 2018 22:33:08 +0000 (UTC)
Received: from gimli.home (ovpn-116-29.phx2.redhat.com [10.3.116.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DB580308BDAE;
        Thu, 12 Jul 2018 22:33:04 +0000 (UTC)
Subject: [PATCH] vfio-pci: Disable binding to PFs with SR-IOV enabled
From:   Alex Williamson <alex.williamson@redhat.com>
To:     alex.williamson@redhat.com
Cc:     kvm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, david@gibson.dropbear.id.au
Date:   Thu, 12 Jul 2018 16:33:04 -0600
Message-ID: <20180712223243.9593.24855.stgit@gimli.home>
User-Agent: StGit/0.18-102-gdf9f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.24
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Thu, 12 Jul 2018 22:33:08 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We expect to receive PFs with SR-IOV disabled, however some host
drivers leave SR-IOV enabled at unbind.  This puts us in a state where
we can potentially assign both the PF and the VF, leading to both
functionality as well as security concerns due to lack of managing the
SR-IOV state as well as vendor dependent isolation from the PF to VF.
If we were to attempt to actively disable SR-IOV on driver probe, we
risk VF bound drivers blocking, potentially risking live lock
scenarios.  Therefore simply refuse to bind to PFs with SR-IOV enabled
with a warning message indicating the issue.  Users can resolve this
by re-binding to the host driver and disabling SR-IOV before
attempting to use the device with vfio-pci.

Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 drivers/vfio/pci/vfio_pci.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/vfio/pci/vfio_pci.c b/drivers/vfio/pci/vfio_pci.c
index b423a309a6e0..f372f209c5c2 100644
--- a/drivers/vfio/pci/vfio_pci.c
+++ b/drivers/vfio/pci/vfio_pci.c
@@ -1189,6 +1189,19 @@ static int vfio_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (pdev->hdr_type != PCI_HEADER_TYPE_NORMAL)
 		return -EINVAL;
 
+	/*
+	 * Prevent binding to PFs with VFs enabled, this too easily allows
+	 * userspace instance with VFs and PFs from the same device, which
+	 * cannot work.  Disabling SR-IOV here would initiate removing the
+	 * VFs, which would unbind the driver, which is prone to blocking
+	 * if that VF is also in use by vfio-pci.  Just reject these PFs
+	 * and let the user sort it out.
+	 */
+	if (pci_num_vf(pdev)) {
+		pci_warn(pdev, "Cannot bind to PF with SR-IOV enabled\n");
+		return -EBUSY;
+	}
+
 	group = vfio_iommu_group_get(&pdev->dev);
 	if (!group)
 		return -EINVAL;

