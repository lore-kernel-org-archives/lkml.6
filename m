Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751974AbeBBUPO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:15:14 -0500
Received: from g9t1613g.houston.hpe.com ([15.241.32.99]:30672 "EHLO
        g9t1613g.houston.hpe.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeBBUPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:15:07 -0500
From: Toshi Kani <toshi.kani@hpe.com>
To: dan.j.williams@intel.com
Cc: rjw@rjwysocki.net, linux-nvdimm@lists.01.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Toshi Kani <toshi.kani@hpe.com>
Subject: [PATCH] acpi, nfit: fix register dimm error handling
Date: Fri,  2 Feb 2018 14:00:36 -0700
Message-Id: <20180202210036.3153-1-toshi.kani@hpe.com>
X-Mailer: git-send-email 2.14.3
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A NULL pointer reference kernel bug was observed when
acpi_nfit_add_dimm() called in acpi_nfit_register_dimms()
failed. This error path does not set nfit_mem->nvdimm, but
the 2nd list_for_each_entry() loop in the function assumes
it's always set. Add a check to nfit_mem->nvdimm.

Signed-off-by: Toshi Kani <toshi.kani@hpe.com>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/nfit/core.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
index abeb4df4f22e..b28ce440a06f 100644
--- a/drivers/acpi/nfit/core.c
+++ b/drivers/acpi/nfit/core.c
@@ -1867,6 +1867,9 @@ static int acpi_nfit_register_dimms(struct acpi_nfit_desc *acpi_desc)
 		struct kernfs_node *nfit_kernfs;
 
 		nvdimm = nfit_mem->nvdimm;
+		if (!nvdimm)
+			continue;
+
 		nfit_kernfs = sysfs_get_dirent(nvdimm_kobj(nvdimm)->sd, "nfit");
 		if (nfit_kernfs)
 			nfit_mem->flags_attr = sysfs_get_dirent(nfit_kernfs,
