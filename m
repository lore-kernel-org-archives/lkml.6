Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753403AbeBJAig (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 19:38:36 -0500
Received: from mga09.intel.com ([134.134.136.24]:49515 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753300AbeBJAid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 19:38:33 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,486,1511856000";
   d="scan'208";a="173307909"
Subject: [PATCH v2 2/2] device-dax: implement ->pagesize() for smaps to
 report MMUPageSize
From: Dave Jiang <dave.jiang@intel.com>
To: akpm@linux-foundation.org
Cc: Jane Chu <jane.chu@oracle.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, mhocko@kernel.org, linux-mm@kvack.org,
        dan.j.williams@intel.com
Date: Fri, 09 Feb 2018 17:38:32 -0700
Message-ID: <151822311257.52376.12067958018820885784.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <151822289999.52376.4998780583577188804.stgit@djiang5-desk3.ch.intel.com>
References: <151822289999.52376.4998780583577188804.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Given that device-dax is making similar page mapping size guarantees as
hugetlbfs, emit the size in smaps and any other kernel path that
requests the mapping size of a vma.

Reported-by: Jane Chu <jane.chu@oracle.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/dax/device.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/dax/device.c b/drivers/dax/device.c
index 7b0bf825c4e7..b57cd5a7b0bd 100644
--- a/drivers/dax/device.c
+++ b/drivers/dax/device.c
@@ -439,10 +439,20 @@ static int dev_dax_split(struct vm_area_struct *vma, unsigned long addr)
 	return 0;
 }
 
+static unsigned long dev_dax_pagesize(struct vm_area_struct *vma)
+{
+	struct file *filp = vma->vm_file;
+	struct dev_dax *dev_dax = filp->private_data;
+	struct dax_region *dax_region = dev_dax->region;
+
+	return dax_region->align;
+}
+
 static const struct vm_operations_struct dax_vm_ops = {
 	.fault = dev_dax_fault,
 	.huge_fault = dev_dax_huge_fault,
 	.split = dev_dax_split,
+	.pagesize = dev_dax_pagesize,
 };
 
 static int dax_mmap(struct file *filp, struct vm_area_struct *vma)
