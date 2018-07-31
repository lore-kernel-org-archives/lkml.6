Return-Path: <SRS0=SIc1=KP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=DATE_IN_FUTURE_06_12,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50F73C43142
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:07:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 125F620841
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Jul 2018 03:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 125F620841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727279AbeGaEpb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Jul 2018 00:45:31 -0400
Received: from mga05.intel.com ([192.55.52.43]:49219 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725853AbeGaEpb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jul 2018 00:45:31 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 30 Jul 2018 20:07:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,425,1526367600"; 
   d="scan'208";a="249749831"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jul 2018 20:07:29 -0700
Received: from dazhang1-ssd.sh.intel.com (dazhang1-ssd.sh.intel.com [10.239.48.78])
        by linux.intel.com (Postfix) with ESMTP id 6C787580335;
        Mon, 30 Jul 2018 20:07:27 -0700 (PDT)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, jack@suse.cz, zwisler@kernel.org,
        dave.jiang@intel.com, yu.c.zhang@intel.com
Cc:     yi.z.zhang@intel.com, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [RFC PATCH 1/1] device-dax: check for vma range while dax_mmap.
Date:   Tue, 31 Jul 2018 19:46:06 +0800
Message-Id: <e260d513ab831bfe1298374c87c6cca5f7dd3a6f.1533036772.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It should be prevent user map an illegal vma range which larger than
dax device phiscal resourse, as we don't have swap logic while page
faulting in dax device.

Applications, especailly qemu, map the /dev/dax for virtual nvdimm's
backend device, we defined the v-nvdimm label area at the end of mapped
rang. By using an illegal size that exceeds the physical resource of
/dev/dax, then it will triger qemu a signal fault while accessing these
label area.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 drivers/dax/device.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index aff2c15..c9a50cd 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -177,6 +177,32 @@ static const struct attribute_group *dax_attribute_groups[] = {
 	NULL,
 };
 
+static int check_vma_range(struct dev_dax *dev_dax, struct vm_area_struct *vma,
+		const char *func)
+{
+	struct device *dev = &dev_dax->dev;
+	struct resource *res;
+	unsigned long size;
+	int ret, i;
+
+	if (!dax_alive(dev_dax->dax_dev))
+		return -ENXIO;
+
+	size = vma->vm_end - vma->vm_start + (vma->vm_pgoff << PAGE_SHIFT);
+	ret = -EINVAL;
+	for (i = 0; i < dev_dax->num_resources; i++) {
+		res = &dev_dax->res[i];
+		if (size > resource_size(res)) {
+			dev_info(dev, "%s: %s: fail, vma range is overflow\n",
+				current->comm, func);
+			ret = -EINVAL;
+			continue;
+		} else
+			return 0;
+	}
+	return ret;
+}
+
 static int check_vma(struct dev_dax *dev_dax, struct vm_area_struct *vma,
 		const char *func)
 {
@@ -465,6 +491,8 @@ static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
 	 */
 	id = dax_read_lock();
 	rc = check_vma(dev_dax, vma, __func__);
+	if (!rc)
+		rc |= check_vma_range(dev_dax, vma, __func__);
 	dax_read_unlock(id);
 	if (rc)
 		return rc;
-- 
2.7.4

