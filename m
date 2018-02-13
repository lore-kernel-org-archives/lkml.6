Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966231AbeBMXtj (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 18:49:39 -0500
Received: from mga17.intel.com ([192.55.52.151]:53398 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966213AbeBMXtg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 18:49:36 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,509,1511856000";
   d="scan'208";a="29822334"
From: Reinette Chatre <reinette.chatre@intel.com>
To: tglx@linutronix.de, fenghua.yu@intel.com, tony.luck@intel.com
Cc: gavin.hindman@intel.com, vikas.shivappa@linux.intel.com,
        dave.hansen@intel.com, mingo@redhat.com, hpa@zytor.com, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Reinette Chatre <reinette.chatre@intel.com>
Subject: [RFC PATCH V2 12/22] x86/intel_rdt: Support CBM checking from value and character buffer
Date: Tue, 13 Feb 2018 07:46:56 -0800
Message-Id: <3148e84c57dcc05c9e79c801fd19824ba69da6c8.1518443616.git.reinette.chatre@intel.com>
X-Mailer: git-send-email 2.13.6
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
In-Reply-To: <cover.1518443616.git.reinette.chatre@intel.com>
References: <cover.1518443616.git.reinette.chatre@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Validity check of capacity bitmask (CBM) is currently only done on
character buffer when user writes new schemata to resctrl file.

In preparation for support of CBM checking within other areas of the RDT
code the CBM validity check is split up to support checking with CBM
provided as character buffer as well as the value itself.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
---
 arch/x86/kernel/cpu/intel_rdt.h             |  1 +
 arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c | 34 ++++++++++++++++++++---------
 2 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel_rdt.h b/arch/x86/kernel/cpu/intel_rdt.h
index f0e020686e99..2c4e13252057 100644
--- a/arch/x86/kernel/cpu/intel_rdt.h
+++ b/arch/x86/kernel/cpu/intel_rdt.h
@@ -442,6 +442,7 @@ struct rdt_domain *get_domain_from_cpu(int cpu, struct rdt_resource *r);
 int closid_alloc(void);
 void closid_free(int closid);
 bool closid_allocated(unsigned int closid);
+bool cbm_validate_val(unsigned long val, struct rdt_resource *r);
 int update_domains(struct rdt_resource *r, int closid);
 int alloc_rmid(void);
 void free_rmid(u32 rmid);
diff --git a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
index 9e1a455e4d9b..4a11aea3ad2c 100644
--- a/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
+++ b/arch/x86/kernel/cpu/intel_rdt_ctrlmondata.c
@@ -86,17 +86,10 @@ int parse_bw(char *buf, struct rdt_resource *r, struct rdt_domain *d)
  *	are allowed (e.g. FFFFH, 0FF0H, 003CH, etc.).
  * Additionally Haswell requires at least two bits set.
  */
-static bool cbm_validate(char *buf, unsigned long *data, struct rdt_resource *r)
+bool cbm_validate_val(unsigned long val, struct rdt_resource *r)
 {
-	unsigned long first_bit, zero_bit, val;
+	unsigned long first_bit, zero_bit;
 	unsigned int cbm_len = r->cache.cbm_len;
-	int ret;
-
-	ret = kstrtoul(buf, 16, &val);
-	if (ret) {
-		rdt_last_cmd_printf("non-hex character in mask %s\n", buf);
-		return false;
-	}
 
 	if (val == 0 || val > r->default_ctrl) {
 		rdt_last_cmd_puts("mask out of range\n");
@@ -117,11 +110,32 @@ static bool cbm_validate(char *buf, unsigned long *data, struct rdt_resource *r)
 		return false;
 	}
 
-	*data = val;
 	return true;
 }
 
 /*
+ * Validate CBM as provided in character buffer. If CBM is valid
+ * true will be returned as well as number representation pointed to by
+ * @data. If CBM is invalid, return false.
+ */
+static bool cbm_validate(char *buf, unsigned long *data, struct rdt_resource *r)
+{
+	unsigned long val;
+	bool ret;
+
+	if (kstrtoul(buf, 16, &val)) {
+		rdt_last_cmd_printf("non-hex character in mask %s\n", buf);
+		return false;
+	}
+
+	ret = cbm_validate_val(val, r);
+	if (ret)
+		*data = val;
+
+	return ret;
+}
+
+/*
  * Read one cache bit mask (hex). Check that it is valid for the current
  * resource type.
  */
-- 
2.13.6
