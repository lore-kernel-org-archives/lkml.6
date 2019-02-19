Return-Path: <SRS0=K7k5=Q2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292D1C43381
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D36F221905
	for <linux-kernel@archiver.kernel.org>; Tue, 19 Feb 2019 20:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729768AbfBSUA7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 Feb 2019 15:00:59 -0500
Received: from mga11.intel.com ([192.55.52.93]:8744 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725987AbfBSUA4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Feb 2019 15:00:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Feb 2019 12:00:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.58,388,1544515200"; 
   d="scan'208";a="139918055"
Received: from otc-lr-04.jf.intel.com ([10.54.39.129])
  by orsmga001.jf.intel.com with ESMTP; 19 Feb 2019 12:00:56 -0800
From:   kan.liang@linux.intel.com
To:     peterz@infradead.org, tglx@linutronix.de, acme@kernel.org,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org
Cc:     len.brown@intel.com, jolsa@redhat.com, namhyung@kernel.org,
        eranian@google.com, ak@linux.intel.com,
        Kan Liang <kan.liang@linux.intel.com>
Subject: [PATCH 01/10] perf/x86/intel: Introduce a concept "domain" as the scope of counters
Date:   Tue, 19 Feb 2019 12:00:02 -0800
Message-Id: <1550606411-5313-2-git-send-email-kan.liang@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
References: <1550606411-5313-1-git-send-email-kan.liang@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kan Liang <kan.liang@linux.intel.com>

Perf supports miscellaneous modules, e.g cstate, RAPL and uncore.
The counters of these modules have different scope of effect than core.
So these modules maintain their own scope information independently.
Actually, the scope of counters among these modules are similar.
It's very useful to abstract several common topology related codes for
these modules to reduce the code redundancy.
Furthermore, it will be very helpful if some counters within a new
scope are added, e.g die scope counters on CLX-AP. The similar topology
codes will not to be updated for each modules repeatedly.

A concept, "domain", is introduced as the scope of counters.
 - Domain type: A type of domain is classified by the scope of effect.
   Currently, there are two types of domain, PACKAGE_DOMAIN and
   CORE_DOMAIN. Their scope are physical package and physical core
   respectively.
   Add a new struct domain_type for domain type.
 - The number of domain for each type depends on the topology of the
   machine. For example, for a 4 socket machine, the number of domain
   is 4 for PACKAGE_DOMAIN type.
 - The domain ID: Each domain has an ID, which has to be consecutive.

Four common functions are abstracted.
 - domain_type_init(): Initialize domain type. Updates the number of
   domain for a given type. For PACKAGE_DOMAIN type, it's the maximum
   packages of the machine.
   Assign a postfix string for the name of a given domain type. If there
   are more than two types of domain on a system, the postfix is
   required to distinguish between domain types. For example, cstate PMU
   names are cstate_core and cstate_pkg. If there is only one type on a
   system, postfix is not applied, e.g. RAPL PMU name is powerf.
 - get_domain_cpu_mask(): Return a CPU mask for a given domain type and
   a CPU.
 - get_domain_id(): Return a domain ID for a given domain type and a
   CPU.
   Now, it is only used by RAPL and uncore for PACKAGE_DOMAIN type of
   domain. The domain ID is the same as the logical package ID.
 - get_domain_id_from_group_id(): Return a domain ID for a given domain
   type and a group ID of PCI BUS.
   The function is used by PCI uncore blocks to calculate the mapping
   between a domain ID and PCI BUS.
   For PACKAGE_DOMAIN type of domain, the group ID is the same as the
   physical package ID.

The new concept will be applied for each modules in the following
patches.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
---
 arch/x86/events/Makefile |  2 +-
 arch/x86/events/domain.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++
 arch/x86/events/domain.h | 25 +++++++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/events/domain.c
 create mode 100644 arch/x86/events/domain.h

diff --git a/arch/x86/events/Makefile b/arch/x86/events/Makefile
index b8ccdb5..db638e2 100644
--- a/arch/x86/events/Makefile
+++ b/arch/x86/events/Makefile
@@ -1,4 +1,4 @@
-obj-y					+= core.o
+obj-y					+= core.o domain.o
 obj-y					+= amd/
 obj-$(CONFIG_X86_LOCAL_APIC)            += msr.o
 obj-$(CONFIG_CPU_SUP_INTEL)		+= intel/
diff --git a/arch/x86/events/domain.c b/arch/x86/events/domain.c
new file mode 100644
index 0000000..bd24c5b
--- /dev/null
+++ b/arch/x86/events/domain.c
@@ -0,0 +1,70 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019, Intel Corporation.
+ * Define "domain" as the scope of counters
+ *
+ */
+
+#include "domain.h"
+
+int domain_type_init(struct domain_type *type)
+{
+	switch (type->type) {
+	case PACKAGE_DOMAIN:
+		type->max_domains = topology_max_packages();
+		type->postfix = "pkg";
+		return 0;
+	case CORE_DOMAIN:
+		type->postfix = "core";
+		return 0;
+	default:
+		return -1;
+	}
+}
+EXPORT_SYMBOL_GPL(domain_type_init);
+
+/* Return a CPU mask for a given domain type and a CPU. */
+const struct cpumask *get_domain_cpu_mask(int cpu, struct domain_type *type)
+{
+	switch (type->type) {
+	case PACKAGE_DOMAIN:
+		return topology_die_cpumask(cpu);
+	case CORE_DOMAIN:
+		return topology_sibling_cpumask(cpu);
+	default:
+		return NULL;
+	}
+}
+EXPORT_SYMBOL_GPL(get_domain_cpu_mask);
+
+/*
+ * Return a domain ID for a given domain type and a CPU.
+ * The domain ID has to be consecutive.
+ */
+int get_domain_id(unsigned int cpu, struct domain_type *type)
+{
+	switch (type->type) {
+	case PACKAGE_DOMAIN:
+		/* Domain id is the same as logical package id */
+		return topology_logical_package_id(cpu);
+	default:
+		return -1;
+	}
+}
+EXPORT_SYMBOL_GPL(get_domain_id);
+
+/*
+ * Return a domain ID for a given domain type and a group ID of PCI BUS.
+ * Used by uncore to calculate the mapping between a domain ID and PCI BUS.
+ */
+int get_domain_id_from_group_id(int id, struct domain_type *type)
+{
+	switch (type->type) {
+	case PACKAGE_DOMAIN:
+		/* group id is physical pkg id*/
+		return topology_phys_to_logical_pkg(id);
+	default:
+		return -1;
+	}
+}
+EXPORT_SYMBOL_GPL(get_domain_id_from_group_id);
diff --git a/arch/x86/events/domain.h b/arch/x86/events/domain.h
new file mode 100644
index 0000000..c787816
--- /dev/null
+++ b/arch/x86/events/domain.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0
+ *
+ * Copyright (C) 2019, Intel Corporation.
+ */
+#include <linux/perf_event.h>
+
+#define DOMAIN_NAME_LEN	32
+
+enum domain_types {
+	PACKAGE_DOMAIN = 0,
+	CORE_DOMAIN,
+
+	DOMAIN_TYPE_MAX,
+};
+
+struct domain_type {
+	enum domain_types	type;
+	unsigned int		max_domains;
+	const char		*postfix;
+};
+
+int domain_type_init(struct domain_type *type);
+const struct cpumask *get_domain_cpu_mask(int cpu, struct domain_type *type);
+int get_domain_id(unsigned int cpu, struct domain_type *type);
+int get_domain_id_from_group_id(int id, struct domain_type *type);
-- 
2.7.4

