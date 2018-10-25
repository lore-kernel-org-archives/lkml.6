Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF765C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3DA820856
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 14:14:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="yRzyUmQR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3DA820856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728711AbeJYWrw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Oct 2018 18:47:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:56020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbeJYWru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Oct 2018 18:47:50 -0400
Received: from sasha-vm.mshome.net (unknown [167.98.65.38])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 79BA420848;
        Thu, 25 Oct 2018 14:14:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540476893;
        bh=6GpEUGniTVgQUgJO05aajOgzwCK2FLXSUF4agkzUCPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yRzyUmQRrQG190pL0jVxLsfhVlxOhB1XW5ooNhWlWVlDlUp9xhtie9VxAnobDU2L7
         zgdM4c6j6cm6l42pMmJzQJ3XHMBnP/HNkqjGlxiv0FEgKJNWGwYqKe1xbDxSsjZ6gG
         JD/QGAT9r6VAdczX4dQnDMvbbjXiHIajk4VOz8uA=
From:   Sasha Levin <sashal@kernel.org>
To:     stable@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.9 18/98] nvme-pci: fix CMB sysfs file removal in reset path
Date:   Thu, 25 Oct 2018 10:13:03 -0400
Message-Id: <20181025141423.213774-18-sashal@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181025141423.213774-1-sashal@kernel.org>
References: <20181025141423.213774-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Gurtovoy <maxg@mellanox.com>

[ Upstream commit 1c78f7735b2bdd0afbe5d14c5c8b6d8d381b6f13 ]

Currently we create the sysfs entry even if we fail mapping
it. In that case, the unmapping will not remove the sysfs created
file. There is no good reason to create a sysfs entry for a non
working CMB and show his characteristics.

Fixes: f63572dff ("nvme: unmap CMB and remove sysfs file in reset path")
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
Reviewed-by: Stephen Bates <sbates@raithlin.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index fadf151ce830..1ac4cec5f4f7 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1393,11 +1393,9 @@ static inline void nvme_release_cmb(struct nvme_dev *dev)
 	if (dev->cmb) {
 		iounmap(dev->cmb);
 		dev->cmb = NULL;
-		if (dev->cmbsz) {
-			sysfs_remove_file_from_group(&dev->ctrl.device->kobj,
-						     &dev_attr_cmb.attr, NULL);
-			dev->cmbsz = 0;
-		}
+		sysfs_remove_file_from_group(&dev->ctrl.device->kobj,
+					     &dev_attr_cmb.attr, NULL);
+		dev->cmbsz = 0;
 	}
 }
 
@@ -1632,16 +1630,14 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	/*
 	 * CMBs can currently only exist on >=1.2 PCIe devices. We only
-	 * populate sysfs if a CMB is implemented. Note that we add the
-	 * CMB attribute to the nvme_ctrl kobj which removes the need to remove
-	 * it on exit. Since nvme_dev_attrs_group has no name we can pass
-	 * NULL as final argument to sysfs_add_file_to_group.
+	 * populate sysfs if a CMB is implemented. Since nvme_dev_attrs_group
+	 * has no name we can pass NULL as final argument to
+	 * sysfs_add_file_to_group.
 	 */
 
 	if (readl(dev->bar + NVME_REG_VS) >= NVME_VS(1, 2, 0)) {
 		dev->cmb = nvme_map_cmb(dev);
-
-		if (dev->cmbsz) {
+		if (dev->cmb) {
 			if (sysfs_add_file_to_group(&dev->ctrl.device->kobj,
 						    &dev_attr_cmb.attr, NULL))
 				dev_warn(dev->dev,
-- 
2.17.1

