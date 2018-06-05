Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752286AbeFENzw (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:55:52 -0400
Received: from foss.arm.com ([217.140.101.70]:56196 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752239AbeFENzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:55:49 -0400
From: Sudeep Holla <sudeep.holla@arm.com>
To: linux-acpi@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Jeremy Linton <jeremy.linton@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Hanjun Guo <hanjun.guo@linaro.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/3] ACPI / PPTT: fix build when CONFIG_ACPI_PPTT is not enabled
Date: Tue,  5 Jun 2018 14:55:37 +0100
Message-Id: <1528206938-2702-2-git-send-email-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1528206938-2702-1-git-send-email-sudeep.holla@arm.com>
References: <CAMuHMdWJWj3a0MZgEi7VJTUJRNoeR+X3eoN8A-sW6fwimEr6Fg@mail.gmail.com>
 <1528206938-2702-1-git-send-email-sudeep.holla@arm.com>
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
 include/linux/acpi.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

Hi Rafael,

If you are fine with this, can you provide Ack, so that we route this
through ARM64 tree where most of the ACPI PPTT support is present.

Regards,
Sudeep

diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 8f2cdb0eca71..0fa28265d095 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1299,8 +1299,28 @@ static inline int lpit_read_residency_count_address(u64 *address)
 }
 #endif
 
+#ifdef CONFIG_ACPI_PPTT
 int find_acpi_cpu_topology(unsigned int cpu, int level);
 int find_acpi_cpu_topology_package(unsigned int cpu);
 int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
+int acpi_find_last_cache_level(unsigned int cpu);
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
+static inline int acpi_find_last_cache_level(unsigned int cpu)
+{
+	return -EINVAL;
+}
+#endif
 
 #endif	/*_LINUX_ACPI_H*/
-- 
2.7.4
