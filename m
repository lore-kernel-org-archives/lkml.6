Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AIpwx4/tWVY1tLdacadO9JT0FQs6ZvIIDPw91G7ST2dnE82/bUZY8VOeI8vdmblOSKqxZz5vwZ0u
ARC-Seal: i=1; a=rsa-sha256; t=1524702378; cv=none;
        d=google.com; s=arc-20160816;
        b=C+zrqdmssup+EyAmoQgJ91E9HIxIyUGgxBq0R9WG7epdHDXZK4Z9XhQGnZ8O1uKATd
         ki5qlt/QMBea6MK7m7v4t/QscCB6FnNQN6R+87t4V7DM6sTCAGfjuJLkbImmWds+bvnI
         nROeEQ/tCD5KXAEQXd/661Ckee2vRQgD6HTpWfRbYFuaE++g5YI5gWaagktOgG/q1Op5
         F3ZzTt60oShxEl6gc0P+ZDaS7ymcYVcporBsWpmMGe35BsZqDLqFpRH8+ZBpboPiP1CN
         IE3fDm5Mriipy8b2eLhgsSjl2ACzTuAmizT90rXBF1zx3Icxsm/Su3i/FbFBvt1W0eiW
         gO7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=PTPvWz+szEH3kdCZzEjVMTEpBS0YbWS5logb5GbXD/c=;
        b=wdb+ISZb1kdnLpRUACLJ3i2WuHLrvpONkEwtLLtG0lnZ1EMFiVRMrIb4Jn767PF3hF
         8BlFuvqXevv5rf9dfVDYBjGcr98Q4Cl9m5tzKnkUIlu2lw71UQZPZ4PzLWVOBET8G/uV
         0645bRkHBvgro3sgUPnCUbCtJR99NfltYgtSWuOOT/x0iba0Ke6ZcIdx5uxdO028CfmK
         a6T8dznCq9dBKXOsqiOFE+w8UF4FkxpmZlFBnhQRWE9lxdZzsiFCuRCJDyQdenOdpoZF
         rF+MO4oAWgQUWzVdLiBZyiWuQtIl4qRtPFAnb+MrYNEF0Egn7rBrbWw/rslfWIJEbce5
         Lapg==
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
Subject: [PATCH v8 07/13] drivers: base cacheinfo: Add support for ACPI based firmware tables
Date: Wed, 25 Apr 2018 18:31:15 -0500
Message-Id: <20180425233121.13270-8-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766321415119595?=
X-GMAIL-MSGID: =?utf-8?q?1598766321415119595?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Call ACPI cache parsing routines from base cacheinfo code if ACPI
is enable. Also stub out cache_setup_acpi() so that individual
architectures can enable ACPI topology parsing.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/base/cacheinfo.c  | 14 ++++++++++----
 include/linux/cacheinfo.h | 10 ++++++++++
 2 files changed, 20 insertions(+), 4 deletions(-)

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
index 0c6f658054d2..70ef44669fa3 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -97,6 +97,16 @@ int func(unsigned int cpu)					\
 struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu);
 int init_cache_level(unsigned int cpu);
 int populate_cache_leaves(unsigned int cpu);
+int cache_setup_acpi(unsigned int cpu);
+#ifndef CONFIG_ACPI
+static inline int acpi_find_last_cache_level(unsigned int cpu)
+{
+	/* ACPI kernels should be built with PPTT support */
+	return 0;
+}
+#else
+int acpi_find_last_cache_level(unsigned int cpu);
+#endif
 
 const struct attribute_group *cache_get_priv_group(struct cacheinfo *this_leaf);
 
-- 
2.13.6
