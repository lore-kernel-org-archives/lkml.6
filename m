Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031005AbeEZBKN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 21:10:13 -0400
Received: from mga05.intel.com ([192.55.52.43]:45524 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030816AbeEZBKM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 21:10:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,441,1520924400";
   d="scan'208";a="231934335"
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: rui.zhang@intel.com, edubezval@gmail.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH] thermal: int340x: Prevent error in reading trip hysteresis attribute
Date: Fri, 25 May 2018 18:10:10 -0700
Message-Id: <20180526011010.15915-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.9.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the INT340X devices may not have hysteresis defined in the ACPI
definition. In that case reading trip hysteresis results in error. This
spams logs of user space utilities.

In this case instead of returning error, just return hysteresis as 0,
which is correct as there is no hysteresis defined for the device.

Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
---
 drivers/thermal/int340x_thermal/int340x_thermal_zone.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
index 145a5c53ff5c..dfdf6dbc2ddc 100644
--- a/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
+++ b/drivers/thermal/int340x_thermal/int340x_thermal_zone.c
@@ -147,9 +147,9 @@ static int int340x_thermal_get_trip_hyst(struct thermal_zone_device *zone,
 
 	status = acpi_evaluate_integer(d->adev->handle, "GTSH", NULL, &hyst);
 	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	*temp = hyst * 100;
+		*temp = 0;
+	else
+		*temp = hyst * 100;
 
 	return 0;
 }
-- 
2.17.0
