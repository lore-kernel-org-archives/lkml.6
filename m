Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AG47ELv9qnTEP6ja2DLscqQdOOx5/TCWczj7PBmyNe9/VwYm+iNcseI+CFtoEU8JtZlohDNIM1Zc
ARC-Seal: i=1; a=rsa-sha256; t=1519855648; cv=none;
        d=google.com; s=arc-20160816;
        b=tFq4f1YjV1UpZok4WcfrZdCjKCbxSq/kRcH+fhqOrrQgGBob7DLjigWwI3y4cJVO3W
         zbtLOEFD3ZOnUbFxYRjjqJ4wVQWIBTVzR+BLmEHQ7ky8R4N7O1qGzsnDxgvpPd56BXAU
         Yn9Ozg7ogCdHQ33+eqfO9n5Z0LrBEBDuAqH0fwZ4wWXsJ8rEcKPpMf5mP2AAibnUc7Sp
         ++5FZibeaxnt3HEPSobdmTte1OKli2cyThpxjHeMe0Ep/Hhy4js5hvvXuM8yZJsQfUgj
         HetBnAXA8P6IudUgFnr3LslroLV32LX9iI5uksxAZwEgEfjfQOYeaLmu+a4GX1PBM8Tp
         hrqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=QJLztZ2g/MRSiA6xzxg+u6RJFe94U/bV8XHyRQyuNd0=;
        b=khzmbhAzMtr7SNQ/37kE7HQl4c5cEBrk7FJp+pfjfYlegGB62VJEzusHPPDWVTgxNl
         TN5SPdX5j9fYIU5/izO0vnY3KQr1u1cXwqrWgtpw8mwZqeSKsth5BdPpFi1Fg1JT3U3J
         fDpvNeoIpvG3KyrQnHL/ImeGtdzCrrl/9RBgn2iT0cB3I528gX2sPqqc5A3WVsixUGX/
         dmzpiqbghLtK6tgp+TgpCMpQ/dp+VU/Fr+DX5bgfydPGXI9cjSyducgzIaDhmDWyynVS
         XHIdlPvhe5zER733ZFkQlPH+NHC/cJuG/rqf+T08rX/q8MpCXfI0CT1I9rypBeCootd/
         Cklw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jeremy.linton@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jeremy.linton@arm.com
From: Jeremy Linton <jeremy.linton@arm.com>
To: linux-acpi@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org,
	sudeep.holla@arm.com,
	lorenzo.pieralisi@arm.com,
	hanjun.guo@linaro.org,
	rjw@rjwysocki.net,
	will.deacon@arm.com,
	catalin.marinas@arm.com,
	gregkh@linuxfoundation.org,
	mark.rutland@arm.com,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	wangxiongfeng2@huawei.com,
	vkilari@codeaurora.org,
	ahs3@redhat.com,
	dietmar.eggemann@arm.com,
	morten.rasmussen@arm.com,
	palmer@sifive.com,
	lenb@kernel.org,
	john.garry@huawei.com,
	austinwc@codeaurora.org,
	tnowicki@caviumnetworks.com,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v7 09/13] ACPI/PPTT: Add topology parsing code
Date: Wed, 28 Feb 2018 16:06:15 -0600
Message-Id: <20180228220619.6992-10-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180228220619.6992-1-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684156400334198?=
X-GMAIL-MSGID: =?utf-8?q?1593684156400334198?=
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
 drivers/acpi/pptt.c  | 153 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/acpi.h |   4 ++
 2 files changed, 157 insertions(+)

diff --git a/drivers/acpi/pptt.c b/drivers/acpi/pptt.c
index c98f94ebd272..d66342c2eb29 100644
--- a/drivers/acpi/pptt.c
+++ b/drivers/acpi/pptt.c
@@ -424,6 +424,79 @@ static void cache_setup_acpi_cpu(struct acpi_table_header *table,
 	}
 }
 
+/* Passing level values greater than this will result in search termination */
+#define PPTT_ABORT_PACKAGE 0xFF
+
+/*
+ * Given an acpi_pptt_processor node, walk up until we identify the
+ * package that the node is associated with, or we run out of levels
+ * to request or the search is terminated with a flag match
+ * The level parameter also serves to limit possible loops within the tree.
+ */
+static struct acpi_pptt_processor *acpi_find_processor_package_id(
+	struct acpi_table_header *table_hdr,
+	struct acpi_pptt_processor *cpu,
+	int level, int flag)
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
+/*
+ * Get a unique value given a cpu, and a topology level, that can be
+ * matched to determine which cpus share common topological features
+ * at that level.
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
+	pr_err_once("PPTT table found, but unable to locate core for %d\n",
+		    cpu);
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
+		pr_err_once("No PPTT table found, cpu topology may be inaccurate\n");
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
@@ -487,3 +560,83 @@ int cache_setup_acpi(unsigned int cpu)
 
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
+		pr_err_once("No PPTT table found, topology may be inaccurate\n");
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
index 968173ec2726..2c9b6a000ea7 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -1290,4 +1290,8 @@ static inline int lpit_read_residency_count_address(u64 *address)
 }
 #endif
 
+int find_acpi_cpu_topology(unsigned int cpu, int level);
+int find_acpi_cpu_topology_package(unsigned int cpu);
+int find_acpi_cpu_cache_topology(unsigned int cpu, int level);
+
 #endif	/*_LINUX_ACPI_H*/
-- 
2.13.6
