Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AIpwx49ftbkK/rCeggxdS+EyrAmoXe0j7MCeKmcuqQGCFm4n/KAb0oIgZ7aR6I1eBE3/DDT3Mzy5
ARC-Seal: i=1; a=rsa-sha256; t=1524702380; cv=none;
        d=google.com; s=arc-20160816;
        b=iwUM5BkhsK6qj2RZawO9X+NSHkd+tL+9GMEL/n5VaMZczfwUUvEosEcfQxeNUuqzFP
         a6MGfOPa+BzDh//r6pDnT+xojpYDRBtIuJe0KGHUncrLthu0A4JBU3PMEKMIVGRl9EdJ
         facE7b8Lcumqa5I/u6PB8/q/CIytZ3YI0d/lmXZ7nDsnwZPHJ/UARcyxbnMchkuEl/i6
         lKzrxv1jOyGT0cjE1TdU00m0ceYLGNHn19MwvJAaqto/FgdRscFEE21H38RHMVGq6G7F
         l5VvSwIcNmgKNXCCjsO61Rr8AP8uFcJ5x7Y4pcjaCHI4+eqMUiTZ6NLL5DJwtI/JKNww
         lc5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=pw/1FJVVpEwBqN8kfTu2DwucS6iimCd0vcO/ASj9O94=;
        b=eXRuNZDtIHGXpd+j5RD2vgk41djvgipMJ1AIe9ZSrGKO4Aw2D+4idtLi/+PwaM0/Zy
         anJSJJ9Z/YK85KdEmlYjKMYQLyAc88yD9oQgw8A+CWloMvNo/vC15KHgk3+xsBlPrZkW
         ZFfyRO7wkKlbsyBPH2VUWA7Fiq28CIDk9AB51KkWUtR9V4LzogEVKAaMbYEaQhCDfH0K
         LFbbVYc4aLSfRHq8j9EGdRNRnJLOdzQPC1P9RatTdMLrQZfKcDDoTAIZLdQuoJdg0QCc
         ZzeA8ZxlwevJ1QNFPxoZQ1tNgCvFgo5QNU0LiXDhYOhv+ZukEhvyLBgN0iqPdP3xEfH8
         h2Bg==
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
Subject: [PATCH v8 08/13] arm64: Add support for ACPI based firmware tables
Date: Wed, 25 Apr 2018 18:31:16 -0500
Message-Id: <20180425233121.13270-9-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180425233121.13270-1-jeremy.linton@arm.com>
References: <20180425233121.13270-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598766323366552984?=
X-GMAIL-MSGID: =?utf-8?q?1598766323366552984?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The /sys cache entries should support ACPI/PPTT generated cache
topology information. Lets detect ACPI systems and call
an arch specific cache_setup_acpi() routine to update the hardware
probed cache topology.

For arm64, if ACPI is enabled, determine the max number of cache
levels and populate them using the PPTT table if one is available.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>
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
