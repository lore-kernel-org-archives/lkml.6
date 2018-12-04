Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E377C07E85
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00D562082B
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 17:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00D562082B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbeLDR0a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Dec 2018 12:26:30 -0500
Received: from 8bytes.org ([81.169.241.247]:51554 "EHLO theia.8bytes.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726226AbeLDR00 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Dec 2018 12:26:26 -0500
Received: by theia.8bytes.org (Postfix, from userid 1000)
        id D63FC239; Tue,  4 Dec 2018 18:26:23 +0100 (CET)
From:   Joerg Roedel <joro@8bytes.org>
To:     iommu@lists.linux-foundation.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Subject: [PATCH 1/5] driver core: Introduce device_iommu_mapped() function
Date:   Tue,  4 Dec 2018 18:25:00 +0100
Message-Id: <20181204172504.19708-2-joro@8bytes.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204172504.19708-1-joro@8bytes.org>
References: <20181204172504.19708-1-joro@8bytes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joerg Roedel <jroedel@suse.de>

Some places in the kernel check the iommu_group pointer in
'struct device' in order to find ot whether a device is
mapped by an IOMMU.

This is not good way to make this check, as the pointer will
be moved to 'struct dev_iommu_data'. This way to make the
check is also not very readable.

Introduce an explicit function to perform this check.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 include/linux/device.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/linux/device.h b/include/linux/device.h
index 1b25c7a43f4c..6cb4640b6160 100644
--- a/include/linux/device.h
+++ b/include/linux/device.h
@@ -1058,6 +1058,16 @@ static inline struct device *kobj_to_dev(struct kobject *kobj)
 	return container_of(kobj, struct device, kobj);
 }
 
+/**
+ * device_iommu_mapped - Returns true when the device DMA is translated
+ *			 by an IOMMU
+ * @dev: Device to perform the check on
+ */
+static inline bool device_iommu_mapped(struct device *dev)
+{
+	return (dev->iommu_group != NULL);
+}
+
 /* Get the wakeup routines, which depend on struct device */
 #include <linux/pm_wakeup.h>
 
-- 
2.17.1

