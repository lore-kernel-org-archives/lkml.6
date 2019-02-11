Return-Path: <SRS0=Yeso=QS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB44C169C4
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:10:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C220222A7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 Feb 2019 15:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549897851;
	bh=z6kU14J5OZBw9v07wVZj1U4EFp+ZC6k8AP9GcYtvqBk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=rnGVczBmV3NVIXqt0i+WQlwopM1rq+T3AYzHi+qjCTdD1wgsSD48jPbZwE5VKm62Q
	 +hwUETTtOGtxgLX/E0aPLXljivrcyHx6qf44UXlg3MeuxnOXl759PceIG3vw+zRfD7
	 WunS/EL0H03YtRs6aVyER6hBu75Q7iMIaG5JaBqk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403870AbfBKPKu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 Feb 2019 10:10:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:60862 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403982AbfBKPKr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Feb 2019 10:10:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A859222B0;
        Mon, 11 Feb 2019 15:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549897846;
        bh=z6kU14J5OZBw9v07wVZj1U4EFp+ZC6k8AP9GcYtvqBk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L/aG+TB7ZBtIwdIvhImJgzfTqZIN6t92jkk6zHqKUnQpKy9fu7VxRTJGxrEFpb9eU
         cjDbFbmY8jkYuLKeyiROUT9bf+AKI2tSrdWNIYjcfmEGHBlKkSbbPOEhwyFSdi/Y8+
         0W9Iy0vUE6l5k2vrS+wYiZ3e2OfDyRyYVoWpSy3c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Scott Bauer <scott.bauer@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Keith Busch <keith.busch@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>
Subject: [PATCH 4.9 135/137] PCI: vmd: Free up IRQs on suspend path
Date:   Mon, 11 Feb 2019 15:20:16 +0100
Message-Id: <20190211141824.652182230@linuxfoundation.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190211141811.964925535@linuxfoundation.org>
References: <20190211141811.964925535@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Scott Bauer <scott.bauer@intel.com>

commit e2b1820bd5d0962d6f271b0d47c3a0e38647df2f upstream.

Free up the IRQs we request on the suspend path and reallocate them on the
resume path.

Fixes this error:

  CPU 111 disable failed: CPU has 9 vectors assigned and there are only 0 available.
  Error taking CPU111 down: -34
  Non-boot CPUs are not disabled
  Enabling non-boot CPUs ...

Signed-off-by: Scott Bauer <scott.bauer@intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Acked-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
Signed-off-by: Sushma Kalakota <sushmax.kalakota@intel.com>

---
 drivers/pci/host/vmd.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/drivers/pci/host/vmd.c
+++ b/drivers/pci/host/vmd.c
@@ -731,6 +731,11 @@ static void vmd_remove(struct pci_dev *d
 static int vmd_suspend(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct vmd_dev *vmd = pci_get_drvdata(pdev);
+	int i;
+
+	for (i = 0; i < vmd->msix_count; i++)
+                devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
 
 	pci_save_state(pdev);
 	return 0;
@@ -739,6 +744,16 @@ static int vmd_suspend(struct device *de
 static int vmd_resume(struct device *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct vmd_dev *vmd = pci_get_drvdata(pdev);
+	int err, i;
+
+	for (i = 0; i < vmd->msix_count; i++) {
+		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
+				       vmd_irq, IRQF_NO_THREAD,
+				       "vmd", &vmd->irqs[i]);
+		if (err)
+			return err;
+	}
 
 	pci_restore_state(pdev);
 	return 0;


