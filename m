Return-Path: <SRS0=fmpj=NT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2499ECDE4B
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9612520844
	for <linux-kernel@archiver.kernel.org>; Thu,  8 Nov 2018 22:05:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="GbPwucoE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9612520844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731535AbeKIHmb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 02:42:31 -0500
Received: from mail.kernel.org ([198.145.29.99]:34350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730387AbeKIHma (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 02:42:30 -0500
Received: from localhost (unknown [208.72.13.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3AEB72133D;
        Thu,  8 Nov 2018 22:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541714700;
        bh=bnKe0QPt6/blWpVM3dp+ygigpm2qpX/fceBJR8utqZE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GbPwucoEfXUsp9pgStxqxej7EJpkPCTFbhvIYYgS3Ba+bTz2juhGtLU0XCkreIn1p
         gBHjKi23oujUkT3+Cc7rnU5S9ytLE87rMZK8gqd3vwwMpSTGH3xZVtAm4M5HUeHNQ9
         gWTVCwY4C8cHn+pyyV6ojoFExyIkDYeznaQtNC60=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Max Gurtovoy <maxg@mellanox.com>,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.9 049/171] nvme-pci: fix CMB sysfs file removal in reset path
Date:   Thu,  8 Nov 2018 13:50:19 -0800
Message-Id: <20181108215131.068100065@linuxfoundation.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20181108215127.257643509@linuxfoundation.org>
References: <20181108215127.257643509@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

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



