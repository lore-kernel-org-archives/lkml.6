Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbeEDAQq (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 20:16:46 -0400
Received: from mga01.intel.com ([192.55.52.88]:31676 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751632AbeEDAQo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 20:16:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,360,1520924400";
   d="scan'208";a="42944386"
Subject: [PATCH v3 8/9] pmem: switch to copy_to_iter_mcsafe()
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: hch@lst.de, linux-kernel@vger.kernel.org, tony.luck@intel.com,
        linux-fsdevel@vger.kernel.org
Date: Thu, 03 May 2018 17:06:47 -0700
Message-ID: <152539240757.31796.14176557943876214824.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <152539236455.31796.7516599166555186700.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <152539236455.31796.7516599166555186700.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the machine check safe version of copy_to_iter() for the
->copy_to_iter() operation published by the pmem driver.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/pmem.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 1b8ab48365de..6d3da8c92868 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -267,7 +267,7 @@ static size_t pmem_copy_from_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 static size_t pmem_copy_to_iter(struct dax_device *dax_dev, pgoff_t pgoff,
 		void *addr, size_t bytes, struct iov_iter *i)
 {
-	return copy_to_iter(addr, bytes, i);
+	return copy_to_iter_mcsafe(addr, bytes, i);
 }
 
 static const struct dax_operations pmem_dax_ops = {
