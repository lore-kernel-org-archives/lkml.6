Return-Path: <jeremy.linton@arm.com>
X-Google-Smtp-Source: AG47ELteIRzUGihTUOANRy+0u8Gj4lfjNj2emATs9uCgOlxydtT6mCxaMXW6j3OS4CpoFi/XL3m7
ARC-Seal: i=1; a=rsa-sha256; t=1519855646; cv=none;
        d=google.com; s=arc-20160816;
        b=e96kW1oPgUI/0DlPWqkVKXzfpR1VZVnEZUzpi8sV70dMwVHS9lC0EThaRRBIsyBey7
         56s59qvQ1okqYjtDcu8xH7o1nTfep2kReie+YkQIwKr/DP8N0asLMCiqxB+IVj+/cpT4
         BQRgivzVGBXxLIabaBzguAv2UU9gEoa9/or4trisjSBRkO3HoQY0Kmihadjkd7pNgnxw
         UiOQp9oZHsJicgpq/NuH+XoDZQsTmoLxtvJ/3dwLUXKNII28YxedTio+vrdJ/up3cu4g
         NtHbUz7tsWjHQZnca6/mIIPcJgSGj+p7oOgOseS0loEvWKzg1xDaYSU2d1MIgbWbqvg+
         XurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :arc-authentication-results;
        bh=gYJcPau5DwzOr52kAGNEYhGRTTtgDf9MaGTWv2DO+Go=;
        b=mMP1+wfsZj0ucwayoCPj7vVIhvoTZjoQ8ajWtjX+RKXkdlH0Rg5+Hc/rKLnK2Vy2mh
         RO+HKQLW3ZMw5gxlaHHBOBSubw/4bKmB+F4Wt+lErgW1bHg3IhVVByxOTb42UfluE/8h
         c9kWsF9XDy5AITWvK1vr5wdhdRMFvCgCFeN/xP4ExC24KR1yd/GrT8pooEaiAAn9oDUs
         pZaJkV+dAOwdZfgahgoZvtN6KfgDuIkUm3e5Ez4zM8fGAA3+2yEzKvvlNupMcX8/4gC3
         pbtsReWAPKsJC2EySMawFdeJehwmx1xA84ToTQn0QNzzCa5ILibe+V/pzdFE66hDqA0J
         1YXg==
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
Subject: [PATCH v7 08/13] arm64: Add support for ACPI based firmware tables
Date: Wed, 28 Feb 2018 16:06:14 -0600
Message-Id: <20180228220619.6992-9-jeremy.linton@arm.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <20180228220619.6992-1-jeremy.linton@arm.com>
References: <20180228220619.6992-1-jeremy.linton@arm.com>
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593684154790972814?=
X-GMAIL-MSGID: =?utf-8?q?1593684154790972814?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

The /sys cache entries should support ACPI/PPTT generated cache
topology information. Lets detect ACPI systems and call
an arch specific cache_setup_acpi() routine to update the hardware
probed cache topology.

For arm64, if ACPI is enabled, determine the max number of cache
levels and populate them using the PPTT table if one is available.

Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
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
