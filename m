Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AIpwx48CqS2ivVoZkR5LKEBKfJsV+sHqOKGZlzgyGAUY10Q/T706oOtlgu0m/HJeWyPFhvvDUQ26
ARC-Seal: i=1; a=rsa-sha256; t=1524702381; cv=none;
        d=google.com; s=arc-20160816;
        b=tUlKqcvprTl0P2DSf9RRl0yR6m/QYEQYF+fHWGC9shQe6CTHy0v9B32chEN9ozxoYL
         P+0fTCo9S4jcPJTKLaupvmrkd72XY8S1rJR/DcgsIbKMQmVnItQqeubIc0lzCVZDJMav
         FfSukxm6+w/RdEIJE+iMjXUr+S0/P45QjnyTrSWERgK86zycSSRSzlBcUujX+mcY6mVL
         +YJGNdEGmqVPP3iUOXZBD363RD2ohiyLNrkMz9Qe7/XttofQZuCR7mLHSP5tQdqvbSp3
         kjLFU92oZF36YW73nphaqeJyzxmWM9qTLhiRcnzTylbyJG2+89zCLOapjCT3crFMu2MJ
         HwvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=6KLKCt+oirq/8z1GYBPkUZ2ZCADEADEsnaq8KoBVY4k=;
        b=UNJhLcJ19BN08Ydtn2UP7yej7hbbj+3vOCQyMC+19jVFs9APBrpKYHdzB2AlujxZra
         y/3iUrdpeQPh21GLue8d5EoZs4FaUfi3Wf2FDx2eastbU2jSQpdt8T3GdaqoeY7L+8u/
         2hmuOEzuSDIPUq6Y677X4P6sA+lmtSi+UFooTJFU6De38Yt9hMouWLIv7CvlzM+HRZNB
         m49cK1XFzuCpe9SjAr+fy8kzvbLgXELUudA6YO/HlzbTTNFZcfQZW/CoMOt5lOvRdhgx
         DMLWELLdfBqY+gM/tJ/urUZKTwtIZCg8Y50kd2Z4GUS4q43ThC2LOG1KJSvm/pBqbLf7
         Y9RQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-acpi@vger.kernel.org
Cc: Sudeep.Holla@arm.com,
	linux-arm-kernel@lists.infradead.org,
	Lorenzo.Pieralisi@arm.com,
	hanjun.guo@linaro.org,
	rjw@rjwysocki.net,
	Will.Deacon@arm.com,
	Catalin.Marinas@arm.com,
	gregkh@linuxfoundation.org,
	Mark.Rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org,
	ahs3@redhat.com,
	Dietmar.Eggemann@arm.com,
	Morten.Rasmussen@arm.com,
	palmer@sifive.com,
	lenb@kernel.org,
	john.garry@huawei.com,
	austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com,
	jhugo@qti.qualcomm.com,
	timur@qti.qualcomm.com,
	ard.biesheuvel@linaro.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v8 09/13] ACPI/PPTT: Add topology parsing code
Date: Wed, 25 Apr 2018 18:31:17 -0500
Message-Id: <20180425233121.13270-10-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766324602043171?=
X-GMAIL-MSGID: =?utf-8?q?1598766324602043171?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The PPTT can be used to determine the groupings of CPU's at
given levels in the system. Lets add a few routines to the PPTT
parsing code to return a unique id for each unique level in the
processor hierarchy. This can then be matched to build
thread/core/cluster/die/package/etc mappings for each processing
element in the system.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/acpi/pptt.c  | 160 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h |   4 ++
 2 files changed, 164 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index cced71ef851a..0fc4b2654665 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -453,6 +453,86 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
 	}
 }
 
