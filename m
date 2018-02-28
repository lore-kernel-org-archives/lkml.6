Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AG47ELuUNcpcpOOWrYp+/tJl/SkDhZpHZAS/3G74mIM3xNw5Uk5CMLopDAXhpO/9cw7/Hzm+/Ulo
ARC-Seal: i=1; a=rsa-sha256; t=1519855637; cv=none;
        d=google.com; s=arc-20160816;
        b=avtpQvaU78tiYWWcMMffPQ1/mtiBJNCPCiSk2Qc05SG8InVBQc+GrPtj8Vo/pYjm8j
         UVN3PIIPOg2n/uLelJ2A3LxgxogP7E99I11wrJaERyXFkpeuSRTc2Zx+1arANjOk3LO5
         2v3SVTfig7m6fvV3f24s6eXynIiQQg/CiaUpi1reK4FTl7uhi/71Qa/jEKIM33TjKU7Y
         8CPRZb4x5quPguvTwXBuKzZjJYw4EmXNciBEIEbiPQridPzuwqrjX8baSqAEZFpFRJw8
         UBLmXjV8wIEIeGYDFZVNNMPaKJ8SFN0QTUfNve3I42WvBUVGCtENAeh7NR5vHA6SdmgO
         KVvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=8NWZ8sT0R53qLbfcNMAzCXLEEN7L0I/NJnUvlKJnrns=;
        b=H9DsR84AwZnXQ9t30FYw6gSRSTGIHNJX7HtkMBhoDzUswXbvqrjECLO1FcTBX6/ULw
         T0oZa6xQUfhTrG6zqwsAZe13+TR8/pxFcSd+ZdHdvmHC5fcNgpvog8xhfaG2CyfUvAee
         fQKcecR83LSiAYKQij9IAz+ytWjmgGvHagMxLDv/65sp3Mp3HKZw6AYHIUf+XwuqPF0/
         t8KDPSt55WgT6PF2XU6is1kvnGClukva4Sj82meoPrF7xTKsBkB3qdRsCj3CWUltgXRn
         kYLNs0DSVakEac4G63dHTYJRoyLlMRgmuDOFDvVQQc9iKYR78zPoS9uuakzMO0a/Lqif
         JifQ==
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
Subject: [PATCH v7 03/13] cacheinfo: rename of_node to fw_token
Date: Wed, 28 Feb 2018 16:06:09 -0600
Message-Id: <20180228220619.6992-4-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180228220619.6992-1-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684145443447566?=
X-GMAIL-MSGID: =?utf-8?q?1593684145443447566?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Rename and change the type of of_node to indicate
it is a generic pointer which is generally only used
for comparison purposes. In a later patch we will put
an ACPI/PPTT token pointer in fw_token so that
the code which builds the shared cpu masks can be reused.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/base/cacheinfo.c  | 16 +++++++++-------
 include/linux/cacheinfo.h |  8 +++-----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index a872523e8951..597aacb233fc 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -35,7 +35,7 @@ struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu)
 static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 					   struct cacheinfo *sib_leaf)
 {
-	return sib_leaf->of_node == this_leaf->of_node;
+	return sib_leaf->fw_token == this_leaf->fw_token;
 }
 
 /* OF properties to query for a given cache type */
@@ -167,9 +167,10 @@ static int cache_setup_of_node(unsigned int cpu)
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	unsigned int index = 0;
 
-	/* skip if of_node is already populated */
-	if (this_cpu_ci->info_list->of_node)
+	/* skip if fw_token is already populated */
+	if (this_cpu_ci->info_list->fw_token) {
 		return 0;
+	}
 
 	if (!cpu_dev) {
 		pr_err("No cpu device for CPU %d\n", cpu);
@@ -190,7 +191,7 @@ static int cache_setup_of_node(unsigned int cpu)
 		if (!np)
 			break;
 		cache_of_set_props(this_leaf, np);
-		this_leaf->of_node = np;
+		this_leaf->fw_token = np;
 		index++;
 	}
 
@@ -278,7 +279,7 @@ static void cache_shared_cpu_map_remove(unsigned int cpu)
 			cpumask_clear_cpu(cpu, &sib_leaf->shared_cpu_map);
 			cpumask_clear_cpu(sibling, &this_leaf->shared_cpu_map);
 		}
-		of_node_put(this_leaf->of_node);
+		of_node_put(this_leaf->fw_token);
 	}
 }
 
@@ -323,8 +324,9 @@ static int detect_cache_attributes(unsigned int cpu)
 	if (ret)
 		goto free_ci;
 	/*
-	 * For systems using DT for cache hierarchy, of_node and shared_cpu_map
-	 * will be set up here only if they are not populated already
+	 * For systems using DT for cache hierarchy, fw_token
+	 * and shared_cpu_map will be set up here only if they are
+	 * not populated already
 	 */
 	ret = cache_shared_cpu_map_setup(cpu);
 	if (ret) {
diff --git a/include/linux/cacheinfo.h b/include/linux/cacheinfo.h
index 3d9805297cda..0c6f658054d2 100644
--- a/include/linux/cacheinfo.h
+++ b/include/linux/cacheinfo.h
@@ -34,9 +34,8 @@ enum cache_type {
  * @shared_cpu_map: logical cpumask representing all the cpus sharing
  *	this cache node
  * @attributes: bitfield representing various cache attributes
- * @of_node: if devicetree is used, this represents either the cpu node in
- *	case there's no explicit cache node or the cache node itself in the
- *	device tree
+ * @fw_token: Unique value used to determine if different cacheinfo
+ *	structures represent a single hardware cache instance.
  * @disable_sysfs: indicates whether this node is visible to the user via
  *	sysfs or not
  * @priv: pointer to any private data structure specific to particular
@@ -65,8 +64,7 @@ struct cacheinfo {
 #define CACHE_ALLOCATE_POLICY_MASK	\
 	(CACHE_READ_ALLOCATE | CACHE_WRITE_ALLOCATE)
 #define CACHE_ID		BIT(4)
-
-	struct device_node *of_node;
+	void *fw_token;
 	bool disable_sysfs;
 	void *priv;
 };
-- 
2.13.6
