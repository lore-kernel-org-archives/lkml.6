Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753566AbeDIVTh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 17:19:37 -0400
Received: from mga11.intel.com ([192.55.52.93]:39476 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753100AbeDIVTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 17:19:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,429,1517904000";
   d="scan'208";a="42001515"
Subject: [PATCH] libnvdimm, of_pmem: workaround OF_NUMA=n build error
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: Rob Herring <robh@kernel.org>, "Oliver O'Halloran" <oohall@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date: Mon, 09 Apr 2018 14:09:38 -0700
Message-ID: <152330817871.32685.18143005199739186530.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen reports that an x86 allmodconfig build fails to build the
of_pmem driver due to a missing definition of of_node_to_nid(). That
helper is currently only exported in the OF_NUMA=y case. In other cases,
ppc and sparc, it is a weak symbol, and outside of those platforms it is
a static inline.

Until an OF_NUMA=n configuration can reliably support usage of
of_node_to_nid() in modules across architectures, mark this driver as
'bool' instead of 'tristate'.

Cc: Rob Herring <robh@kernel.org>
Cc: Oliver O'Halloran <oohall@gmail.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/Kconfig |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvdimm/Kconfig b/drivers/nvdimm/Kconfig
index 2d6862bf7436..f6c533c4d09b 100644
--- a/drivers/nvdimm/Kconfig
+++ b/drivers/nvdimm/Kconfig
@@ -103,7 +103,8 @@ config NVDIMM_DAX
 	  Select Y if unsure
 
 config OF_PMEM
-	tristate "Device-tree support for persistent memory regions"
+	# FIXME: make tristate once OF_NUMA dependency removed
+	bool "Device-tree support for persistent memory regions"
 	depends on OF
 	default LIBNVDIMM
 	help
