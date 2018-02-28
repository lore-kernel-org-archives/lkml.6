Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AG47ELtRtjTjmcHiHmTaHYVshsTmtjuz49VFl0ugtwUmvfWa4K+dcAMSnIwv47+NUKL1xQ1vArzj
ARC-Seal: i=1; a=rsa-sha256; t=1519855633; cv=none;
        d=google.com; s=arc-20160816;
        b=dF5pWwh7IeiRR18Sf8Gkbp8nXFkrLmroMAFjHSe1V0xZPEDISJoFMilcLNzLY5rvaM
         hDnB86sWzyBi50ueJLfwyIIQhEynZha+KgYPGhgCPpCEFlqO9P4vztkE+az32FYi0/1A
         eCSs5ztEjh7t7hJo+z4lyi+msMXlunKp4Na29vrYrYXhKWCcOIij3MJqAfRd3VaFWYp5
         yTHwmy1B4gGf4bbSWC3uuZ3ZKjdDjAo4CNvglDKBIATb7YB2XvZK9oIoalfwZXb1FpfO
         h6O8Nvh95Nd49GfWDmsczVLI5c4WtfwTDnC/x5ugRzZO7dqhY5qcb4zdlO1YL4L8Iosr
         1Vig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=RRkUghi/VYTokt7oDldjgKvni1G8OPv/dexXLnqGdSg=;
        b=tFH3D7xaV3FIcCmtPOcJfMj9bpcCceKwbk4H5+Z4YmRwjqghZm/uRu2m3r+BtB7J1Z
         kf8FUbakLjzyKUKEszqXf7tjxhFTYoA/KR6OXDZ0MK0NKH9alMCno87kFnh3ZpaOIlx9
         pddKRl2iUQ6vSce7eA5IqJ0GfhwWwYh+39Hl7oBCUy3jxP8BT7OjicHCjH0RISELnRQ0
         e3iJxmrTjg+ncxD7mIA/aMGWRDhVpItBgIanTinULElNfosDFV49z8A5t/xRejD36DjK
         o+PbbSNjG+ctU88BpDotCeaJhCjtxXnJAf2ANdAsF5phKuHH8VBTbAjFqF+lSSCfW+jJ
         J6zA==
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
Subject: [PATCH v7 01/13] drivers: base: cacheinfo: move cache_setup_of_node()
Date: Wed, 28 Feb 2018 16:06:07 -0600
Message-Id: <20180228220619.6992-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180228220619.6992-1-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684140441831379?=
X-GMAIL-MSGID: =?utf-8?q?1593684140441831379?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation for the next patch, and to aid in
review of that patch, lets move cache_setup_of_node
further down in the module without any changes.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
---
 drivers/base/cacheinfo.c | 80 ++++++++++++++++++++++++------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index edf726267282..09ccef7ddc99 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -32,46 +32,6 @@ struct cpu_cacheinfo *get_cpu_cacheinfo(unsigned int cpu)
 }
 
 #ifdef CONFIG_OF
-static int cache_setup_of_node(unsigned int cpu)
-{
-	struct device_node *np;
-	struct cacheinfo *this_leaf;
-	struct device *cpu_dev = get_cpu_device(cpu);
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	unsigned int index = 0;
-
-	/* skip if of_node is already populated */
-	if (this_cpu_ci->info_list->of_node)
-		return 0;
-
-	if (!cpu_dev) {
-		pr_err("No cpu device for CPU %d\n", cpu);
-		return -ENODEV;
-	}
-	np = cpu_dev->of_node;
-	if (!np) {
-		pr_err("Failed to find cpu%d device node\n", cpu);
-		return -ENOENT;
-	}
-
-	while (index < cache_leaves(cpu)) {
-		this_leaf = this_cpu_ci->info_list + index;
-		if (this_leaf->level != 1)
-			np = of_find_next_cache_node(np);
-		else
-			np = of_node_get(np);/* cpu node itself */
-		if (!np)
-			break;
-		this_leaf->of_node = np;
-		index++;
-	}
-
-	if (index != cache_leaves(cpu)) /* not all OF nodes populated */
-		return -ENOENT;
-
-	return 0;
-}
-
 static inline bool cache_leaves_are_shared(struct cacheinfo *this_leaf,
 					   struct cacheinfo *sib_leaf)
 {
@@ -202,6 +162,46 @@ static void cache_of_override_properties(unsigned int cpu)
 		cache_associativity(this_leaf);
 	}
 }
+
+static int cache_setup_of_node(unsigned int cpu)
+{
+	struct device_node *np;
+	struct cacheinfo *this_leaf;
+	struct device *cpu_dev = get_cpu_device(cpu);
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	unsigned int index = 0;
+
+	/* skip if of_node is already populated */
+	if (this_cpu_ci->info_list->of_node)
+		return 0;
+
+	if (!cpu_dev) {
+		pr_err("No cpu device for CPU %d\n", cpu);
+		return -ENODEV;
+	}
+	np = cpu_dev->of_node;
+	if (!np) {
+		pr_err("Failed to find cpu%d device node\n", cpu);
+		return -ENOENT;
+	}
+
+	while (index < cache_leaves(cpu)) {
+		this_leaf = this_cpu_ci->info_list + index;
+		if (this_leaf->level != 1)
+			np = of_find_next_cache_node(np);
+		else
+			np = of_node_get(np);/* cpu node itself */
+		if (!np)
+			break;
+		this_leaf->of_node = np;
+		index++;
+	}
+
+	if (index != cache_leaves(cpu)) /* not all OF nodes populated */
+		return -ENOENT;
+
+	return 0;
+}
 #else
 static void cache_of_override_properties(unsigned int cpu) { }
 static inline int cache_setup_of_node(unsigned int cpu) { return 0; }
-- 
2.13.6
