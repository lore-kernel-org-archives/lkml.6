Return-Path: <SRS0=VkHl=QP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3F90C169C4
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E2772192C
	for <linux-kernel@archiver.kernel.org>; Fri,  8 Feb 2019 22:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1549663550;
	bh=3MW0a6RXwxhcNgHSR4Zm8xqwdBl/JKLL3CuGcZmfRww=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:List-ID:From;
	b=GQ95bzmRApMjRJ5hTDvJDCtcx5DwFWBUOhlkGkZHULKdc2Qw50MQUW7aQKIhrtP1s
	 SbBSYQDX0lJ9sRroDEQ4WEn7GECLmanVOXad2OWZWnzYkSpeTHtWGAmxShzsQIZHDg
	 52rNLQVjCZU/6SR0/pODTQOguCYsxBMnyBb4bIT0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfBHWFt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 8 Feb 2019 17:05:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:53898 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726020AbfBHWFs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Feb 2019 17:05:48 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9376F21924;
        Fri,  8 Feb 2019 22:05:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1549663547;
        bh=3MW0a6RXwxhcNgHSR4Zm8xqwdBl/JKLL3CuGcZmfRww=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=s5nXUvd/FIuG+Xcyb4MNjjcgfyR1YauEwqLuqfxGv/C9DFQ04Zp9o5GR9/M1RKSdH
         KjAwzwlcoawUx/MX7bcffl22BAi8Iqdgc3XNwhWZ9IH2UF/bNl/OogpgqT5sdRCEmz
         4R2Bz3JwZg/51YEuWgIx0ncbqlEYRc9URHffxUzs=
Subject: [PATCH v1 1/7] iommu: Use dev_printk() when possible
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Date:   Fri, 08 Feb 2019 16:05:45 -0600
Message-ID: <154966354568.132359.3728108083634257425.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <154966319813.132359.14641436497228395449.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: StGit/0.18
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

Use dev_printk() when possible so the IOMMU messages are more consistent
with other messages related to the device.

E.g., I think these messages related to surprise hotplug:

  pciehp 0000:80:10.0:pcie004: Slot(36): Link Down
  iommu: Removing device 0000:87:00.0 from group 12
  pciehp 0000:80:10.0:pcie004: Slot(36): Card present
  pcieport 0000:80:10.0: Data Link Layer Link Active not set in 1000 msec

would be easier to read as these (also requires some PCI changes not
included here):

  pci 0000:80:10.0: Slot(36): Link Down
  pci 0000:87:00.0: Removing from iommu group 12
  pci 0000:80:10.0: Slot(36): Card present
  pci 0000:80:10.0: Data Link Layer Link Active not set in 1000 msec

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/iommu/iommu.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
index 3ed4db334341..54c9d18fe31d 100644
--- a/drivers/iommu/iommu.c
+++ b/drivers/iommu/iommu.c
@@ -668,7 +668,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 
 	trace_add_device_to_group(group->id, dev);
 
-	pr_info("Adding device %s to group %d\n", dev_name(dev), group->id);
+	dev_info(dev, "Adding to iommu group %d\n", group->id);
 
 	return 0;
 
@@ -684,7 +684,7 @@ int iommu_group_add_device(struct iommu_group *group, struct device *dev)
 	sysfs_remove_link(&dev->kobj, "iommu_group");
 err_free_device:
 	kfree(device);
-	pr_err("Failed to add device %s to group %d: %d\n", dev_name(dev), group->id, ret);
+	dev_err(dev, "Failed to add to iommu group %d: %d\n", group->id, ret);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(iommu_group_add_device);
@@ -701,7 +701,7 @@ void iommu_group_remove_device(struct device *dev)
 	struct iommu_group *group = dev->iommu_group;
 	struct group_device *tmp_device, *device = NULL;
 
-	pr_info("Removing device %s from group %d\n", dev_name(dev), group->id);
+	dev_info(dev, "Removing from iommu group %d\n", group->id);
 
 	/* Pre-notify listeners that a device is being removed. */
 	blocking_notifier_call_chain(&group->notifier,
@@ -1951,7 +1951,7 @@ int iommu_request_dm_for_dev(struct device *dev)
 		iommu_domain_free(group->default_domain);
 	group->default_domain = dm_domain;
 
-	pr_info("Using direct mapping for device %s\n", dev_name(dev));
+	dev_info(dev, "Using iommu direct mapping\n");
 
 	ret = 0;
 out:

