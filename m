Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZrEdi995jgv+Yr4rtFrylmfMeJRELPxX8iTe/Wx8iUyJuMnZsLckPh3Ja+UMrZZQeDXFtCs
ARC-Seal: i=1; a=rsa-sha256; t=1526083142; cv=none;
        d=google.com; s=arc-20160816;
        b=BGCmqROmkSkx1j5cUGwLra7XdCHnc6l6jz2uwAgU5C1hngekOzBO1AKSNu+s7eHVat
         XF07wuGP3ksZzsF8qeDUUxF9h6t+D/JLHxQMGm/9LZSQRp/OVbyhOsT7IXnNYVuxpbOl
         OWIWI+pfc55hzseO/vtVV/LvKmRcLl5aIhsfAVRn43IevrLUS2zB0xR/OBxsKOJsitn2
         4Leqhw5Dt0EAHl8cF2vas00a3SPQe9Yxa2xGt1MXEtWy3sViv9Qpv7rq4TntXZ8vJTXb
         KJZftGoeKMTSq+FGpZlFklg6u90OpDi8aMilpDymYV1XgJrgf1O5RysQ/ZmZZOvaLjQb
         z8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=1WLjyI7UFB+nUzGYdSQRfBvMsibs7spPl4yrZ6T/tH4=;
        b=OIYL9I3oWm+ShgqElj3BJWDtQm7OxBAEYIh1LiadxMgXhbxz2SHv5WaMKsaFacohF4
         B0WGDxXoruqKISVCtji5mML9LhUkyiYdebiKMSFkseAaP9IEFTT4MLGcQJTCSL8FNClf
         0+cm9WA3Sd6vM6X/7bLBYJuyeXM0gQiHTSjRTEaJ+EnXMCC0KY4syjnBJunKhnLoOWtv
         y/ILjKV80QoXdTcJU3144NbNA8gvkqyNSuOM29A8Q/i5YpFbXxp28nq8t4ZTGubDk2HT
         k1MRyn+ev7H9yn+vxOfHExVT4MuldIVJWik3JHnW85ooD2mdQ1C0IiEXIoQ+XsiHLqNy
         CQmQ==
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
Subject: [PATCH v9 01/12] drivers: base: cacheinfo: move cache_setup_of_node()
Date: Fri, 11 May 2018 18:57:56 -0500
Message-Id: <20180511235807.30834-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180511235807.30834-1-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214156882662916?=
X-GMAIL-MSGID: =?utf-8?q?1600214156882662916?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation for the next patch, and to aid in
review of that patch, lets move cache_setup_of_node
further down in the module without any changes.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
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
