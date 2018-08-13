Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DATE_IN_FUTURE_03_06,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DF9C46464
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:24:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17A9F217B9
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 03:24:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A9F217B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728127AbeHMGE0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 02:04:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:52940 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbeHMGE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 02:04:26 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 12 Aug 2018 20:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,231,1531810800"; 
   d="scan'208";a="74856396"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga003.jf.intel.com with ESMTP; 12 Aug 2018 20:24:09 -0700
Received: from dazhang1-ssd.sh.intel.com (dazhang1-ssd.sh.intel.com [10.239.48.78])
        by linux.intel.com (Postfix) with ESMTP id D776258019B;
        Sun, 12 Aug 2018 20:24:07 -0700 (PDT)
From:   Zhang Yi <yi.z.zhang@linux.intel.com>
To:     linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        dan.j.williams@intel.com, jack@suse.cz, zwisler@kernel.org,
        dave.jiang@intel.com, yu.c.zhang@intel.com
Cc:     yi.z.zhang@intel.com, Zhang Yi <yi.z.zhang@linux.intel.com>
Subject: [PATCH V2 1/1] device-dax: check for vma range while dax_mmap.
Date:   Mon, 13 Aug 2018 20:02:56 +0800
Message-Id: <46441800c43f029757c70d8386e3112701081503.1534160958.git.yi.z.zhang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch prevents a user mapping an illegal vma range that is larger
than a dax device physical resource.

When qemu maps the dax device for virtual nvdimm's backend device, the
v-nvdimm label area is defined at the end of mapped range. By using an
illegal size that exceeds the range of the device dax, it will trigger a
fault with qemu.

Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
---
 drivers/dax/device.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 108c37f..6fe8c30 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -177,6 +177,33 @@ static const struct attribute_group *dax_attribute_groups[] = {
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
+			dev_info_ratelimited(dev,
+				"%s: %s: fail, vma range overflow\n",
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
@@ -469,6 +496,8 @@ static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
 	 */
 	id = dax_read_lock();
 	rc = check_vma(dev_dax, vma, __func__);
+	if (!rc)
+		rc = check_vma_range(dev_dax, vma, __func__);
 	dax_read_unlock(id);
 	if (rc)
 		return rc;
-- 
2.7.4

