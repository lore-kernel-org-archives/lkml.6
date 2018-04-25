Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AIpwx4/J+MtouYwXEN84jl1nPs9lm3faSrIZgLqL0cPJSuBJwAZUEkXMkRLok8sekUklRISc3mkB
ARC-Seal: i=1; a=rsa-sha256; t=1524702372; cv=none;
        d=google.com; s=arc-20160816;
        b=Cj/jlnCXEkkLaOkFgFXal+mqWsxr1/wRNZ54mDhMJ0dECV4mUpWRqjiarYOhUeeu53
         ndWg0ODIz34AUlhC8vNSFsibLBhsYv94NVXuQbsIgg7rRYDT7Ph8OqojPh4gWLEjz6hM
         s03fgTnmOnTKC1Bt3oiWckHIWox4SJHKj4Wndvq4lW0f4yg7UQmSPD/Yx8YwuvU6WzKn
         wh7qfIgbMweYM1mhfzs69JV9JlVLxI8h67vIZaNxCcIPzPYEJim9TvL0eGjbMuvNyOBo
         sumg+UqTV/57wdVBXQ9bMYWtdTO3JxzI0zMQncAj3AtlIdSQPzYDpTlzwponCopJjVc5
         1Isw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=Ffyu3dxJi3Ofe4pvMrIAV+UdTchCL3z0BsrO55t1wsk=;
        b=ywOWl8TGPCHIUO/KB4gS3CXRVb3yMTdRgr2PWSAp0Q4GpludfsZHUZOG2PMfrmLt3C
         Otp2LrsNZfk+fY5YVYZkVZs13AJOFnW05SyHALerl9VfIpr8JUDHMMm2qjqAaTpR+LBR
         hHcuu5RAfaF0rFftfSzhjrGI+H4rUiiNdO0xUVGa+JmN2XdlgoMMbT7gSlWdBFHsYWwj
         zkSj1/cRm015bzXqe3HyYQnWUNePXayagrPofcc9r34jZSgFXUJTsJ/iyX3nbSBBzgu5
         c6neY283U+vK6dOFNcbQLO/MFQ416zOGXRw6v8jpa0A9c+Mvct4RthcFp7P7Xitxldy4
         dgSw==
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
Subject: [PATCH v8 03/13] cacheinfo: rename of_node to fw_token
Date: Wed, 25 Apr 2018 18:31:11 -0500
Message-Id: <20180425233121.13270-4-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766314314032259?=
X-GMAIL-MSGID: =?utf-8?q?1598766314314032259?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Rename and change the type of of_node to indicate
it is a generic pointer which is generally only used
for comparison purposes. In a later patch we will put
an ACPI/PPTT token pointer in fw_token so that
the code which builds the shared cpu masks can be reused.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Acked-by: Sudeep Holla <sudeep.holla@arm.com>
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
