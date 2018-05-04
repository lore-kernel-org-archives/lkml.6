Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751704AbeEDID4 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 04:03:56 -0400
Received: from mga03.intel.com ([134.134.136.65]:41126 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbeEDIDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 04:03:55 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,361,1520924400";
   d="scan'208";a="38367378"
From: Chen Yu <yu.c.chen@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Rui Zhang <rui.zhang@intel.com>, linux-acpi@vger.kernel.org
Subject: [PATCH][RFC] ACPI: acpi_pad: Do not launch acpi_pad threads on idle cpus
Date: Fri,  4 May 2018 16:08:42 +0800
Message-Id: <1525421322-23431-1-git-send-email-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to current implementation of acpi_pad driver,
it does not make sense to spawn any power saving threads
on the cpus which are already idle - it might bring
unnecessary overhead on these idle cpus and causes power
waste. So verify the condition that if the number of 'busy'
cpus exceeds the amount of the 'forced idle' cpus - This is
applicable due to round-robin attribute of the power saving
threads, otherwise ignore the setting/ACPI notification.

Suggested-by: Lenny Szubowicz <lszubowi@redhat.com>
Suggested-by: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Rui Zhang <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/acpi_pad.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 552c1f7..190aa36 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -253,13 +253,36 @@ static void set_power_saving_task_num(unsigned int num)
 			destroy_power_saving_task();
 	}
 }
+/*
+ * Extra acpi_pad threads should not be created until
+ * the requested idle count is less than/equals to the
+ * number of the busy cpus - it does not make sense to
+ * throttle the idle cpus.
+ */
+static bool idle_cpu_valid(unsigned int num_cpus)
+{
+	int busy_nr = 0, i = 0;
+
+	for_each_online_cpu(i) {
+		/*
+		 * In case the acpi_pad threads are treated as
+		 * idle in the future(as intel_powerclamp),
+		 * the pad_busy_cpus_bits should be checked too.
+		 */
+		if (!idle_cpu(i))
+			busy_nr++;
+	}
+
+	return (busy_nr >= num_cpus) ? true : false;
+}
 
 static void acpi_pad_idle_cpus(unsigned int num_cpus)
 {
 	get_online_cpus();
 
 	num_cpus = min_t(unsigned int, num_cpus, num_online_cpus());
-	set_power_saving_task_num(num_cpus);
+	if (idle_cpu_valid(num_cpus))
+		set_power_saving_task_num(num_cpus);
 
 	put_online_cpus();
 }
-- 
2.7.4
