Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZooT/UCkFrs8yhvtQ9434wP7Pqg4SaFkB5rxoyH5SufLPC1PvT9z8AslNLeo9hmCN0X2Jc2
ARC-Seal: i=1; a=rsa-sha256; t=1526083151; cv=none;
        d=google.com; s=arc-20160816;
        b=vz7LJR/1pSmPi/kjeq2Ek5igpl8lc2btg/78m8mOhzO3OQTVxxf5mh16pKMcQ3XBUn
         5G45zWcTySNHrUbY0wtvhc6I3F474qzj8VvcAk8E4Aikpiqje+cXvMbdKiaWoiQACZXk
         Yov4O8rvJz9bSlWUIVte28kWxOHWii5zgRApsUq8podBBcXnIv0Ay+t7hS2UyQfbDbjj
         FDfOuPih7vEuE1Preb2T8GbJeb62lteOTKDxFx529tz9/C+cwCUCcrZlNMA+peqE9lzt
         om5YufMK8pr1B9sARQACoyJ/ElUbL2XYU7bHCQJO4MU02F+6nhI0kDerOVqY0GyyA0fo
         lhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=G8RoyA6JUCJ5uM5SN8vKVFtdmlJHzHZYyC8RjTzFmm8=;
        b=gZ0ND4oI1cbvFf6muGoL1f7wKfY2IfynHP6v9rHaK3nNBD5pheNEvhiVDLVSAySZdm
         Ol+B0DCD2YSF2ubqbkPjwHZDx2LUjlPgvM2dT6j2N9FJ7/CAn9qykTJ+7WCH4pubYXoF
         MaF2gjiaiTkG8NcLFw0t0/3sypvX/fC63mwMb6hBXt2/0Vei8g/Sl0HbCq05CXX6lFs/
         ACv5En84Fyjv6vBG6yZ5QN1MePdoCJkIex3AwU8NgRUlLBC24r40jVeWdwcNuS2MKq/k
         NlakiWNkR7E+Rzvhj1M2s3vvnTTKeI10l63I/owl6xFYgArtt19oBMMTswJh/bDDHnYJ
         SqAQ==
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
	jhugo@codeaurora.org,
	ard.biesheuvel@linaro.org,
	Jeremy Linton <jeremy.linton@arm.com>
Subject: [PATCH v9 07/12] drivers: base cacheinfo: Add support for ACPI based firmware tables
Date: Fri, 11 May 2018 18:58:02 -0500
Message-Id: <20180511235807.30834-8-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180511235807.30834-1-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214166387104037?=
X-GMAIL-MSGID: =?utf-8?q?1600214166387104037?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Call ACPI cache parsing routines from base cacheinfo code if ACPI
is enabled. Also stub out cache_setup_acpi and acpi_find_last_cache_level
so that individual architectures can enable ACPI topology parsing.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 drivers/base/cacheinfo.c  | 14 ++++++++++----
 include/linux/cacheinfo.h | 17 +++++++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 597aacb233fc..2880e2ab01f5 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -206,7 +206,7 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 					   struct cacheinfo *sib_leaf)
 {
 	/*
-	 * For non-DT systems, assume unique level 1 cache, system-wide
+	 * For non-DT/ACPI systems, assume unique level 1 caches, system-wide
 	 * shared caches for all other levels. This will be used only if
 	 * arch specific code has not populated shared_cpu_map
 	 */
@@ -214,6 +214,11 @@ static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 }
 #endif
 
+int __weak cache_setup_acpi(unsigned int cpu)
+{
+	return -ENOTSUPP;
+}
+
 static int cache_shared_cpu_map_setup(unsigned int cpu)
 {
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
@@ -227,8 +232,8 @@ static int cache_shared_cpu_map_setup(unsigned int cpu)
 	if (of_have_populated_dt())
 		ret = cache_setup_of_node(cpu);
 	else if (!acpi_disabled)
-		/* No cache property/hierarchy support yet in ACPI */
-		ret = -ENOTSUPP;
+		ret = cache_setup_acpi(cpu);
+
 	if (ret)
 		return ret;
 
@@ -279,7 +284,8 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 			cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
 			cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
 		}
-		of_node_put(this_leaf->fw_token);
+		if (of_have_populated_dt())
+			of_node_put(this_leaf->fw_token);
 	}
 }
 
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 0c6f658054d2..89397e30e269 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -97,6 +97,23 @@ int func(unsigned int cpu)					\
 struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
+int cache_setup_acpi(unsigned int cpu);
+#ifndef CONFIG_ACPI
+/*
+ * acpi_find_last_cache_level is only called on ACPI enabled
+ * platforms using the PPTT for topology. This means that if
+ * the platform supports other firmware configuration methods
+ * we need to stub out the call when ACPI is disabled.
+ * ACPI enabled platforms not using PPTT won't be making calls
+ * to this function so we need not worry about them.
+ */
+static inline int acpi_find_last_cache_level(unsigned int cpu)
+{
+	return 0;
+}
+#else
+int acpi_find_last_cache_level(unsigned int cpu);
+#endif
 
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
 
-- 
2.13.6
