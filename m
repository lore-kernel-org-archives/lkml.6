Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752249AbeDGPAz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 7 Apr 2018 11:00:55 -0400
Received: from mga01.intel.com ([192.55.52.88]:14732 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751895AbeDGPAx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Apr 2018 11:00:53 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,419,1517904000";
   d="scan'208";a="31487258"
Subject: [PATCH] libnvdimm, region: quiet region probe
From: Dan Williams <dan.j.williams@intel.com>
To: linux-nvdimm@lists.01.org
Cc: linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sat, 07 Apr 2018 07:50:57 -0700
Message-ID: <152311265738.13507.13982862389654638905.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-2-gc94f
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The message about constraining number of online cpus to be less than or
equal to ND_MAX_LANES (256) is only useful for block-aperture
configurations and BTT. Make it debug since its only relevant when
debugging performance.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/nvdimm/region.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvdimm/region.c b/drivers/nvdimm/region.c
index 034f0a07d627..b9ca0033cc99 100644
--- a/drivers/nvdimm/region.c
+++ b/drivers/nvdimm/region.c
@@ -27,10 +27,10 @@ static int nd_region_probe(struct device *dev)
 	if (nd_region->num_lanes > num_online_cpus()
 			&& nd_region->num_lanes < num_possible_cpus()
 			&& !test_and_set_bit(0, &once)) {
-		dev_info(dev, "online cpus (%d) < concurrent i/o lanes (%d) < possible cpus (%d)\n",
+		dev_dbg(dev, "online cpus (%d) < concurrent i/o lanes (%d) < possible cpus (%d)\n",
 				num_online_cpus(), nd_region->num_lanes,
 				num_possible_cpus());
-		dev_info(dev, "setting nr_cpus=%d may yield better libnvdimm device performance\n",
+		dev_dbg(dev, "setting nr_cpus=%d may yield better libnvdimm device performance\n",
 				nd_region->num_lanes);
 	}
 
