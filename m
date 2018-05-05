Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751563AbeEELsl (ORCPT <rfc822;w@1wt.eu>);
        Sat, 5 May 2018 07:48:41 -0400
Received: from mga11.intel.com ([192.55.52.93]:41516 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeEELsk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 May 2018 07:48:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,365,1520924400";
   d="scan'208";a="56183747"
From: Chen Yu <yu.c.chen@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>,
        Lenny Szubowicz <lszubowi@redhat.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Rui Zhang <rui.zhang@intel.com>, linux-acpi@vger.kernel.org
Subject: [PATCH][RFC v2] ACPI: acpi_pad: Do not launch acpi_pad threads on idle cpus
Date: Sat,  5 May 2018 19:53:22 +0800
Message-Id: <1525521202-32519-1-git-send-email-yu.c.chen@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to current implementation of acpi_pad driver,
it does not make sense to spawn any power saving threads
on the cpus which are already idle - it might bring
unnecessary overhead on these idle cpus and causes power
waste. So verify the condition that if the number of 'busy'
cpus exceeds the amount of the 'forced idle' cpus is met.
This is applicable due to round-robin attribute of the
power saving threads, otherwise ignore the setting/ACPI
notification.

Suggested-by: Lenny Szubowicz <lszubowi@redhat.com>
Suggested-by: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Lenny Szubowicz <lszubowi@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Rui Zhang <rui.zhang@intel.com>
Cc: linux-acpi@vger.kernel.org
Signed-off-by: Chen Yu <yu.c.chen@intel.com>
---
 drivers/acpi/acpi_pad.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 51 insertions(+), 1 deletion(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index 552c1f7..515e60e 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -254,12 +254,62 @@ static void set_power_saving_task_num(unsigned int num)
 	}
 }
 
+/*
+ * Extra acpi_pad threads should not be created until
+ * the requested idle count is less than/equals to the
+ * number of the busy cpus - it does not make sense to
+ * throttle the idle cpus.
+ */
+#define SAMPLE_INTERVAL_JIF	20
+
+static u64 get_idle_time(int cpu)
+{
+	u64 idle, idle_usecs = -1ULL;
+
+	idle_usecs = get_cpu_idle_time_us(cpu, NULL);
+
+	if (idle_usecs == -1ULL)
+		idle = kcpustat_cpu(cpu).cpustat[CPUTIME_IDLE];
+	else
+		idle = idle_usecs * NSEC_PER_USEC;
+
+	return idle;
+}
+
+static bool idle_nr_valid(unsigned int num_cpus)
+{
+	int busy_nr = 0, i = 0, load_thresh = 100 - idle_pct;
+
+	if (!num_cpus)
+		return true;
+
+	for_each_online_cpu(i) {
+		u64 wall_time, idle_time;
+		unsigned int elapsed_delta, idle_delta, load;
+
+		wall_time = jiffies64_to_nsecs(get_jiffies_64());
+		idle_time = get_idle_time(i);
+		/* Wait and see... */
+		schedule_timeout_uninterruptible(SAMPLE_INTERVAL_JIF);
+
+		idle_delta = get_idle_time(i) - idle_time;
+		elapsed_delta = jiffies64_to_nsecs(get_jiffies_64()) - wall_time;
+		idle_delta = (idle_delta > elapsed_delta) ? elapsed_delta : idle_delta;
+		load = 100 * (elapsed_delta - idle_delta) / elapsed_delta;
+		if (load >= load_thresh)
+			busy_nr++;
+	}
+
+	return (busy_nr >= num_cpus) ? true : false;
+}
+
 static void acpi_pad_idle_cpus(unsigned int num_cpus)
 {
 	get_online_cpus();
 
 	num_cpus = min_t(unsigned int, num_cpus, num_online_cpus());
-	set_power_saving_task_num(num_cpus);
+	if (idle_nr_valid(num_cpus))
+		set_power_saving_task_num(num_cpus);
 
 	put_online_cpus();
 }
-- 
2.7.4
