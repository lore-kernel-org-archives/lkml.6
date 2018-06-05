Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752409AbeFEOfS (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 10:35:18 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:56752 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751958AbeFEOfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 10:35:14 -0400
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH v2 2/3] ACPI / PPTT: fix build when CONFIG_ACPI_PPTT is not enabled
Date: Tue,  5 Jun 2018 15:35:03 +0100
Message-Id: <1528209304-3280-2-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528209304-3280-1-git-send-email-sudeep.holla@arm.com>
References: <1528209304-3280-1-git-send-email-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Though CONFIG_ACPI_PPTT is selected by platforms and nor user visible,
it may be useful to support the build with CONFIG_ACPI_PPTT disabled.

This patch adds the missing dummy/boiler plate implementation to fix
the build.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 include/linux/acpi.h      | 15 +++++++++++++++
 include/linux/cacheinfo.h |  2 +-
 2 files changed, 16 insertions(+), 1 deletion(-)

Hi Rafael,

If you are fine with this, can you provide Ack, so that we route this
through ARM64 tree where most of the ACPI PPTT support is present.

Regards,
Sudeep

v1->v2:
	- removed duplicate definition for acpi_find_last_cache_level

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 8f2cdb0eca71..4b35a66383f9 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1299,8 +1299,23 @@ static inline int lpit_read_residency_count_address(u64 *address)
 }
 #endif
 
+#ifdef CONFIG_ACPI_PPTT
 int find_acpi_cpu_topology(unsigned int cpu, int level);
 int find_acpi_cpu_topology_package(unsigned int cpu);
 int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
+#else
+static inline int find_acpi_cpu_topology(unsigned int cpu, int level)
+{
+	return -EINVAL;
+}
+static inline int find_acpi_cpu_topology_package(unsigned int cpu)
+{
+	return -EINVAL;
+}
+static inline int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
+{
+	return -EINVAL;
+}
+#endif
 
 #endif	/*_LINUX_ACPI_H*/
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 89397e30e269..70e19bc6cc9f 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -98,7 +98,7 @@ struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
 int cache_setup_acpi(unsigned int cpu);
-#ifndef CONFIG_ACPI
+#ifndef CONFIG_ACPI_PPTT
 /*
  * acpi_find_last_cache_level is only called on ACPI enabled
  * platforms using the PPTT for topology. This means that if
-- 
2.7.4