+/* Passing level values greater than this will result in search termination */
+#define PPTT_ABORT_PACKAGE 0xFF
+
+/**
+ * acpi_find_processor_package_id() - Locate the processor structure for a cpu
+ *
+ * Given an acpi_pptt_processor node, walk up until we identify the
+ * package that the node is associated with, or we run out of levels
+ * to request or the search is terminated with a flag match
+ * The level parameter also serves to limit possible loops within the tree.
+ *
+ * Return: acpi_pptt_processor* describing the passed core or NULL
+ */
+static struct acpi_pptt_processor *acpi_find_processor_package_id(struct acpi_table_header *table_hdr,
+								  struct acpi_pptt_processor *cpu,
+								  int level, int flag)
+{
+	struct acpi_pptt_processor *prev_node;
+
+	while (cpu && level) {
+		if (cpu->flags & flag)
+			break;
+		pr_debug("level %d\n", level);
+		prev_node = fetch_pptt_node(table_hdr, cpu->parent);
+		if (prev_node == NULL)
+			break;
+		cpu = prev_node;
+		level--;
+	}
+	return cpu;
+}
+
+/**
+ * topology_get_acpi_cpu_tag() - Find a unique topology value for a feature
+ *
+ * Get a unique value given a cpu, and a topology level, that can be
+ * matched to determine which cpus share common topological features
+ * at that level.
+ *
+ * Return: Unique value, or -ENOENT if unable to locate cpu
+ */
+static int topology_get_acpi_cpu_tag(struct acpi_table_header *table,
+				     unsigned int cpu, int level, int flag)
+{
+	struct acpi_pptt_processor *cpu_node;
+	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+
+	cpu_node = acpi_find_processor_node(table, acpi_cpu_id);
+	if (cpu_node) {
+		cpu_node = acpi_find_processor_package_id(table, cpu_node,
+							  level, flag);
+		/* Only the first level has a guaranteed id */
+		if (level == 0)
+			return cpu_node->acpi_processor_id;
+		return ACPI_PTR_DIFF(cpu_node, table);
+	}
+	pr_warn_once("PPTT table found, but unable to locate core %d (%d)\n",
+		    cpu, acpi_cpu_id);
+	return -ENOENT;
+}
+
+static int find_acpi_cpu_topology_tag(unsigned int cpu, int level, int flag)
+{
+	struct acpi_table_header *table;
+	acpi_status status;
+	int retval;
+
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
+	if (ACPI_FAILURE(status)) {
+		pr_warn_once("No PPTT table found, cpu topology may be inaccurate\n");
+		return -ENOENT;
+	}
+	retval = topology_get_acpi_cpu_tag(table, cpu, level, flag);
+	pr_debug("Topology Setup ACPI cpu %d, level %d ret = %d\n",
+		 cpu, level, retval);
+	acpi_put_table(table);
+
+	return retval;
+}
+
 /**
  * acpi_find_last_cache_level() - Determines the number of cache levels for a PE
  * @cpu: Kernel logical cpu number
@@ -516,3 +596,83 @@ int cache_setup_acpi(unsigned int cpu)
 
 	return status;
 }
+
+/**
+ * find_acpi_cpu_topology() - Determine a unique topology value for a given cpu
+ * @cpu: Kernel logical cpu number
+ * @level: The topological level for which we would like a unique ID
+ *
+ * Determine a topology unique ID for each thread/core/cluster/mc_grouping
+ * /socket/etc. This ID can then be used to group peers, which will have
+ * matching ids.
+ *
+ * The search terminates when either the requested level is found or
+ * we reach a root node. Levels beyond the termination point will return the
+ * same unique ID. The unique id for level 0 is the acpi processor id. All
+ * other levels beyond this use a generated value to uniquely identify
+ * a topological feature.
+ *
+ * Return: -ENOENT if the PPTT doesn't exist, or the cpu cannot be found.
+ * Otherwise returns a value which represents a unique topological feature.
+ */
+int find_acpi_cpu_topology(unsigned int cpu, int level)
+{
+	return find_acpi_cpu_topology_tag(cpu, level, 0);
+}
+
+/**
+ * find_acpi_cpu_cache_topology() - Determine a unique cache topology value
+ * @cpu: Kernel logical cpu number
+ * @level: The cache level for which we would like a unique ID
+ *
+ * Determine a unique ID for each unified cache in the system
+ *
+ * Return: -ENOENT if the PPTT doesn't exist, or the cpu cannot be found.
+ * Otherwise returns a value which represents a unique topological feature.
+ */
+int find_acpi_cpu_cache_topology(unsigned int cpu, int level)
+{
+	struct acpi_table_header *table;
+	struct acpi_pptt_cache *found_cache;
+	acpi_status status;
+	u32 acpi_cpu_id = get_acpi_id_for_cpu(cpu);
+	struct acpi_pptt_processor *cpu_node = NULL;
+	int ret = -1;
+
+	status = acpi_get_table(ACPI_SIG_PPTT, 0, &table);
+	if (ACPI_FAILURE(status)) {
+		pr_warn_once("No PPTT table found, topology may be inaccurate\n");
+		return -ENOENT;
+	}
+
+	found_cache = acpi_find_cache_node(table, acpi_cpu_id,
+					   CACHE_TYPE_UNIFIED,
+					   level,
+					   &cpu_node);
+	if (found_cache)
+		ret = ACPI_PTR_DIFF(cpu_node, table);
+
+	acpi_put_table(table);
+
+	return ret;
+}
+
+
+/**
+ * find_acpi_cpu_topology_package() - Determine a unique cpu package value
+ * @cpu: Kernel logical cpu number
+ *
+ * Determine a topology unique package ID for the given cpu.
+ * This ID can then be used to group peers, which will have matching ids.
+ *
+ * The search terminates when either a level is found with the PHYSICAL_PACKAGE
+ * flag set or we reach a root node.
+ *
+ * Return: -ENOENT if the PPTT doesn't exist, or the cpu cannot be found.
+ * Otherwise returns a value which represents the package for this cpu.
+ */
+int find_acpi_cpu_topology_package(unsigned int cpu)
+{
+	return find_acpi_cpu_topology_tag(cpu, PPTT_ABORT_PACKAGE,
+					  ACPI_PPTT_PHYSICAL_PACKAGE);
+}
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 15bfb15c2fa5..032e12a2fdc2 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1297,4 +1297,8 @@ static inline int lpit_read_residency_count_address(u64 *address)
 }
 #endif
 
+int find_acpi_cpu_topology(unsigned int cpu, int level);
+int find_acpi_cpu_topology_package(unsigned int cpu);
+int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
+
 #endif	/*_LINUX_ACPI_H*/
-- 
2.13.6
