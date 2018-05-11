Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AB8JxZr+bkfmUliOvqB6eVALtMA/UF0idx3LB7vPnuaxil3B3c32fxvavsQCalxrWs6WdYsrqvNC
ARC-Seal: i=1; a=rsa-sha256; t=1526083151; cv=none;
        d=google.com; s=arc-20160816;
        b=F3grA5k5t4dav7X6luFfFyfNkp8jr6o6SRYXFiAA/w1wXJV706heibi3RSCd9HsyyD
         lprYVnbXmaaWqdYc9614EUOOtsJ0lc/StKcoJmqiduBuJIG61aRWlfDyNLhHzF1tWpA5
         F/3qMz4fJVBYxNHsgoTd6xwlxPGQm5Z5wEmYQmgSs08U5DqjYeQBjA73IHvDbC+cguGg
         HRBwX+cO3/gVjBKm7FvlD+wvuFdGyc/+hS7k58Uvdk9/8BAHEAQyhGWHtuM3Fc753KnC
         yxxhNatGUTY5ePeWV2Jw025ruD0OubPe3Sh3uxR+Kx87QuedIm6b9PAZ6fonvu5UA9jl
         MwAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=r0R89/oaVUYtoarW9PUGEEZtoOJYcJjvSBR+IoYm+hw=;
        b=ui3jk25P81JIj/WzFEz5LK2GachlZMBu8r2daY5susWii8PEG+B7HkS1xRv2YoTuYV
         KezM7ADKM/dIAYZ4tC1Nu3afIcH3nKcZbPlCHqVHOsEZZvEC5R8+XlLjatyKb3UMB2VM
         RFC5gUcOx9KSiMqgKBxi1Mynoab+PEHK1pMu2ANWcmNw1kxi7ZQ3AYZsO9gVEsmZKdm2
         Z/Ydr83gZvivokeHwKMUp/iqfd6fmfyIuc1VZU8ZEocVWT4ZfS4UOSeS+S4c4jEIyt/G
         uvvJSFvnK8nULEGfL2TSlWElGSlxr1yeXJj0jnD3OvnlHPuCZv5n4RsXXsDJ5mzmMXbD
         MMhQ==
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
Subject: [PATCH v9 08/12] arm64: Add support for ACPI based firmware tables
Date: Fri, 11 May 2018 18:58:03 -0500
Message-Id: <20180511235807.30834-9-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180511235807.30834-1-jeremy.linton@arm.com>
References: <20180511235807.30834-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214166964323495?=
X-GMAIL-MSGID: =?utf-8?q?1600214166964323495?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The /sys cache entries should support ACPI/PPTT generated cache
topology information.  For arm64, if ACPI is enabled, determine
the max number of cache levels and populate them using the PPTT
table if one is available.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/arm64/kernel/cacheinfo.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 380f2e2fbed5..0bf0a835122f 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -17,6 +17,7 @@
  * along with this program.  If not, see <http://www.gnu.org/licenses/>.
  */
 
+#include <linux/acpi.h>
 #include <linux/cacheinfo.h>
 #include <linux/of.h>
 
@@ -46,7 +47,7 @@ static void ci_leaf_init(struct cacheinfo *this_leaf,
 
 static int __init_cache_level(unsigned int cpu)
 {
-	unsigned int ctype, level, leaves, of_level;
+	unsigned int ctype, level, leaves, fw_level;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 
 	for (level = 1, leaves = 0; level <= MAX_CACHE_LEVEL; level++) {
@@ -59,15 +60,19 @@ static int __init_cache_level(unsigned int cpu)
 		leaves += (ctype == CACHE_TYPE_SEPARATE) ? 2 : 1;
 	}
 
-	of_level = of_find_last_cache_level(cpu);
-	if (level < of_level) {
+	if (acpi_disabled)
+		fw_level = of_find_last_cache_level(cpu);
+	else
+		fw_level = acpi_find_last_cache_level(cpu);
+
+	if (level < fw_level) {
 		/*
 		 * some external caches not specified in CLIDR_EL1
 		 * the information may be available in the device tree
 		 * only unified external caches are considered here
 		 */
-		leaves += (of_level - level);
-		level = of_level;
+		leaves += (fw_level - level);
+		level = fw_level;
 	}
 
 	this_cpu_ci->num_levels = level;
-- 
2.13.6
