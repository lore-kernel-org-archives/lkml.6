Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AIpwx48UUZx9Hjtyiu0qpBo2ptdP1X3KFV7BiJT80pjAPGR+rMumZVdT0VYyXkQ4QHTh1Tmr7bZ8
ARC-Seal: i=1; a=rsa-sha256; t=1524702368; cv=none;
        d=google.com; s=arc-20160816;
        b=OBIU8reRGrcw96FYU3MH0H4UhfaxqtJdjPhrj7Cl+CMm/AIuLMyuY9KNcMwMZqD6OP
         oCfHsli32xx5S7xlZxTENRB3oSwVwF81evwoONRYt+q7SyuEFvb0+SN6lDHhZp352c0n
         eSOd+1OzZ9U1GgmfXsJOA/hHa5nPUG1PljBJbhpJTvpjdkLw5jp13Ws9/7t0G2OiRgJu
         mIvXRSfCtb7owNqaKnnBsXebjevJsOX99Cor2fVVYfARkv3JuvJ/Qu0sMyQIzc5lVemQ
         qd84adSoB88VKhn66yOnV4yf4x4R8AHasiVPMr+SK87RTAKY8/Pr6EaY9Egh4wUOX7XG
         9KWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=XLke42KokNfQqxobaF9UWr4WeK8Zqg/cFZzrBESXMmI=;
        b=czwmByoVGiaXjEocmyKVaaan3AFrAkV1WLjUGoFYF7Hmi5KaLh8ZBwZ9l1uQ+NSPd2
         O12jH1nlZ7AS3lddQfMCqQ2E20+cEmEZS12N0dbUNiamYHmTfazBAAHdu/sV6DmYvWqP
         J+jCbtlgLeJa7GzKoanDgYV8sk2FpEpXMCYTU++24BUY8bmgOsct++p/sJoP723TTOWd
         oul0VOmiiMkDuxu6eG6JHahn+NCpV0d6DZavjmWxJ0ckXF3wnJjYp7ClFKXSS7F8+na6
         QgCpvZjXS3h87l7rilvW19JlBPVh3EIGylQ7d4/i/y1zkUV3yqSa6E8pWNbghjxTyMh2
         h/aA==
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
Subject: [PATCH v8 01/13] drivers: base: cacheinfo: move cache_setup_of_node()
Date: Wed, 25 Apr 2018 18:31:09 -0500
Message-Id: <20180425233121.13270-2-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766310751978642?=
X-GMAIL-MSGID: =?utf-8?q?1598766310751978642?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

In preparation for the next patch, and to aid in
review of that patch, lets move cache_setup_of_node
further down in the module without any changes.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
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
